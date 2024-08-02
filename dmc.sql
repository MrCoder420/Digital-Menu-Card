-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2024 at 07:38 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dmc`
--

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `item_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `psize_id` bigint(20) UNSIGNED DEFAULT NULL,
  `createdat` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `item_name`, `price`, `item_type_id`, `psize_id`, `createdat`) VALUES
(1, 'Veg Pizza', 79.00, 1, 1, '2024-07-31 04:58:05'),
(3, 'Soda', 20.00, 3, 4, '2024-07-31 04:58:05'),
(4, 'Cheese Burger', 150.00, 2, 3, '2024-07-31 04:58:05'),
(5, 'Pav Bhaji', 120.00, 1, 3, '2024-07-31 04:58:05');

-- --------------------------------------------------------

--
-- Table structure for table `item_type`
--

CREATE TABLE `item_type` (
  `tid` bigint(20) UNSIGNED NOT NULL,
  `tname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item_type`
--

INSERT INTO `item_type` (`tid`, `tname`) VALUES
(6, 'CHINESE'),
(3, 'DRINK'),
(2, 'NON_VEG'),
(4, 'SNACKS'),
(9, 'SOUP'),
(5, 'STARTERS'),
(1, 'VEG');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_amount`) VALUES
(1, 11, '2024-07-31 22:15:30', 79.00),
(2, 11, '2024-07-31 22:18:07', 79.00),
(3, 11, '2024-07-31 22:20:20', 79.00),
(4, 11, '2024-07-31 22:20:23', 79.00),
(5, 11, '2024-07-31 22:21:06', 79.00),
(6, 11, '2024-07-31 22:21:37', 79.00),
(7, 11, '2024-07-31 22:22:28', 79.00),
(8, 8, '2024-07-31 22:27:24', 79.00),
(9, 8, '2024-07-31 22:27:29', 79.00),
(10, 8, '2024-07-31 22:27:34', 79.00),
(11, 8, '2024-07-31 22:32:14', 79.00),
(12, 8, '2024-07-31 22:32:20', 20.00),
(13, 8, '2024-07-31 22:37:13', 79.00),
(14, 8, '2024-07-31 22:37:18', 79.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `psize`
--

CREATE TABLE `psize` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ps` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `psize`
--

INSERT INTO `psize` (`id`, `ps`) VALUES
(3, ''),
(4, '100ml'),
(5, '250ml'),
(6, '500ml'),
(2, 'FULL PLATE'),
(1, 'HALF PLATE');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `mobile_no` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `mobile_no`) VALUES
(1, 'nikky', 'email', '123', '0000000001'),
(2, 'testuser', 'test@example.com', '$2y$10$RiF2exHK5lgIGjTp0bfi3.tNoxqD0m9cuSCjEiBBdbzvx14ifFwf2', '0000000002'),
(8, 'nihkil', 'n@c.c', '$2y$10$OATJVukmu6gBhkVY1eTFhOLRLIiQXXFFXFbOK9xIFJ.b9I.O1sfva', '1234567890'),
(9, 'n', 'k@c.c', '$2y$10$ToqGDL1DVt/NQVl/KBthEenA4JihwKKrD0XyVndVVaAKgvRm7HTWS', '000000'),
(10, 'j', 'w@s.s', '$2y$10$T1RrY.QWSOmDUYFd2m.uA.URGxAVGZbYlXx2Bm2GDW8WmHQm6OjvO', '1234567899'),
(11, 'nikhil11', 'nikhil@gmail.com', '$2y$10$Sk0pEr8N6ZO6FEl1lr8/ZenAO7Ro/bRXuaQ3SuVsRFol7itHqD0pu', '2222222222'),
(12, 'darshan', 'darshan@gmail.com', '$2y$10$6vS0c9BFgpZYh.HHThMWheOUzYdI3pEAmCVGmyK0LYj.wtU/fBygS', '7822819029');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_type_id` (`item_type_id`),
  ADD KEY `psize_id` (`psize_id`);

--
-- Indexes for table `item_type`
--
ALTER TABLE `item_type`
  ADD UNIQUE KEY `tid` (`tid`),
  ADD UNIQUE KEY `tname` (`tname`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `psize`
--
ALTER TABLE `psize`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `ps` (`ps`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `mobile_no` (`mobile_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `item_type`
--
ALTER TABLE `item_type`
  MODIFY `tid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `psize`
--
ALTER TABLE `psize`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`item_type_id`) REFERENCES `item_type` (`tid`),
  ADD CONSTRAINT `items_ibfk_2` FOREIGN KEY (`psize_id`) REFERENCES `psize` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
