-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2021 年 11 月 27 日 21:55
-- 伺服器版本： 10.3.29-MariaDB
-- PHP 版本： 7.3.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `happy_shop`
--

-- --------------------------------------------------------

--
-- 資料表結構 `member`
--

CREATE TABLE `member` (
  `member_id` int(10) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `gender` int(10) NOT NULL,
  `birthday` varchar(22) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` int(10) NOT NULL,
  `buy_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `like_list` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- 傾印資料表的資料 `member`
--

INSERT INTO `member` (`member_id`, `name`, `gender`, `birthday`, `address`, `phone`, `buy_list`, `like_list`) VALUES
(1, '劉振隆', 1, '2000-01-01', '台北市德惠街173號五樓', 25961396, '[111111111,11111111]\r\n', '[22222,222222'),
(2, '劉超', 1, '1220', '台北市大安區基隆路一號', 259612345, '[111111111,11111112]\r\n', '[22222,222223]'),
(3, '劉欣', 0, '1989', '台北市大安區基隆路2號', 25963455, '[111111111,11111113]\r\n', '[22222,222224]'),
(4, '劉超人', 0, '1989', '台北市大安區基隆路3號', 259631234, '[111111111,11111114]\r\n', '[22222,2222255]'),
(5, '林雨景', 0, '1990-03-19', '新北市土城區大道一號', 912345567, '[111111111,11111115]\r\n', '[22222,22222556]'),
(6, '李愛', 0, '1990-03-12', '新北市土城區大道4號', 912345678, '[111111111,11111116]\r\n', '[111111111,11111116]\r\n'),
(7, '李意珍', 0, '1990-01-12', '新北市土城區大道5號', 912345678, '[111111111,11111117]\r\n', '[111111111,11111117]\r\n'),
(8, '李麗珍', 0, '1990-01-12', '香港區九龍大道一號', 912345234, '[111111111,11111118]\r\n', '[111111111,11111118]\r\n'),
(9, '劉秋萍', 0, '1980-01-12', '美國洛杉磯34街一號', 912345290, '[111111111,11111119]\r\n', '[111111111,11111118]\r\n'),
(10, '林葦婷', 0, '1980-01-12', '台北林口長庚大道一號', 912342356, '[111111111,1111111912]\r\n', '[111111111,1111111812]\r\n');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`member_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
