-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
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


-- Listage de la structure de la base pour ruegg_thomas_expi1b_pappy_john
DROP DATABASE IF EXISTS `ruegg_thomas_expi1b_pappy_john`;
CREATE DATABASE IF NOT EXISTS `ruegg_thomas_expi1b_pappy_john` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ruegg_thomas_expi1b_pappy_john`;

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblarticle
DROP TABLE IF EXISTS `tblarticle`;
CREATE TABLE IF NOT EXISTS `tblarticle` (
  `Id_article` int NOT NULL AUTO_INCREMENT,
  `ArtArticle` varchar(25) DEFAULT NULL,
  `ArtVariante` varchar(25) DEFAULT NULL,
  `ArtQuantite` int DEFAULT NULL,
  `ArtNo_Article` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Id_article`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblarticle : ~8 rows (environ)
INSERT INTO `tblarticle` (`Id_article`, `ArtArticle`, `ArtVariante`, `ArtQuantite`, `ArtNo_Article`) VALUES
	(128, 'test', '10kg', 10000, 'ajcn134'),
	(161, 'Test', '10kg', 100, 'Pas de donnée'),
	(191, 'Test2', 'Pas de donnée', 10, 'Pas de donnée'),
	(200, 'Caffé', '100kg', 1000, '12ab'),
	(202, 'Test2', 'Pas de donnée', 10, 'Pas de donnée'),
	(206, 'Téléphone', 'Pas de donnée', 100, 'Pas de donnée'),
	(209, 'Test89', '100000kg', 1000, 'Pas de donnée'),
	(210, 'Test', 'Pas de donnée', 100, 'Pas de donnée');

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblcmd_art
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
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblcmd_art : ~7 rows (environ)
INSERT INTO `tblcmd_art` (`Id_Cmd_Art`, `Fk_Cmd`, `Fk_Art`) VALUES
	(120, 143, 161),
	(166, 173, 191),
	(176, 182, 200),
	(178, 184, 202),
	(182, 188, 206),
	(188, 191, 209),
	(189, 192, 210);

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblcmd_fourn
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
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblcmd_fourn : ~7 rows (environ)
INSERT INTO `tblcmd_fourn` (`Id_Cmd_Fourn`, `Fk_Cmd`, `Fk_Fourn`) VALUES
	(167, 143, 50),
	(213, 173, 46),
	(223, 182, 52),
	(225, 184, 46),
	(229, 188, 40),
	(235, 191, 41),
	(236, 192, 40);

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblcommande
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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblcommande : ~7 rows (environ)
INSERT INTO `tblcommande` (`Id_commande`, `CmdNo_Commande`, `CmdPers_passe_Cmd`, `CmdStatus`, `CmdCommande_le`, `CmdRecu_le`, `CmdRemarque`) VALUES
	(143, 15, 'Vendeur', 'Arrivé', '2024-04-10', '2024-04-10', 'Pas de donnée'),
	(173, 15, 'Patron', 'En attente', '2024-05-16', '0001-01-01', 'Pas de donnée'),
	(182, 10, 'Vendeur', 'Arrivé', '2024-04-24', '2024-05-03', 'Pas de donnée'),
	(184, 15, 'Venndeur', 'En attente', '2024-04-10', '0001-01-01', 'Commande urgente !!'),
	(188, 30, 'Patron', 'En attente', '2024-05-31', '0001-01-01', 'Pas de donnée'),
	(191, 89, 'Insert', 'En attente', '2024-04-26', '0001-01-01', 'Pas de donnée'),
	(192, 3000, 'Test', 'Test', '2024-04-11', '0001-01-01', 'Pas de donnée');

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblcontact
DROP TABLE IF EXISTS `tblcontact`;
CREATE TABLE IF NOT EXISTS `tblcontact` (
  `Id_contact` int NOT NULL AUTO_INCREMENT,
  `ContNo_telephone` varchar(30) DEFAULT NULL,
  `ContMail` varchar(320) DEFAULT NULL,
  PRIMARY KEY (`Id_contact`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblcontact : ~6 rows (environ)
INSERT INTO `tblcontact` (`Id_contact`, `ContNo_telephone`, `ContMail`) VALUES
	(40, '+41 77 495 28 20', 'module164@gmail.com'),
	(41, '', 'Inert@gmail.com'),
	(46, 'Pas de donnée', 'test2@gmail.ch'),
	(50, '+41 12 013 99 80', 'test123@gmail.com'),
	(51, 'Pas de donnée', 'i164@gmail.com'),
	(52, '+41 78 981 00 12', 'Test@testmail.com');

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblfournisseur
DROP TABLE IF EXISTS `tblfournisseur`;
CREATE TABLE IF NOT EXISTS `tblfournisseur` (
  `Id_Fourn` int NOT NULL AUTO_INCREMENT,
  `FournNom_fournisseur` varchar(25) DEFAULT NULL,
  `Fourn_domaine_vente` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`Id_Fourn`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblfournisseur : ~6 rows (environ)
INSERT INTO `tblfournisseur` (`Id_Fourn`, `FournNom_fournisseur`, `Fourn_domaine_vente`) VALUES
	(40, 'Module 164', 'Vendeur en informatique'),
	(41, 'Insert', 'Insert'),
	(46, 'Test2', 'Pas de donnée'),
	(50, 'test1', 'Test132'),
	(51, 'i164', 'Pas de donnée'),
	(52, 'Test', 'Pas de donnée');

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblfourn_cont
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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblfourn_cont : ~6 rows (environ)
INSERT INTO `tblfourn_cont` (`Id_Fourn_Cont`, `Fk_Fourn`, `Fk_Cont`) VALUES
	(57, 40, 40),
	(59, 41, 41),
	(67, 46, 46),
	(75, 50, 50),
	(76, 51, 51),
	(77, 52, 52);

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblsarlacc1
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
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table pour stocker les commandes supprimées';

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblsarlacc1 : ~0 rows (environ)

-- Listage de la structure de table ruegg_thomas_expi1b_pappy_john. tblsarlacc2
DROP TABLE IF EXISTS `tblsarlacc2`;
CREATE TABLE IF NOT EXISTS `tblsarlacc2` (
  `Id_sarlacc` int NOT NULL AUTO_INCREMENT,
  `SANom_fournisseur` varchar(25) DEFAULT NULL,
  `SADomaine_vente` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SATelephone` varchar(30) DEFAULT NULL,
  `SAMail` varchar(320) DEFAULT NULL,
  PRIMARY KEY (`Id_sarlacc`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table pour stocker les fournisseurs supprimées';

-- Listage des données de la table ruegg_thomas_expi1b_pappy_john.tblsarlacc2 : ~0 rows (environ)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
