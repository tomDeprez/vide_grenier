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
  `ID_EXP` int(11) NOT NULL,
  `ID_HOROD` int(11) NOT NULL,
  `DATENAIS_AH` date DEFAULT NULL,
  `DEPTNAIS_AH` decimal(8,0) DEFAULT NULL,
  `VILLENAIS_AH` text DEFAULT NULL,
  `NUMCNI_AH` decimal(13,0) DEFAULT NULL,
  `DATEDELIVRCNI_AH` date DEFAULT NULL,
  `EMETCNI_AH` text DEFAULT NULL,
  `NUMPLAQIMM_AH` text DEFAULT NULL,
  PRIMARY KEY (`ID_AH`),
  KEY `ID_HOROD` (`ID_HOROD`)
) ENGINE=InnoDB AUTO_INCREMENT=111112 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `attestationhonneur`
--

INSERT INTO vide_grenier.`attestationhonneur` (`ID_AH`, `ID_EXP`, `ID_HOROD`, `DATENAIS_AH`, `DEPTNAIS_AH`, `VILLENAIS_AH`, `NUMCNI_AH`, `DATEDELIVRCNI_AH`, `EMETCNI_AH`, `NUMPLAQIMM_AH`) VALUES
(111112, 1, 1111112, NULL, NULL, NULL, '3', '2021-06-30', 'Deprez', 'AB-254-DC');

-- --------------------------------------------------------

--
-- Structure de la table `exposant`
--

DROP TABLE IF EXISTS vide_grenier.exposant;
CREATE TABLE IF NOT EXISTS vide_grenier.`exposant` (
  `ID_EXP` int(11) NOT NULL AUTO_INCREMENT,
  `ID_UTIL` int(11) NOT NULL,
  `ADR_EXP` text NOT NULL,
  `CP_EXP` decimal(8,0) NOT NULL,
  `VILLE_EXP` text NOT NULL,
  `COMMENT_EXP` text,
  PRIMARY KEY (`ID_EXP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `exposant`
--

INSERT INTO vide_grenier.`exposant` (`ID_EXP`, `ID_UTIL`, `ADR_EXP`, `CP_EXP`, `VILLE_EXP`, `COMMENT_EXP`) VALUES
(1, 1, 'test 4', '38540', 'valencin', '');

-- --------------------------------------------------------

--
-- Structure de la table `horodatage`
--

DROP TABLE IF EXISTS vide_grenier.horodatage;
CREATE TABLE IF NOT EXISTS vide_grenier.`horodatage` (
  `ID_HOROD` int(11) NOT NULL AUTO_INCREMENT,
  `IP_HOROD` text NOT NULL,
  `DATE_HOROD` date DEFAULT NULL,
  `HEURE_HOROD` time DEFAULT NULL,
  PRIMARY KEY (`ID_HOROD`)
) ENGINE=InnoDB AUTO_INCREMENT=1111112 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `horodatage`
--

INSERT INTO vide_grenier.horodatage (`ID_HOROD`, `IP_HOROD`, `DATE_HOROD`, `HEURE_HOROD`) VALUES
(1111111, '172.16.254.1', '2019-03-15', '22:21:20');
INSERT INTO vide_grenier.horodatage (`ID_HOROD`, `IP_HOROD`, `DATE_HOROD`, `HEURE_HOROD`) VALUES
(1111112, '192.168.0.1', '2021-06-10', '12:40:20');
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

DROP TABLE IF EXISTS vide_grenier.Placer;
CREATE TABLE vide_grenier.Placer(
    Id_Place int(11) NOT NULL  AUTO_INCREMENT,
    Id_Reservation int(11),
    Id_PlanPosition varchar(20),
    PRIMARY KEY(Id_Place),
    FOREIGN KEY(Id_Reservation) REFERENCES Reservation(ID_RES),
    FOREIGN KEY(Id_PlanPosition) REFERENCES PlanPosition(ID_POSITION)
);


--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS vide_grenier.reservation;
CREATE TABLE IF NOT EXISTS vide_grenier.`reservation` (
  `ID_RES` int(11) NOT NULL AUTO_INCREMENT,
  `ID_VG` int(11) NOT NULL,
  `ID_EX` int(11) NOT NULL,
  `NBREEMPLRESERVE_RES` decimal(8,0) DEFAULT NULL,
  `TYPEPAIEMENT_RES` text DEFAULT NULL,
  `NUMEMPLATTRIBUE_RES` decimal(8,0) DEFAULT NULL,
  `STATU_RESA` INT(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID_RES`),
  KEY `ID_VG` (`ID_VG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO vide_grenier.`reservation` (`ID_RES`, `ID_VG`, `ID_EX`, `NBREEMPLRESERVE_RES`, `TYPEPAIEMENT_RES`, `NUMEMPLATTRIBUE_RES`) VALUES
(1, 11111, 1, '2', 'En ligne', '1');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS vide_grenier.role;
CREATE TABLE IF NOT EXISTS vide_grenier.`role` (
  `ID_ROL` int(11) NOT NULL AUTO_INCREMENT,
  `Libelle_ROL` text NOT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `role`
--

INSERT INTO vide_grenier.role (`ID_ROL`, `Libelle_ROL`) VALUES
(1, 'visiteur'),
(2, 'administrateur'),
(3, 'exposant');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS vide_grenier.utilisateur;
CREATE TABLE IF NOT EXISTS vide_grenier.`utilisateur` (
  `ID_UTIL` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ROL` int(11) NOT NULL,
  `NOM_UTIL` text NOT NULL,
  `PRENOM_UTIL` VARCHAR(100) NOT NULL,
  `DESC_UTIL` VARCHAR(280) NOT NULL,
  `MDP_UTIL` text NOT NULL,
  `EMAIL_UTIL` text NOT NULL,
  `TEL_UTIL` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID_UTIL`),
  KEY `ID_ROL` (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO vide_grenier.utilisateur (`ID_UTIL`, `ID_ROL`, `NOM_UTIL`, `PRENOM_UTIL`,`MDP_UTIL`, `EMAIL_UTIL`, `TEL_UTIL`) VALUES
(1, 1, 'TOTO', 'Titi', '000000', 't@gmail.com', '0606060606'),
(4, 2, 'aa', 'Pierre', '000000', 'aa@gmail.com', '0606060606'),
(5, 1, 'bb', 'Paul','000000', 'bb@gmail.com', '0606060606'),
(6, 1, 'cc', 'Tom','000000', 'cc@gmail.com', '0606060606');

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


-- --------------------------------------------------------

--
-- Structure de la table `planlegende`
--

DROP TABLE IF EXISTS vide_grenier.planlegende;
CREATE TABLE IF NOT EXISTS vide_grenier.`planlegende` (
  `ID_LEGENDE` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE_LEGENDE` text NOT NULL,
  `COULEUR_LEGENDE` text NOT NULL,
  PRIMARY KEY (`ID_LEGENDE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `planlegende`
--

INSERT INTO vide_grenier.planlegende (`ID_LEGENDE`, `LIBELLE_LEGENDE`, `COULEUR_LEGENDE`) VALUES
(1, 'Passage des visiteurs', '#E4FF00'),
(2, 'Zébras', '#EEEE4F'),
(3, ' Obstacle nature : arbre', '#30B232'),
(4, 'Banc en pierre', '#D0D1D0'),
(5, 'Voie privée', '#868686'),
(6, 'Route', '#515151'),
(7, ' Zone de déchargement', '#0CC9BD'),
(8, 'Place débarquement (decharge voiture 1 place)', '#4E00CD'),
(9, 'Place débarquement Place handicapée', '#A770FF'),
(10, 'Emplacement indisponible', '#663B03'),
(11, 'Emplacement de 2m', '#00FFD1'),
(12, 'Emplacement de 3m', '#00FFD1'),
(13, 'Emplacement de 4m', '#00FFD1');

-- --------------------------------------------------------

--
-- Structure de la table `planposition`
--

DROP TABLE IF EXISTS vide_grenier.planposition;
CREATE TABLE IF NOT EXISTS vide_grenier.`planposition` (
  `ID_POSITION` varchar(20) NOT NULL,
  `ID_PLANLEGENDE` int(11) NOT NULL,
  `LARGEUR_POSITION` int(11) NOT NULL,
  `CONTENT_POSITION` text DEFAULT NULL,
  PRIMARY KEY (`ID_POSITION`),
  KEY `ID_PLANLEGENDE` (`ID_PLANLEGENDE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `planposition`
--

INSERT INTO vide_grenier.planposition (`ID_POSITION`, `ID_PLANLEGENDE`, `LARGEUR_POSITION`, `CONTENT_POSITION`) VALUES
('l7c5', 1, 98, null),
('l3c24', 1, 79, null),
('l4c24', 1, 2, null),
('l5c24', 1, 2, null),
('l6c24', 1, 2, null),
('l8c5', 1, 2, null),
('l9c5', 1, 91, null),
('l12c5', 1, 98, null),
('l5c31', 3, 72, null),
('l1c1', 6, 2, null),
('l2c1', 6, 2, null),
('l3c1', 6, 2, null),
('l4c1', 6, 2, null),
('l5c1', 6, 2, null),
('l6c1', 6, 2, null),
('l7c1', 6, 2, null),
('l8c1', 6, 2, null),
('l9c1', 6, 2, null),
('l10c1', 6, 2, null),
('l11c1', 6, 2, null),
('l12c1', 6, 2, null),
('l13c1', 6, 2, null),
('l14c1', 6, 2, null),
('l15c1', 6, 2, null),
('l16c1', 6, 104, null),
('l1c3', 5, 2, null),
('l2c3', 5, 2, null),
('l3c3', 5, 2, null),
('l4c3', 5, 2, null),
('l5c3', 5, 2, null),
('l6c3', 5, 2, null),
('l7c3', 5, 2, null),
('l8c3', 5, 2, null),
('l9c3', 5, 2, null),
('l10c3', 5, 2, null),
('l11c3', 5, 2, null),
('l12c3', 5, 2, null),
('l13c3', 5, 2, null),
('l14c3', 5, 2, null),
('l15c3', 5, 2, null),
('l1c103', 5, 2, null),
('l2c103', 5, 2, null),
('l3c103', 5, 2, null),
('l4c103', 5, 2, null),
('l5c103', 5, 2, null),
('l6c103', 5, 2, null),
('l7c103', 5, 2, null),
('l8c103', 5, 2, null),
('l9c103', 5, 2, null),
('l10c103', 5, 2, null),
('l11c103', 5, 2, null),
('l12c103', 5, 2, null),
('l13c103', 5, 2, null),
('l14c103', 5, 2, null),
('l15c103', 5, 2, null),
('l6c5', 10, 2, null),
('l6c7', 10, 3, null),
('l6c10', 10, 3, null),
('l6c13', 10, 2, null),
('l6c15', 10, 2, null),
('l6c17', 10, 2, null),
('l6c19', 10, 3, null),
('l2c22', 10, 2, null),
('l2c33', 10, 3, null),
('l2c24', 11, 2, null),
('l2c26', 11, 2, null),
('l2c28', 11, 2, null),
('l2c30', 12, 3, null),
('l3c22', 11, 2, null),
('l4c22', 11, 2, null),
('l5c22', 11, 2, null),
('l6c22', 11, 2, null),
('l2c36', 11, 2, null),
('l2c38', 12, 3, null),
('l2c41', 11, 2, null),
('l2c43', 12, 3, null),
('l2c46', 11, 2, null),
('l2c48', 11, 2, null),
('l2c50', 12, 3, null),
('l2c53', 11, 2, null),
('l2c55', 12, 3, null),
('l11c5', 11, 2, null),
('l10c7', 12, 3, null),
('l10c10', 12, 3, null),
('l10c13', 11, 2, null),
('l10c15', 11, 2, null),
('l11c17', 11, 2, null),
('l10c19', 12, 3, null),
('l10c22', 11, 2, null),
('l10c24', 11, 2, null),
('l10c26', 12, 3, null),
('l11c29', 11, 2, null),
('l10c31', 12, 3, null),
('l10c34', 11, 2, null),
('l10c36', 11, 2, null),
('l10c38', 12, 3, null),
('l11c41', 11, 2, null),
('l10c43', 12, 3, null),
('l10c46', 11, 2, null),
('l10c48', 11, 2, null),
('l10c50', 12, 3, null),
('l11c53', 11, 2, null),
('l10c55', 12, 3, null),
('l10c58', 11, 2, null),
('l10c60', 11, 2, null),
('l10c62', 12, 3, null),
('l11c65', 11, 2, null),
('l10c67', 12, 3, null),
('l10c70', 11, 2, null),
('l10c72', 11, 2, null),
('l10c74', 12, 3, null),
('l11c77', 11, 2, null),
('l10c79', 12, 3, null),
('l10c82', 11, 2, null),
('l10c84', 11, 2, null),
('l10c86', 12, 3, null),
('l11c89', 11, 2, null),
('l10c91', 12, 3, null),
('l10c94', 11, 2, null),
('l8c7', 12, 3, null),
('l8c10', 11, 2, null),
('l8c12', 11, 2, null),
('l8c14', 11, 2, null),
('l8c19', 12, 3, null),
('l8c22', 11, 2, null),
('l8c24', 11, 2, null),
('l8c26', 12, 3, null),
('l8c31', 12, 3, null),
('l8c34', 11, 2, null),
('l8c36', 11, 2, null),
('l8c38', 12, 3, null),
('l8c43', 12, 3, null),
('l8c46', 11, 2, null),
('l8c48', 11, 2, null),
('l8c50', 12, 3, null),
('l8c55', 12, 3, null),
('l8c58', 11, 2, null),
('l8c60', 11, 2, null),
('l8c62', 12, 3, null),
('l8c67', 12, 3, null),
('l8c70', 11, 2, null),
('l8c72', 11, 2, null),
('l8c74', 12, 3, null),
('l8c79', 12, 3, null),
('l8c82', 11, 2, null),
('l8c84', 11, 2, null),
('l8c86', 12, 3, null),
('l8c91', 12, 3, null),
('l8c94', 11, 2, null),
('l6c28', 12, 3, null),
('l6c31', 12, 3, null),
('l6c34', 11, 2, null),
('l6c36', 11, 2, null),
('l6c38', 12, 3, null),
('l6c43', 12, 3, null),
('l6c46', 11, 2, null),
('l6c48', 11, 2, null),
('l6c50', 12, 3, null),
('l6c55', 12, 3, null),
('l6c58', 11, 2, null),
('l6c60', 11, 2, null),
('l6c62', 12, 3, null),
('l6c67', 12, 3, null),
('l6c70', 11, 2, null),
('l6c72', 11, 2, null),
('l6c74', 12, 3, null),
('l6c79', 12, 3, null),
('l6c82', 11, 2, null),
('l6c84', 11, 2, null),
('l6c86', 12, 3, null),
('l6c91', 12, 3, null),
('l6c94', 11, 2, null),
('l6c96', 11, 2, null),
('l6c98', 12, 3, null),
('l4c28', 12, 3, null),
('l4c31', 12, 3, null),
('l4c34', 11, 2, null),
('l4c36', 11, 2, null),
('l4c38', 12, 3, null),
('l4c43', 12, 3, null),
('l4c46', 11, 2, null),
('l4c48', 11, 2, null),
('l4c50', 12, 3, null),
('l4c55', 12, 3, null),
('l4c58', 11, 2, null),
('l4c60', 11, 2, null),
('l4c62', 12, 3, null),
('l4c67', 12, 3, null),
('l4c70', 11, 2, null),
('l4c72', 11, 2, null),
('l4c74', 12, 3, null),
('l4c79', 12, 3, null),
('l4c82', 11, 2, null),
('l4c84', 11, 2, null),
('l4c86', 12, 3, null),
('l4c91', 12, 3, null),
('l4c94', 11, 2, null),
('l4c96', 11, 2, null),
('l4c98', 12, 3, null),
('l4c101', 11, 2, null),
('l2c60', 11, 2, null),
('l2c62', 12, 3, null),
('l2c65', 11, 2, null),
('l2c67', 11, 3, null),
('l2c70', 12, 3, null),
('l2c76', 12, 3, null),
('l2c79', 11, 2, null),
('l2c81', 11, 2, null),
('l2c86', 13, 4, null),
('l2c90', 12, 3, null),
('l2c94', 11, 2, null),
('l2c96', 11, 2, null),
('l2c98', 12, 3, null),
('l2c101', 11, 2, null),
('l13c7', 12, 3, null),
('l13c10', 11, 2, null),
('l13c12', 11, 2, null),
('l13c14', 12, 3, null),
('l13c51', 11, 2, null),
('l13c55', 12, 3, null),
('l13c58', 12, 3, null);


DROP TABLE IF EXISTS vide_grenier.statuts;
CREATE TABLE vide_grenier.`statuts` (
  `ID_STATUS` INT NOT NULL AUTO_INCREMENT,
  `LIBELLE_STATUS` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`ID_STATUS`)
  ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

INSERT INTO vide_grenier.`statuts` (`ID_STATUS`, `LIBELLE_STATUS`) VALUES ('1', 'En attente'), ('2', 'Validé'), ('3', 'Refusé');
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `attestationhonneur`
--
ALTER TABLE vide_grenier.attestationhonneur
  ADD CONSTRAINT `attestationhonneur_ibfk_1` FOREIGN KEY (`ID_HOROD`) REFERENCES `horodatage` (`ID_HOROD`);

--
-- Contraintes pour la table `attestationhonneur`
--
ALTER TABLE vide_grenier.planposition
  ADD CONSTRAINT `planposition_ibfk_1` FOREIGN KEY (`ID_PLANLEGENDE`) REFERENCES `planlegende` (`ID_LEGENDE`);

--
-- Contraintes pour la table `exposant`
--
ALTER TABLE vide_grenier.exposant
  ADD CONSTRAINT `exposant_ibfk_1` FOREIGN KEY (`ID_UTIL`) REFERENCES `utilisateur` (`ID_UTIL`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE vide_grenier.reservation
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`ID_EX`) REFERENCES `exposant` (`ID_EXP`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`ID_VG`) REFERENCES `videgrenier` (`ID_VG`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE vide_grenier.utilisateur
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`ID_ROL`) REFERENCES `role` (`ID_ROL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;