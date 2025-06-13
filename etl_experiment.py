import pandas as pd
from pandas import DataFrame
import numpy as np
import io
import re
from datetime import datetime


class AddPlateParameters:

    def __init__(self, protocol_id, operation_id, plate_type, plate_layout, measurement_type, lab, contact,
                 plate_id=None, plate_index=None, plate_transfer=None, plate_timestamp=None,
                 client=None):

        self.protocol_id = protocol_id
        self.operation_id = operation_id
        self.measurement_type = measurement_type
        self._lab = lab
        self._contact = contact
        self.timestamp = plate_timestamp
        self.index = plate_index
        self.transfer = plate_transfer
        self.id = plate_id
        self.type = plate_type
        self.layout = plate_layout
        if client:
            d_lab = pd.read_sql(f"SELECT * FROM lab WHERE id = {self._lab}", client).transpose().to_dict()
            d_people = pd.read_sql(f"SELECT * FROM people WHERE id = {self._contact}", client).transpose().to_dict()
            if len(d_lab) == 1:
                self._lab = d_lab[0]
            else:
                raise ValueError(f'Invalid Lab ID: {self._lab}')
            if len(d_people) == 1:
                self._contact = d_people[0]
            else:
                raise ValueError(f'Invalid Contact ID: {self._contact}')

    @property
    def lab_id(self):
        if type(self._lab) == dict:
            return self._lab['id']
        return self._lab

    @property
    def contact_id(self):
        if type(self._contact) == dict:
            return self._contact['id']
        return self._contact

    def _repr_html_(self):
        _str_lab = self._lab['name'] if type(self._lab) == dict else self._lab
        _str_contact = self._contact['email'] if type(self._contact) == dict else self._contact
        return """
        <table>
            <tr>
                <td><strong>ID</strong></td>
                <td>{address}</td>
            </tr><tr>
                <td><strong>Protocol</strong></td>
                <td>{protocol_id}</td>
            </tr><tr>
                <td><strong>Operation</strong></td>
                <td>{operation_id}</td>
            </tr><tr>
                <td><strong>measurement_type</strong></td>
                <td>{measurement_type}</td>
            </tr><tr>
                <td><strong>Lab</strong></td>
                <td>{contact} ({lab})</td>
            </tr><tr>
                <td><strong>plate</strong></td>
                <td>{plate_type} ({plate_layout})</td>
            </tr>
          </table>""".format(
            address="0x0%x" % id(self),
            protocol_id=self.protocol_id,
            operation_id=self.operation_id,
            measurement_type=self.measurement_type,
            contact=_str_contact,
            lab=_str_lab,
            plate_type=self.type,
            plate_layout=self.layout,
        )


class EtlExperiment:

    def __init__(self, engine, minio):
        self.engine = engine
        self.mio = minio

    # Functions
    # def etl_plate(...)
