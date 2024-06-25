-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2024 at 05:27 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grandoasis`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `Admin_id` int(11) NOT NULL,
  `Nama_admin` varchar(255) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Tipe_admin` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Admin_id`, `Nama_admin`, `Email`, `Username`, `Password`, `Tipe_admin`) VALUES
(1, 'vita suci', 'vitasuci@example.com', 'vita', 'vita123', 'Manager'),
(2, 'Jane Smith', 'jane.smith@example.com', 'janesmith', 'secret456', 'Receptionist'),
(3, 'Michael Johnson', 'michael.johnson@example.com', 'michaelj', 'admin789', 'Housekeeping');

-- --------------------------------------------------------

--
-- Table structure for table `ballroom`
--

CREATE TABLE `ballroom` (
  `Ballroom_id` int(11) NOT NULL,
  `Tipe_ballroom` varchar(20) DEFAULT NULL,
  `Harga` int(11) NOT NULL,
  `Nomor_ballroom` varchar(10) NOT NULL,
  `Deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ballroom`
--

INSERT INTO `ballroom` (`Ballroom_id`, `Tipe_ballroom`, `Harga`, `Nomor_ballroom`, `Deskripsi`) VALUES
(1, 'Ballroom Indoor', 5000000, 'B101', 'Ballroom Indoor dengan fasilitas mewah'),
(2, 'Ballroom Outdoor', 5200000, 'B202', 'Ballroom refresing dengan scenery asri');

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `Kamar_id` int(11) NOT NULL,
  `Tipe_kamar` varchar(20) NOT NULL,
  `Nomor_kamar` varchar(10) NOT NULL,
  `Deskripsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`Kamar_id`, `Tipe_kamar`, `Nomor_kamar`, `Deskripsi`) VALUES
(1, 'Standard Suite', '101', 'Kamar standar dengan fasilitas dasar'),
(2, 'Deluxe Room', '202', 'Kamar deluxe dengan pemandangan laut'),
(3, 'Family Suite', '303', 'Kamar untuk sekeluarga bersama');

-- --------------------------------------------------------

--
-- Table structure for table `meeting`
--

CREATE TABLE `meeting` (
  `Meeting_id` int(11) NOT NULL,
  `Tipe_meeting` varchar(20) DEFAULT NULL,
  `Harga` int(11) NOT NULL,
  `Nomor_meeting` varchar(10) NOT NULL,
  `Deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `meeting`
--

INSERT INTO `meeting` (`Meeting_id`, `Tipe_meeting`, `Harga`, `Nomor_meeting`, `Deskripsi`) VALUES
(1, 'Standard Meeting Roo', 500000, 'M101', 'Meeting room standar sesuai kebutuhan'),
(2, 'VIP Meeting Room', 600000, 'M202', 'Meeting room medium dengan fasilitas lebih'),
(3, 'VVIP Meeting Room', 650000, 'M202', 'Meeting room High End dengan fasilitas premium'),
(4, 'Executive Meeting Ro', 1200000, 'M303', 'Meeting room dengan fitur eksekutif');

-- --------------------------------------------------------

--
-- Table structure for table `reservasiballroom`
--

CREATE TABLE `reservasiballroom` (
  `ReservasiBallroom_id` int(11) NOT NULL,
  `Tamu_id` int(11) DEFAULT NULL,
  `Ballroom_id` int(11) DEFAULT NULL,
  `CheckInDate` datetime NOT NULL,
  `CheckOutDate` datetime NOT NULL,
  `Status` enum('Confirmed','Booked','Checked-in') DEFAULT 'Confirmed',
  `Harga` int(11) DEFAULT NULL,
  `Tanggal_bayar` datetime DEFAULT NULL,
  `Jumlah_bayar` int(11) DEFAULT NULL,
  `Metode_bayar` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservasiballroom`
--

INSERT INTO `reservasiballroom` (`ReservasiBallroom_id`, `Tamu_id`, `Ballroom_id`, `CheckInDate`, `CheckOutDate`, `Status`, `Harga`, `Tanggal_bayar`, `Jumlah_bayar`, `Metode_bayar`) VALUES
(4, 1, 1, '2024-07-03 00:00:00', '2024-07-04 00:00:00', 'Confirmed', 5000000, '2024-07-01 00:00:00', 5000000, 'Credit Card'),
(5, 2, 2, '2024-07-07 00:00:00', '2024-07-08 00:00:00', 'Confirmed', 3000000, '2024-07-02 00:00:00', 3000000, 'Cash');

--
-- Triggers `reservasiballroom`
--
DELIMITER $$
CREATE TRIGGER `set_status_booked_ballroom` BEFORE UPDATE ON `reservasiballroom` FOR EACH ROW BEGIN
    IF NEW.CheckInDate IS NOT NULL AND NEW.CheckOutDate IS NOT NULL AND NEW.Status = 'Confirmed' THEN
        SET NEW.Status = 'Booked';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `set_status_checked_out_ballroom` BEFORE UPDATE ON `reservasiballroom` FOR EACH ROW BEGIN
    IF NEW.CheckOutDate IS NOT NULL AND OLD.CheckOutDate IS NULL THEN
        SET NEW.Status = 'Checked-out';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservasikamar`
--

CREATE TABLE `reservasikamar` (
  `ReservasiKamar_id` int(11) NOT NULL,
  `Tamu_id` int(11) DEFAULT NULL,
  `Kamar_id` int(11) DEFAULT NULL,
  `CheckInDate` datetime NOT NULL,
  `CheckOutDate` datetime NOT NULL,
  `Status` enum('Confirmed','Booked','Checked-Out') DEFAULT 'Confirmed',
  `Harga` int(11) DEFAULT NULL,
  `Tanggal_bayar` datetime DEFAULT NULL,
  `Jumlah_bayar` int(11) DEFAULT NULL,
  `Metode_bayar` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservasikamar`
--

INSERT INTO `reservasikamar` (`ReservasiKamar_id`, `Tamu_id`, `Kamar_id`, `CheckInDate`, `CheckOutDate`, `Status`, `Harga`, `Tanggal_bayar`, `Jumlah_bayar`, `Metode_bayar`) VALUES
(1, 1, 1, '2024-07-01 00:00:00', '2024-07-03 00:00:00', 'Confirmed', 200000, '2024-06-25 00:00:00', 200000, 'Transfer'),
(2, 2, 2, '2024-07-05 00:00:00', '2024-07-07 00:00:00', 'Booked', 400000, '2024-06-26 00:00:00', 400000, 'Credit Card'),
(3, 3, 3, '2024-07-10 00:00:00', '2024-07-12 00:00:00', 'Checked-Out', 600000, '2024-06-27 00:00:00', 600000, 'Cash');

--
-- Triggers `reservasikamar`
--
DELIMITER $$
CREATE TRIGGER `set_status_booked_kamar` BEFORE UPDATE ON `reservasikamar` FOR EACH ROW BEGIN
    IF NEW.CheckInDate IS NOT NULL AND NEW.CheckOutDate IS NOT NULL AND NEW.Status = 'Confirmed' THEN
        SET NEW.Status = 'Booked';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `set_status_checked_out_kamar` BEFORE UPDATE ON `reservasikamar` FOR EACH ROW BEGIN
    IF NEW.CheckOutDate IS NOT NULL AND OLD.CheckOutDate IS NULL THEN
        SET NEW.Status = 'Checked-out';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservasimeeting`
--

CREATE TABLE `reservasimeeting` (
  `ReservasiMeeting_id` int(11) NOT NULL,
  `Tamu_id` int(11) DEFAULT NULL,
  `Meeting_id` int(11) DEFAULT NULL,
  `CheckInDate` datetime NOT NULL,
  `CheckOutDate` datetime NOT NULL,
  `Status` enum('Confirmed','Booked','Checked-in') DEFAULT 'Confirmed',
  `Harga` int(11) DEFAULT NULL,
  `Tanggal_bayar` datetime DEFAULT NULL,
  `Jumlah_bayar` int(11) DEFAULT NULL,
  `Metode_bayar` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservasimeeting`
--

INSERT INTO `reservasimeeting` (`ReservasiMeeting_id`, `Tamu_id`, `Meeting_id`, `CheckInDate`, `CheckOutDate`, `Status`, `Harga`, `Tanggal_bayar`, `Jumlah_bayar`, `Metode_bayar`) VALUES
(1, 1, 1, '2024-07-02 00:00:00', '2024-07-02 00:00:00', 'Confirmed', 500000, '2024-06-28 00:00:00', 500000, 'Cash'),
(2, 2, 2, '2024-07-06 00:00:00', '2024-07-06 00:00:00', 'Confirmed', 800000, '2024-06-29 00:00:00', 800000, 'Credit Card'),
(3, 3, 3, '2024-07-11 00:00:00', '2024-07-11 00:00:00', 'Confirmed', 1200000, '2024-06-30 00:00:00', 1200000, 'Transfer');

--
-- Triggers `reservasimeeting`
--
DELIMITER $$
CREATE TRIGGER `set_status_booked_meeting` BEFORE UPDATE ON `reservasimeeting` FOR EACH ROW BEGIN
    IF NEW.CheckInDate IS NOT NULL AND NEW.CheckOutDate IS NOT NULL AND NEW.Status = 'Confirmed' THEN
        SET NEW.Status = 'Booked';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `set_status_checked_out_meeting` BEFORE UPDATE ON `reservasimeeting` FOR EACH ROW BEGIN
    IF NEW.CheckOutDate IS NOT NULL AND OLD.CheckOutDate IS NULL THEN
        SET NEW.Status = 'Checked-out';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tamu`
--

CREATE TABLE `tamu` (
  `Tamu_id` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `No_HP` char(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tamu`
--

INSERT INTO `tamu` (`Tamu_id`, `FirstName`, `LastName`, `Email`, `No_HP`) VALUES
(1, 'Alice', 'Brown', 'alice.brown@example.com', '1234567890'),
(2, 'Bob', 'Lee', 'bob.lee@example.com', '9876543210'),
(3, 'Carol', 'Garcia', 'carol.garcia@example.com', '555444333');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Admin_id`);

--
-- Indexes for table `ballroom`
--
ALTER TABLE `ballroom`
  ADD PRIMARY KEY (`Ballroom_id`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`Kamar_id`);

--
-- Indexes for table `meeting`
--
ALTER TABLE `meeting`
  ADD PRIMARY KEY (`Meeting_id`);

--
-- Indexes for table `reservasiballroom`
--
ALTER TABLE `reservasiballroom`
  ADD PRIMARY KEY (`ReservasiBallroom_id`),
  ADD KEY `Tamu_id` (`Tamu_id`),
  ADD KEY `Ballroom_id` (`Ballroom_id`);

--
-- Indexes for table `reservasikamar`
--
ALTER TABLE `reservasikamar`
  ADD PRIMARY KEY (`ReservasiKamar_id`),
  ADD KEY `Tamu_id` (`Tamu_id`),
  ADD KEY `Kamar_id` (`Kamar_id`);

--
-- Indexes for table `reservasimeeting`
--
ALTER TABLE `reservasimeeting`
  ADD PRIMARY KEY (`ReservasiMeeting_id`),
  ADD KEY `Tamu_id` (`Tamu_id`),
  ADD KEY `Meeting_id` (`Meeting_id`);

--
-- Indexes for table `tamu`
--
ALTER TABLE `tamu`
  ADD PRIMARY KEY (`Tamu_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `Admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ballroom`
--
ALTER TABLE `ballroom`
  MODIFY `Ballroom_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `Kamar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `meeting`
--
ALTER TABLE `meeting`
  MODIFY `Meeting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reservasiballroom`
--
ALTER TABLE `reservasiballroom`
  MODIFY `ReservasiBallroom_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reservasikamar`
--
ALTER TABLE `reservasikamar`
  MODIFY `ReservasiKamar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reservasimeeting`
--
ALTER TABLE `reservasimeeting`
  MODIFY `ReservasiMeeting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tamu`
--
ALTER TABLE `tamu`
  MODIFY `Tamu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservasiballroom`
--
ALTER TABLE `reservasiballroom`
  ADD CONSTRAINT `reservasiballroom_ibfk_1` FOREIGN KEY (`Tamu_id`) REFERENCES `tamu` (`Tamu_id`),
  ADD CONSTRAINT `reservasiballroom_ibfk_2` FOREIGN KEY (`Ballroom_id`) REFERENCES `ballroom` (`Ballroom_id`);

--
-- Constraints for table `reservasikamar`
--
ALTER TABLE `reservasikamar`
  ADD CONSTRAINT `reservasikamar_ibfk_1` FOREIGN KEY (`Tamu_id`) REFERENCES `tamu` (`Tamu_id`),
  ADD CONSTRAINT `reservasikamar_ibfk_2` FOREIGN KEY (`Kamar_id`) REFERENCES `kamar` (`Kamar_id`);

--
-- Constraints for table `reservasimeeting`
--
ALTER TABLE `reservasimeeting`
  ADD CONSTRAINT `reservasimeeting_ibfk_1` FOREIGN KEY (`Tamu_id`) REFERENCES `tamu` (`Tamu_id`),
  ADD CONSTRAINT `reservasimeeting_ibfk_2` FOREIGN KEY (`Meeting_id`) REFERENCES `meeting` (`Meeting_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
