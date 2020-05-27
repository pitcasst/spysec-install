-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnueabihf (armv8l)
--
-- Host: localhost    Database: spysec
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audios`
--

DROP TABLE IF EXISTS `audios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audios` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `audio` varchar(255) NOT NULL DEFAULT '.wav',
  `duracion` text DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audios`
--

LOCK TABLES `audios` WRITE;
/*!40000 ALTER TABLE `audios` DISABLE KEYS */;
INSERT INTO `audios` VALUES (1,'2020-05-03 07:00:00','MASARI_20200503-070000.wav',NULL,'MASARI_20200503-070000');
/*!40000 ALTER TABLE `audios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logSpysec`
--

DROP TABLE IF EXISTS `logSpysec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logSpysec` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `idSession` int(11) DEFAULT NULL,
  `fechaEvento` datetime NOT NULL,
  `usuario` varchar(255) NOT NULL DEFAULT '',
  `accion` varchar(255) NOT NULL DEFAULT '',
  `query` varchar(255) NOT NULL DEFAULT '',
  `ipHost` varchar(255) DEFAULT NULL,
  `osHost` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logSpysec`
--

LOCK TABLES `logSpysec` WRITE;
/*!40000 ALTER TABLE `logSpysec` DISABLE KEYS */;
/*!40000 ALTER TABLE `logSpysec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planificacion`
--

DROP TABLE IF EXISTS `planificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planificacion` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL DEFAULT '',
  `hora_inicio` varchar(255) NOT NULL DEFAULT '00:00:00',
  `hora_fin` varchar(255) NOT NULL DEFAULT '00:00:00',
  `dia_semana_0` varchar(11) DEFAULT '',
  `dia_semana_1` varchar(11) DEFAULT '',
  `dia_semana_2` varchar(11) DEFAULT '',
  `dia_semana_3` varchar(11) DEFAULT NULL,
  `dia_semana_4` varchar(11) DEFAULT NULL,
  `dia_semana_5` varchar(11) DEFAULT NULL,
  `dia_semana_6` varchar(11) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 0,
  `dias_semana` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planificacion`
--

LOCK TABLES `planificacion` WRITE;
/*!40000 ALTER TABLE `planificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `planificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(255) NOT NULL DEFAULT '',
  `contrasena` varchar(255) NOT NULL DEFAULT '',
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `puesto` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `img` varchar(255) NOT NULL DEFAULT 'FullSizeRender.png',
  `status` int(1) NOT NULL DEFAULT 0,
  `perfil` int(1) NOT NULL DEFAULT 2,
  `tema` varchar(255) NOT NULL DEFAULT 'skin-blue',
  `activo` int(1) NOT NULL DEFAULT 1,
  `navbar` int(1) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_session` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `bloqueado` int(1) NOT NULL DEFAULT 0,
  `grupo` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','2dd9236f0ce33fd51d5b9f1e6c0ebf1b','Administrador',NULL,NULL,NULL,'FullSizeRender.png',1,1,'skin-blue',1,NULL,'0000-00-00 00:00:00','2020-05-11 14:58:48',0,'Administrador'),(2,'jrangel','a83293e08249f08bbd7daf50e13eb166','Juan','Rangel','Soporte','jrangel@conessis.com.mx','FullSizeRender.png',0,3,'skin-blue',1,NULL,'2020-05-26 21:05:57','0000-00-00 00:00:00',0,'');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-27 12:03:00
