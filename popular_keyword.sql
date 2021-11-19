-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2021 年 11 月 19 日 20:37
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
-- 資料表結構 `popular_keyword`
--

CREATE TABLE `popular_keyword` (
  `id` int(100) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `count` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- 傾印資料表的資料 `popular_keyword`
--

INSERT INTO `popular_keyword` (`id`, `name`, `count`) VALUES
(1, '常相見', 988990),
(2, '常香健鐵觀音床墊雙人加大尺寸', 790534),
(3, '鐵觀音茶葉', 970000),
(4, '弘道實業', 888888),
(5, '常香健鐵觀音茶香包', 567856),
(7, '茶葉', 321234),
(8, '頭枕', 312222),
(9, '頭枕組合', 312222),
(10, '靠枕', 302222),
(11, '弘道', 299999),
(12, '弘道實業', 288888),
(13, '弘道實業有限公司', 277777),
(14, 'KA', 266666),
(15, 'MH', 255555),
(16, 'Meeting Health', 244444),
(17, '茶香健', 233333),
(18, '坐墊', 222222),
(19, '椅墊', 211111),
(20, '烏龍茶', 200000),
(21, '高山鐵觀音茶葉', 198349),
(22, '弘道實業', 888888),
(23, '高級健康', 188888),
(24, '睡眠', 177777),
(25, '失眠', 166666),
(26, '全球最大茶葉寢具製造商', 123456),
(27, '全球第一茶香', 133333),
(28, '全球唯一獨家專利', 122222),
(29, '茶葉國度', 111111),
(30, '茶香世界', 102222),
(31, '1987年創立', 98534),
(32, '全球最大魚池製造商', 97234),
(33, '茶葉用品帝國', 95678),
(34, '除臭天王', 93534),
(35, '除鞋臭無敵強', 93456),
(36, '完美無瑕車縫線', 92578),
(37, '堅持天然無毒', 91234),
(38, '通過SGS認證', 90356),
(39, '通過國家標準CNS認證', 90212),
(40, '無效三個月退費', 90123);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `popular_keyword`
--
ALTER TABLE `popular_keyword`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
