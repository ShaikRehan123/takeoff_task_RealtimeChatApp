-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2022 at 03:03 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chatbot`
--

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `q_date` varchar(255) NOT NULL,
  `a_date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `user_id`, `question`, `answer`, `q_date`, `a_date`) VALUES
(44, '19', 'Hello', '', '2022-06-17 13:08:29', ''),
(45, '19', 'Hello', '', '2022-06-17 13:08:29', ''),
(46, '61', 'Hello how to delete react.js globaly', '', '2022-06-17 15:43:05', ''),
(47, '17', 'You can run this in command like npm remove -g create-react-app', '', '2022-06-17 15:48:58', ''),
(48, '17', 'How to create Next.js App', '', '2022-06-17 15:50:06', ''),
(49, '61', 'you can do npx create-next-app@latest project_location', '', '2022-06-17 15:50:38', ''),
(50, '17', 'Ok Thanks', '', '2022-06-17 16:06:39', ''),
(51, '17', 'How to create angular App', '', '2022-06-17 16:07:10', ''),
(52, '17', 'Wassup', '', '2022-06-17 16:07:40', ''),
(53, '17', 'How to create Vue App', '', '2022-06-17 16:08:49', ''),
(54, '17', 'Say Quick', '', '2022-06-17 16:15:54', ''),
(55, '17', 'Please', '', '2022-06-17 16:16:04', ''),
(56, '17', 'Please I am createing next big website', '', '2022-06-17 16:18:05', ''),
(57, '17', 'Let me tell you secret I am creatin netflix', '', '2022-06-17 16:19:47', ''),
(58, '17', 'Hello', '', '2022-06-17 16:21:24', ''),
(59, '17', 'Are you there', '', '2022-06-17 16:21:28', ''),
(60, '61', 'Ruko zara sabar karo', 'Abe zelli bol sube panvel nikalna Hai', '2022-06-17 16:26:49', '2022-06-17 17:44:33'),
(61, '61', 'Really are you creating Netflix', 'No He is not', '2022-06-17 16:27:36', '2022-06-17 17:38:08'),
(62, '17', 'YEs', 'No', '2022-06-17 16:27:40', '2022-06-17 17:37:34'),
(63, '61', 'True', 'False', '2022-06-17 16:27:56', '2022-06-17 17:37:00'),
(64, '17', 'yes of course', 'OK', '2022-06-17 16:28:18', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `name` varchar(90) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(90) NOT NULL,
  `password` varchar(90) NOT NULL,
  `cretedOn` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `address` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `des` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `phone`, `email`, `password`, `cretedOn`, `address`, `type`, `des`) VALUES
(14, 1, 'ADMIN', '7410852096', 'admin@gmail.com', 'admin', '2020-05-02 13:32:50.151363', 'sfsf', '', ''),
(17, 2, 'sravani1', '7418529630', 'sravani@gmail.com', 'Sravani125', '2020-06-25 11:52:28.462859', 'address', 'Student', 'Description'),
(18, 2, 'dabud', '7418529630', 'uvbhv@gmail.com', '123', '2020-06-26 05:33:36.203483', 'addressh', 'Student', 'hygffvg '),
(19, 2, 'jghjb', '7418529630', 'uibubbhb@gmail.com', 'Madhubala123', '2020-06-25 11:33:24.482185', 'addressh', 'Guest', 'dercg'),
(20, 2, 'srdtvvdhshvhv', '7418529630', 'SR@gmail.com', 'Madhu123456', '2020-06-25 11:35:12.547999', 'addressh', 'Guest', 'dvgdcw e'),
(61, 0, 'Rehan Shaik', '8328519900', 'abacusrehan@gmail.com', 'Farruboti786', '2022-06-16 12:07:27.160502', '4-4-746, Is Mahal , Tirupati, Chittoor, Andhra Pradesh, South India, India, Earth, Solar System, Milky Way Galaxy. ', 'student', 'My name is Rehan Shaiik. I am a student');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
