-- phpMyAdmin SQL Dump
-- Microfinance Management System - Sri Lanka Edition
-- Database: `mydb`
-- Currency: LKR (Sri Lankan Rupees)

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

CREATE TABLE `customer` (
  `cus_id` int(11) NOT NULL,
  `scheme_id` int(11) NOT NULL,
  `scheme_name` varchar(200) NOT NULL,
  `scheme_amount` float NOT NULL,
  `installment_amount` float NOT NULL,
  `cus_name` varchar(255) NOT NULL,
  `cus_contact` varchar(255) NOT NULL,
  `cus_address` varchar(255) NOT NULL,
  `cus_asset` varchar(255) NOT NULL,
  `asset_price` float NOT NULL,
  `img` varchar(200) NOT NULL,
  `date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `customer` (`cus_id`, `scheme_id`, `scheme_name`, `scheme_amount`, `installment_amount`, `cus_name`, `cus_contact`, `cus_address`, `cus_asset`, `asset_price`, `img`, `date`) VALUES
(1, 1, 'Housing Loan', 500000, 41666.67, 'Kumara Perera', '0771234567', 'No 45, Galle Road, Colombo 03', 'Gold Jewelry', 150000, '[000274].jpg', '2025-01-15'),
(2, 1, 'Housing Loan', 500000, 41666.67, 'Nimal Fernando', '0772345678', 'Temple Road, Kandy', 'Motorcycle', 200000, '[000040].jpg', '2025-01-20'),
(3, 2, 'Business Loan', 300000, 50000, 'Sanduni Silva', '0773456789', 'Main Street, Galle', 'Shop Equipment', 180000, '[000658].jpg', '2025-02-01'),
(4, 3, 'Education Loan', 150000, 25000, 'Kasun Rajapaksa', '0774567890', 'Station Road, Negombo', 'Laptop & Books', 80000, '[000279].jpg', '2025-02-10'),
(5, 2, 'Business Loan', 300000, 50000, 'Chamari Wickramasinghe', '0775678901', 'Market Street, Matara', 'Sewing Machines', 120000, '[000033].jpg', '2025-02-15'),
(6, 1, 'Housing Loan', 500000, 41666.67, 'Pradeep Jayawardena', '0776789012', 'Lake Road, Kurunegala', 'Land Title', 800000, '[000033].jpg', '2025-02-20'),
(7, 3, 'Education Loan', 150000, 25000, 'Dilini Amarasinghe', '0777890123', 'School Lane, Anuradhapura', 'Gold Chain', 90000, '[000033].jpg', '2025-02-25'),
(8, 4, 'Vehicle Loan', 800000, 66666.67, 'Roshan De Silva', '0778901234', 'Beach Road, Hikkaduwa', 'Three-Wheeler', 400000, 'download.jpg', '2026-01-05'),
(9, 2, 'Business Loan', 300000, 50000, 'Malini Gunasekara', '0779012345', 'Temple Street, Jaffna', 'Refrigerator', 150000, 'images.jpg', '2026-01-15'),
(10, 4, 'Vehicle Loan', 800000, 66666.67, 'Anil Bandara', '0770123456', 'Hill Street, Nuwara Eliya', 'Van', 500000, 'download (1).jpg', '2026-02-01');

-- --------------------------------------------------------

CREATE TABLE `installment` (
  `install_id` int(11) NOT NULL,
  `cus_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `remaining` float NOT NULL,
  `status` varchar(11) NOT NULL,
  `fine` float NOT NULL,
  `ins_date` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `installment` (`install_id`, `cus_id`, `amount`, `remaining`, `status`, `fine`, `ins_date`) VALUES
(1, 1, 41666.67, 458333.33, 'On Time', 0, '2025-02-15'),
(2, 1, 41666.67, 416666.66, 'On Time', 0, '2025-03-15'),
(3, 2, 41666.67, 458333.33, 'Late', 833.33, '2025-03-05'),
(4, 3, 50000, 250000, 'On Time', 0, '2025-03-01'),
(5, 3, 50000, 200000, 'On Time', 0, '2025-04-01'),
(6, 4, 25000, 125000, 'On Time', 0, '2025-03-10'),
(7, 5, 50000, 250000, 'Late', 1000, '2025-04-20'),
(8, 6, 41666.67, 458333.33, 'On Time', 0, '2025-03-20'),
(9, 7, 25000, 125000, 'On Time', 0, '2025-03-25'),
(10, 8, 66666.67, 733333.33, 'On Time', 0, '2026-02-05'),
(11, 9, 50000, 250000, 'Late', 1000, '2026-03-01'),
(12, 10, 66666.67, 733333.33, 'On Time', 0, '2026-03-01');

-- --------------------------------------------------------

CREATE TABLE `loan_info` (
  `scheme_id` int(11) NOT NULL,
  `cus_id` int(11) NOT NULL,
  `scheme_amount` float NOT NULL,
  `remaining_amount` float NOT NULL,
  `installment_no` int(11) NOT NULL,
  `installment_remaining` int(11) NOT NULL,
  `installment_amount` float NOT NULL,
  `date` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `loan_info` (`scheme_id`, `cus_id`, `scheme_amount`, `remaining_amount`, `installment_no`, `installment_remaining`, `installment_amount`, `date`) VALUES
(1, 1, 500000, 416666.66, 12, 10, 41666.67, '2025-01-15'),
(1, 2, 500000, 458333.33, 12, 11, 41666.67, '2025-01-20'),
(2, 3, 300000, 200000, 6, 4, 50000, '2025-02-01'),
(3, 4, 150000, 125000, 6, 5, 25000, '2025-02-10'),
(2, 5, 300000, 250000, 6, 5, 50000, '2025-02-15'),
(1, 6, 500000, 458333.33, 12, 11, 41666.67, '2025-02-20'),
(3, 7, 150000, 125000, 6, 5, 25000, '2025-02-25'),
(4, 8, 800000, 733333.33, 12, 11, 66666.67, '2026-01-05'),
(2, 9, 300000, 250000, 6, 5, 50000, '2026-01-15'),
(4, 10, 800000, 733333.33, 12, 11, 66666.67, '2026-02-01');

-- --------------------------------------------------------

CREATE TABLE `schedule` (
  `install_no` int(11) NOT NULL,
  `cus_id` int(11) NOT NULL,
  `cus_name` varchar(200) NOT NULL,
  `Time` varchar(255) NOT NULL,
  `status` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `schedule` (`install_no`, `cus_id`, `cus_name`, `Time`, `status`) VALUES
(1, 1, 'Kumara Perera', '2025-02-15', 'paid'),
(2, 1, 'Kumara Perera', '2025-03-15', 'paid'),
(3, 1, 'Kumara Perera', '2025-04-15', 'unpaid'),
(4, 1, 'Kumara Perera', '2025-05-15', 'unpaid'),
(5, 1, 'Kumara Perera', '2025-06-15', 'unpaid'),
(6, 1, 'Kumara Perera', '2025-07-15', 'unpaid'),
(7, 1, 'Kumara Perera', '2025-08-15', 'unpaid'),
(8, 1, 'Kumara Perera', '2025-09-15', 'unpaid'),
(9, 1, 'Kumara Perera', '2025-10-15', 'unpaid'),
(10, 1, 'Kumara Perera', '2025-11-15', 'unpaid'),
(11, 1, 'Kumara Perera', '2025-12-15', 'unpaid'),
(12, 1, 'Kumara Perera', '2026-01-15', 'unpaid'),
(1, 2, 'Nimal Fernando', '2025-02-20', 'unpaid'),
(2, 2, 'Nimal Fernando', '2025-03-20', 'paid'),
(3, 2, 'Nimal Fernando', '2025-04-20', 'unpaid'),
(4, 2, 'Nimal Fernando', '2025-05-20', 'unpaid'),
(5, 2, 'Nimal Fernando', '2025-06-20', 'unpaid'),
(6, 2, 'Nimal Fernando', '2025-07-20', 'unpaid'),
(7, 2, 'Nimal Fernando', '2025-08-20', 'unpaid'),
(8, 2, 'Nimal Fernando', '2025-09-20', 'unpaid'),
(9, 2, 'Nimal Fernando', '2025-10-20', 'unpaid'),
(10, 2, 'Nimal Fernando', '2025-11-20', 'unpaid'),
(11, 2, 'Nimal Fernando', '2025-12-20', 'unpaid'),
(12, 2, 'Nimal Fernando', '2026-01-20', 'unpaid'),
(1, 3, 'Sanduni Silva', '2025-03-01', 'paid'),
(2, 3, 'Sanduni Silva', '2025-04-01', 'paid'),
(3, 3, 'Sanduni Silva', '2025-05-01', 'unpaid'),
(4, 3, 'Sanduni Silva', '2025-06-01', 'unpaid'),
(5, 3, 'Sanduni Silva', '2025-07-01', 'unpaid'),
(6, 3, 'Sanduni Silva', '2025-08-01', 'unpaid'),
(1, 4, 'Kasun Rajapaksa', '2025-03-10', 'paid'),
(2, 4, 'Kasun Rajapaksa', '2025-04-10', 'unpaid'),
(3, 4, 'Kasun Rajapaksa', '2025-05-10', 'unpaid'),
(4, 4, 'Kasun Rajapaksa', '2025-06-10', 'unpaid'),
(5, 4, 'Kasun Rajapaksa', '2025-07-10', 'unpaid'),
(6, 4, 'Kasun Rajapaksa', '2025-08-10', 'unpaid'),
(1, 5, 'Chamari Wickramasinghe', '2025-03-15', 'unpaid'),
(2, 5, 'Chamari Wickramasinghe', '2025-04-15', 'paid'),
(3, 5, 'Chamari Wickramasinghe', '2025-05-15', 'unpaid'),
(4, 5, 'Chamari Wickramasinghe', '2025-06-15', 'unpaid'),
(5, 5, 'Chamari Wickramasinghe', '2025-07-15', 'unpaid'),
(6, 5, 'Chamari Wickramasinghe', '2025-08-15', 'unpaid'),
(1, 8, 'Roshan De Silva', '2026-02-05', 'paid'),
(2, 8, 'Roshan De Silva', '2026-03-05', 'unpaid'),
(3, 8, 'Roshan De Silva', '2026-04-05', 'unpaid'),
(4, 8, 'Roshan De Silva', '2026-05-05', 'unpaid'),
(5, 8, 'Roshan De Silva', '2026-06-05', 'unpaid'),
(6, 8, 'Roshan De Silva', '2026-07-05', 'unpaid'),
(7, 8, 'Roshan De Silva', '2026-08-05', 'unpaid'),
(8, 8, 'Roshan De Silva', '2026-09-05', 'unpaid'),
(9, 8, 'Roshan De Silva', '2026-10-05', 'unpaid'),
(10, 8, 'Roshan De Silva', '2026-11-05', 'unpaid'),
(11, 8, 'Roshan De Silva', '2026-12-05', 'unpaid'),
(12, 8, 'Roshan De Silva', '2027-01-05', 'unpaid');

-- --------------------------------------------------------

CREATE TABLE `scheme` (
  `scheme_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `amount` float NOT NULL,
  `r_asset` varchar(100) NOT NULL,
  `no_installment` int(11) NOT NULL,
  `Install_amount` float NOT NULL,
  `duration` varchar(20) NOT NULL,
  `date` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `scheme` (`scheme_id`, `name`, `amount`, `r_asset`, `no_installment`, `Install_amount`, `duration`, `date`) VALUES
(1, 'Housing Loan', 500000, 'Property', 12, 41666.67, 'month', '2025-01-01'),
(2, 'Business Loan', 300000, 'Machinery', 6, 50000, 'month', '2025-01-01'),
(3, 'Education Loan', 150000, 'None', 6, 25000, 'month', '2025-01-01'),
(4, 'Vehicle Loan', 800000, 'Car', 12, 66666.67, 'month', '2026-01-01');

-- --------------------------------------------------------

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `father_name` varchar(200) NOT NULL,
  `likee` varchar(200) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `time` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `users` (`id`, `name`, `email`, `father_name`, `likee`, `pass`, `time`) VALUES
(1, 'Admin User', 'test1@gmail.com', '', '', '12345', '2025-01-01'),
(2, 'Saman Kumara', 'saman@microfinance.lk', 'W.A. Kumara', 'cricket', '12345', '2025-01-15'),
(3, 'Nadeeka Silva', 'nadeeka@microfinance.lk', 'H.M. Silva', 'reading', '12345', '2025-02-01');

-- --------------------------------------------------------

ALTER TABLE `customer`
  ADD PRIMARY KEY (`cus_id`),
  ADD KEY `scheme` (`scheme_id`);

ALTER TABLE `installment`
  ADD PRIMARY KEY (`install_id`);

ALTER TABLE `loan_info`
  ADD KEY `scheme_id` (`scheme_id`),
  ADD KEY `cus_id` (`cus_id`);

ALTER TABLE `schedule`
  ADD KEY `cus_id` (`cus_id`);

ALTER TABLE `scheme`
  ADD PRIMARY KEY (`scheme_id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `customer`
  MODIFY `cus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `installment`
  MODIFY `install_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

ALTER TABLE `loan_info`
  MODIFY `cus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `scheme`
  MODIFY `scheme_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
