<?php 
session_start();
// On test toutes les données obligatoires
if (isset($_SESSION["id_util"]) && isset($_GET['idVG']) && $_POST['nom'] !="" && $_POST['prenom'] !="" && $_POST['addresse'] !="" && $_POST['postal'] !="" && $_POST['ville'] !="" && $_POST['numCNI'] !="" && $_POST['dateCNI'] !="" && $_POST['parCNI'] !="" && $_POST['portable'] !="" && $_POST['nbrEmplacement'] !="") {

?>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verification Réservation | CIL de la Gravière</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/monstyle.css">
</head>

<body>
    <?php
    include 'inc_header.php';
    ?>


    <?php

    try {
        include 'inc_bdd.php';

        // Test réservation existent 
        $mail = htmlspecialchars($_POST['mail']);

        $select_resa =  "SELECT * FROM reservation JOIN exposant e on reservation.ID_RES = e.ID_RES WHERE EMAIL_EXP = :doublon AND id_vg = :id";

        $resultat_select = $base->prepare($select_resa);

        $resultat_select->bindParam(':doublon', $mail);
        $resultat_select->bindParam(':id', $_GET['idVG']);
        $resultat_select->execute();

        $okDoublon = false;

        // On test si un résultat est retourné
        while ($ligneDoublon = $resultat_select->fetch()) {

            $okDoublon = true;
        }

        if ($okDoublon) {

            header("Location:reservation.php?erreur_reservation=" . urlencode("*Cette adresse e-mail est déjà utilisée pour cette réservation"));
        } else {

            $id_vg = $_GET['idVG'];
            $nom = htmlspecialchars($_POST['nom']);
            $prenom = htmlspecialchars($_POST['prenom']);
            $addresse = htmlspecialchars($_POST['addresse']);
            $postal = htmlspecialchars($_POST['postal']);
            $ville = htmlspecialchars($_POST['ville']);
            $numCNI = htmlspecialchars($_POST['numCNI']);
            $dateCNI = htmlspecialchars($_POST['dateCNI']);
            $parCNI = htmlspecialchars($_POST['parCNI']);
            $immatriculation = htmlspecialchars($_POST['immatriculation']);
            $portable = htmlspecialchars($_POST['portable']);
            $nbrEmplacement = htmlspecialchars($_POST['nbrEmplacement']);
            $commentaire = htmlspecialchars($_POST['remarque']);


            $sql0 = "SELECT NBREEMPLINDISPO_VG FROM videgrenier WHERE id_vg = :id";

            $resultat0 = $base->prepare($sql0);
            $resultat0->bindParam(':id', $id_vg);
            $resultat0->execute();
            $nbrPlaceRestant = $resultat0->fetchColumn();
  
            $nbrPlaceRestantApresResa = (int) ($nbrPlaceRestant - $nbrEmplacement);

            if ($nbrPlaceRestantApresResa <= 0){

                header("Location:reservation.php?erreur_reservation=" . urlencode("*Désoler, plus de places disponibles"));
            }
  

            $update_place = "UPDATE videgrenier SET NBREEMPLINDISPO_VG = :restant WHERE id_vg = :id";
            $resultat_update = $base->prepare($update_place);

            $resultat_update->bindParam(':id', $id_vg);
            $resultat_update->bindParam(':restant', $nbrPlaceRestantApresResa);
            $resultat_update->execute();

            $type = 'En ligne';
            $statut = 'En attente';
            $numPlace = 1;



            $insert_resa = "INSERT INTO reservation (ID_VG, TYPEPAIEMENT_RES, STATUTRESERVATION_RES, NUMEMPLATTRIBUE_RES, NBREEMPLRESERVE_RES) VALUES (:id_vg, :type, :statut, :numPlace, :nbPlace)";
            $resultat_insert = $base->prepare($insert_resa);


            // poura récupérer l'id de la réservation passé
            $base->beginTransaction();

            $resultat_insert->bindParam(':id_vg', $id_vg);
            $resultat_insert->bindParam(':type', $type);
            $resultat_insert->bindParam(':numPlace', $numPlace);
            $resultat_insert->bindParam(':nbPlace', $nbrEmplacement);
            $resultat_insert->bindParam(':statut', $statut);

            $resultat_insert->execute();
            $id_reservation = $base->lastInsertId();
            $base->commit();

            $insert_horodatage = "INSERT INTO horodatage (IP_HOROD, DATE_HOROD, HEURE_HOROD) VALUES (:ipHorod, :DateHorod, :HeureHorod)";
            $resultat_horodatage = $base->prepare($insert_horodatage);

            $localIP = $_SERVER['REMOTE_ADDR'];

            if($localIP == '::1')
            {
                $localIP = '127.0.0.1';
            }

            date_default_timezone_set('UTC');
            $today = date("Y-m-d");
            $hour = date("H:i:s");

            // poura récupérer l'id de l'horodatage
            $base->beginTransaction();

            $resultat_horodatage->bindParam(':ipHorod', $localIP);
            $resultat_horodatage->bindParam(':DateHorod', $today);
            $resultat_horodatage->bindParam(':HeureHorod', $hour);

            $resultat_horodatage->execute();
            $id_horodatage = $base->lastInsertId();
            $base->commit();

            $insert_AttestationH = "INSERT INTO attestationhonneur (ID_HOROD, DATENAIS_AH, DEPTNAIS_AH, VILLENAIS_AH, NUMCNI_AH, DATEDELIVRCNI_AH, EMETCNI_AH, NUMPLAQIMM_AH) VALUES (:idH, null, null, null, :numCNI, :dateCNI, :parCNI, :immatriculation)";
            $resultat_AttestationH = $base->prepare($insert_AttestationH);

            // poura récupérer l'id de l'attestation honneurs
            $base->beginTransaction();

            $resultat_AttestationH->bindParam(':idH', $id_horodatage);
            $resultat_AttestationH->bindParam(':numCNI', $numCNI);
            $resultat_AttestationH->bindParam(':dateCNI', $dateCNI);
            $resultat_AttestationH->bindParam(':parCNI', $parCNI);
            $resultat_AttestationH->bindParam(':immatriculation', $immatriculation);

            $resultat_AttestationH->execute();
            $id_ah = $base->lastInsertId();
            $base->commit();

            $insert_exposant = "INSERT INTO exposant (ID_RES, ID_AH, ID_UTIL, NOM_EXP, PRENOM_EXP, ADR_EXP, CP_EXP, VILLE_EXP, TEL_EXP, EMAIL_EXP, COMMENT_EXP) VALUES (:idReservation, :idAH, :id, :nom, :prenom, :addresse, :postal, :ville, :portable, :mail, :commentaire)";
            $result_exposant = $base->prepare($insert_exposant);

            $result_exposant->bindParam(':id', $_SESSION["id_util"]);
            $result_exposant->bindParam(':idReservation', $id_reservation);
            $result_exposant->bindParam(':idAH', $id_ah);
            $result_exposant->bindParam(':nom', $nom);
            $result_exposant->bindParam(':prenom', $prenom);
            $result_exposant->bindParam(':mail', $mail);
            $result_exposant->bindParam(':addresse', $addresse);
            $result_exposant->bindParam(':postal', $postal);
            $result_exposant->bindParam(':ville', $ville);
//            $resultat_insert->bindParam(':cni', $numCNI);
//            $resultat_insert->bindParam(':delivrer', $dateCNI);
//            $result_exposant->bindParam(':par', $parCNI);
            $result_exposant->bindParam(':portable', $portable);
            $result_exposant->bindParam(':commentaire', $commentaire);
//            $resultat_insert->bindParam(':nbr', $nbrEmplacement);
//
//
//            var_dump($result_exposant);
            $result_exposant->execute();

//            if ($_POST['immatriculation'] != "") {
//
//                $immatriculation = htmlspecialchars($_POST['immatriculation']);
//                $resultat_insert->bindParam(':immatricul', $immatriculation);
//            }
//
//            if ($_POST['remarque'] != "") {
//
//                $remarque = htmlspecialchars($_POST['remarque']);
//                $resultat_insert->bindParam(':info', $remarque);
//            }


            echo "<section id=\"resaValidée\" class=\"boxSite\">Votre réservation est validée!<br/>
        <a class=\"nav-link\" href=\"mon_compte.php\">Voir mon compte</a></section>";
        }
    } catch (Exception $e) {

        die('Erreur : ' . $e->getMessage());
    } finally {

        $base = null; //fermeture de la connexion
    }
    ?>



    <?php
    include 'inc_footer.php';
    ?>

    <script src="../js/jquery-3.5.0.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/myscript.js"></script>
</body>

</html>

<?php

} else {

    header("Location:accueil.php");
}
?>