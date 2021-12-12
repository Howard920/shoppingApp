-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2021 年 12 月 13 日 04:37
-- 伺服器版本： 10.3.29-MariaDB
-- PHP 版本： 7.4.18

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
-- 資料表結構 `advertisement`
--

CREATE TABLE `advertisement` (
  `id` int(11) NOT NULL,
  `image` varchar(1000) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- 傾印資料表的資料 `advertisement`
--

INSERT INTO `advertisement` (`id`, `image`) VALUES
(1, 'https://raw.githubusercontent.com/SiangTu/shoppingApp/thor/img/%E8%8C%B6%E8%91%89%E6%9E%95%E9%A0%AD%E5%B0%81%E9%9D%A2.jpg');

-- --------------------------------------------------------

--
-- 資料表結構 `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `category`
--

INSERT INTO `category` (`category_id`, `name`) VALUES
(1, '防疫商品'),
(2, '冷凍店取'),
(3, '箱購飲料'),
(4, '甜點蛋糕'),
(5, '素食蔬食'),
(6, '水產海鮮'),
(7, '生鮮肉品'),
(8, '3C週邊'),
(9, '生活日用'),
(10, '餅乾零食'),
(11, '熟食小吃'),
(12, '保健商品'),
(13, '毛小孩'),
(14, '家具廚具'),
(15, '美妝用品'),
(16, '首飾配件'),
(17, '服飾'),
(18, '包包提袋'),
(19, '文創商品'),
(20, '文/玩具');

-- --------------------------------------------------------

--
-- 資料表結構 `category_product`
--

CREATE TABLE `category_product` (
  `category_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `category_product`
--

INSERT INTO `category_product` (`category_id`, `item_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10);

-- --------------------------------------------------------

--
-- 資料表結構 `member`
--

CREATE TABLE `member` (
  `member_id_phone` char(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `gender` int(11) NOT NULL,
  `birthday` varchar(22) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `buy_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `like_list` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- 傾印資料表的資料 `member`
--

INSERT INTO `member` (`member_id_phone`, `password`, `name`, `gender`, `birthday`, `address`, `buy_list`, `like_list`) VALUES
('0900000000', '123', '劉秋萍', 0, '1980-01-12', '美國洛杉磯34街一號', '[111111111,11111119]\r\n', '[111111111,11111119]\r '),
('0911111111', '123', '劉振隆', 1, '2000-01-01', '台北市德惠街173號五樓', '[111111111,11111111]\r\n', '[111111111,11111119]\r '),
('0922222222', '123', '林葦婷', 0, '1980-01-12', '台北林口長庚大道一號', '[111111111,11111111]\r ', '[111111111,11111119]\r '),
('0933333333', '123', '劉超', 1, '1984-02-19', '台北市大安區基隆路一號', '[111111111,11111112]\r\n', '[111111111,11111119]\r '),
('0944444444', '123', '劉欣', 0, '1989-11-15', '台北市大安區基隆路2號', '[111111111,11111113]\r\n', '[111111111,11111119]\r '),
('0955555555', '123', '劉超人', 0, '1989-2-12', '台北市大安區基隆路3號', '[111111111,11111114]\r\n', '[111111111,11111119]\r '),
('0966666666', '123', '林雨景', 0, '1990-03-19', '新北市土城區大道一號', '[111111111,11111115]\r\n', '[111111111,11111119]\r '),
('0977777777', '123', '李愛', 0, '1990-03-12', '新北市土城區大道4號', '[111111111,11111116]\r\n', '[111111111,11111119]\r '),
('0988888888', '123', '李意珍', 0, '1990-01-12', '新北市土城區大道5號', '[111111111,11111117]\r\n', '[111111111,11111119]\r '),
('0999999999', '123', '李麗珍', 0, '1990-01-12', '香港區九龍大道一號', '[111111111,11111118]\r\n', '[111111111,11111119]\r ');

-- --------------------------------------------------------

--
-- 資料表結構 `order_list`
--

CREATE TABLE `order_list` (
  `order_id` int(11) NOT NULL,
  `member_id_phone` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `shipment` enum('7-11取貨','全家取貨','宅配','') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment` enum('超商取貨付款','Apple Pay','信用卡一次付清','') COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_date` date DEFAULT NULL,
  `order_person_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_person_phone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_person_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_person_email` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `order_list`
--

INSERT INTO `order_list` (`order_id`, `member_id_phone`, `price`, `shipment`, `payment`, `order_date`, `order_person_name`, `order_person_phone`, `order_person_address`, `order_person_email`) VALUES
(1, '0955555555', 0, '', '', NULL, NULL, NULL, NULL, NULL),
(2, '0955555555', 0, '', '', NULL, NULL, NULL, NULL, NULL),
(4, '0900000000', 0, '7-11取貨', '超商取貨付款', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `order_product`
--

CREATE TABLE `order_product` (
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `order_product`
--

INSERT INTO `order_product` (`order_id`, `item_id`, `item_count`) VALUES
(4, 1, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `popular_keyword`
--

CREATE TABLE `popular_keyword` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `count` int(11) NOT NULL
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

-- --------------------------------------------------------

--
-- 資料表結構 `product_info`
--

CREATE TABLE `product_info` (
  `item_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `media_info` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `payment` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `delivery` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- 傾印資料表的資料 `product_info`
--

INSERT INTO `product_info` (`item_id`, `name`, `price`, `quantity`, `detail`, `vendor_id`, `media_info`, `payment`, `delivery`) VALUES
(1, '常香健枕頭', 980, 999, '{\"說明\": \"枕頭\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(2, '常香健雙人加大床墊', 4300, 9999, '{\"說明\": \"床墊\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E5%BA%8A%E5%A2%8A/%E8%8C%B6%E8%91%89%E5%BA%8A%E5%A2%8A.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(3, '常香健雙人床墊-弘道實業有限公司出品', 3600, 9999, '{\"說明\": \"床墊\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E5%BA%8A%E5%A2%8A/%E8%8C%B6%E8%91%89%E5%BA%8A%E5%A2%8A.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(4, '常香健超強除鞋臭茶香包', 599, 99999999, '{\"說明\": \"茶香包\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E5%BA%8A%E5%A2%8A/%E8%8C%B6%E8%91%89%E5%BA%8A%E5%A2%8A.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(5, '常香健鐵觀音抱枕', 288, 99999999, '{\"說明\": \"全球獨家茶葉抱枕\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%8A%B1%E6%9E%95/%E5%B0%81%E9%9D%A2.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(6, '常香健鐵觀音頭枕', 288, 99999999, '{\"說明\": \"全球獨家茶葉頭枕\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%8A%B1%E6%9E%95/%E5%B0%81%E9%9D%A2.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(7, '常香健鐵觀音頭枕', 288, 99999999, '{\"說明\": \"全球獨家茶葉頭枕\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%8A%B1%E6%9E%95/%E5%B0%81%E9%9D%A2.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(8, '常香健鐵觀音透氣座墊', 1299, 99999999, '{\"說明\": \"坐墊\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E8%BB%8A%E5%A2%8A/%E8%90%AC%E7%94%A8%E6%A4%85%E5%A2%8A.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(9, '常香健鐵觀音透氣沙發座墊-弘道實業有限公司出品', 1299, 99999999, '{\"說明\": \"坐墊\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E8%BB%8A%E5%A2%8A/%E8%90%AC%E7%94%A8%E6%A4%85%E5%A2%8A.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(10, '常香健鐵觀音超值11件車墊高級套裝組-弘道實業有限公司出品', 16000, 99999999, '{\"說明\": \"車墊\"}', 1, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E8%BB%8A%E5%A2%8A/Car1.jpg', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(11, '【亞尼克】亞尼克生乳捲特黑，324g，共1入\n', 565, 999, '{\"成份\": \"特黑－日本奶霜乳製品（牛奶）、食用植物油脂（棕櫚仁油、棕櫚油）、糊精、乳清蛋白、乳糖、乳化劑（脂肪酸甘油酯、大豆卵磷脂、脂肪酸蔗糖酯）、纖維素、乳清、香料、雞蛋、鮮奶、砂糖、日本麵粉、奶油、可可粉、蛋白粉\", \"規格\": \"324G／18CM一條，共1條\"}', 1, 'https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7253814/0/637739494702870000?v=1', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(12, '【晟品凍洋】極凍超厚切鮭魚，400g±10%/包*10包\n', 2750, 999, '{\"成份\": \"鮭魚\", \"規格\": \"400g±10％／包（10包)\"}', 1, 'https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7430949/0/637727440456630000?v=1', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]'),
(13, '【Samsung】三星Galaxy智慧手錶，Watch4 BT 40mm R860', 8990, 999, '{\"型號\": \"R860（幻影黑、鈦灰銀、玫瑰金\", \"產地\": \"越南\"}', 1, 'https://diz36nn4q02zr.cloudfront.net/webapi/imagesV3/Original/SalePage/7446448/0/637731710733930000?v=1', '[\"7-11取貨\",“全家取貨”,”宅配“]', '[\"超商貨到付款\",\"Apple Pay\",\"信用卡一次付清\"]');

-- --------------------------------------------------------

--
-- 資料表結構 `vendor_info`
--

CREATE TABLE `vendor_info` (
  `vendor_id` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` int(11) NOT NULL,
  `logo` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `contact` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `payment` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- 傾印資料表的資料 `vendor_info`
--

INSERT INTO `vendor_info` (`vendor_id`, `name`, `address`, `phone`, `logo`, `contact`, `payment`) VALUES
(1, '弘道實業有限公司', '台北市德惠街173號五樓', 25961396, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E5%B8%B8%E9%A6%99%E5%81%A5logo/3.jpg', '劉振隆', '月結30天'),
(2, '常香健有限公司', '台北市德惠街173號', 25961324, 'https://github.com/scott93723/happy_shop_api/blob/main/%E5%B8%B8%E9%A6%99%E5%81%A5logo/43201722_2264559010456023_549238261738897408_n.jpg?raw=true', '劉天', '月結60天'),
(3, '台灣積體電路有限公司', '高雄發大財一號', 7234567, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '劉德音', '月結60天'),
(4, '長榮航空公司', '桃園機場路一號', 25963455, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '劉冰', '月結60天'),
(5, '中華航空公司', '桃園機場路2號', 325962340, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '劉天仙', '月結60天'),
(6, '台灣三星電子分公司', '桃園亞洲矽谷領航北路二段一號', 352362340, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '戴天', '月結60天'),
(7, '亞洲矽谷寶哥集團', '桃園亞洲矽谷領航北路二段一號', 352362345, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '林雨璟', '月結60天'),
(8, '李愛花藝有限公司', '桃園亞洲矽谷領航南路三段124號', 352362323, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '李明潔', '月結60天'),
(9, '林神經外科診所', '桃園亞洲矽谷領航南路三段14號', 352362325, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '林葦婷', '月結60天'),
(10, '劉家生物科技有限公司', '桃園亞洲矽谷領航南路三段234號', 352362312, 'https://raw.githubusercontent.com/scott93723/happy_shop_api/main/%E6%9E%95%E9%A0%AD/8%E8%8C%B6%E8%91%89%E6%9E%95.jpg', '劉秋萍', '月結60天');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `advertisement`
--
ALTER TABLE `advertisement`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- 資料表索引 `category_product`
--
ALTER TABLE `category_product`
  ADD PRIMARY KEY (`category_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- 資料表索引 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`member_id_phone`);

--
-- 資料表索引 `order_list`
--
ALTER TABLE `order_list`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `member_id_phone` (`member_id_phone`);

--
-- 資料表索引 `order_product`
--
ALTER TABLE `order_product`
  ADD PRIMARY KEY (`order_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- 資料表索引 `popular_keyword`
--
ALTER TABLE `popular_keyword`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `product_info`
--
ALTER TABLE `product_info`
  ADD PRIMARY KEY (`item_id`);

--
-- 資料表索引 `vendor_info`
--
ALTER TABLE `vendor_info`
  ADD PRIMARY KEY (`vendor_id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `order_list`
--
ALTER TABLE `order_list`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `product_info`
--
ALTER TABLE `product_info`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `category_product`
--
ALTER TABLE `category_product`
  ADD CONSTRAINT `category_product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `category_product_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `product_info` (`item_id`);

--
-- 資料表的限制式 `order_list`
--
ALTER TABLE `order_list`
  ADD CONSTRAINT `order_list_ibfk_1` FOREIGN KEY (`member_id_phone`) REFERENCES `member` (`member_id_phone`);

--
-- 資料表的限制式 `order_product`
--
ALTER TABLE `order_product`
  ADD CONSTRAINT `order_product_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `product_info` (`item_id`),
  ADD CONSTRAINT `order_product_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order_list` (`order_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
