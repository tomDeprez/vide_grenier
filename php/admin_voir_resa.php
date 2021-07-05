<?php
session_start();

if (isset($_SESSION['id_util']) && $_SESSION["admin"] == 1 && isset($_GET["id_resa"])) {
    ?>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voir demande en attente | CIL de la Gravière</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/monstyle.css">
</head>

<body>

    <?php
        include 'inc_header.php'; ?>
    <main id="listeAttente">
        <?php

            try {
                include 'inc_bdd.php';

                // liste des demande de VG en attente de validation ou d'annulation
                $select_attente =  "SELECT * FROM reservation JOIN videgrenier ON reservation.id_vg = videgrenier.id_vg JOIN statuts ON reservation.statu_resa = statuts.ID_STATUS WHERE STATU_RESA = 1 AND ID_RES = :id_resa";
                $select_attente = "SELECT * FROM reservation resa
                INNER JOIN exposant ex ON ex.ID_EXP = resa.ID_EX
                INNER JOIN videgrenier vide ON resa.ID_VG = vide.ID_VG 
                INNER JOIN statuts stat ON stat.ID_STATUS = resa.STATU_RESA 
                INNER JOIN utilisateur util ON util.ID_UTIL = ex.ID_UTIL
                INNER JOIN attestationhonneur att ON att.ID_EXP = ex.ID_EXP
                WHERE STATU_RESA = 1 AND ID_RES = :id_resa";
                $resultat_select = $base->prepare($select_attente);
                $id_resa = htmlspecialchars($_GET["id_resa"]);
                $resultat_select->bindParam(':id_resa', $id_resa);
                $resultat_select->execute();
                $ligne = $resultat_select->fetch();
                echo "<section class = \"boxSite\">";
                echo "<section id=\"recapResa\">";
                echo "<h4>" . $ligne['DATE_VG'] . "</h4><br/>";
                echo "<p>Statut de la réservation: " . $ligne['LIBELLE_STATUS'] . "</p>";
                echo "<p>Date: " . $ligne['DATE_VG'] . "</p>";
                echo "<p>Adresse: " . $ligne['ADR_EXP'] . "</p>";
                echo "<p>Nom Prénom de réservation: " . $ligne['NOM_UTIL'] . " " . $ligne['PRENOM_UTIL'] . "</p>";

                echo "<p>N° Carte d'identiter: " . $ligne['NUMCNI_AH'] . "</p>";
                echo "<p>Délivrer le: " . $ligne['DATEDELIVRCNI_AH'] . "</p>";
                echo "<p>Délivrer par: " . $ligne['EMETCNI_AH'] . "</p>";

                echo "<p>Mail de contacte: " . $ligne['EMAIL_UTIL'] . "</p>";
                // echo "<p>Portable: " . $ligne['TEL_EXP'] . "</p>";
                if ($ligne['NUMPLAQIMM_AH'] != "") {
                    echo "<p>Immatriculation enregistrer: " . $ligne['NUMPLAQIMM_AH'] . "</p>";
                }
                echo "<p>Nombre de places réservées: 1</p>";
                echo "<br/></section>";
                ////////////////////////////////////////////////////////////////

                echo "<form class=\"row boxSite\" method=\"POST\" action=\"admin_update_resa.php?id_resa=" . $id_resa . "\" id=\"formUpdateResa\">";
                echo "<div class=\"col-md-3\">Votre Choix: </div> ";
                echo "<div class=\"col-md-3\"><input type=\"radio\" id=\"Valider\" name=\"choix\" value=\"2\">";
                echo "<label for=\"Valider\">Valider</label></div>";
                echo "<div class=\"col-md-3\"><input type=\"radio\" id=\"Annuler\" name=\"choix\" value=\"3\">";
                echo "<label for=\"Annuler\">Annuler</label></div>";
                echo "<div class=\"col-md-3 text-center\"><button class=\"bouton\" type=\"submit\">Appliquer</button></div></form>";
                echo "</form";



                echo "<div id=\"erreurSupp\" class=\"red\">";
                if (isset($_GET["erreur_supp"])) {
                    echo $_GET["erreur_supp"];
                }
                echo "</div>";
                //////////////////////////////////////////////////

                echo "<div id=\"erreur\" class=\"red\">";
                if (isset($_GET["erreur"])) {
                    echo $_GET["erreur"];
                }
                echo "</div></section>";
            } catch (Exception $e) {
                die('Erreur : ' . $e->getMessage());
            } finally {
                $base = null; //fermeture de la connexion
            } ?>


    </main>
    <?php
        include 'inc_footer.php'; ?>

    <script src="../js/jquery-3.5.0.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/myscript.js"></script>
</body>

</html>

<?php
} else {
            header("Location:accueil.php");
        }
