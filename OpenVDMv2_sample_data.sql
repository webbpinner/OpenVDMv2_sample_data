-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: OpenVDMv2
-- ------------------------------------------------------
-- Server version	8.0.23-0ubuntu0.20.04.1

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
-- Table structure for table `OVDM_CollectionSystemTransfers`
--

DROP TABLE IF EXISTS `OVDM_CollectionSystemTransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OVDM_CollectionSystemTransfers` (
  `collectionSystemTransferID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `longName` text,
  `cruiseOrLowering` int unsigned NOT NULL DEFAULT '0',
  `sourceDir` tinytext,
  `destDir` tinytext,
  `staleness` int DEFAULT '0',
  `useStartDate` tinyint(1) DEFAULT '0',
  `transferType` int unsigned NOT NULL,
  `localDirIsMountPoint` int unsigned NOT NULL DEFAULT '0',
  `rsyncServer` tinytext,
  `rsyncUser` tinytext,
  `rsyncPass` tinytext,
  `smbServer` tinytext,
  `smbUser` tinytext,
  `smbPass` tinytext,
  `smbDomain` tinytext,
  `sshServer` tinytext,
  `sshUser` tinytext,
  `sshUseKey` int unsigned NOT NULL DEFAULT '0',
  `sshPass` tinytext,
  `includeFilter` text,
  `excludeFilter` text,
  `ignoreFilter` text,
  `status` int unsigned NOT NULL DEFAULT '3',
  `enable` tinyint(1) NOT NULL DEFAULT '0',
  `pid` int unsigned DEFAULT '0',
  `bandwidthLimit` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`collectionSystemTransferID`),
  KEY `CollectionSystemTransferStatus` (`status`),
  KEY `CollectionSystemTransferType` (`transferType`),
  CONSTRAINT `CollectionSystemTransferStatus` FOREIGN KEY (`status`) REFERENCES `OVDM_Status` (`statusID`),
  CONSTRAINT `CollectionSystemTransferType` FOREIGN KEY (`transferType`) REFERENCES `OVDM_TransferTypes` (`transferTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OVDM_CollectionSystemTransfers`
--

LOCK TABLES `OVDM_CollectionSystemTransfers` WRITE;
/*!40000 ALTER TABLE `OVDM_CollectionSystemTransfers` DISABLE KEYS */;
INSERT INTO `OVDM_CollectionSystemTransfers` VALUES (1,'OpenRVDAS','OpenRVDAS (SSH Server)',0,'/vault/sample_data/ssh_source/OpenRVDAS','OpenRVDAS',0,0,4,0,'','','','','','','','127.0.0.1','survey',1,NULL,'*','','',2,1,0,0),(2,'XBT','XBT  (Authenticated SMB Share)',0,'XBT','XBT',0,0,3,0,'','','','//localhost/SampleAuthSource','survey','sample_smb_passwd','WORKGROUP','','',0,'','*{cruiseID}_XBT[0-9][0-9][0-9]_*','','',2,1,0,0),(3,'EM302','EM302 Multibeam (Rsync Server)',0,'/EM302','EM302',0,0,2,0,'localhost/sample_data','survey','b4dPassword!','','','','','','',0,'','*','','',2,1,0,0),(4,'CTD','SBE 911+ CTD (Local Directory)',0,'/vault/sample_data/local_source/CTD','CTD ',0,0,1,0,'','','','','','','','','',0,'','*{cruiseID}_CTD[0-9][0-9][0-9]_*','','*decktest*',2,1,0,0),(5,'Sealog','Sealog (Guest SMB Share)',0,'sealog','Sealog',0,0,3,0,'','','','//localhost/SampleAnonSource','guest','','WORKGROUP','','',0,'','*','','',2,1,0,0),(7,'ROV_SCS','SCS collecting data for ROV',1,'/vault/sample_data/local_source/SCSData','SCSData',0,0,1,0,'','','','','','','','','',0,'','*','','',2,1,0,0);
/*!40000 ALTER TABLE `OVDM_CollectionSystemTransfers` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `OVDM_CruiseDataTransfers`
--

DROP TABLE IF EXISTS `OVDM_CruiseDataTransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OVDM_CruiseDataTransfers` (
  `cruiseDataTransferID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `longName` text,
  `transferType` int unsigned NOT NULL,
  `destDir` tinytext,
  `localDirIsMountPoint` int unsigned NOT NULL DEFAULT '0',
  `rsyncServer` tinytext,
  `rsyncUser` tinytext,
  `rsyncPass` tinytext,
  `smbServer` tinytext,
  `smbUser` tinytext,
  `smbPass` tinytext,
  `smbDomain` tinytext,
  `sshServer` tinytext,
  `sshUser` tinytext,
  `sshUseKey` int unsigned NOT NULL DEFAULT '0',
  `sshPass` tinytext,
  `status` int unsigned NOT NULL DEFAULT '3',
  `enable` tinyint(1) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `pid` int unsigned DEFAULT '0',
  `bandwidthLimit` int unsigned NOT NULL DEFAULT '0',
  `includeOVDMFiles` int unsigned NOT NULL DEFAULT '0',
  `includePublicDataFiles` int unsigned NOT NULL DEFAULT '0',
  `excludedCollectionSystems` tinytext,
  `excludedExtraDirectories` tinytext,
  PRIMARY KEY (`cruiseDataTransferID`),
  KEY `CruiseDataTransferStatus` (`status`),
  KEY `CruiseDataTransferType` (`transferType`),
  CONSTRAINT `CruiseDataTransferStatus` FOREIGN KEY (`status`) REFERENCES `OVDM_Status` (`statusID`),
  CONSTRAINT `CruiseDataTransferType` FOREIGN KEY (`transferType`) REFERENCES `OVDM_TransferTypes` (`transferTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OVDM_CruiseDataTransfers`
--

LOCK TABLES `OVDM_CruiseDataTransfers` WRITE;
/*!40000 ALTER TABLE `OVDM_CruiseDataTransfers` DISABLE KEYS */;
INSERT INTO `OVDM_CruiseDataTransfers` VALUES (1,'SSDW','Shoreside Data Warehouse',4,'/vault/sample_data/ssdw',0,'','','','','','','','localhost','survey',1,NULL,2,1,1,0,128,0,0,'0','0'),(2,'Local_Copy','Cruise copy to local directory',1,'/vault/sample_data/local_destination',0,'','','','','','','','','',0,'',2,1,0,0,0,0,0,'0','0'),(3,'Cruise_Auth_SMB','Cruise copy to authenticated SMB share',3,'/',0,'','','','//localhost/SampleAuthDestination','survey','sample_smb_passwd','WORKGROUP','','',0,'',2,1,0,0,0,0,0,'0','0'),(4,'Cruise_Anon_SMB','Cruise copy to anonymous SMB share',3,'/',0,'','','','//localhost/SampleAnonDestination','guest','','WORKGROUP','','',0,'',2,1,0,0,0,0,0,'0','0'),(5,'cruise_rsync','Cruise copy to rsync server',2,'/',0,'localhost/sample_dest','survey','b4dPassword!','','','','','','',0,'',2,1,0,0,0,0,0,'0','0'),(6,'cruise_ssh','Cruise copy to SSH server',4,'/vault/sample_data/ssh_destination',0,'','','','','','','','localhost','survey',1,NULL,2,1,0,0,0,0,0,'0','0');
/*!40000 ALTER TABLE `OVDM_CruiseDataTransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OVDM_ExtraDirectories`
--

DROP TABLE IF EXISTS `OVDM_ExtraDirectories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OVDM_ExtraDirectories` (
  `extraDirectoryID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `longName` tinytext,
  `destDir` tinytext NOT NULL,
  `enable` tinyint(1) DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`extraDirectoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OVDM_ExtraDirectories`
--

LOCK TABLES `OVDM_ExtraDirectories` WRITE;
/*!40000 ALTER TABLE `OVDM_ExtraDirectories` DISABLE KEYS */;
INSERT INTO `OVDM_ExtraDirectories` VALUES (1,'Transfer_Logs','Transfer Logs','OpenVDM/TransferLogs',1,1),(2,'Dashboard_Data','Dashboard Data','OpenVDM/DashboardData',1,1),(3,'From_PublicData','Files copied from PublicData share','From_PublicData',1,1),(4,'Tracklines','Cruise Tracklines','Products/Tracklines',1,0);
/*!40000 ALTER TABLE `OVDM_ExtraDirectories` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `OVDM_ShipToShoreTransfers`
--

DROP TABLE IF EXISTS `OVDM_ShipToShoreTransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OVDM_ShipToShoreTransfers` (
  `shipToShoreTransferID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext,
  `longName` tinytext,
  `priority` int DEFAULT NULL,
  `collectionSystem` int unsigned DEFAULT NULL,
  `extraDirectory` int unsigned DEFAULT NULL,
  `includeFilter` tinytext,
  `enable` tinyint(1) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shipToShoreTransferID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OVDM_ShipToShoreTransfers`
--

LOCK TABLES `OVDM_ShipToShoreTransfers` WRITE;
/*!40000 ALTER TABLE `OVDM_ShipToShoreTransfers` DISABLE KEYS */;
INSERT INTO `OVDM_ShipToShoreTransfers` VALUES (1,'DashboardData','Dashboard Data',1,0,2,'*',1,1),(2,'TransferLogs','Transfer Logs',1,0,1,'*',0,1),(3,'MD5Summary','MD5 Summary',1,0,0,'MD5_Summary.txt,MD5_Summary.md5 ',1,1),(4,'OVDM_Config','OpenVDM Configuration',1,0,0,'ovdmConfig.json',1,1),(5,'GGA_FILES','GGA Files',1,1,0,'*GGA*.Raw',1,0),(6,'MET','Met raw files',3,1,0,'*MET-M01*.Raw,*TSG-RAW*.Raw',1,0);
/*!40000 ALTER TABLE `OVDM_ShipToShoreTransfers` ENABLE KEYS */;
UNLOCK TABLES;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-05 14:57:23
