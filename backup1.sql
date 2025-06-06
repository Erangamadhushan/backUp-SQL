-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: ass8
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `p_project_id` varchar(5) NOT NULL,
  `p_descrption` varchar(50) DEFAULT NULL,
  `p_budget` int DEFAULT NULL,
  `p_due_date` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`p_project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('P01','Inventory',95000,'2012-09-2'),('P02','Payroll',117000,'2012-12-10'),('P03','HRM System',200000,'2012-11-25'),('P04','Billing System',125000,'2012-11-4'),('P05','Rate Cal System',100000,'2012-09-26'),('P06','Payroll',112000,'2013-01-12'),('P07','Stock Control System',99000,'2012-10-1'),('P08','Inventory',140000,'2012-10-12');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `s_emp_no` varchar(5) NOT NULL,
  `s_surname` varchar(30) DEFAULT NULL,
  `s_initials` varchar(40) DEFAULT NULL,
  `s_title` varchar(30) DEFAULT NULL,
  `s_hourly_rate` int DEFAULT NULL,
  `s_manager` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`s_emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('E100','Perera','P.B.','Sr.Programmer',500,'E105'),('E101','Silva','D.K.','Analysts',510,'E114'),('E102','Gamage','W.G.','Sr.Programmer',430,'E114'),('E103','Bandara','R.A.','Programmer',330,'E105'),('E104','Soyza','L.','Programmer',410,'E123'),('E105','Peiris','N.C.L.','Project Mg',570,NULL),('E106','Dias','P.','Programmer',240,'E110'),('E107','Gunasena','C.','Sr.Programmer',480,'E110'),('E108','Pathirana','M.','Programmer',210,'E114'),('E109','Somapala','K.','Programmer',290,'E105'),('E110','Sirisena','G.H.','Project Mg',470,NULL),('E111','Rathnasena','B.','Sr.Programmer',420,'E123'),('E112','Silva','G.H.','Programmer',370,'E105'),('E113','Fernando','S.','Sr.Programmer',490,'E110'),('E114','Alwis','J.K.','Project Mg',660,NULL),('E115','Jayakodi','P.','Sr.Programmer',390,'E123'),('E116','Peiris','H.','Consultant',520,'E105'),('E117','David','W.F.','Programmer',360,'E114'),('E118','Dias','G.L.','Programmer',250,'E123'),('E119','Kamaladasa','P.','Sr.Programmer',700,'E114'),('E120','Jayakodi','P.','Programmer',550,'E105'),('E121','Gamage','R.A.','Consultant',450,'E110'),('E122','Alwis','P.R','Sr.Programmer',800,'E105'),('E123','Fernando','S.K.','Project Mg',300,NULL),('E124','Smith','R.D.','Programmer',550,'E105');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `t_emp_no` varchar(5) NOT NULL,
  `t_project_id` varchar(10) NOT NULL,
  `t_task` varchar(40) NOT NULL,
  `t_hours` int DEFAULT NULL,
  PRIMARY KEY (`t_emp_no`,`t_project_id`,`t_task`),
  KEY `t_project_id` (`t_project_id`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`t_emp_no`) REFERENCES `staff` (`s_emp_no`),
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`t_project_id`) REFERENCES `project` (`p_project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES ('E100','P01','Design',8),('E100','P01','Implement',5),('E101','P01','Design',8),('E101','P05','Design',16),('E101','P08','Design',10),('E101','P08','Implement',10),('E102','P06','Design',10),('E102','P06','Implement',24),('E103','P01','Implement',16),('E103','P01','Test',26),('E103','P08','Test',8),('E104','P01','Implement',18),('E104','P02','Design',16),('E104','P02','Implement',32),('E105','P02','Design',24),('E105','P02','Implement',8),('E105','P02','Manage',10),('E106','P03','Test',32);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-02 21:35:29
