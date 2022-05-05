-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2022 at 09:25 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `votingniter`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(32) NOT NULL,
  `last_login` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `nama`, `username`, `password`, `last_login`) VALUES
(1, 'Santhosh', 'Santhosh', '21232f297a57a5a743894a0e4a801fc3', '2021-06-13 23:13:17');

-- --------------------------------------------------------

--
-- Table structure for table `ikut_kandidat`
--

CREATE TABLE `ikut_kandidat` (
  `id_ikut_kandidat` int(11) NOT NULL,
  `id_voting` int(11) DEFAULT NULL,
  `id_kandidat` int(11) DEFAULT NULL,
  `poin` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ikut_kandidat`
--

INSERT INTO `ikut_kandidat` (`id_ikut_kandidat`, `id_voting`, `id_kandidat`, `poin`) VALUES
(7, 3, 1, 1),
(8, 3, 2, 0),
(9, 3, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ikut_voting`
--

CREATE TABLE `ikut_voting` (
  `id_ikut` int(11) NOT NULL,
  `id_voting` int(11) DEFAULT NULL,
  `id_pemilih` int(11) DEFAULT NULL,
  `waktu` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ikut_voting`
--

INSERT INTO `ikut_voting` (`id_ikut`, `id_voting`, `id_pemilih`, `waktu`) VALUES
(3, 3, 2, '2022-05-05 14:18:51');

-- --------------------------------------------------------

--
-- Table structure for table `kandidat`
--

CREATE TABLE `kandidat` (
  `id_kandidat` int(11) NOT NULL,
  `nama_kandidat` varchar(50) NOT NULL DEFAULT '0',
  `keterangan` text DEFAULT NULL,
  `foto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kandidat`
--

INSERT INTO `kandidat` (`id_kandidat`, `nama_kandidat`, `keterangan`, `foto`) VALUES
(1, 'Santhosh', 'Don\'t just hope for a better life, vote for it!', '11.jpg'),
(2, 'Ganesh', 'For the many, not the few.', '2.jpg'),
(3, 'Vijayakumar', 'Vote for me if you want change !', '3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `pemilih`
--

CREATE TABLE `pemilih` (
  `id_pemilih` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT '0',
  `username` varchar(15) DEFAULT '0',
  `password` varchar(32) DEFAULT '0',
  `mobileno` bigint(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemilih`
--

INSERT INTO `pemilih` (`id_pemilih`, `nama`, `username`, `password`, `mobileno`) VALUES
(1, 'Santhosh', 'santhosh', 'f1134a6d1c4fcfee2132c09223dea961', 9789429543),
(2, 'Ganesh', 'ganesh', '4185633248cfeb1559c5c6b2ccc22494', 9876543210),
(7, 'Vijay', 'vijay', '4f9fecabbd77fba02d2497f880f44e6f', 0);

-- --------------------------------------------------------

--
-- Table structure for table `voting`
--

CREATE TABLE `voting` (
  `id_voting` int(11) NOT NULL,
  `nama_voting` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `voting`
--

INSERT INTO `voting` (`id_voting`, `nama_voting`) VALUES
(3, 'Class Representative Election');

--
-- Triggers `voting`
--
DELIMITER $$
CREATE TRIGGER `delete_voting` BEFORE DELETE ON `voting` FOR EACH ROW BEGIN
	DELETE FROM ikut_kandidat WHERE ikut_kandidat.id_voting=OLD.id_voting;
	DELETE FROM ikut_voting WHERE ikut_voting.id_voting=OLD.id_voting;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `ikut_kandidat`
--
ALTER TABLE `ikut_kandidat`
  ADD PRIMARY KEY (`id_ikut_kandidat`);

--
-- Indexes for table `ikut_voting`
--
ALTER TABLE `ikut_voting`
  ADD PRIMARY KEY (`id_ikut`);

--
-- Indexes for table `kandidat`
--
ALTER TABLE `kandidat`
  ADD PRIMARY KEY (`id_kandidat`);

--
-- Indexes for table `pemilih`
--
ALTER TABLE `pemilih`
  ADD PRIMARY KEY (`id_pemilih`);

--
-- Indexes for table `voting`
--
ALTER TABLE `voting`
  ADD PRIMARY KEY (`id_voting`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ikut_kandidat`
--
ALTER TABLE `ikut_kandidat`
  MODIFY `id_ikut_kandidat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `ikut_voting`
--
ALTER TABLE `ikut_voting`
  MODIFY `id_ikut` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kandidat`
--
ALTER TABLE `kandidat`
  MODIFY `id_kandidat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pemilih`
--
ALTER TABLE `pemilih`
  MODIFY `id_pemilih` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `voting`
--
ALTER TABLE `voting`
  MODIFY `id_voting` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
