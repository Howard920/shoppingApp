-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2021 年 11 月 28 日 09:34
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
-- 資料表結構 `vendor_info`
--

CREATE TABLE `vendor_info` (
  `vendor_id` int(10) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` int(22) NOT NULL,
  `logo` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `contact` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `payment` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- 傾印資料表的資料 `vendor_info`
--

INSERT INTO `vendor_info` (`vendor_id`, `name`, `address`, `phone`, `logo`, `contact`, `payment`) VALUES
(1, '弘道實業有限公司', '台北市德惠街173號五樓', 25961396, '', '劉振隆', '月結30天'),
(2, '超人實業有限公司', '台北市德惠街173號', 25961324, '', '劉天', '月結60天'),
(3, '台灣積體電路有限公司', '高雄發大財一號', 7234567, '', '劉德音', '月結60天'),
(4, '長榮航空公司', '桃園機場路一號', 25963455, '', '劉冰', '月結60天'),
(5, '中華航空公司', '桃園機場路2號', 325962340, '', '劉天仙', '月結60天'),
(6, '台灣三星電子分公司', '桃園亞洲矽谷領航北路二段一號', 352362340, '', '戴天', '月結60天'),
(7, '亞洲矽谷寶哥集團', '桃園亞洲矽谷領航北路二段一號', 352362345, '', '林雨璟', '月結60天'),
(8, '李愛花藝有限公司', '桃園亞洲矽谷領航南路三段124號', 352362323, '', '李明潔', '月結60天'),
(9, '林神經外科診所', '桃園亞洲矽谷領航南路三段14號', 352362325, '', '林葦婷', '月結60天'),
(10, '劉家生物科技有限公司', '桃園亞洲矽谷領航南路三段234號', 352362312, '', '劉秋萍', '月結60天');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `vendor_info`
--
ALTER TABLE `vendor_info`
  ADD PRIMARY KEY (`vendor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
