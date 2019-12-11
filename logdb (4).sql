-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2019 at 08:52 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `logdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `store` (IN `del` VARCHAR(50))  NO SQL
DELETE FROM user WHERE uid = del$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `City_ID` varchar(50) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Longitude` varchar(50) NOT NULL,
  `Latitude` varchar(50) NOT NULL,
  `Zip` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `no_of_users` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`City_ID`, `Name`, `Longitude`, `Latitude`, `Zip`, `Country`, `no_of_users`) VALUES
('2', 'Chennai', '13.0827 N', '80.2707 E', '600001', 'India', 2),
('3', 'Tokyo', '35.672 N', '139.6503 E', '1000001', 'Japan', 0),
('4', 'Paris', '48.8566 N', '2.3522 E', '75000', 'France', 1),
('5', 'Delhi', '28.7041 N', '7.1025 E', '110001', 'India', 1);

-- --------------------------------------------------------

--
-- Table structure for table `daily`
--

CREATE TABLE `daily` (
  `did` varchar(50) NOT NULL,
  `wid` varchar(50) NOT NULL,
  `dates` varchar(50) NOT NULL,
  `mint` varchar(50) NOT NULL,
  `maxt` varchar(50) NOT NULL,
  `avghum` varchar(50) NOT NULL,
  `sunr` varchar(50) NOT NULL,
  `suns` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hourly`
--

CREATE TABLE `hourly` (
  `hid` varchar(50) NOT NULL,
  `wid` varchar(50) NOT NULL,
  `temp` varchar(50) NOT NULL,
  `humidity` varchar(50) NOT NULL,
  `wind` varchar(50) NOT NULL,
  `direction` varchar(50) NOT NULL,
  `pressure` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hourly`
--

INSERT INTO `hourly` (`hid`, `wid`, `temp`, `humidity`, `wind`, `direction`, `pressure`) VALUES
('001', '111', '22', '21', '3', 'N', '1013');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `sno` int(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`sno`, `username`, `password`) VALUES
(1, 'admin', 'password'),
(2, 'monu', '12345'),
(3, 'abc', 'abc');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `wid` varchar(50) NOT NULL,
  `wstatus` varchar(50) NOT NULL,
  `City_ID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`wid`, `wstatus`, `City_ID`) VALUES
('111', 'Rainy', '2'),
('112', 'Sunny', '2'),
('113', 'Sunny', '4'),
('114', 'Cold', '5');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `City_ID` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `addon` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `name`, `City_ID`, `country`, `addon`) VALUES
('13', 'Chawang', '2', 'India', '26/11/19'),
('14', 'John', '4', 'France', '14/3/19'),
('15', 'Jeev', '5', 'India', '15/8/19'),
('16', 'Abc', '2', 'ac', 'ac');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `ct` AFTER INSERT ON `user` FOR EACH ROW UPDATE city c SET no_of_users = (SELECT COUNT(*) FROM user u WHERE u.City_ID=c.City_ID)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ut` AFTER DELETE ON `user` FOR EACH ROW UPDATE city c SET no_of_users = (SELECT COUNT(*) FROM user u WHERE u.City_ID=c.City_ID)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`City_ID`);

--
-- Indexes for table `daily`
--
ALTER TABLE `daily`
  ADD PRIMARY KEY (`did`),
  ADD KEY `daily_ibfk_1` (`wid`);

--
-- Indexes for table `hourly`
--
ALTER TABLE `hourly`
  ADD PRIMARY KEY (`hid`),
  ADD KEY `wid` (`wid`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`wid`),
  ADD KEY `City_ID` (`City_ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `user_ibfk_1` (`City_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `daily`
--
ALTER TABLE `daily`
  ADD CONSTRAINT `daily_ibfk_1` FOREIGN KEY (`wid`) REFERENCES `status` (`wid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hourly`
--
ALTER TABLE `hourly`
  ADD CONSTRAINT `wid` FOREIGN KEY (`wid`) REFERENCES `status` (`wid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `status`
--
ALTER TABLE `status`
  ADD CONSTRAINT `status_ibfk_1` FOREIGN KEY (`City_ID`) REFERENCES `city` (`City_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`City_ID`) REFERENCES `city` (`City_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
