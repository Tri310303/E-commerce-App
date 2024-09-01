
--
-- Host: localhost    Database: EcommerceDB
-- ------------------------------------------------------
-- Server version	8.0.27
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Đồ gia dụng',NULL),
                              (2,'Quần áo',NULL),
                              (3,'Máy tính xách tay',NULL),
                              (4,'Điện thoại thông minh',NULL),
                              (5,'Túi đeo chéo',NULL),
                              (6,'Phụ kiện',NULL),
                              (7,'Âm thanh',NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_idx` (`product_id`),
  KEY `fk_user_idx` (`user_id`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'Hài lòng với chất lượng sản phẩm',6,1,'2024-05-23 22:24:00'),
                              (2,'Sản phẩm tuyệt vời so với mức mong đợi',7,1,'2024-05-25 20:24:00'),
                              (3,'Giá cả hợp lý',6,1,'2003-12-25 21:24:00'),
                              (4,'Sản phẩm quá đã',6,1,'2003-03-31 00:00:00'),
                              (5,'Pha quế',6,1,'2024-06-01 00:00:00'),
                              (6,'Hài lòng với chất lượng sản phẩm',6,2,'2024-05-23 22:24:00'),
                              (7,'Sản phẩm tuyệt vời so với mức mong đợi',7,2,'2024-05-25 20:24:00'),
                              (8,'Giá cả hợp lý',6,2,'2003-12-25 21:24:00'),
                              (9,'Sản phẩm quá đã',6,2,'2003-03-31 00:00:00'),
                              (10,'Pha quế',6,2,'2024-06-01 00:00:00'),
                              (11,'Vô địch tầm giá',6,37,'2024-05-23 22:24:00'),
                              (12,'Sản phẩm tuyệt đẹp, sẽ mua thêm cái nữa',7,37,'2024-05-25 20:24:00'),
                              (13,'Giao hàng nhanh vừa kịp đi du lịch',6,37,'2003-12-25 21:24:00'),
                              (14,'Sản phẩm quá đã',6,37,'2003-03-31 00:00:00'),
                              (15,'Âm thanh sống động, đã tai',6,37,'2024-06-01 00:00:00'),
                              (16,'Nghe ghiền, sướng tai',6,36,'2024-05-23 22:24:00'),
                              (17,'Xịn quá',7,36,'2024-05-25 20:24:00'),
                              (18,'Âm bass đập ầm ầm',6,36,'2003-12-25 21:24:00'),
                              (19,'Uy tín 10 điểm không có nhưng',6,36,'2003-03-31 00:00:00'),
                              (20,'Đi quẩy cháy đét',6,36,'2024-06-01 00:00:00'),
                              (21,'Giao hàng nhanh như 1 cơn gió',6,35,'2024-05-23 22:24:00'),
                              (22,'Có thể nghe mọi lúc mọi nơi',7,35,'2024-05-25 20:24:00'),
                              (23,'Đẹp quá, mlem mlem',6,35,'2003-12-25 21:24:00'),
                              (24,'Nghe cháy máy không lo hư khi đã có bảo hành',6,35,'2003-03-31 00:00:00'),
                              (25,'Bass căng đét',6,35,'2024-06-01 00:00:00'),
                              (26,'Đeo lên sang tay quá',6,34,'2024-05-23 22:24:00'),
                              (27,'Lấp lánh sáng chói',7,34,'2024-05-25 20:24:00'),
                              (28,'Đẹp quá muốn mua thêm mấy cái',6,34,'2003-12-25 21:24:00'),
                              (29,'Lung linh như Ngọc Trinh',6,34,'2003-03-31 00:00:00'),
                              (30,'Sáng chói hơn nụ cười của em',6,33,'2024-06-01 00:00:00'),
                              (31,'Ốp dày dặn',6,33,'2024-05-23 22:24:00'),
                              (32,'Sản phẩm đẹp quá, chắc chắn sẽ mua tiếp',7,33,'2024-05-25 20:24:00'),
                              (33,'Chất lượng',6,33,'2003-12-25 21:24:00'),
                              (34,'Ốp trong suốt tôn vẻ đẹp điện thoại',6,33,'2003-03-31 00:00:00'),
                              (35,'Ốp dẻo bền bỉ',6,33,'2024-06-01 00:00:00'),
                              (36,'Mua cho vịu ơ',6,32,'2024-05-23 22:24:00'),
                              (37,'Em ghệ khen xinh với dịu quá',7,32,'2024-05-25 20:24:00'),
                              (38,'Dễ thương, xinh lung linh',6,32,'2003-12-25 21:24:00'),
                              (39,'Khuyên các bạn nên mua tặng bồ nha, xinh lắm',6,32,'2003-03-31 00:00:00'),
                              (40,'Kẹp tóc cứng cáp, chất lượng, rơi từ tầng 3 xuống tầng 1 mà chưa nứt nữa',6,32,'2024-06-01 00:00:00'),
                              (41,'Túi đựng được nhiều đồ',6,31,'2024-05-23 22:24:00'),
                              (42,'Hợp style thư sinh',7,31,'2024-05-25 20:24:00'),
                              (43,'Mang đi chơi đi học đều được',6,31,'2003-12-25 21:24:00'),
                              (44,'Giao hàng kịp giờ đi học',6,31,'2003-03-31 00:00:00'),
                              (45,'Vải dày',6,31,'2024-06-01 00:00:00'),
                              (46,'Vải dày bền bỉ',6,30,'2024-05-23 22:24:00'),
                              (47,'Giá rẻ mà xịn xò',7,30,'2024-05-25 20:24:00'),
                              (48,'Đeo lên đẹp điên',6,30,'2003-12-25 21:24:00'),
                              (49,'Mua về đẹp quá, nên để nhà không dám mang nhiều',6,30,'2003-03-31 00:00:00'),
                              (50,'Đựng sách vở đi học siêu tiện',6,30,'2024-06-01 00:00:00'),
                              (51,'Túi đẹp dữ vậy trời',6,29,'2024-05-23 22:24:00'),
                              (52,'Đánh giá 5 sao không nói nhiều',7,29,'2024-05-25 20:24:00'),
                              (53,'Style thời thượng đánh bại thời thế',6,29,'2003-12-25 21:24:00'),
                              (54,'Không sợ đụng hàng',6,29,'2003-03-31 00:00:00'),
                              (55,'Chất lượng mà được cái giá rẻ',6,29,'2024-06-01 00:00:00'),
                              (56,'Má mới mua cho máy chơi game đã quá, phải cày game tới sáng thôi',6,28,'2024-05-23 22:24:00'),
                              (57,'Má mua cho không chơi má chửi',7,28,'2024-05-25 20:24:00'),
                              (58,'Máy mạnh phà phà bắn valorant cực mượt',6,28,'2003-12-25 21:24:00'),
                              (59,'Lap mạnh, phím đẹp, lâu không xài bị liệt phím hên còn bảo hành',6,28,'2003-03-31 00:00:00'),
                              (60,'Lap ngầu quá',6,28,'2024-06-01 00:00:00'),
                              (61,'Ba dặn mua máy tính ráng lo học, nên tôi học chăm chỉ mỗi ngày tới 3h sáng mà học bắn valorant',7,27,'2024-05-25 20:24:00'),
                              (62,'Con lap xịn đẹp mới cứng, đi flex thôi',6,27,'2024-05-23 22:24:00'),
                              (63,'Laptop theo chuẩn quân đội, lỡ duột tay làm rớt xíu hên chưa bể mới nứt thôi',6,27,'2003-12-25 21:24:00'),
                              (64,'Lap bền điên, đi mưa hên chưa thay màn mới',6,27,'2003-03-31 00:00:00'),
                              (65,'Lap ngầu quá',6,27,'2024-06-01 00:00:00'),
                              (66,'Má mới mua cho máy chơi game đã quá, phải cày game tới sáng thôi',6,26,'2024-05-23 22:24:00'),
                              (67,'Má mua cho không chơi má chửi',7,26,'2024-05-25 20:24:00'),
                              (68,'Máy mạnh phà phà bắn valorant cực mượt',6,26,'2003-12-25 21:24:00'),
                              (69,'Lap mạnh, phím đẹp, lâu không xài bị liệt phím hên còn bảo hành',6,26,'2003-03-31 00:00:00'),
                              (70,'Lap ngầu quá',6,26,'2024-06-01 00:00:00'),
                              (71,'Áo đẹp quá nên mua mặc đi date nha mọi người',6,25,'2024-05-23 22:24:00'),
                              (72,'Giá rẻ áo đẹp săn sale rẻ bất ngờ',7,25,'2024-05-25 20:24:00'),
                              (73,'Giao hàng nhanh kịp giờ đi date',6,25,'2003-12-25 21:24:00'),
                              (74,'Áo dày dặn form đẹp',6,25,'2003-03-31 00:00:00'),
                              (75,'Mua mặc nhìn cho trưởng thành',6,25,'2024-06-01 00:00:00'),
                              (76,'Quần đẹp mặc đi date hao gái quá',6,24,'2024-05-23 22:24:00'),
                              (77,'Săn sale được cái quần giá hời mà mặc mát quá',7,24,'2024-05-25 20:24:00'),
                              (78,'Quần mặc đẹp hết nước chấm',6,24,'2003-12-25 21:24:00'),
                              (79,'Mới mua áo sơ mi mua thêm cái quần mặc dính quá',6,24,'2003-03-31 00:00:00'),
                              (80,'Mua mặc đi đám cưới người yêu cũ',6,24,'2024-06-01 00:00:00'),
                              (81,'Giá thành hợp lý nên không đòi hỏi gì nhiều',6,23,'2024-05-23 22:24:00'),
                              (82,'Áo mặc đứng form nhưng giặt máy vài lần vải có hơi bị cứng lại',7,23,'2024-05-25 20:24:00'),
                              (83,'Mặc đi học đi chơi quá đẹp luôn',6,23,'2003-12-25 21:24:00'),
                              (84,'Áo cho ai thích sự đơn giản',6,23,'2003-03-31 00:00:00'),
                              (85,'Áo đẹp',6,23,'2024-06-01 00:00:00');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_price` decimal(10,0) DEFAULT '0',
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_ORDERDETAIL_ORDER_idx` (`order_id`),
  KEY `FK_ORDERDETAIL_PRODUCT_idx` (`product_id`),
  CONSTRAINT `FK_ORDERDETAIL_ORDER` FOREIGN KEY (`order_id`) REFERENCES `sale_order` (`id`),
  CONSTRAINT `FK_ORDERDETAIL_PRODUCT` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (5,4,1,12500000,1),(6,4,2,21000000,1),(7,4,3,17000000,1),(8,5,1,12500000,1),(9,5,3,17000000,1),(10,5,7,10540000,1),(11,6,2,21000000,1),(12,7,5,18600000,1),(13,7,6,12990000,3),(14,8,1,12500000,1),(15,8,2,21000000,2),(16,8,3,17000000,1),(17,9,1,12500000,1),(18,9,2,21000000,2),(19,10,4,28000000,1),(20,10,5,18600000,5),(21,11,1,12500000,2),(22,11,2,21000000,2),(23,11,3,17000000,1),(24,13,2,0,0),(25,13,1,0,0);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_tag`
--

DROP TABLE IF EXISTS `prod_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `f1_idx` (`product_id`),
  KEY `f2_idx` (`tag_id`),
  CONSTRAINT `f1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `f2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_tag`
--

LOCK TABLES `prod_tag` WRITE;
/*!40000 ALTER TABLE `prod_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(10,0) DEFAULT '0',
  `manufacturer` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `category_id` int NOT NULL,
  `store_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PRODUCE_CATEGORY_idx` (`category_id`),
  KEY `FK_PRODUCT_STORE_idx` (`store_id`),
  CONSTRAINT `FK_PRODUCT_CATEGORY` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_PRODUCT_STORE` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'iPhone 7 Plus','RAM: 3GB + ROM: 256 GB + 4G + Dung lượng pin: 2900 mAh',11000000,'Apple','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973003/iphone-7-plus-256gb-jetblack1-1-3-org_jlawrg.jpg','2020-01-20 00:00:00',_binary '',4,1),
                             (2,'Galaxy Note 10','RAM: 8GB + ROM: 256GB + 4G + Dung lượng pin: 3500 mAh',21000000,'Samsung','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973002/samsung-galaxy-note-10-bac-1-org_p9aqzy.jpg','2020-01-08 00:00:00',_binary '',4,2),
                             (3,'iPhone 11','RAM: 4GB + ROM: 128GB + 4G + Dung lượng pin: 3110 mAh',17000000,'Apple','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973003/iphone-11-den-1-1-org_fqeesj.jpg','2020-01-12 00:00:00',_binary '',4,1),
                             (4,'iPhone 11 Pro Max','RAM: 4GB + ROM: 128GB + 4G + Dung lượng pin: 3969 mAh',28000000,'Apple','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973004/iphone-11-pro-max-512gb-xanh-1-1-org_lgplnk.jpg','2020-01-15 00:00:00',_binary '',4,2),
                             (5,'Galaxy Tab S6','RAM: 6GB + ROM: 128GB + 4G + Dung lượng pin: 7040 mAh',18600000,'Samsung','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973002/samsung-galaxy-tab-s6-xanh-duong-1-org_fvpour.jpg','2020-01-12 00:00:00',_binary '',4,1),
                             (6,'iPad Mini 7.9','RAM: 3GB + ROM: 64GB + 4G + Dung lượng pin: 5124 mAh',12990000,'Apple','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973003/ipad-mini-79-inch-wifi-cellular-64gb-2019-1-org_bkscup.jpg','2020-01-18 00:00:00',_binary '',4,2),
                             (7,'iPad 9','RAM: 3GB + ROM: 256GB + 4G + Dung lượng pin: 8600 mAh',10540000,'Apple','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973003/ipad-wifi-9-xam-glr-1_akhxbc.jpg','2020-01-26 00:00:00',_binary '',4,1),
                             (16,'iPhone 12 Pro Max','RAM: 6GB + ROM: 256GB + 5G + Dung lượng pin: 3687 mAh',30000000,'Apple','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973004/iphone-12-pro-max-256gb-xanh-duong-1-org_o9eeb7.jpg','2020-01-26 00:00:00',_binary '',4,2),
                             (17,'iPhone 15 Pro Max','RAM: 8GB + ROM: 1TB + 5G + Dung lượng pin: 4422 mAh',30000000,'Apple','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973005/iphone-15-pro-max-tu-nhien-1_yxeaiv.jpg','2020-01-26 00:00:00',_binary '',4,1),
                             (18,'iPhone 13 Pro','RAM: 6GB + ROM: 128GB + 5G + Dung lượng pin: 3095 mAh',30000000,'Apple','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973004/iphone-13-pro-xanh-xa-1_ijxn3g.jpg','2020-01-26 00:00:00',_binary '',4,2),
                             (19,'Galaxy S24','RAM: 8GB + ROM: 512GB + 5G + Dung lượng pin: 4000 mAh',10000,'Samsung','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973002/samsung-galaxy-s24-tim-1_vgwmiv.jpg',NULL,NULL,4,1),
                             (20,'Máy lọc nước Kangaroo 10 lõi KG100HK','Việt Nam + Công nghệ lọc RO + Công suất lọc:	15-20 lít/giờ',7990000,'Kangaroo','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973002/10047211-may-loc-nuoc-kangaroo-10-loi-kg100hk-3_yx1f-_z76byx.jpg','2024-06-04 00:00:00',_binary '',1,2),
                             (21,'Quạt điều hòa Boss S106','Thái Lan + Loại quạt điện:	Hơi nước + Công suất:	160W',6690000,'Boss','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973002/10035987-quat-dieu-hoa-boss-s106-1_x86x7p.jpg','2024-06-04 00:00:00',_binary '',1,2),
                             (22,'Máy lọc không khí LG 360 độ Alpha 2 tầng AS10GDBY0.ABAE Vàng Be','Hàn Quốc + Công suất:	72W + Độ ồn: 53 dB(Max)/26 dB(Sleep)',28490000,'LG','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973002/10056908-may-loc-khong-khi-360-do-alpha-2-tang-as10gdby0-abae-vang-be-1_pcdift.jpg','2024-06-04 00:00:00',_binary '',1,2),
                             (23,'Áo T-shirt basic xanh lá','Cổ áo: Cổ tròn + Chất liệu: Cotton',99000,'Nowhere','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973006/vn-11134207-7qukw-lilkefaw02c29d_xtyxu6.jpg','2024-06-04 00:00:00',_binary '',2,1),
                             (24,'Quần âu baggy nam Aukai','Mẫu: Trơn + Kiểu dáng quần: Đứng',250000,'Aukaito','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973842/f16235fa10aa0c1040037abf8c0296da.jpg_720x720q80.jpg__kda4bi.webp','2024-06-04 00:00:00',_binary '',2,1),
                             (25,'Áo sơ mi nam đũi cổ đức','Chất liệu: Lanh + Mẫu: Trơn',120000,'PNstore','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973006/vn-11134207-7r98o-lw2tsb8rv7ixe8_ccjfv7.jpg','2024-06-04 00:00:00',_binary '',2,1),
                             (26,'Laptop ASUS Gaming ROG Zephyrus G14 GA401QC-K2199W','RAM: 8GB + DDR4 + Ổ cứng: 512GB M.2 NVMe™ PCIe® 3.0 SSD',17890000,'Asus','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973004/laptop-asus-gaming-rog-zephyrus-g14-ga403uv-qs171w_ovw9kp.webp','2024-06-04 00:00:00',_binary '',3,2),
                             (27,'Laptop ASUS TUF Gaming F15 FX507VV-LP157W','RAM: 16GB + DDR5 4800MHz + Ổ cứng: 512GB SSD M.2 NVMe/ 3 x M.2 NVMe',31490000,'Asus','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973006/text_ng_n_15__6_4_xvarra.webp','2024-06-04 00:00:00',_binary '',3,2),
                             (28,'Laptop Lenovo Gaming Legion 5 15ARH7 82RE0035VN','RAM: 8GB + 8GB SO-DIMM DDR5-4800 + Ổ cứng: 512GB SSD M.2 2280 PCIe 4.0x4 NVMe',25490000,'Lenovo','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973005/text_ng_n_5__1_2_1_ycbqmm.webp','2024-06-04 00:00:00',_binary '',3,2),
                             (29,'Túi đeo chéo phong cách Nhật Bản IMELON','Chất liệu: Nylon + Khóa Túi: Khóa Zip',68000,'IMELON','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973006/vn-11134201-7qukw-lew9int7s7rr97_pl6fws.jpg','2024-06-04 00:00:00',_binary '',5,2),
                             (30,'Túi xách đeo vai vải Canvas Hazin','Chất liệu: Vải canvas + Số ngăn: 1 ngăn lớn, 2 ngăn nhỏ',95000,'Hazin','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973006/vn-11134207-7r98o-luyc5f90wdutf8_rrphjd.jpg','2024-06-04 00:00:00',_binary '',5,2),
                             (31,'Túi đeo vai Yadou','Chất liệu: Vải canvas + Chi tiết phong cách: Mặt cười',79000,'Yadou','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973006/vn-11134207-7r98o-luyc5f90wdutf8_rrphjd.jpg','2024-06-04 00:00:00',_binary '',5,2),
                             (32,'Kẹp tóc hoa sứ Emi Jay','Màu: Maui',400000,'Emi Jay ','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973005/superbloomclipinmauifront_ywnkau.webp','2024-06-04 00:00:00',_binary '',6,2),
                             (33,'Ốp Lưng Trong Suốt MagSafe','Màu: Trong suốt',1429000,'Apple','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973004/MT223_ztwjra.jpg','2024-06-04 00:00:00',_binary '',6,2),
                             (34,'Nhẫn Vàng trắng 10K đính đá ECZ PNJ XM00W000078','Hình dạng đá: Tròn + Số viên đá chính: 1viên',2803000,'PNJ','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718974620/sp-gnxm00w000078-nhan-vang-trang-10k-dinh-da-ecz-pnj-1_u0j6z7.jpg','2024-06-04 00:00:00',_binary '',6,2),
                             (35,'Tai nghe Apple AirPods Max','Màu: Silver + Chipset:	Apple H1',12990000,'Apple','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973005/tai-nghe-apple-airpods-max-P11493-1683357861855_um39mn.jpg','2024-06-04 00:00:00',_binary '',7,2),
                             (36,'LG XBOOMGo PL7','công nghệ Meridian + Âm thanh 30W + IPX5',4490000,'XBOOM','Tu Dong shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718974620/N03_medium03_wx60gy.jpg','2024-06-04 00:00:00',_binary '',7,2),
                             (37,'Loa JBL PartyBox Stage 320','Số lượng bass loa: 2 bass + Công suất RMS: 240w',15900000,'JBL','Tri Huynh shop','https://res.cloudinary.com/dg1zsnywc/image/upload/v1718973004/loa-jbl-partybox-stage-320-anh-sp-14_w90jy9.jpg','2024-06-04 00:00:00',_binary '',7,2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `sale_order`
--

DROP TABLE IF EXISTS `sale_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ORDER_USER_idx` (`user_id`),
  KEY `FK_ORDER_STORE_idx` (`store_id`),
  CONSTRAINT `FK_ORDER_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_ORDER_STORE` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_order`
--

LOCK TABLES `sale_order` WRITE;
/*!40000 ALTER TABLE `sale_order` DISABLE KEYS */;
INSERT INTO `sale_order` VALUES (4,'2020-02-03 00:00:00',7,1),
                                (5,'2020-02-03 00:00:00',7,2),
                                (6,'2020-02-03 00:00:00',7,1),
                                (7,'2020-02-04 00:00:00',7,2),
                                (8,'2020-02-05 00:00:00',6,1),
                                (9,'2020-02-05 00:00:00',7,2),
                                (10,'2020-02-07 00:00:00',6,1),
                                (11,'2020-02-07 00:00:00',8,2),
                                (12,'2020-11-17 18:43:31',NULL,1),
                                (13,'2020-11-17 18:48:11',NULL,2);
/*!40000 ALTER TABLE `sale_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tagcol` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `active` bit(1) DEFAULT b'1',
  `user_role` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (6,'Tri','Huynh','2151010397Tri@ou.edu.vn','0375290878','tri123','$2a$10$5X9k5N1sTc1/CjVH5XJoje3QMYijH3ETpgkox00R0MdPaJPPrf7wO',_binary '','ROLE_ADMIN',NULL),(7,'Tu','Dong','2151010425tu@ou.edu.vn','0909945425','tu123','$2a$10$RL0rTJd2ThLmCzYHMhz9aOBBZfA8ybYpa3Ugl9ds.Pkb8AjtSHWua',_binary '','ROLE_ADMIN',NULL),(8,'Tri','Tu','abc@gmail.com','0123456789','tritu123','$2a$10$qv8SsUwRnp/YhPWTPqdgp.MXJ01hcW4ji6wKvP6.qkWWx1ZxhqxyG',_binary '','ROLE_STAFF',NULL),(9,'ABC','XYZ','123@gmail.com','1234567890','khoi123','$2a$10$DT8XCG5IEd0RS0iKleeJ9.1LXWezuUj/qY2SLq/Vy64zUlxHHK9rG',NULL,'ROLE_USER','https://res.cloudinary.com/dxxwcby8l/image/upload/v1692330009/vuyk886cdgjykoi6qs3f.png');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;





DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_manager_idx` (`manager_id`),
  CONSTRAINT `fk_manager` FOREIGN KEY (`manager_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Insert sample data into `store`
LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES (1, 'Tri Huynh shop', '123 Main St', '1234567890', 'store1@gmail.com', 6),
                           (2, 'Tu Dong shop', '456 Elm St', '0987654321', 'store2@gmail.com', 7);
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;





/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-21 10:13:02
