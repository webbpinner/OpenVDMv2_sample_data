-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: localhost    Database: OpenVDMv2
-- ------------------------------------------------------
-- Server version	5.7.32-0ubuntu0.18.04.1

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
-- Table structure for table `OVDM_CollectionSystemTransfers`
--

DROP TABLE IF EXISTS `OVDM_CollectionSystemTransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OVDM_CollectionSystemTransfers` (
  `collectionSystemTransferID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `longName` text,
  `cruiseOrLowering` int(1) unsigned NOT NULL DEFAULT '0',
  `sourceDir` tinytext,
  `destDir` tinytext,
  `staleness` int(11) DEFAULT '0',
  `useStartDate` tinyint(1) DEFAULT '0',
  `transferType` int(11) unsigned NOT NULL,
  `localDirIsMountPoint` int(1) unsigned NOT NULL DEFAULT '0',
  `rsyncServer` tinytext,
  `rsyncUser` tinytext,
  `rsyncPass` tinytext,
  `smbServer` tinytext,
  `smbUser` tinytext,
  `smbPass` tinytext,
  `smbDomain` tinytext,
  `sshServer` tinytext,
  `sshUser` tinytext,
  `sshUseKey` int(1) unsigned NOT NULL DEFAULT '0',
  `sshPass` tinytext,
  `includeFilter` text,
  `excludeFilter` text,
  `ignoreFilter` text,
  `status` int(11) unsigned NOT NULL DEFAULT '3',
  `enable` tinyint(1) NOT NULL DEFAULT '0',
  `pid` int(11) unsigned DEFAULT '0',
  `bandwidthLimit` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`collectionSystemTransferID`),
  KEY `CollectionSystemTransferStatus` (`status`),
  KEY `CollectionSystemTransferType` (`transferType`),
  CONSTRAINT `CollectionSystemTransferStatus` FOREIGN KEY (`status`) REFERENCES `OVDM_Status` (`statusID`),
  CONSTRAINT `CollectionSystemTransferType` FOREIGN KEY (`transferType`) REFERENCES `OVDM_TransferTypes` (`transferTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OVDM_CollectionSystemTransfers`
--

LOCK TABLES `OVDM_CollectionSystemTransfers` WRITE;
/*!40000 ALTER TABLE `OVDM_CollectionSystemTransfers` DISABLE KEYS */;
INSERT INTO `OVDM_CollectionSystemTransfers` VALUES (1,'OpenRVDAS','OpenRVDAS Underway Data Acquistion System',0,'/vault/data/OpenRVDAS','OpenRVDAS',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*','','',2,1,0,0),(2,'XBT','Expendable Bathythermograph ',0,'/vault/data/XBT','XBT',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*{cruiseID}_XBT[0-9][0-9][0-9]_*','','',2,1,0,0),(3,'EM302','EM302 Multibeam Mapping System',0,'/vault/data/EM302','EM302',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*','','',2,1,0,0),(4,'CTD','SBE 911+ CTD',0,'/vault/data/CTD','CTD',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*{cruiseID}_CTD[0-9][0-9][0-9]_*','','*decktest*',2,1,0,0),(5,'Sealog','Sealog Event Logging System',0,'/vault/data/sealog','Sealog',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*','','',2,1,0,0);
/*!40000 ALTER TABLE `OVDM_CollectionSystemTransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OVDM_CoreVars`
--

DROP TABLE IF EXISTS `OVDM_CoreVars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OVDM_CoreVars` (
  `coreVarID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `value` tinytext,
  PRIMARY KEY (`coreVarID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OVDM_CoreVars`
--

LOCK TABLES `OVDM_CoreVars` WRITE;
/*!40000 ALTER TABLE `OVDM_CoreVars` DISABLE KEYS */;
INSERT INTO `OVDM_CoreVars` VALUES (1,'shipboardDataWarehouseIP','openvdm.oceandatarat.org'),(2,'shipboardDataWarehouseUsername','survey'),(3,'shipboardDataWarehousePublicDataDir','/vault/FTPRoot/PublicData'),(4,'shipboardDataWarehouseStatus','2'),(5,'cruiseID','CS2003'),(6,'cruiseStartDate','2021/01/24 00:00'),(7,'cruiseEndDate','2021/02/24 15:45'),(8,'cruiseSize','112747818'),(9,'cruiseSizeUpdated','2021/01/27 13:00:59'),(10,'loweringID',''),(11,'loweringStartDate',''),(12,'loweringEndDate',''),(13,'loweringSize','4096'),(14,'loweringSizeUpdated','2021/01/27 13:00:59'),(15,'systemStatus','On'),(16,'shipToShoreBWLimitStatus','Off'),(17,'md5FilesizeLimit','10'),(18,'md5FilesizeLimitStatus','On'),(19,'showLoweringComponents','Yes');
/*!40000 ALTER TABLE `OVDM_CoreVars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OVDM_CruiseDataTransfers`
--

DROP TABLE IF EXISTS `OVDM_CruiseDataTransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OVDM_CruiseDataTransfers` (
  `cruiseDataTransferID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `longName` text,
  `transferType` int(11) unsigned NOT NULL,
  `destDir` tinytext,
  `localDirIsMountPoint` int(1) unsigned NOT NULL DEFAULT '0',
  `rsyncServer` tinytext,
  `rsyncUser` tinytext,
  `rsyncPass` tinytext,
  `smbServer` tinytext,
  `smbUser` tinytext,
  `smbPass` tinytext,
  `smbDomain` tinytext,
  `sshServer` tinytext,
  `sshUser` tinytext,
  `sshUseKey` int(1) unsigned NOT NULL DEFAULT '0',
  `sshPass` tinytext,
  `status` int(11) unsigned NOT NULL DEFAULT '3',
  `enable` tinyint(1) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `pid` int(11) unsigned DEFAULT '0',
  `bandwidthLimit` int(10) unsigned NOT NULL DEFAULT '0',
  `includeOVDMFiles` int(1) unsigned NOT NULL DEFAULT '0',
  `excludedCollectionSystems` tinytext,
  `excludedExtraDirectories` tinytext,
  PRIMARY KEY (`cruiseDataTransferID`),
  KEY `CruiseDataTransferStatus` (`status`),
  KEY `CruiseDataTransferType` (`transferType`),
  CONSTRAINT `CruiseDataTransferStatus` FOREIGN KEY (`status`) REFERENCES `OVDM_Status` (`statusID`),
  CONSTRAINT `CruiseDataTransferType` FOREIGN KEY (`transferType`) REFERENCES `OVDM_TransferTypes` (`transferTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OVDM_CruiseDataTransfers`
--

LOCK TABLES `OVDM_CruiseDataTransfers` WRITE;
/*!40000 ALTER TABLE `OVDM_CruiseDataTransfers` DISABLE KEYS */;
INSERT INTO `OVDM_CruiseDataTransfers` VALUES (1,'SSDW','Shoreside Data Warehouse',4,'/vault/Shoreside',0,'','','','','','','','ovdm-portoffice.oceandatarat.org','survey',1,NULL,2,0,1,0,128,0,'0','0'),(2,'PI_Copy','Cruise data copy for PI',1,'/media/survey/SANDISK_64GB',0,'','','','','','','','','',0,'',2,1,0,0,0,1,'0','0');
/*!40000 ALTER TABLE `OVDM_CruiseDataTransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OVDM_ExtraDirectories`
--

DROP TABLE IF EXISTS `OVDM_ExtraDirectories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OVDM_ExtraDirectories` (
  `extraDirectoryID` int(11) unsigned NOT NULL AUTO_INCREMENT,
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
INSERT INTO `OVDM_ExtraDirectories` VALUES (1,'Transfer_Logs','Transfer Logs','OpenVDM/TransferLogs',1,1),(2,'Dashboard_Data','Dashboard Data','OpenVDM/DashboardData',1,1),(3,'Science','Misc. cruise docs, pictures and data. ','From_PublicData',1,1),(4,'Tracklines','Cruise Tracklines','Products/Tracklines',1,0);
/*!40000 ALTER TABLE `OVDM_ExtraDirectories` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2021-01-27 13:01:01
