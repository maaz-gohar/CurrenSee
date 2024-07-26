-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 13, 2024 at 08:35 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `practice`
--

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(11) NOT NULL,
  `from_currency` varchar(5) NOT NULL,
  `to_currency` varchar(5) NOT NULL,
  `rate` double NOT NULL,
  `amount` double NOT NULL,
  `converted_amount` double NOT NULL,
  `login_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `from_currency`, `to_currency`, `rate`, `amount`, `converted_amount`, `login_id`) VALUES
(1, 'USD', 'PKR', 278.72, 12, 3344.6400000000003, 3),
(3, 'USD', 'PKR', 278.72, 56, 15608.320000000002, 3),
(4, 'PKR', 'USD', 0.00359, 54, 0.19386, 3),
(5, 'PKR', 'ANG', 0.00642, 56, 0.35952, 4),
(6, 'OMR', 'ZMW', 65.95, 28, 1846.6000000000001, 4),
(7, 'USD', 'PGK', 3.88, 24, 93.12, NULL),
(8, 'PKR', 'AOA', 3.17, 56, 177.51999999999998, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `review` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `name`, `email`, `review`) VALUES
(1, 'abc', 'abc@gmail.com', 'recommended'),
(2, 'abcd', 'abcd@gmail.com', 'Highly recommended'),
(3, 'maaz', 'maaz@gmail.com', 'excellent');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `username`, `password`) VALUES
(3, 'abc@gmail.com', '1234'),
(4, 'abcd@gmail.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `user_table`
--

CREATE TABLE `user_table` (
  `uid` int(11) NOT NULL,
  `uname` varchar(100) NOT NULL,
  `uemail` varchar(100) NOT NULL,
  `upassword` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_table`
--

INSERT INTO `user_table` (`uid`, `uname`, `uemail`, `upassword`) VALUES
(3, 'Maaz altaf', 'maaz@gmail.com', '1234'),
(4, 'another record', 'A@gmail.com', '123'),
(5, 'hammard', 'abc@gmail.com', '123'),
(6, 'sammad', 's@gmail.com', '1234'),
(8, 'rahim', 'rahim@gmail.com', 'rahim123'),
(9, 'umair', 'umair@gmail.com', 'umair123'),
(10, 'umair', 'umair@gmail.com', 'umair123'),
(11, 'usama', 'usama@gmail.com', '1234'),
(13, 'mohsin', 'm@gmail.com', '5678');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_table`
--
ALTER TABLE `user_table`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_table`
--
ALTER TABLE `user_table`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `currencies`
--
ALTER TABLE `currencies`
  ADD CONSTRAINT `fk_login` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
