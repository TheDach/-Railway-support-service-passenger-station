CREATE DATABASE  IF NOT EXISTS `railway_transportation` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `railway_transportation`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: railway_transportation
-- ------------------------------------------------------
-- Server version	5.5.23

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
-- Table structure for table `brigades`
--

DROP TABLE IF EXISTS `brigades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brigades` (
  `ID_Brigade` int(11) NOT NULL,
  PRIMARY KEY (`ID_Brigade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brigades`
--

LOCK TABLES `brigades` WRITE;
/*!40000 ALTER TABLE `brigades` DISABLE KEYS */;
INSERT INTO `brigades` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `brigades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengers` (
  `ID_Passenger` int(11) NOT NULL,
  `FIO` varchar(100) DEFAULT NULL,
  `Gender` varchar(5) DEFAULT NULL,
  `Passport` varchar(45) DEFAULT NULL,
  `Date_birth` varchar(45) DEFAULT NULL,
  `Department_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_Passenger`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengers`
--

LOCK TABLES `passengers` WRITE;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
INSERT INTO `passengers` VALUES (1,'Alexandrova Yasmina Savelyevna','W','92 78 621522','10.04.1961','101-194'),(2,'Fedorova Polina Alekseevna','W','14 84 904474','07.01.1991','873-548'),(3,'Solovyova Sofia Andreevna','W','92 96 064048','22.07.1966','723-414'),(4,'Gracheva Malika Daniilovna','W','94 51 639715','13.02.1983','522-707'),(5,'Andreeva Kristina Konstantinovna','W','26 92 486447','20.10.1999','532-502'),(6,'Gorbunov Maxim Mikhailovich','M','37 67 178237','10.07.1959','303-866'),(7,'Panina Yana Markovna','W','40 62 166206','19.11.1991','343-207'),(8,'Kozlov Matvey Yaroslavovich','M','03 39 789916','10.01.2000','211-933'),(9,'Dmitriev Evgeny Maksimovich','M','27 60 724435','03.10.1977','443-883'),(10,'Yaroslav Petrovich Zaitsev','M','54 71 649407','25.04.2001','851-310'),(11,'Morozova Ekaterina Makarovna','W','76 79 161442','11.01.1990','413-830'),(12,'Kuznetsov Grigory Kirillovich','M','12 27 353208','03.03.1972','172-369'),(13,'Gusev Maxim Alievich','M','63 61 208565','29.10.2003','571-713'),(14,'Utkina Olga Ivanovna','W','50 66 027666','17.01.1984','283-129'),(15,'Morozova Ekaterina Makarovna','W','85 68 847642','26.03.1992','641-216'),(16,'Morozov Ekaterina Makarevich','M','61 32 350298','31.05.2001','772-842'),(17,'Arkhipov Konstantin Dmitrievich','M','47 48 189581','18.02.1963','632-237'),(18,'Nikitin Igor Arsenyevich','M','50 87 507714','50 87 507714','143-865'),(19,'Lazar Alekseevich Markov','M','95 26 024070','22.06.1983','22.06.1983'),(20,'Lytkin Ruben Germanovich','M','21 37 838144','21 37 838144','751-998');
/*!40000 ALTER TABLE `passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `routes` (
  `ID_Route` int(11) NOT NULL,
  `Place_departure` int(11) DEFAULT NULL,
  `Place_arrival` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_Route`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routes`
--

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
INSERT INTO `routes` VALUES (1,1,2),(2,15,4),(3,14,12),(4,7,4),(5,15,2),(6,10,11),(7,10,2),(8,5,4),(9,6,8),(10,11,13);
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `ID_Race` int(11) NOT NULL,
  `ID_Train` int(11) DEFAULT NULL,
  `Route` int(11) DEFAULT NULL,
  `Brigade` int(11) DEFAULT NULL,
  `Date_and_time_departure` varchar(45) DEFAULT NULL,
  `Date_and_time_arrival` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_Race`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,4,1,4,'17.03.2025 07:42','17.03.2025 16:20'),(2,6,10,2,'15.06.2025 11:35','17.06.2025 12:32'),(3,1,8,3,'14.05.2025 13:54','15.05.2025 00:11'),(4,3,6,1,'01.11.2025 07:48','01.11.2025 20:59'),(5,6,9,2,'10.12.2024 22:07','11.12.2024 02:28'),(6,6,5,2,'19.06.2025 05:26','19.06.2025 15:49'),(7,6,2,1,'28.10.2025 01:50','29.10.2025 10:35'),(8,4,7,4,'18.03.2025 16:54','19.03.2025 16:54'),(9,4,10,4,'20.02.2025 01:42','25.02.2025 00:30'),(10,4,9,4,'16.01.2025 00:02','16.01.2025 22:12');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `ID_Staff` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Surname` varchar(45) DEFAULT NULL,
  `Post` varchar(45) DEFAULT NULL,
  `Brigade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_Staff`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Olga','Mikhailovna','Conductor','1'),(2,'Igor','Bogdanov','Machinist','1'),(3,'Nikita','Tikhomirov','Conductor','1'),(4,'Alice','Kiselyova','Conductor','1'),(5,'Mark','Pavlov','Machinist','1'),(6,'Medina','Ulyanova','Conductor','2'),(7,'Roman','Tsvetkov','Conductor','2'),(8,'Mikhail','Prokhorov','Machinist','2'),(9,'Sergey','Danilov','Machinist','2'),(10,'Alexander','Kharitonov','Conductor','2'),(11,'Aliya','Akimova','Conductor','3'),(12,'Maria ','Makeeva','Machinist','3'),(13,'Mikhail ','Alexandrov','Conductor','3'),(14,'Serafima ','Popova','Conductor','3'),(15,'Maryam ','Golovin','Machinist','3'),(16,'Egor ','Gorelov','Conductor','4'),(17,'Evgeny ','Makarov','Machinist','4'),(18,'Mark','Ustinov ','Machinist','4'),(19,'Varvara','Kuznetsova','Conductor','4'),(20,'Amir','Maslov','Conductor','4');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stations` (
  `ID_Station` int(11) NOT NULL,
  `Name_station` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_Station`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
INSERT INTO `stations` VALUES (1,'Tomsk'),(2,'Moscow'),(3,'Kemerovo'),(4,'Yurga'),(5,'Omsk'),(6,'Novosibirsk'),(7,'Vladivostok'),(8,'Simferopol'),(9,'Saint-Petersburg'),(10,'Kaliningrad'),(11,'Novgorod'),(12,'Krasnoyarsk'),(13,'Cheboksary'),(14,'Abakan'),(15,'Voronezh');
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `Ticket number` int(11) NOT NULL,
  `Railway_carriage` int(11) DEFAULT NULL,
  `Place` int(11) DEFAULT NULL,
  `Passenger` int(11) DEFAULT NULL,
  `Route` varchar(45) DEFAULT NULL,
  `Price` decimal(15,2) DEFAULT NULL,
  `Type_carriage` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Ticket number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (2,8,32,20,'2',1456.17,'Compartment'),(3,8,26,16,'2',3004.20,'Compartment'),(4,4,1,2,'2',983.00,'Compartment'),(5,3,18,10,'1',1029.39,'Sedentary'),(6,4,14,13,'1',503.32,'Sedentary'),(7,1,8,6,'6',983.08,'Sedentary'),(9,3,11,4,'6',6382.98,'Sedentary'),(10,7,22,18,'3',2836.00,'Compartment');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trains`
--

DROP TABLE IF EXISTS `trains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trains` (
  `ID_Train` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Number_wagons` varchar(45) DEFAULT NULL,
  `Speed_Km/h` int(11) DEFAULT NULL,
  `Thrust_force_kN` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_Train`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trains`
--

LOCK TABLES `trains` WRITE;
/*!40000 ALTER TABLE `trains` DISABLE KEYS */;
INSERT INTO `trains` VALUES (1,'Topeka','Electric freight locomotive','7',55,539),(2,'ServTrans','Electric freight locomotive','15',51,845),(3,'Atchison','Electric freight locomotive','21',55,538),(4,'Swallow','Passenger electric locomotive','4',162,192),(5,'Sinara','Diesel locomotive','12',197,167),(6,'Peregrine Falcon','Passenger electric locomotive','10',354,1000);
/*!40000 ALTER TABLE `trains` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-07 20:50:48
