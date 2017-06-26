-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: SP15_2308_tue41582
-- ------------------------------------------------------
-- Server version	5.5.44-0ubuntu0.14.04.1

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
-- Table structure for table `purchase_test`
--

DROP TABLE IF EXISTS `purchase_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_test` (
  `purchase_seqno` int(11) NOT NULL,
  `purchase_qty` int(11) DEFAULT NULL,
  `purchase_date` varchar(45) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` varchar(10) NOT NULL,
  PRIMARY KEY (`purchase_seqno`),
  KEY `fk_purchase_purchase_idx` (`customer_id`),
  KEY `fk_purchase_product1_idx` (`product_id`),
  CONSTRAINT `fk_purchase_product1` FOREIGN KEY (`product_id`) REFERENCES `product_test` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_purchase` FOREIGN KEY (`customer_id`) REFERENCES `customer_test` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_test`
--

LOCK TABLES `purchase_test` WRITE;
/*!40000 ALTER TABLE `purchase_test` DISABLE KEYS */;
INSERT INTO `purchase_test` VALUES (152103,1,'2014-05-05',2,'C789'),(1241513,2,'2015-01-12',2,'B456'),(1955390,3,'2014-06-24',3,'A123'),(2461390,2,'2014-11-14',3,'B456'),(2741359,1,'2014-03-19',1,'A123'),(3259798,2,'2014-07-13',1,'B456'),(4261589,3,'2014-08-27',1,'C789'),(5694860,3,'2014-09-15',2,'A123');
/*!40000 ALTER TABLE `purchase_test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-22 21:33:56
