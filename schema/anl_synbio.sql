-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Jun 27, 2025 at 09:37 PM
-- Server version: 9.1.0
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anl_synbio`
--

-- --------------------------------------------------------

--
-- Table structure for table `biolog_measurement`
--

CREATE TABLE `biolog_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL COMMENT 'Biolog measurements link to the same measurement object as OD timepoints and their calculated growth curves',
  `growth_condition` int NOT NULL,
  `max_od` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `breseq_measurement`
--

CREATE TABLE `breseq_measurement` (
  `id` int NOT NULL,
  `measurement_id` int DEFAULT NULL,
  `reference_genome` varchar(255) DEFAULT NULL,
  `file_location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contig`
--

CREATE TABLE `contig` (
  `id` int NOT NULL,
  `dna_sequence_md5` varchar(255) DEFAULT NULL,
  `length` int DEFAULT NULL,
  `is_closed` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contig_feature`
--

CREATE TABLE `contig_feature` (
  `id` varchar(255) NOT NULL,
  `contig_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `protein_md5` varchar(255) DEFAULT NULL COMMENT 'required or optional?',
  `dna_sequence_md5` varchar(255) DEFAULT NULL COMMENT 'required or optional?',
  `start_position` int DEFAULT NULL,
  `end_position` int DEFAULT NULL,
  `direction` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `copynumber_measurement`
--

CREATE TABLE `copynumber_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL COMMENT 'qPCR measurements and the copy numbers calculated from them are measurements that link to the same sample measurement object',
  `feature_id` int NOT NULL,
  `copy_number` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dna_sequence`
--

CREATE TABLE `dna_sequence` (
  `md5` varchar(255) NOT NULL,
  `sequence` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `experiment`
--

CREATE TABLE `experiment` (
  `id` varchar(255) NOT NULL COMMENT 'format:<experiment type>.<start date>.<index>',
  `start_date` date DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `index` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `operation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feature`
--

CREATE TABLE `feature` (
  `id` int NOT NULL,
  `is_heterologous` tinyint(1) DEFAULT NULL COMMENT 'Is heterologous to what? Does this imply that this db will only every hold A.b. strains?'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feature_alias`
--

CREATE TABLE `feature_alias` (
  `feature_id` int NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `alias` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feature_annotation`
--

CREATE TABLE `feature_annotation` (
  `feature_id` int NOT NULL,
  `annotation` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `is_primary_annotation` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flask`
--

CREATE TABLE `flask` (
  `id` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flux_measurement`
--

CREATE TABLE `flux_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL COMMENT 'Metabolomic measurements and the flux calculated from them are measurements that link to the same sample measurement object',
  `metabolite_id` int NOT NULL,
  `flux` float DEFAULT NULL,
  `units` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `growth_condition`
--

CREATE TABLE `growth_condition` (
  `id` int NOT NULL COMMENT 'Table should have standardized units.',
  `long_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `agitation_speed` float DEFAULT NULL,
  `minimal_media` varchar(255) DEFAULT NULL,
  `carbon_source` varchar(255) DEFAULT NULL,
  `nitrogen_source` varchar(255) DEFAULT NULL,
  `carbon_concentration` float DEFAULT NULL,
  `nitrogen_concentration` float DEFAULT NULL,
  `antibiotics` varchar(255) DEFAULT NULL,
  `ab_concentration` float DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `growth_measurement`
--

CREATE TABLE `growth_measurement` (
  `id` int NOT NULL,
  `measurement_id` int DEFAULT NULL COMMENT 'OD timepoints and their calculated growth curves are measurements that link to the same sample measurement object',
  `operation_id` varchar(255) DEFAULT NULL,
  `lag_time` float DEFAULT NULL,
  `max_od` float DEFAULT NULL,
  `growth_rate` float DEFAULT NULL,
  `doubling_time` float DEFAULT NULL,
  `error` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lab`
--

CREATE TABLE `lab` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `long_reads_measurement`
--

CREATE TABLE `long_reads_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `measurement`
--

CREATE TABLE `measurement` (
  `id` int NOT NULL,
  `sample_id` varchar(255) NOT NULL,
  `operation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `metabolite`
--

CREATE TABLE `metabolite` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `aliases` varchar(255) DEFAULT NULL,
  `formula` varchar(255) DEFAULT NULL,
  `structure` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `metabolomics_measurement`
--

CREATE TABLE `metabolomics_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL COMMENT 'Metabolomic measurements and the flux calculated from them are measurements that link to the same sample measurement object',
  `metabolite_id` int NOT NULL,
  `value` float DEFAULT NULL,
  `units` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `od_measurement`
--

CREATE TABLE `od_measurement` (
  `id` int NOT NULL,
  `measurement_id` int DEFAULT NULL COMMENT 'OD timepoints and their calculated growth curves are measurements that link to the same sample measurement object',
  `operation_id` varchar(255) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `timepoint` float DEFAULT NULL,
  `od` float DEFAULT NULL,
  `background` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `operation`
--

CREATE TABLE `operation` (
  `id` varchar(255) NOT NULL,
  `protocol_id` varchar(255) NOT NULL,
  `lab_id` int DEFAULT NULL,
  `contact_id` int DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `parent_operation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `id` int NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `lab_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plate`
--

CREATE TABLE `plate` (
  `id` varchar(255) NOT NULL COMMENT 'format: id <experiment type>.<start date>.<index>.<plate index>',
  `experiment_id` varchar(255) NOT NULL,
  `plate_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `plate_index` int DEFAULT NULL COMMENT '<plate index>',
  `layout_filename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `protein_sequence`
--

CREATE TABLE `protein_sequence` (
  `md5` varchar(255) NOT NULL,
  `sequence` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proteomics_measurement`
--

CREATE TABLE `proteomics_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `value` float DEFAULT NULL,
  `units` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `protocol`
--

CREATE TABLE `protocol` (
  `id` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qPCR_measurement`
--

CREATE TABLE `qPCR_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL COMMENT 'qPCR measurements and the copy numbers calculated from them are measurements that link to the same sample measurement object',
  `feature_id` int NOT NULL,
  `fwd_primer` varchar(255) DEFAULT NULL,
  `rvs_primer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `annealing_temp` float DEFAULT NULL,
  `ct_value` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE `sample` (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `experiment_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `culture_container` enum('plate_well','shake_flask') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `well` enum('A1','B1','C1','D1','E1','F1','G1','H1','A2','B2','C2','D2','E2','F2','G2','H2','A3','B3','C3','D3','E3','F3','G3','H3','A4','B4','C4','D4','E4','F4','G4','H4','A5','B5','C5','D5','E5','F5','G5','H5','A6','B6','C6','D6','E6','F6','G6','H6','A7','B7','C7','D7','E7','F7','G7','H7','A8','B8','C8','D8','E8','F8','G8','H8','A9','B9','C9','D9','E9','F9','G9','H9','A10','B10','C10','D10','E10','F10','G10','H10','A11','B11','C11','D11','E11','F11','G11','H11','A12','B12','C12','D12','E12','F12','G12','H12') DEFAULT NULL,
  `flask` varchar(255) DEFAULT NULL,
  `growth_condition_id` int DEFAULT NULL,
  `strain_id` int DEFAULT NULL,
  `replicate` int DEFAULT NULL,
  `passage` int DEFAULT NULL,
  `parent_sample_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `innoculation_timestamp` datetime DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `short_reads_measurement`
--

CREATE TABLE `short_reads_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `strain`
--

CREATE TABLE `strain` (
  `id` int NOT NULL,
  `long_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `culture` enum('purified','population') DEFAULT NULL,
  `parent_strain_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `strain_contig`
--

CREATE TABLE `strain_contig` (
  `contig_id` int NOT NULL,
  `strain_id` int NOT NULL,
  `is_construct` tinyint(1) DEFAULT NULL,
  `inserted_contig_id` int NOT NULL,
  `insertion_position` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `strain_mutations`
--

CREATE TABLE `strain_mutations` (
  `id` int NOT NULL,
  `strain_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `contig_id` int NOT NULL,
  `contig_position` int DEFAULT NULL,
  `feature_position` int DEFAULT NULL,
  `insertion_sequence` varchar(255) DEFAULT NULL,
  `deletion_sequence` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_coding` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tnseq_measurement`
--

CREATE TABLE `tnseq_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `fitness_score` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transcriptomics_measurement`
--

CREATE TABLE `transcriptomics_measurement` (
  `id` int NOT NULL,
  `measurement_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `value` float DEFAULT NULL,
  `units` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `well`
--

CREATE TABLE `well` (
  `id` varchar(255) NOT NULL COMMENT 'format: <experiment type>.<start date>.<index>.<plate index>.<well ID>',
  `location` enum('A1','B1','C1','D1','E1','F1','G1','H1','A2','B2','C2','D2','E2','F2','G2','H2','A3','B3','C3','D3','E3','F3','G3','H3','A4','B4','C4','D4','E4','F4','G4','H4','A5','B5','C5','D5','E5','F5','G5','H5','A6','B6','C6','D6','E6','F6','G6','H6','A7','B7','C7','D7','E7','F7','G7','H7','A8','B8','C8','D8','E8','F8','G8','H8','A9','B9','C9','D9','E9','F9','G9','H9','A10','B10','C10','D10','E10','F10','G10','H10','A11','B11','C11','D11','E11','F11','G11','H11','A12','B12','C12','D12','E12','F12','G12','H12') NOT NULL,
  `plate_id` varchar(255) NOT NULL,
  `operation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sample_id` int DEFAULT NULL,
  `passage_step` int DEFAULT NULL,
  `innoculation_timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `biolog_measurement`
--
ALTER TABLE `biolog_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `biolog_measurement_ibfk_3` (`measurement_id`),
  ADD KEY `growth_condition` (`growth_condition`);

--
-- Indexes for table `breseq_measurement`
--
ALTER TABLE `breseq_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `measurement_id` (`measurement_id`),
  ADD KEY `reference_genome` (`reference_genome`);

--
-- Indexes for table `contig`
--
ALTER TABLE `contig`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contig_feature`
--
ALTER TABLE `contig_feature`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dna_sequence_md5` (`dna_sequence_md5`),
  ADD KEY `protein_md5` (`protein_md5`),
  ADD KEY `contig_id` (`contig_id`);

--
-- Indexes for table `copynumber_measurement`
--
ALTER TABLE `copynumber_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feature_id` (`feature_id`),
  ADD KEY `copynumber_measurement_ibfk_1` (`measurement_id`);

--
-- Indexes for table `dna_sequence`
--
ALTER TABLE `dna_sequence`
  ADD PRIMARY KEY (`md5`);

--
-- Indexes for table `experiment`
--
ALTER TABLE `experiment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `experiment_ibfk_1` (`operation_id`);

--
-- Indexes for table `feature`
--
ALTER TABLE `feature`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_alias`
--
ALTER TABLE `feature_alias`
  ADD PRIMARY KEY (`feature_id`,`alias`);

--
-- Indexes for table `feature_annotation`
--
ALTER TABLE `feature_annotation`
  ADD PRIMARY KEY (`feature_id`,`annotation`);

--
-- Indexes for table `flask`
--
ALTER TABLE `flask`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flux_measurement`
--
ALTER TABLE `flux_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `metabolite_id` (`metabolite_id`),
  ADD KEY `flux_measurement_ibfk_1` (`measurement_id`);

--
-- Indexes for table `growth_condition`
--
ALTER TABLE `growth_condition`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `growth_measurement`
--
ALTER TABLE `growth_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `growth_measurement_ibfk_1` (`measurement_id`),
  ADD KEY `operation_id` (`operation_id`);

--
-- Indexes for table `lab`
--
ALTER TABLE `lab`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `long_reads_measurement`
--
ALTER TABLE `long_reads_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `measurement_id` (`measurement_id`);

--
-- Indexes for table `measurement`
--
ALTER TABLE `measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `measurement_ibfk_3` (`sample_id`),
  ADD KEY `measurement_ibfk_2` (`operation_id`);

--
-- Indexes for table `metabolite`
--
ALTER TABLE `metabolite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `metabolomics_measurement`
--
ALTER TABLE `metabolomics_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `metabolite_id` (`metabolite_id`),
  ADD KEY `metabolomics_measurement_ibfk_1` (`measurement_id`);

--
-- Indexes for table `od_measurement`
--
ALTER TABLE `od_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `od_measurement_ibfk_1` (`measurement_id`),
  ADD KEY `operation_id` (`operation_id`);

--
-- Indexes for table `operation`
--
ALTER TABLE `operation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lab_id` (`lab_id`),
  ADD KEY `contact_id` (`contact_id`),
  ADD KEY `protocol_id` (`protocol_id`),
  ADD KEY `parent_operation` (`parent_operation`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lab_id` (`lab_id`);

--
-- Indexes for table `plate`
--
ALTER TABLE `plate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate_ibfk_1` (`experiment_id`);

--
-- Indexes for table `protein_sequence`
--
ALTER TABLE `protein_sequence`
  ADD PRIMARY KEY (`md5`);

--
-- Indexes for table `proteomics_measurement`
--
ALTER TABLE `proteomics_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proteomics_measurement_ibfk_1` (`measurement_id`);

--
-- Indexes for table `protocol`
--
ALTER TABLE `protocol`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qPCR_measurement`
--
ALTER TABLE `qPCR_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feature_id` (`feature_id`),
  ADD KEY `qPCR_measurement_ibfk_1` (`measurement_id`);

--
-- Indexes for table `sample`
--
ALTER TABLE `sample`
  ADD PRIMARY KEY (`name`),
  ADD KEY `growth_condition_id` (`growth_condition_id`),
  ADD KEY `strain_id` (`strain_id`),
  ADD KEY `sample_ibfk_5` (`plate`),
  ADD KEY `sample_ibfk_4` (`parent_sample_name`),
  ADD KEY `flask` (`flask`),
  ADD KEY `experiment_id` (`experiment_id`);

--
-- Indexes for table `short_reads_measurement`
--
ALTER TABLE `short_reads_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `measurement_id` (`measurement_id`);

--
-- Indexes for table `strain`
--
ALTER TABLE `strain`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `long_name` (`long_name`);

--
-- Indexes for table `strain_contig`
--
ALTER TABLE `strain_contig`
  ADD KEY `contig_id` (`contig_id`),
  ADD KEY `strain_id` (`strain_id`),
  ADD KEY `inserted_contig_id` (`inserted_contig_id`);

--
-- Indexes for table `strain_mutations`
--
ALTER TABLE `strain_mutations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feature_id` (`feature_id`),
  ADD KEY `strain_id` (`strain_id`),
  ADD KEY `contig_id` (`contig_id`);

--
-- Indexes for table `tnseq_measurement`
--
ALTER TABLE `tnseq_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feature_id` (`feature_id`),
  ADD KEY `tnseq_measurement_ibfk_1` (`measurement_id`);

--
-- Indexes for table `transcriptomics_measurement`
--
ALTER TABLE `transcriptomics_measurement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feature_id` (`feature_id`),
  ADD KEY `transcriptomics_measurement_ibfk_1` (`measurement_id`);

--
-- Indexes for table `well`
--
ALTER TABLE `well`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate_id` (`plate_id`),
  ADD KEY `sample_id` (`sample_id`),
  ADD KEY `method_id` (`operation_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `biolog_measurement`
--
ALTER TABLE `biolog_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `breseq_measurement`
--
ALTER TABLE `breseq_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contig`
--
ALTER TABLE `contig`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `copynumber_measurement`
--
ALTER TABLE `copynumber_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flux_measurement`
--
ALTER TABLE `flux_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `growth_condition`
--
ALTER TABLE `growth_condition`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Table should have standardized units.';

--
-- AUTO_INCREMENT for table `growth_measurement`
--
ALTER TABLE `growth_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lab`
--
ALTER TABLE `lab`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `long_reads_measurement`
--
ALTER TABLE `long_reads_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `measurement`
--
ALTER TABLE `measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metabolite`
--
ALTER TABLE `metabolite`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metabolomics_measurement`
--
ALTER TABLE `metabolomics_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `od_measurement`
--
ALTER TABLE `od_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proteomics_measurement`
--
ALTER TABLE `proteomics_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qPCR_measurement`
--
ALTER TABLE `qPCR_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `short_reads_measurement`
--
ALTER TABLE `short_reads_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `strain`
--
ALTER TABLE `strain`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tnseq_measurement`
--
ALTER TABLE `tnseq_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transcriptomics_measurement`
--
ALTER TABLE `transcriptomics_measurement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `biolog_measurement`
--
ALTER TABLE `biolog_measurement`
  ADD CONSTRAINT `biolog_measurement_ibfk_3` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `biolog_measurement_ibfk_4` FOREIGN KEY (`growth_condition`) REFERENCES `growth_condition` (`id`) ON UPDATE RESTRICT;

--
-- Constraints for table `breseq_measurement`
--
ALTER TABLE `breseq_measurement`
  ADD CONSTRAINT `breseq_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `contig_feature`
--
ALTER TABLE `contig_feature`
  ADD CONSTRAINT `contig_feature_ibfk_1` FOREIGN KEY (`dna_sequence_md5`) REFERENCES `dna_sequence` (`md5`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `contig_feature_ibfk_2` FOREIGN KEY (`protein_md5`) REFERENCES `protein_sequence` (`md5`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `contig_feature_ibfk_3` FOREIGN KEY (`contig_id`) REFERENCES `contig` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `copynumber_measurement`
--
ALTER TABLE `copynumber_measurement`
  ADD CONSTRAINT `copynumber_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `copynumber_measurement_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `experiment`
--
ALTER TABLE `experiment`
  ADD CONSTRAINT `experiment_ibfk_1` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `feature_alias`
--
ALTER TABLE `feature_alias`
  ADD CONSTRAINT `feature_alias_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `feature_annotation`
--
ALTER TABLE `feature_annotation`
  ADD CONSTRAINT `feature_annotation_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `flux_measurement`
--
ALTER TABLE `flux_measurement`
  ADD CONSTRAINT `flux_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `flux_measurement_ibfk_2` FOREIGN KEY (`metabolite_id`) REFERENCES `metabolite` (`id`);

--
-- Constraints for table `growth_measurement`
--
ALTER TABLE `growth_measurement`
  ADD CONSTRAINT `growth_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `growth_measurement_ibfk_2` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `long_reads_measurement`
--
ALTER TABLE `long_reads_measurement`
  ADD CONSTRAINT `long_reads_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `measurement`
--
ALTER TABLE `measurement`
  ADD CONSTRAINT `measurement_ibfk_2` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `measurement_ibfk_3` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`name`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `metabolomics_measurement`
--
ALTER TABLE `metabolomics_measurement`
  ADD CONSTRAINT `metabolomics_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `metabolomics_measurement_ibfk_2` FOREIGN KEY (`metabolite_id`) REFERENCES `metabolite` (`id`);

--
-- Constraints for table `od_measurement`
--
ALTER TABLE `od_measurement`
  ADD CONSTRAINT `od_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `od_measurement_ibfk_2` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `operation`
--
ALTER TABLE `operation`
  ADD CONSTRAINT `operation_ibfk_2` FOREIGN KEY (`lab_id`) REFERENCES `lab` (`id`),
  ADD CONSTRAINT `operation_ibfk_3` FOREIGN KEY (`contact_id`) REFERENCES `people` (`id`),
  ADD CONSTRAINT `operation_ibfk_4` FOREIGN KEY (`protocol_id`) REFERENCES `protocol` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `operation_ibfk_5` FOREIGN KEY (`parent_operation`) REFERENCES `operation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `people`
--
ALTER TABLE `people`
  ADD CONSTRAINT `people_ibfk_1` FOREIGN KEY (`lab_id`) REFERENCES `lab` (`id`);

--
-- Constraints for table `plate`
--
ALTER TABLE `plate`
  ADD CONSTRAINT `plate_ibfk_1` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `proteomics_measurement`
--
ALTER TABLE `proteomics_measurement`
  ADD CONSTRAINT `proteomics_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `qPCR_measurement`
--
ALTER TABLE `qPCR_measurement`
  ADD CONSTRAINT `qPCR_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `qPCR_measurement_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `sample`
--
ALTER TABLE `sample`
  ADD CONSTRAINT `sample_ibfk_2` FOREIGN KEY (`growth_condition_id`) REFERENCES `growth_condition` (`id`),
  ADD CONSTRAINT `sample_ibfk_3` FOREIGN KEY (`strain_id`) REFERENCES `strain` (`id`),
  ADD CONSTRAINT `sample_ibfk_4` FOREIGN KEY (`parent_sample_name`) REFERENCES `sample` (`name`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `sample_ibfk_5` FOREIGN KEY (`plate`) REFERENCES `plate` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `sample_ibfk_6` FOREIGN KEY (`flask`) REFERENCES `flask` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `sample_ibfk_7` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `short_reads_measurement`
--
ALTER TABLE `short_reads_measurement`
  ADD CONSTRAINT `short_reads_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `strain_contig`
--
ALTER TABLE `strain_contig`
  ADD CONSTRAINT `strain_contig_ibfk_1` FOREIGN KEY (`contig_id`) REFERENCES `contig` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `strain_contig_ibfk_2` FOREIGN KEY (`strain_id`) REFERENCES `strain` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `strain_contig_ibfk_3` FOREIGN KEY (`inserted_contig_id`) REFERENCES `strain` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `strain_mutations`
--
ALTER TABLE `strain_mutations`
  ADD CONSTRAINT `strain_mutations_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `strain_mutations_ibfk_2` FOREIGN KEY (`strain_id`) REFERENCES `strain` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `strain_mutations_ibfk_3` FOREIGN KEY (`contig_id`) REFERENCES `contig` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `tnseq_measurement`
--
ALTER TABLE `tnseq_measurement`
  ADD CONSTRAINT `tnseq_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `tnseq_measurement_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `transcriptomics_measurement`
--
ALTER TABLE `transcriptomics_measurement`
  ADD CONSTRAINT `transcriptomics_measurement_ibfk_1` FOREIGN KEY (`measurement_id`) REFERENCES `measurement` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `transcriptomics_measurement_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `well`
--
ALTER TABLE `well`
  ADD CONSTRAINT `well_ibfk_1` FOREIGN KEY (`plate_id`) REFERENCES `plate` (`id`),
  ADD CONSTRAINT `well_ibfk_4` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
