-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 21 avr. 2021 à 09:36
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
-- Base de données : `vide_grenier3`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `exposant`
--

DROP TABLE IF EXISTS `exposant`;
CREATE TABLE IF NOT EXISTS `exposant` (
                                          `ID_EXP` int(11) NOT NULL AUTO_INCREMENT,
                                          `ID_RES` int(11) NOT NULL,
                                          `ID_AH` int(11) NOT NULL,
                                          `ID_UTIL` int(11) NOT NULL,
                                          `NOM_EXP` text NOT NULL,
                                          `PRENOM_EXP` text NOT NULL,
                                          `ADR_EXP` text NOT NULL,
                                          `CP_EXP` decimal(8,0) NOT NULL,
                                          `VILLE_EXP` text NOT NULL,
                                          `TEL_EXP` decimal(10,0) NOT NULL,
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

DROP TABLE IF EXISTS `horodatage`;
CREATE TABLE IF NOT EXISTS `horodatage` (
                                            `ID_HOROD` int(11) NOT NULL AUTO_INCREMENT,
                                            `IP_HOROD` text NOT NULL,
                                            `DATE_HOROD` date NOT NULL,
                                            `HEURE_HOROD` time NOT NULL,
                                            PRIMARY KEY (`ID_HOROD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `mailing_list`
--

DROP TABLE IF EXISTS `mailing_list`;
CREATE TABLE IF NOT EXISTS `mailing_list` (
                                              `ID_ML` int(11) NOT NULL AUTO_INCREMENT,
                                              `MAIL_ML` varchar(50) DEFAULT NULL,
                                              PRIMARY KEY (`ID_ML`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
                                             `ID_RES` int(11) NOT NULL AUTO_INCREMENT,
                                             `ID_VG` int(11) NOT NULL,
                                             `NBREEMPLRESERVE_RES` decimal(8,0) NOT NULL,
                                             `TYPEPAIEMENT_RES` text NOT NULL,
                                             `STATUTRESERVATION_RES` text NOT NULL,
                                             `NUMEMPLATTRIBUE_RES` decimal(8,0) NOT NULL,
                                             PRIMARY KEY (`ID_RES`),
                                             KEY `ID_VG` (`ID_VG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
                                      `ID_ROL` int(11) NOT NULL AUTO_INCREMENT,
                                      `ADMIN_ROL` text NOT NULL,
                                      `MEMB_ROL` text NOT NULL,
                                      `VISIT_ROL` text NOT NULL,
                                      PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
                                             `ID_UTIL` int(11) NOT NULL AUTO_INCREMENT,
                                             `ID_ROL` int(11) NOT NULL,
                                             `NOM_UTIL` text NOT NULL,
                                             `MDP_UTIL` text NOT NULL,
                                             `EMAIL_UTIL` text NOT NULL,
                                             `TEL_UTIL` decimal(10,0) DEFAULT NULL,
                                             PRIMARY KEY (`ID_UTIL`),
                                             KEY `ID_ROL` (`ID_ROL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `videgrenier`
--

DROP TABLE IF EXISTS `videgrenier`;
CREATE TABLE IF NOT EXISTS `videgrenier` (
                                             `ID_VG` int(11) NOT NULL AUTO_INCREMENT,
                                             `DATE_VG` date NOT NULL,
                                             `PRIXEMPL_VG` float(8,2) NOT NULL,
                                             `NBREEMPLINIT_VG` decimal(8,0) NOT NULL,
                                             `NBREEMPLINDISPO_VG` decimal(8,0) NOT NULL,
                                             `NOMBRE_D_EMPLACEMENTS_RESTANTS_TEMPORAIRES_` decimal(8,0) NOT NULL,
                                             `NBREEMPLRESTREEL_VG` decimal(8,0) NOT NULL,
                                             `NBREPARTICIP_VG` decimal(8,0) NOT NULL,
                                             PRIMARY KEY (`ID_VG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `attestationhonneur`
--
ALTER TABLE `attestationhonneur`
    ADD CONSTRAINT `attestationhonneur_ibfk_1` FOREIGN KEY (`ID_HOROD`) REFERENCES `horodatage` (`ID_HOROD`);

--
-- Contraintes pour la table `exposant`
--
ALTER TABLE `exposant`
    ADD CONSTRAINT `exposant_ibfk_1` FOREIGN KEY (`ID_RES`) REFERENCES `reservation` (`ID_RES`),
    ADD CONSTRAINT `exposant_ibfk_2` FOREIGN KEY (`ID_AH`) REFERENCES `attestationhonneur` (`ID_AH`),
    ADD CONSTRAINT `exposant_ibfk_3` FOREIGN KEY (`ID_UTIL`) REFERENCES `utilisateur` (`ID_UTIL`);

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
    ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`ID_VG`) REFERENCES `videgrenier` (`ID_VG`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
    ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`ID_ROL`) REFERENCES `role` (`ID_ROL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
