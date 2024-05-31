-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ruegg_thomas_expi1b_pappy_john
DROP DATABASE IF EXISTS `ruegg_thomas_expi1b_pappy_john`;
CREATE DATABASE IF NOT EXISTS `ruegg_thomas_expi1b_pappy_john` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ruegg_thomas_expi1b_pappy_john`;

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblarticle
DROP TABLE IF EXISTS `tblarticle`;
CREATE TABLE IF NOT EXISTS `tblarticle` (
  `Id_article` int NOT NULL AUTO_INCREMENT,
  `ArtArticle` varchar(25) DEFAULT NULL,
  `ArtVariante` varchar(25) DEFAULT NULL,
  `ArtQuantite` int DEFAULT NULL,
  `ArtNo_Article` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Id_article`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblcommande
DROP TABLE IF EXISTS `tblcommande`;
CREATE TABLE IF NOT EXISTS `tblcommande` (
  `Id_commande` int NOT NULL AUTO_INCREMENT,
  `CmdNo_Commande` int DEFAULT NULL,
  `CmdPers_passe_Cmd` varchar(25) DEFAULT NULL,
  `CmdStatus` varchar(25) DEFAULT NULL,
  `CmdCommande_le` date DEFAULT NULL,
  `CmdRecu_le` date DEFAULT NULL,
  `CmdRemarque` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`Id_commande`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblcontact
DROP TABLE IF EXISTS `tblcontact`;
CREATE TABLE IF NOT EXISTS `tblcontact` (
  `Id_contact` int NOT NULL AUTO_INCREMENT,
  `ContNo_telephone` varchar(30) DEFAULT NULL,
  `ContMail` varchar(320) DEFAULT NULL,
  PRIMARY KEY (`Id_contact`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblfournisseur
DROP TABLE IF EXISTS `tblfournisseur`;
CREATE TABLE IF NOT EXISTS `tblfournisseur` (
  `Id_Fourn` int NOT NULL AUTO_INCREMENT,
  `FournNom_fournisseur` varchar(25) DEFAULT NULL,
  `Fourn_domaine_vente` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`Id_Fourn`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblcmd_art
DROP TABLE IF EXISTS `tblcmd_art`;
CREATE TABLE IF NOT EXISTS `tblcmd_art` (
  `Id_Cmd_Art` int NOT NULL AUTO_INCREMENT,
  `Fk_Cmd` int DEFAULT NULL,
  `Fk_Art` int DEFAULT NULL,
  PRIMARY KEY (`Id_Cmd_Art`),
  KEY `Fkcmd_art` (`Fk_Cmd`),
  KEY `Fkart_cmd` (`Fk_Art`),
  CONSTRAINT `Fkart_cmd` FOREIGN KEY (`Fk_Art`) REFERENCES `tblarticle` (`Id_article`),
  CONSTRAINT `Fkcmd_art` FOREIGN KEY (`Fk_Cmd`) REFERENCES `tblcommande` (`Id_commande`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblcmd_fourn
DROP TABLE IF EXISTS `tblcmd_fourn`;
CREATE TABLE IF NOT EXISTS `tblcmd_fourn` (
  `Id_Cmd_Fourn` int NOT NULL AUTO_INCREMENT,
  `Fk_Cmd` int DEFAULT NULL,
  `Fk_Fourn` int DEFAULT NULL,
  PRIMARY KEY (`Id_Cmd_Fourn`),
  KEY `FKfourn_cmd` (`Fk_Fourn`),
  KEY `Fkcmd_fourn` (`Fk_Cmd`),
  CONSTRAINT `Fkcmd_fourn` FOREIGN KEY (`Fk_Cmd`) REFERENCES `tblcommande` (`Id_commande`),
  CONSTRAINT `FKfourn_cmd` FOREIGN KEY (`Fk_Fourn`) REFERENCES `tblfournisseur` (`Id_Fourn`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblfourn_cont
DROP TABLE IF EXISTS `tblfourn_cont`;
CREATE TABLE IF NOT EXISTS `tblfourn_cont` (
  `Id_Fourn_Cont` int NOT NULL AUTO_INCREMENT,
  `Fk_Fourn` int DEFAULT NULL,
  `Fk_Cont` int DEFAULT NULL,
  PRIMARY KEY (`Id_Fourn_Cont`),
  KEY `Fkcont_fourn` (`Fk_Cont`),
  KEY `Fkfourn_cont` (`Fk_Fourn`),
  CONSTRAINT `Fkcont_fourn` FOREIGN KEY (`Fk_Cont`) REFERENCES `tblcontact` (`Id_contact`),
  CONSTRAINT `Fkfourn_cont` FOREIGN KEY (`Fk_Fourn`) REFERENCES `tblfournisseur` (`Id_Fourn`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblsarlacc1
DROP TABLE IF EXISTS `tblsarlacc1`;
CREATE TABLE IF NOT EXISTS `tblsarlacc1` (
  `Id_sarlacc` int NOT NULL AUTO_INCREMENT,
  `SANo_commande` int DEFAULT NULL,
  `SAArticle` varchar(25) DEFAULT NULL,
  `SAVariante` varchar(25) DEFAULT NULL,
  `SAQuantite` int DEFAULT NULL,
  `SACommande_par` varchar(25) DEFAULT NULL,
  `SAStatut` varchar(25) DEFAULT NULL,
  `SACommande_le` date DEFAULT NULL,
  `SARecu_le` date DEFAULT NULL,
  `SARemarque` varchar(100) DEFAULT NULL,
  `SANo_article` varchar(15) DEFAULT NULL,
  `SALiaison_fournisseur` int DEFAULT NULL,
  PRIMARY KEY (`Id_sarlacc`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table pour stocker les commandes supprimées';

-- Data exporting was unselected.

-- Dumping structure for table ruegg_thomas_expi1b_pappy_john.tblsarlacc2
DROP TABLE IF EXISTS `tblsarlacc2`;
CREATE TABLE IF NOT EXISTS `tblsarlacc2` (
  `Id_sarlacc` int NOT NULL AUTO_INCREMENT,
  `SANom_fournisseur` varchar(25) DEFAULT NULL,
  `SADomaine_vente` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SATelephone` varchar(30) DEFAULT NULL,
  `SAMail` varchar(320) DEFAULT NULL,
  PRIMARY KEY (`Id_sarlacc`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table pour stocker les fournisseurs supprimées';

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
