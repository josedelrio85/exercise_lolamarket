-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: exercise_lm
-- ------------------------------------------------------
-- Server version	5.7.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Name 1','Surname 1','email1@test.gal','+34666666666'),(2,'Name 2','Surname 2','email2@test.gal','+34666666662'),(3,'Test Edit 1','Surtest Edit 1','test1@test.gal','+34666666666'),(4,'Test 1','Surtest 1','test1@test.gal','+34666666666');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_date` datetime NOT NULL,
  `delivery_date` datetime NOT NULL,
  `interval_delivery` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `client_id_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398DC2902E0` (`client_id_id`),
  CONSTRAINT `FK_F5299398DC2902E0` FOREIGN KEY (`client_id_id`) REFERENCES `client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2020-11-07 00:00:00','2020-11-07 00:00:00','11:00-14:00',1,0,1,'Address 1'),(2,'2020-11-07 00:00:00','2020-11-09 00:00:00','10:00-12:00',1,0,1,'Address 2'),(8,'2020-11-22 00:00:00','2020-11-23 00:00:00','13:00-15:00',0,0,1,'Address 3'),(9,'2020-11-22 00:00:00','2020-11-23 00:00:00','09:00-10:30',0,0,1,'Address 4'),(10,'2020-11-22 00:00:00','2020-11-23 00:00:00','19:00-20:00',0,0,2,'Address 5'),(11,'2020-11-22 00:00:00','2020-11-23 00:00:00','11:00-14:00',0,0,2,'Address 6'),(12,'2020-11-22 00:00:00','2020-11-23 00:00:00','19:00-20:00',0,0,2,'Address 7'),(13,'2020-11-22 00:00:00','2020-11-23 00:00:00','11:00-14:00',0,0,2,'Address 8');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `parent_order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ED896F464584665A` (`product_id`),
  KEY `IDX_ED896F461252C1E9` (`parent_order_id`),
  CONSTRAINT `FK_ED896F461252C1E9` FOREIGN KEY (`parent_order_id`) REFERENCES `order` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_ED896F464584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (1,25,1),(2,26,1),(3,27,1),(4,28,1),(5,29,1),(6,30,2),(7,31,2),(8,32,2),(9,33,2),(10,34,2),(22,35,9),(23,36,9),(24,37,10),(25,38,10),(26,39,11),(27,40,11),(28,41,11),(29,42,11),(30,43,12),(31,44,12),(32,45,12),(33,46,12),(34,47,12),(35,48,13),(36,49,13),(37,50,13),(38,51,13),(39,52,13);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `units` double NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD4D16C4DD` (`shop_id`),
  CONSTRAINT `FK_D34A04AD4D16C4DD` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (25,1,'Producto 1','Descripción Producto 1',3.5,12.78),(26,1,'Producto 2','Descripción Producto 2',4,10.45),(27,1,'Producto 3','Descripción Producto 3',1,4.89),(28,1,'Producto 4','Descripción Producto 4',3,0.98),(29,2,'Producto 5','Descripción Producto 5',5,2.81),(30,2,'Producto 6','Descripción Producto 6',9,21.9),(31,2,'Producto 7','Descripción Producto 7',1,9.87),(32,2,'Producto 8','Descripción Producto 8',2,4.56),(33,299,'Producto 9','Descripción Producto 9',6,9.78),(34,299,'Producto 10','Descripción Producto 10',2,2.18),(35,1,'Product 99','description 99',5,23.45),(36,1,'Product 88','description 88',1,3.45),(37,1,'Product 99','description 99',5,23.45),(38,1,'Product 88','description 88',1,3.45),(39,1,'Product 99','description 99',5,23.45),(40,1,'Product 88','description 88',1,3.45),(41,299,'Product 77','description 77',1,1.23),(42,2,'Product 66','description 66',9,7.87),(43,1,'Product 99','description 99',5,23.45),(44,1,'Product 88','description 88',1,3.45),(45,299,'Product 77','description 77',1,1.23),(46,2,'Product 66','description 66',9,7.87),(47,299,'Product 55','description 55',1,0.45),(48,1,'Product 99','description 99',5,23.45),(49,1,'Product 88','description 88',1,3.45),(50,299,'Product 77','description 77',1,1.23),(51,2,'Product 66','description 66',9,7.87),(52,299,'Product 55','description 55',1,0.45);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES (1,'Tienda 1'),(2,'Tienda 2'),(299,'Tienda 3');
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopper`
--

DROP TABLE IF EXISTS `shopper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `shop_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_26663F5D4D16C4DD` (`shop_id`),
  CONSTRAINT `FK_26663F5D4D16C4DD` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopper`
--

LOCK TABLES `shopper` WRITE;
/*!40000 ALTER TABLE `shopper` DISABLE KEYS */;
INSERT INTO `shopper` VALUES (1,'Shopper 1','','','',1,1),(2,'Shopper 2','','','',1,299),(3,'Shopper 3','','','',1,2);
/*!40000 ALTER TABLE `shopper` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-07 19:11:38
