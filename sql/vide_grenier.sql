-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3309
-- Généré le :  mar. 20 avr. 2021 à 10:16
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `vide_grenier`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `desincriptionMailing`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `desincriptionMailing` (IN `mail` VARCHAR(50))  NO SQL
BEGIN
	DELETE FROM mailing_list where MAIL_ML = mail;
END$$

DROP PROCEDURE IF EXISTS `inscriptionMailing`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inscriptionMailing` (IN `mail` VARCHAR(50))  MODIFIES SQL DATA
BEGIN
INSERT INTO mailing_list
    SELECT mail
    FROM (SELECT MAIL_ML) t
    WHERE NOT EXISTS (SELECT 1
                      FROM mailing_list ml
                      WHERE ml.MAIL_ML = t.MAIL_ML
                     );
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `attestationhonneur`
--

DROP TABLE IF EXISTS `attestationhonneur`;
CREATE TABLE IF NOT EXISTS `attestationhonneur` (
  `ID_AH` int(11) NOT NULL,
  `ID_HOROD` int(11) NOT NULL,
  `DATENAIS_AH` date NOT NULL,
  `DEPTNAIS_AH` decimal(8,0) NOT NULL,
  `VILLENAIS_AH` text NOT NULL,
  `NUMCNI_AH` decimal(8,0) NOT NULL,
  `DATEDELIVRCNI_AH` date NOT NULL,
  `EMETCNI_AH` text NOT NULL,
  `NUMPLAQIMM_AH` text DEFAULT NULL,
  PRIMARY KEY (`ID_AH`),
  KEY `FK_IMPLIQUER` (`ID_HOROD`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `exposant`
--

DROP TABLE IF EXISTS `exposant`;
CREATE TABLE IF NOT EXISTS `exposant` (
  `ID_EXP` int(11) NOT NULL,
  `ID_RES` int(11) NOT NULL,
  `ID_AH` int(11) NOT NULL,
  `ID_UTIL` int(11) NOT NULL,
  `NOM_EXP` text NOT NULL,
  `PRENOM_EXP` text NOT NULL,
  `ADR_EXP` text NOT NULL,
  `CP_EXP` decimal(8,0) NOT NULL,
  `VILLE_EXP` text NOT NULL,
  `TEL_EXP` decimal(8,0) NOT NULL,
  `EMAIL_EXP` text NOT NULL,
  `COMMENT_EXP` text DEFAULT NULL,
  PRIMARY KEY (`ID_EXP`),
  KEY `FK_DEVENIR` (`ID_UTIL`),
  KEY `FK_FAIRE` (`ID_RES`),
  KEY `FK_FOURNIR` (`ID_AH`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `horodatage`
--

DROP TABLE IF EXISTS `horodatage`;
CREATE TABLE IF NOT EXISTS `horodatage` (
  `ID_HOROD` int(11) NOT NULL,
  `IP_HOROD` text NOT NULL,
  `DATE_HOROD` date NOT NULL,
  `HEURE_HOROD` time NOT NULL,
  PRIMARY KEY (`ID_HOROD`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `mailing_list`
--

DROP TABLE IF EXISTS `mailing_list`;
CREATE TABLE IF NOT EXISTS `mailing_list` (
  `ID_ML` int(11) NOT NULL AUTO_INCREMENT,
  `MAIL_ML` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_ML`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `mailing_list`
--

INSERT INTO `mailing_list` (`ID_ML`, `MAIL_ML`) VALUES
(2, 'tom@gotmail.fr');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `ID_RES` int(11) NOT NULL,
  `ID_VG` int(11) NOT NULL,
  `NBREEMPLRESERVE_RES` decimal(8,0) NOT NULL,
  `TYPEPAIEMENT_RES` text NOT NULL,
  `STATUTRESERVATION_RES` text NOT NULL,
  `NUMEMPLATTRIBUE_RES` decimal(8,0) NOT NULL,
  PRIMARY KEY (`ID_RES`),
  KEY `FK_CORRESPONDRE` (`ID_VG`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `ID_ROL` int(11) NOT NULL,
  `ADMIN_ROL` text NOT NULL,
  `MEMB_ROL` text NOT NULL,
  `VISIT_ROL` text NOT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`ID_ROL`, `ADMIN_ROL`, `MEMB_ROL`, `VISIT_ROL`) VALUES
(1, 'admin', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `ID_UTIL` int(11) NOT NULL,
  `ID_ROL` int(11) NOT NULL,
  `NOM_UTIL` text NOT NULL,
  `MDP_UTIL` text NOT NULL,
  `EMAIL_UTIL` text NOT NULL,
  `TEL_UTIL` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`ID_UTIL`),
  KEY `FK_AVOIR` (`ID_ROL`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`ID_UTIL`, `ID_ROL`, `NOM_UTIL`, `MDP_UTIL`, `EMAIL_UTIL`, `TEL_UTIL`) VALUES
(1, 1, 'root', 'rootroot', 'root@hotmail.fr', '66168214');

-- --------------------------------------------------------

--
-- Structure de la table `videgrenier`
--

DROP TABLE IF EXISTS `videgrenier`;
CREATE TABLE IF NOT EXISTS `videgrenier` (
  `ID_VG` int(11) NOT NULL,
  `DATE_VG` date NOT NULL,
  `PRIXEMPL_VG` float(8,2) NOT NULL,
  `NBREEMPLINIT_VG` decimal(8,0) NOT NULL,
  `NBREEMPLINDISPO_VG` decimal(8,0) NOT NULL,
  `NOMBRE_D_EMPLACEMENTS_RESTANTS_TEMPORAIRES_` decimal(8,0) NOT NULL,
  `NBREEMPLRESTREEL_VG` decimal(8,0) NOT NULL,
  `NBREPARTICIP_VG` decimal(8,0) NOT NULL,
  PRIMARY KEY (`ID_VG`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
