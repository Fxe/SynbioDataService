import matplotlib.pyplot as plt
from matplotlib import colormaps
from matplotlib.lines import Line2D
from matplotlib.ticker import ScalarFormatter
from statistics import mean, median
import pandas as pd
import numpy as np

def plot_OD(df, subtract_background = False, yscale='log', append_title=''):
    '''
    Plots OD measurements from DataFrame that is returned from od_query function.

    Args:
        df (pandas.DataFrame): Dataframe returned from od_query() function.
        subtract_background (bool): Whether to subtract background reading 
            from all measurements.
        yscale (str): 'log' or 'linear'
        append_title (str): Additional text to add to the figure title
    Returns:
        None    
    '''

    # Prepare data for plotting
    df = df.sort_values('datetime')
    df['od_background_subtracted'] = df['od'] - df['background']
    
    if subtract_background:
        value = 'od_background_subtracted'
    else:
        value = 'od'

    # Define different combinations of conditions that will be plotted
    conditions = df[['carbon_source', 'strain_name']].drop_duplicates().dropna()
    conditions['label'] = conditions.apply(
        lambda x: f'{x["strain_name"]} - {x["carbon_source"]}', axis=1
    )
    conditions['colors'] = colormaps['tab20'].colors[:len(conditions)]

    # For the legend
    handles = []
    labels = []

    # Create a figure and a set of subplots
    fig, ax = plt.subplots()

    # Figure will need to be stretched horizontally for readability
    fig_width, fig_height = fig.get_size_inches() # Get the current figure size
    fig.set_size_inches(fig_width * 3.5, fig_height) # Doubling the width
    
    total_transfers = df['passage'].max()

    # For the defined conditions and at each transfer,
    # plot the OD readings
    for i, row in conditions.iterrows():
        handle_line = Line2D([0], [0], label=row['label'], color=row['colors'])
        handles.append(handle_line)
        label = row['label']
        labels.append(label)
        
        for t in range(total_transfers+1):
            this_condition = df.loc[
                (df['carbon_source'] == row['carbon_source']) &
                (df['strain_name'] == row['strain_name']) &
                (df['passage'] == t)
            ]
            this_condition = this_condition.groupby('datetime'
                                                   )[value].agg(mean).to_frame().reset_index()
            plt.plot(
                this_condition['datetime'],
                this_condition[value],
                color=row['colors'],
                marker='o',
                markersize=2
            )
            
    # Configure and label the axes and tickmarks
    plt.yscale(yscale)
    ax.yaxis.set_major_formatter(ScalarFormatter())
    plt.xlabel('datetime')
    plt.ylabel('OD') 

    early_datetimes = df.groupby('passage')['datetime'].agg(
        lambda x: sorted(list(set(x)))[3])
    secax = ax.secondary_xaxis('top')
    secax.set_xticks(early_datetimes, np.arange(1, total_transfers+1, 1))
    secax.set_xlabel('transfer')

    # Set title and legend
    plt.title(value + append_title, fontsize=16)
    plt.legend(handles=handles, labels=labels, loc='lower center')
    
    plt.show()