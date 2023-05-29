CREATE DATABASE  IF NOT EXISTS `simple_online_store_dummy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `simple_online_store_dummy`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: simple_online_store_dummy
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `courier`
--

DROP TABLE IF EXISTS `courier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courier` (
  `courier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`courier_id`),
  UNIQUE KEY `courier_id_UNIQUE` (`courier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier`
--

LOCK TABLES `courier` WRITE;
/*!40000 ALTER TABLE `courier` DISABLE KEYS */;
INSERT INTO `courier` VALUES (1,'DHL'),(2,'FedEx'),(3,'UPS'),(4,'Boxberry'),(5,'SDEK'),(6,'Pony Express'),(7,'Dalli');
/*!40000 ALTER TABLE `courier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `sku` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `division` int NOT NULL,
  PRIMARY KEY (`sku`),
  UNIQUE KEY `sku_UNIQUE` (`sku`),
  KEY `FK_division_idx` (`division`),
  CONSTRAINT `FK_division` FOREIGN KEY (`division`) REFERENCES `product_division` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES ('07JOMEMX','Phone Whatchamacallit','Quisque laoreet ullamcorper consequat',157.49,18),('15WW69Y0','Truck Rig','Donec sed augue lectus.',105.87,6),('18RT1167','Camping Instrument','Nulla facilisi',373.16,16),('1Y2AO0F1','Beach Contraption','Curabitur egestas molestie tortor, vitae maximus velit auctor in',438.52,10),('3NVZ8EN8','Cooking Instrument','Vestibulum ornare arcu est',324.17,18),('3Q2CDUS9','Baby Supplies','Praesent ut nibh vitae eros vestibulum semper',452.62,5),('450OHFKZ','Fitness Paraphernalia','Nulla tempus arcu a libero semper ultricies',193.25,7),('48UMP652','Gardening Implement','Integer ligula leo, blandit ut lorem tempus, eleifend convallis odio',46.21,11),('4NUVE4H2','Outdoors Whatchamacallit','Maecenas eu posuere sapien',191.76,20),('4P6WLIBG','Baby Gear','Aliquam faucibus tortor enim, in convallis elit euismod quis.',93.5,9),('4PBPRS9R','Cooking Paraphernalia','Cras diam sapien, dapibus non mi nec, pretium lobortis diam',377.18,14),('4Z39NBLM','Gardening Device','Fusce at arcu non orci hendrerit tincidunt',171.14,7),('526NLE8Q','Truck Rig','Donec sed augue lectus.',96.61,13),('5PYHJU7N','Outdoors Gadget','Pellentesque dignissim mi a sem dapibus eleifend',419.51,7),('5PZN21XB','Baby Attachment','Maecenas quis libero eget nisl faucibus laoreet.',85.64,19),('6F69KW7J','Cooking Instrument','In ullamcorper augue massa, tincidunt interdum mauris pulvinar non',451.99,8),('6IWE0SVH','Bedding Contraption','Vivamus fringilla dui quis mi iaculis, eget sodales arcu vulputate',480.23,13),('73YLN8O6','Baby Gadget','Mauris et lectus in velit tristique lacinia',430.4,19),('7F8NRVTI','Baby Gadget','Mauris et lectus in velit tristique lacinia',400.06,10),('7HWGATST','Womens Rig','In condimentum viverra congue',245.43,6),('7Y4L45PW','Kitchen Machine','Nam fringilla aliquet tellus ac pretium',207.89,6),('81UH1JTK','Biking Whatchamacallit','Pellentesque sit amet blandit justo',89.66,19),('8F2ZJXKW','Womens Contraption','Maecenas sed venenatis purus, quis viverra turpis',480.37,9),('8NG60ART','Mens Apparatus','Proin finibus risus ut dui vulputate malesuada',29.29,13),('8UALRKJR','Camping Instrument','Nulla facilisi',258.65,13),('8W6I44BK','Bedding Contraption','Vivamus fringilla dui quis mi iaculis, eget sodales arcu vulputate',175.75,5),('926UEB04','Phone Thingamajig','Maecenas molestie imperdiet purus, eget imperdiet velit convallis sed',84.24,18),('96FJK1IQ','Kitchen Device','Pellentesque eleifend ante quis magna gravida rhoncus',365.06,7),('AOL362VF','Car Doodad','Aenean id posuere urna',213.1,18),('B44YAXR3','Baby Supplies','Praesent ut nibh vitae eros vestibulum semper',187.82,15),('BFC3VDD4','Hair Care Equipment','Proin auctor ultrices erat, id blandit arcu maximus vitae',251.83,1),('C8N35733','Dining Paraphernalia','Maecenas mauris nulla, auctor nec mauris ut, suscipit interdum purus',306.4,3),('CO8YXHVR','Womens Equipment','Sed consequat felis sed elementum semper',183.07,20),('CR05GC4G','Cat Paraphernalia','Interdum et malesuada fames ac ante ipsum primis in faucibus',253.99,4),('CSBT6BCJ','Music Instrument','Donec sodales maximus lectus, vitae blandit eros congue a',38.92,3),('CX126PLT','Swimming Equipment','Pellentesque sollicitudin ornare egestas',226.12,8),('CYJU40WA','Book Device','Vestibulum ornare arcu est',125.74,13),('CYP0C47Y','Bath Paraphernalia','Cras mauris orci, ornare in ex sed, dapibus semper mauris',19.37,12),('DB8AUO9F','Technology Instrument','Pellentesque convallis turpis in felis gravida sollicitudin',224.73,16),('DEXSKNMK','Phone Whatchamacallit','Quisque laoreet ullamcorper consequat',472.47,10),('DUD8N44J','Aquarium Widget','Sed accumsan pretium interdum',455.39,3),('E1AY5W3X','Beach Contraption','Curabitur egestas molestie tortor, vitae maximus velit auctor in',165.14,16),('FK5GC4CX','Cleaning Whatchamacallit','Nulla et lectus tellus',407.13,20),('FPKL98U5','Cleaning Whatchamacallit','Nulla et lectus tellus',138.55,9),('G4OJM4QP','Phone Accessory','Nullam vestibulum augue id ipsum venenatis lobortis',223.85,2),('G5NW6MHI','Fitness Apparatus','Curabitur quis dignissim eros',494.77,15),('GHM9LQB8','Baby Supplies','Praesent ut nibh vitae eros vestibulum semper',13.47,14),('GU0DIOWR','Fitness Paraphernalia','Nulla tempus arcu a libero semper ultricies',17.98,13),('GXYV1QFB','Cleaning Gizmo','Etiam pharetra mollis ante, eget vestibulum turpis vestibulum vel',355.12,20),('HFYAPVMB','Music Instrument','Donec sodales maximus lectus, vitae blandit eros congue a',281.43,19),('HMFOZXVX','Kitchen Device','Pellentesque eleifend ante quis magna gravida rhoncus',319.29,18),('IDVC8JMV','Truck Rig','Donec sed augue lectus.',338.47,16),('IDXO6VN4','Party Kit','Pellentesque dictum ante vitae tempor sodales',455.74,12),('IH6ZEBPS','Biking Device','Nunc tempus est et purus hendrerit semper vel et mauris',188.97,17),('J4N9XJ4D','Cooking Doodad','Integer interdum turpis ex, in vehicula magna consequat auctor',443.49,15),('JLGBSFH4','Music Doodad','Etiam neque libero, semper sed ex eu, rutrum dignissim diam',58.82,12),('JPZKX5MY','Womens Rig','In condimentum viverra congue',140.99,18),('JXU385OD','Swimming Implement','Nam scelerisque eleifend lorem ut efficitur.',264.83,6),('K2V5CLV0','Storage Kit','Vivamus sit amet fringilla massa, id maximus libero',413.94,3),('LAOEQNN4','Music Instrument','Donec sodales maximus lectus, vitae blandit eros congue a',471.56,14),('LY4JIUNO','Movie Machine','Phasellus at ipsum pellentesque metus molestie rutrum',350.16,19),('M0S38O0M','Swimming Implement','Nam scelerisque eleifend lorem ut efficitur.',457.58,13),('MOWRINWN','Kids Gear','Suspendisse massa orci, iaculis id facilisis tempus, gravida in est',118.11,10),('MPSTRTRI','Cooking Instrument','In ullamcorper augue massa, tincidunt interdum mauris pulvinar non',75,17),('MYK0SBN8','Womens Equipment','Sed consequat felis sed elementum semper',14.26,12),('N0HGHLBB','Baby Gadget','Mauris et lectus in velit tristique lacinia',88.78,1),('N7PI9ORF','Music Doodad','Etiam neque libero, semper sed ex eu, rutrum dignissim diam',121.38,2),('ND82GTIR','Outdoors Apparatus','Nulla congue bibendum velit dictum pulvinar',367.32,10),('NHKC9VA2','Phone Accessory','Nullam vestibulum augue id ipsum venenatis lobortis',304.78,9),('O8WEMOYC','Baby Gear','Aliquam faucibus tortor enim, in convallis elit euismod quis.',58.5,3),('P81IPUK8','Phone Device','Donec fringilla erat a neque dignissim, sit amet pharetra odio pulvinar',181.79,15),('PHLE2L23','Gardening Whatchamacallit','Phasellus dictum vestibulum neque, eu laoreet tortor commodo nec.',160.26,4),('PRBBC9FP','Music Apparatus','Fusce orci justo, elementum vel mi sit amet, ultrices tempor eros',495.42,7),('Q4LYRQZA','Bedding Widget','Duis interdum lacinia felis, ultrices venenatis ex pharetra sit amet',437.52,7),('QOAIPIR8','Biking Whatchamacallit','Pellentesque sit amet blandit justo',283.43,11),('RYXV0R98','Biking Device','Nunc tempus est et purus hendrerit semper vel et mauris',217.99,6),('SKQKS6PT','Baby Gadget','Mauris et lectus in velit tristique lacinia',91.69,1),('SOQJ7WKC','Personal Item','Vestibulum eu lacus eget massa dignissim efficitur vitae malesuada leo',57.83,13),('T270HBL7','Biking Whatchamacallit','Pellentesque sit amet blandit justo',325.11,12),('TH3DUITW','Fitness Apparatus','Curabitur quis dignissim eros',436.13,3),('TSGIDTGJ','Party Instrument','Nam in est id purus laoreet tincidunt nec nec justo',311.3,14),('U7W5WUNR','Womens Equipment','Sed consequat felis sed elementum semper',51.94,4),('UXHWBA9M','Dining Paraphernalia','Maecenas mauris nulla, auctor nec mauris ut, suscipit interdum purus',167.76,18),('VIOB0MKF','Cooking Gear','Fusce libero quam, elementum non auctor ultricies, vulputate non sem',451.28,15),('VME76203','Tire Apparatus','Nam eget aliquet magna',494.04,13),('W53BIZLQ','Bath Kit','Vivamus sit amet fringilla massa, id maximus libero',482.84,5),('W7RZ6N9E','Cat Paraphernalia','Interdum et malesuada fames ac ante ipsum primis in faucibus',377.86,19),('WCWZQ4TN','Cooking Paraphernalia','Cras diam sapien, dapibus non mi nec, pretium lobortis diam',495.37,9),('WDJNX4WZ','Biking Whatchamacallit','Pellentesque sit amet blandit justo',387.16,16),('WKOAOCAP','Swimming Equipment','Pellentesque sollicitudin ornare egestas',50.45,16),('WKYYSXB4','Cleaning Whatchamacallit','Nulla et lectus tellus',84.26,20),('WPKEENN6','Storage Kit','Vivamus sit amet fringilla massa, id maximus libero',386.07,15),('X5D654TR','Dog Tool','Curabitur tincidunt mollis lacus, sit amet tincidunt eros sodales sit amet',420.89,12),('Y2L6XBJN','Engine Equipment','Proin semper efficitur nulla nec egestas',115.68,1),('Y443B9AC','Dog Tool','Curabitur tincidunt mollis lacus, sit amet tincidunt eros sodales sit amet',370.11,18),('YSXRX68Y','Kitchen Device','Pellentesque eleifend ante quis magna gravida rhoncus',406.13,16),('ZCWBI07J','Party Kit','Pellentesque dictum ante vitae tempor sodales',81.7,1),('ZM8JEZ1F','Book Doodad','Proin quis enim ac ipsum fermentum iaculis sed vel sapien',489.06,11),('ZQ6ZJJRA','Aquarium Widget','Sed accumsan pretium interdum',409.09,6);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `recepient_name` varchar(45) NOT NULL,
  `destination_address` varchar(100) NOT NULL,
  `is_shipped` tinyint NOT NULL DEFAULT '0',
  `courier` int NOT NULL,
  `order_datetime` datetime NOT NULL,
  `shipped_datetime` datetime DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'waiting',
  `order_sum` float DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `id_UNIQUE` (`order_id`),
  KEY `FK_courier_idx` (`courier`),
  CONSTRAINT `FK_courier` FOREIGN KEY (`courier`) REFERENCES `courier` (`courier_id`),
  CONSTRAINT `order_chk_1` CHECK ((`status` in (_utf8mb4'waiting',_utf8mb4'approved',_utf8mb4'rejected')))
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'Mel Ayris','7 Stoughton Hill',1,4,'2023-04-23 04:41:17','2023-05-10 13:43:36','mayrisc@mashable.com','approved',578.4),(2,'Rodina Cinelli','83612 Michigan Street',1,4,'2023-04-18 15:43:58','2023-05-10 18:46:24','rcinelli4@discovery.com','approved',58.11),(3,'Mada Spridgeon','5956 Waxwing Alley',1,1,'2023-04-01 23:23:05','2023-05-07 00:29:02','mspridgeonf@adobe.com','approved',420.89),(4,'Livia Caulwell','611 Waywood Hill',1,5,'2023-04-01 17:33:25','2023-04-15 02:47:50','lcaulwell1@techcrunch.com','approved',1596.45),(5,'Robinett Vaux','02807 Mccormick Pass',1,5,'2023-04-13 01:29:32','2023-04-14 20:48:13','rvauxa@g.co','approved',314.98),(6,'Alexis Leachman','18 Bunting Point',1,4,'2023-04-01 12:09:22','2023-04-06 06:41:17','aleachman7@booking.com','approved',115.66),(7,'Ambrosio Elcocks','167 Stone Corner Road',0,4,'2023-05-14 21:20:42',NULL,'aelcocks5@nymag.com','approved',1810.48),(8,'Charline Zoanetti','45 Pankratz Avenue',1,3,'2023-05-09 06:46:53','2023-05-16 16:10:19','czoanetti3@mlb.com','approved',115.66),(9,'Clementia Deakes','33 Myrtle Parkway',1,4,'2023-04-10 18:42:03','2023-04-13 17:58:04','cdeakesd@hostgator.com','approved',2217.45),(10,'Kelsey Rahlof','0623 Bluestem Terrace',1,4,'2023-04-10 10:47:28','2023-04-25 02:34:39','krahlofh@buzzfeed.com','approved',875.04),(11,'Robinett Vaux','02807 Mccormick Pass',0,1,'2023-05-08 17:37:14',NULL,'rvauxa@g.co','approved',566.91),(13,'Charline Zoanetti','45 Pankratz Avenue',1,3,'2023-04-01 17:50:33','2023-04-28 09:47:54','czoanetti3@mlb.com','approved',1133.58),(14,'Clementia Deakes','33 Myrtle Parkway',1,2,'2023-05-01 19:22:10','2023-05-09 09:37:32','cdeakesd@hostgator.com','approved',772.14),(15,'Mel Ayris','7 Stoughton Hill',0,6,'2023-05-10 13:14:55',NULL,'mayrisc@mashable.com','approved',304.78),(16,'Stacee Colegate','3163 Shelley Alley',1,2,'2023-04-17 12:08:58','2023-05-14 22:01:36','scolegatei@joomla.org','approved',1414.68),(17,'Milton Seyfart','333 Graceland Way',1,4,'2023-05-11 01:20:14','2023-05-12 14:27:38','mseyfartg@youtu.be','approved',1805.12),(18,'Livia Caulwell','611 Waywood Hill',1,2,'2023-04-08 18:09:11','2023-04-12 06:37:47','lcaulwell1@techcrunch.com','approved',77.48),(19,'Clementia Deakes','33 Myrtle Parkway',1,2,'2023-05-11 14:10:14','2023-05-13 08:44:00','cdeakesd@hostgator.com','approved',387.16),(20,'Axel Jan','0629 Artisan Crossing',1,3,'2023-05-06 12:30:00','2023-05-12 09:12:49','ajan2@parallels.com','approved',1865.8),(21,'Merci Ellerker','20495 Express Crossing',1,1,'2023-04-22 17:26:01','2023-05-16 20:27:25','mellerker0@ted.com','approved',183.38),(22,'Mada Spridgeon','5956 Waxwing Alley',1,3,'2023-04-11 06:00:04','2023-04-28 23:26:56','mspridgeonf@adobe.com','approved',1865.8),(23,'Pail Rumsey','48222 Hanover Pass',1,7,'2023-04-29 03:44:19','2023-05-03 06:54:32','prumseyj@si.edu','approved',703),(24,'Rodina Cinelli','83612 Michigan Street',0,4,'2023-05-15 09:46:18',NULL,'rcinelli4@discovery.com','approved',562.86),(25,'Max Canizares','215 Sundown Court',1,3,'2023-04-03 00:49:17','2023-04-29 12:15:19','mcanizares9@twitter.com','approved',157.49),(26,'Alexis Leachman','18 Bunting Point',1,3,'2023-04-15 14:37:57','2023-05-05 21:36:48','aleachman7@booking.com','approved',878.75),(27,'Charline Zoanetti','45 Pankratz Avenue',0,3,'2023-05-12 08:43:51',NULL,'czoanetti3@mlb.com','approved',975.33),(28,'Mordy Clemendot','8 Onsgard Circle',1,4,'2023-04-08 04:12:10','2023-04-25 08:37:59','mclemendote@japanpost.jp','approved',167.76),(29,'Mel Ayris','7 Stoughton Hill',1,3,'2023-04-22 16:54:10','2023-04-26 05:44:13','mayrisc@mashable.com','approved',294.1),(30,'Jaimie Raisbeck','17 Crowley Place',1,1,'2023-04-25 17:23:43','2023-05-16 15:43:05','jraisbeckb@cornell.edu','approved',138.55),(31,'Rodina Cinelli','83612 Michigan Street',1,4,'2023-04-14 00:51:12','2023-05-12 18:55:22','rcinelli4@discovery.com','approved',452.62),(32,'Vlad Dmitriev','2831 Sutteridge Avenue',1,6,'2023-05-07 00:06:31','2023-05-17 06:38:29','vdmitriev6@ameblo.jp','approved',365.06),(33,'Pail Rumsey','48222 Hanover Pass',1,5,'2023-04-03 22:08:17','2023-04-15 01:10:47','prumseyj@si.edu','approved',2357.8),(34,'Lazare Austwick','5233 Sunbrook Avenue',1,3,'2023-04-24 07:58:14','2023-05-12 03:45:31','laustwick8@princeton.edu','approved',674.19),(35,'Robinett Vaux','02807 Mccormick Pass',0,3,'2023-05-14 01:37:04',NULL,'rvauxa@g.co','approved',57.83),(36,'Robinett Vaux','02807 Mccormick Pass',1,6,'2023-04-16 03:20:43','2023-05-16 12:55:45','rvauxa@g.co','approved',428.2),(37,'Alexis Leachman','18 Bunting Point',1,6,'2023-05-06 00:56:15','2023-05-28 12:20:33','aleachman7@booking.com','approved',1805.12),(38,'Mel Ayris','7 Stoughton Hill',1,1,'2023-04-25 08:31:38','2023-04-28 19:03:11','mayrisc@mashable.com','approved',409.09),(39,'Pail Rumsey','48222 Hanover Pass',1,5,'2023-04-21 14:44:27','2023-04-26 04:31:15','prumseyj@si.edu','approved',2259.95),(40,'Vlad Dmitriev','2831 Sutteridge Avenue',1,3,'2023-04-12 11:15:06','2023-04-22 13:55:39','vdmitriev6@ameblo.jp','approved',471.56),(41,'Clementia Deakes','33 Myrtle Parkway',1,4,'2023-05-06 10:36:12','2023-05-28 11:52:10','cdeakesd@hostgator.com','approved',1889.3),(42,'Lazare Austwick','5233 Sunbrook Avenue',1,7,'2023-05-07 14:31:48','2023-05-11 04:42:33','laustwick8@princeton.edu','approved',67.35),(43,'Max Canizares','215 Sundown Court',1,4,'2023-04-18 05:54:31','2023-04-21 21:35:25','mcanizares9@twitter.com','approved',355.12),(44,'Livia Caulwell','611 Waywood Hill',1,1,'2023-04-26 15:54:51','2023-05-05 15:33:08','lcaulwell1@techcrunch.com','approved',281.98),(45,'Stacee Colegate','3163 Shelley Alley',1,2,'2023-05-02 11:55:57','2023-05-10 03:10:28','scolegatei@joomla.org','approved',289.83),(46,'Axel Jan','0629 Artisan Crossing',1,3,'2023-04-03 18:32:56','2023-04-18 01:48:58','ajan2@parallels.com','approved',2192.6),(47,'Stacee Colegate','3163 Shelley Alley',1,4,'2023-05-07 13:37:20','2023-05-14 15:13:04','scolegatei@joomla.org','approved',754.36),(48,'Lazare Austwick','5233 Sunbrook Avenue',1,4,'2023-05-13 17:04:43','2023-05-17 04:43:52','laustwick8@princeton.edu','approved',566.86),(49,'Vlad Dmitriev','2831 Sutteridge Avenue',1,5,'2023-05-08 12:49:05','2023-05-12 03:26:44','vdmitriev6@ameblo.jp','approved',855.7),(50,'Pail Rumsey','48222 Hanover Pass',1,5,'2023-04-09 07:17:33','2023-05-11 11:45:15','prumseyj@si.edu','approved',1930.35),(51,'Charline Zoanetti','45 Pankratz Avenue',1,4,'2023-05-06 13:15:35','2023-05-28 13:24:26','czoanetti3@mlb.com','approved',448.3),(52,'Mordy Clemendot','8 Onsgard Circle',1,4,'2023-04-16 05:45:48','2023-05-17 06:25:27','mclemendote@japanpost.jp','approved',14.26),(55,'Johny Bonjony','Berlin Libre Shtrasse 84',0,2,'2023-05-24 14:43:04',NULL,'johnyyy123@bermail.com','approved',509.82),(56,'Lea Seidu','Paris LaBagete 8',0,3,'2023-05-24 14:59:17',NULL,'kruasane.lovi@frfrmail.fr','approved',261.69),(57,'Sally Albright','NY 42 St',0,2,'2023-05-28 12:45:41',NULL,'sally.allbright@gmail.com','waiting',492.48),(58,'Abshishek Kumar','Deli River St 37',0,3,'2023-05-28 13:17:20',NULL,'abs@deli.com','waiting',1124.49);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_sku`
--

DROP TABLE IF EXISTS `order_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_sku` (
  `order_id` int NOT NULL,
  `sku` varchar(15) NOT NULL,
  `quantity` float NOT NULL,
  `item_sum` float NOT NULL,
  KEY `FK_order_idx` (`order_id`),
  KEY `FK_sku_idx` (`sku`),
  CONSTRAINT `FK_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `FK_sku` FOREIGN KEY (`sku`) REFERENCES `item` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_sku`
--

LOCK TABLES `order_sku` WRITE;
/*!40000 ALTER TABLE `order_sku` DISABLE KEYS */;
INSERT INTO `order_sku` VALUES (1,'Y2L6XBJN',5,578.4),(2,'CYP0C47Y',3,58.11),(3,'X5D654TR',1,420.89),(4,'HMFOZXVX',5,1596.45),(5,'07JOMEMX',2,314.98),(6,'SOQJ7WKC',2,115.66),(7,'3Q2CDUS9',4,1810.48),(8,'SOQJ7WKC',2,115.66),(9,'J4N9XJ4D',5,2217.45),(10,'Q4LYRQZA',2,875.04),(11,'IH6ZEBPS',3,566.91),(13,'W7RZ6N9E',3,1133.58),(14,'WPKEENN6',2,772.14),(15,'NHKC9VA2',1,304.78),(16,'LAOEQNN4',3,1414.68),(17,'VIOB0MKF',4,1805.12),(18,'CYP0C47Y',4,77.48),(19,'WDJNX4WZ',1,387.16),(20,'18RT1167',5,1865.8),(21,'SKQKS6PT',2,183.38),(22,'18RT1167',5,1865.8),(23,'8W6I44BK',4,703),(24,'HFYAPVMB',2,562.86),(25,'07JOMEMX',1,157.49),(26,'8W6I44BK',5,878.75),(27,'T270HBL7',3,975.33),(28,'UXHWBA9M',1,167.76),(29,'JLGBSFH4',5,294.1),(30,'FPKL98U5',1,138.55),(31,'3Q2CDUS9',1,452.62),(32,'96FJK1IQ',1,365.06),(33,'LAOEQNN4',5,2357.8),(34,'DB8AUO9F',3,674.19),(35,'SOQJ7WKC',1,57.83),(36,'5PZN21XB',5,428.2),(37,'VIOB0MKF',4,1805.12),(38,'ZQ6ZJJRA',1,409.09),(39,'6F69KW7J',5,2259.95),(40,'LAOEQNN4',1,471.56),(41,'W7RZ6N9E',5,1889.3),(42,'GHM9LQB8',5,67.35),(43,'GXYV1QFB',1,355.12),(44,'JPZKX5MY',2,281.98),(45,'526NLE8Q',3,289.83),(46,'1Y2AO0F1',5,2192.6),(47,'4PBPRS9R',2,754.36),(48,'QOAIPIR8',2,566.86),(49,'4Z39NBLM',5,855.7),(50,'WPKEENN6',5,1930.35),(51,'81UH1JTK',5,448.3),(52,'MYK0SBN8',1,14.26),(55,'DEXSKNMK',1,472.47),(55,'CYP0C47Y',1,19.37),(55,'GU0DIOWR',1,17.98),(56,'U7W5WUNR',3,155.82),(56,'15WW69Y0',1,105.87),(57,'48UMP652',2,92.42),(57,'7F8NRVTI',1,400.06),(58,'HFYAPVMB',1,281.43),(58,'AOL362VF',1,213.1),(58,'07JOMEMX',4,629.96);
/*!40000 ALTER TABLE `order_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_division`
--

DROP TABLE IF EXISTS `product_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_division` (
  `id` int NOT NULL AUTO_INCREMENT,
  `division_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_division`
--

LOCK TABLES `product_division` WRITE;
/*!40000 ALTER TABLE `product_division` DISABLE KEYS */;
INSERT INTO `product_division` VALUES (1,'Industrial'),(2,'Books'),(3,'Baby'),(4,'Computers'),(5,'Kitchen'),(6,'Electronics'),(7,'Houseware'),(8,'Entertainment'),(9,'Music'),(10,'Kids'),(11,'Toys'),(12,'Tools'),(13,'Outdoors'),(14,'Health'),(15,'DIY'),(16,'Grocery'),(17,'Beauty'),(18,'Clothing'),(19,'Garden'),(20,'Jewelry');
/*!40000 ALTER TABLE `product_division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'simple_online_store_dummy'
--

--
-- Dumping routines for database 'simple_online_store_dummy'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-29 15:13:33
