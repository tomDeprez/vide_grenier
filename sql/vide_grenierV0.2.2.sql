-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 28 juin 2021 à 07:22
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `vide_grenier5`
--

DELIMITER $$

DROP DATABASE IF EXISTS vide_grenier$$
CREATE DATABASE vide_grenier$$


--
-- Procédures
--
DROP PROCEDURE IF EXISTS vide_grenier.desincriptionMailing$$
CREATE DEFINER=`root`@`localhost` PROCEDURE vide_grenier.desincriptionMailing (IN `mail` VARCHAR(50))  NO SQL
BEGIN
	DELETE FROM vide_grenier.mailing_list where MAIL_ML = mail;
END$$

DROP PROCEDURE IF EXISTS vide_grenier.inscriptionMailing$$
CREATE DEFINER=`root`@`localhost` PROCEDURE vide_grenier.inscriptionMailing (IN `mail` VARCHAR(50))  MODIFIES SQL DATA
BEGIN
INSERT INTO vide_grenier.mailing_list (MAIL_ML)
    SELECT mail
    FROM (SELECT mail) t
    WHERE NOT EXISTS (SELECT 1
                      FROM mailing_list ml
                      WHERE ml.MAIL_ML = t.mail
                     );
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `attestationhonneur`
--

DROP TABLE IF EXISTS vide_grenier.attestationhonneur;
CREATE TABLE IF NOT EXISTS vide_grenier.`attestationhonneur` (
  `ID_AH` int(11) NOT NULL AUTO_INCREMENT,
  `ID_HOROD` int(11) NOT NULL,
  `DATENAIS_AH` date NOT NULL,
  `DEPTNAIS_AH` decimal(8,0) NOT NULL,
  `VILLENAIS_AH` text NOT NULL,
  `NUMCNI_AH` decimal(13,0) NOT NULL,
  `DATEDELIVRCNI_AH` date NOT NULL,
  `EMETCNI_AH` text NOT NULL,
  `NUMPLAQIMM_AH` text,
  PRIMARY KEY (`ID_AH`),
  KEY `ID_HOROD` (`ID_HOROD`)
) ENGINE=InnoDB AUTO_INCREMENT=111112 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `attestationhonneur`
--

INSERT INTO vide_grenier.attestationhonneur (`ID_AH`, `ID_HOROD`, `DATENAIS_AH`, `DEPTNAIS_AH`, `VILLENAIS_AH`, `NUMCNI_AH`, `DATEDELIVRCNI_AH`, `EMETCNI_AH`, `NUMPLAQIMM_AH`) VALUES
(111111, 1111111, '1980-10-01', '69', 'Lyon', '200769180525', '2010-11-02', 'Préfecture du Rhône', 'AAA-000-AA');

-- --------------------------------------------------------

--
-- Structure de la table `exposant`
--

DROP TABLE IF EXISTS vide_grenier.exposant;
CREATE TABLE IF NOT EXISTS vide_grenier.`exposant` (
  `ID_EXP` int(11) NOT NULL AUTO_INCREMENT,
  `ID_RES` int(11) NOT NULL,
  `ID_AH` int(11) NOT NULL,
  `ID_UTIL` int(11) NOT NULL,
  `NOM_EXP` text NOT NULL,
  `PRENOM_EXP` text NOT NULL,
  `ADR_EXP` text NOT NULL,
  `CP_EXP` decimal(8,0) NOT NULL,
  `VILLE_EXP` text NOT NULL,
  `TEL_EXP` varchar(10) NOT NULL,
  `EMAIL_EXP` text NOT NULL,
  `COMMENT_EXP` text,
  PRIMARY KEY (`ID_EXP`),
  KEY `ID_RES` (`ID_RES`),
  KEY `ID_AH` (`ID_AH`),
  KEY `ID_UTIL` (`ID_UTIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `horodatage`
--

DROP TABLE IF EXISTS vide_grenier.horodatage;
CREATE TABLE IF NOT EXISTS vide_grenier.`horodatage` (
  `ID_HOROD` int(11) NOT NULL AUTO_INCREMENT,
  `IP_HOROD` text NOT NULL,
  `DATE_HOROD` date NOT NULL,
  `HEURE_HOROD` time NOT NULL,
  PRIMARY KEY (`ID_HOROD`)
) ENGINE=InnoDB AUTO_INCREMENT=1111112 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `horodatage`
--

INSERT INTO vide_grenier.horodatage (`ID_HOROD`, `IP_HOROD`, `DATE_HOROD`, `HEURE_HOROD`) VALUES
(1111111, '172.16.254.1', '2019-03-15', '22:21:20');

-- --------------------------------------------------------

--
-- Structure de la table `mailing_list`
--

DROP TABLE IF EXISTS vide_grenier.mailing_list;
CREATE TABLE IF NOT EXISTS vide_grenier.`mailing_list` (
  `ID_ML` int(11) NOT NULL AUTO_INCREMENT,
  `MAIL_ML` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_ML`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `mailing_list`
--

INSERT INTO vide_grenier.mailing_list (`ID_ML`, `MAIL_ML`) VALUES
(5, 't@gmail.com'),
(6, 'a@gmail.com'),
(7, 'aa@gmail.com'),
(8, 'bb@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS vide_grenier.reservation;
CREATE TABLE IF NOT EXISTS vide_grenier.`reservation` (
  `ID_RES` int(11) NOT NULL AUTO_INCREMENT,
  `ID_VG` int(11) NOT NULL,
  `NBREEMPLRESERVE_RES` decimal(8,0) DEFAULT NULL,
  `TYPEPAIEMENT_RES` text DEFAULT NULL,
  `STATUTRESERVATION_RES` text DEFAULT NULL,
  `NUMEMPLATTRIBUE_RES` decimal(8,0) DEFAULT NULL,
  PRIMARY KEY (`ID_RES`),
  KEY `ID_VG` (`ID_VG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS vide_grenier.role;
CREATE TABLE IF NOT EXISTS vide_grenier.`role` (
  `ID_ROL` int(11) NOT NULL AUTO_INCREMENT,
  `ADMIN_ROL` text NOT NULL,
  `MEMB_ROL` text NOT NULL,
  `VISIT_ROL` text NOT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `role`
--

INSERT INTO vide_grenier.role (`ID_ROL`, `ADMIN_ROL`, `MEMB_ROL`, `VISIT_ROL`) VALUES
(1, 'null', 'null', 'visiteur'),
(2, 'administrateur', 'null', 'null'),
(3, 'null', 'exposant', 'null');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS vide_grenier.utilisateur;
CREATE TABLE IF NOT EXISTS vide_grenier.`utilisateur` (
  `ID_UTIL` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ROL` int(11) NOT NULL,
  `NOM_UTIL` text NOT NULL,
  `MDP_UTIL` text NOT NULL,
  `EMAIL_UTIL` text NOT NULL,
  `TEL_UTIL` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID_UTIL`),
  KEY `ID_ROL` (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO vide_grenier.utilisateur (`ID_UTIL`, `ID_ROL`, `NOM_UTIL`, `MDP_UTIL`, `EMAIL_UTIL`, `TEL_UTIL`) VALUES
(1, 1, 'TOTO', '000000', 't@gmail.com', '0606060606'),
(4, 2, 'aa', '000000', 'aa@gmail.com', '0606060606'),
(5, 1, 'bb', '000000', 'bb@gmail.com', '0606060606'),
(6, 1, 'cc', '000000', 'cc@gmail.com', '0606060606');

-- --------------------------------------------------------

--
-- Structure de la table `videgrenier`
--

DROP TABLE IF EXISTS vide_grenier.videgrenier;
CREATE TABLE IF NOT EXISTS vide_grenier.`videgrenier` (
  `ID_VG` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_VG` date NOT NULL,
  `PRIXEMPL_VG` float(8,2) NOT NULL,
  `NBREEMPLINIT_VG` decimal(8,0) NOT NULL,
  `NBREEMPLINDISPO_VG` decimal(8,0) NOT NULL,
  `NOMBRE_D_EMPLACEMENTS_RESTANTS_TEMPORAIRES_` decimal(8,0) NOT NULL,
  `NBREEMPLRESTREEL_VG` decimal(8,0) NOT NULL,
  `NBREPARTICIP_VG` decimal(8,0) NOT NULL,
  PRIMARY KEY (`ID_VG`)
) ENGINE=InnoDB AUTO_INCREMENT=11112 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `videgrenier`
--

INSERT INTO vide_grenier.videgrenier (`ID_VG`, `DATE_VG`, `PRIXEMPL_VG`, `NBREEMPLINIT_VG`, `NBREEMPLINDISPO_VG`, `NOMBRE_D_EMPLACEMENTS_RESTANTS_TEMPORAIRES_`, `NBREEMPLRESTREEL_VG`, `NBREPARTICIP_VG`) VALUES
(11111, '2020-07-25', 10.00, '150', '30', '117', '147', '1');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `attestationhonneur`
--
ALTER TABLE vide_grenier.attestationhonneur
  ADD CONSTRAINT `attestationhonneur_ibfk_1` FOREIGN KEY (`ID_HOROD`) REFERENCES `horodatage` (`ID_HOROD`);

--
-- Contraintes pour la table `exposant`
--
ALTER TABLE vide_grenier.exposant
  ADD CONSTRAINT `exposant_ibfk_1` FOREIGN KEY (`ID_RES`) REFERENCES `reservation` (`ID_RES`),
  ADD CONSTRAINT `exposant_ibfk_2` FOREIGN KEY (`ID_AH`) REFERENCES `attestationhonneur` (`ID_AH`),
  ADD CONSTRAINT `exposant_ibfk_3` FOREIGN KEY (`ID_UTIL`) REFERENCES `utilisateur` (`ID_UTIL`);

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE vide_grenier.reservation
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`ID_VG`) REFERENCES `videgrenier` (`ID_VG`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE vide_grenier.utilisateur
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`ID_ROL`) REFERENCES `role` (`ID_ROL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;