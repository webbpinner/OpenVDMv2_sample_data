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
-- Dumping data for table `OVDM_CollectionSystemTransfers`
--

LOCK TABLES `OVDM_CollectionSystemTransfers` WRITE;
/*!40000 ALTER TABLE `OVDM_CollectionSystemTransfers` DISABLE KEYS */;
INSERT INTO `OVDM_CollectionSystemTransfers` (`name`,`longName`,`cruiseOrLowering`,`sourceDir`,`destDir`,`staleness`,`useStartDate`,`transferType`,`localDirIsMountPoint`,`rsyncServer`,`rsyncUser`,`rsyncPass`,`smbServer`,`smbUser`,`smbPass`,`smbDomain`,`sshServer`,`sshUser`,`sshUseKey`,`sshPass`,`includeFilter`,`excludeFilter`,`ignoreFilter`,`status`,`enable`,`pid`,`bandwidthLimit`)
VALUES ('OpenRVDAS','OpenRVDAS Underway Data Acquistion System',0,'/vault/sample_data/OpenRVDAS','OpenRVDAS',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*','','',2,1,0,0),
('XBT','Expendable Bathythermograph ',0,'/vault/sample_data/XBT','XBT',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*{cruiseID}_XBT[0-9][0-9][0-9]_*','','',2,1,0,0),
('EM302','EM302 Multibeam Mapping System',0,'/vault/sample_data/EM302','EM302',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*','','',2,1,0,0),
('CTD','SBE 911+ CTD',0,'/vault/sample_data/CTD','CTD',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*{cruiseID}_CTD[0-9][0-9][0-9]_*','','*decktest*',2,1,0,0),
('Sealog','Sealog Event Logging System',0,'/vault/sample_data/sealog','Sealog',0,0,4,0,'','','','','','','','openvdm.oceandatarat.org','survey',1,NULL,'*','','',2,1,0,0);
/*!40000 ALTER TABLE `OVDM_CollectionSystemTransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `OVDM_CruiseDataTransfers`
--

LOCK TABLES `OVDM_CruiseDataTransfers` WRITE;
/*!40000 ALTER TABLE `OVDM_CruiseDataTransfers` DISABLE KEYS */;
INSERT INTO `OVDM_CruiseDataTransfers` (`name`,`longName`,`transferType`,`destDir`,`localDirIsMountPoint`,`rsyncServer`,`rsyncUser`,`rsyncPass`,`smbServer`,`smbUser`,`smbPass`,`smbDomain`,`sshServer`,`sshUser`,`sshUseKey`,`sshPass`,`status`,`enable`,`required`,`pid`,`bandwidthLimit`,`includeOVDMFiles`,`excludedCollectionSystems`,`excludedExtraDirectories`)
VALUES ('PI_Copy','Cruise data copy for PI',1,'/media/survey/SANDISK_64GB',0,'','','','','','','','','',0,'',2,1,0,0,0,1,'0','0');
/*!40000 ALTER TABLE `OVDM_CruiseDataTransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `OVDM_ExtraDirectories`
--

LOCK TABLES `OVDM_ExtraDirectories` WRITE;
/*!40000 ALTER TABLE `OVDM_ExtraDirectories` DISABLE KEYS */;
INSERT INTO `OVDM_ExtraDirectories` (`name`,`longName`,`destDir`,`enable`,`required`)
VALUES ('Tracklines','Cruise Tracklines','Products/Tracklines',1,0);
/*!40000 ALTER TABLE `OVDM_ExtraDirectories` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2021-01-27 13:01:01
