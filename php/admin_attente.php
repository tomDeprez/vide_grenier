<?php
session_start();

if (isset($_SESSION['id_util']) && $_SESSION["admin"] == 1) {
?>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liste des demandes en attentes | CIL de la Gravière</title>
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/monstyle.css">
    </head>

    <body>
    
        <?php
        include 'inc_header.php';
        ?>
        <main id="listeAttente">
            <?php

            try {
                include 'inc_bdd.php';

                // liste des demande de VG en attente de validation ou d'annulation
                $select_attente = "SELECT * FROM reservation resa
                INNER JOIN exposant ex ON ex.ID_RES = resa.ID_RES
                INNER JOIN videgrenier vide ON resa.ID_VG = vide.ID_VG 
                INNER JOIN statuts stat ON stat.ID_STATUS = resa.STATU_RESA 
                INNER JOIN utilisateur util ON util.ID_UTIL = ex.ID_UTIL
                WHERE STATU_RESA = 1";

                $resultat_select = $base->prepare($select_attente);
                $resultat_select->execute();
                $returnResult = $resultat_select->fetchAll();

                $table = "<table class=\"table table-striped\"><tr><th>Label VG</th><th>Nom</th><th>Prenom</th><th>Nombre de place</th><th>Commentaires</th><th class=\"text-center\">Voir</th></tr>";


                foreach ($returnResult as $key => $ligne) {
                    $table .= "<tr><td>" . $ligne['DATE_VG'] . "</td><td>" . $ligne['NOM_UTIL'] . "</td><td>" . $ligne['PRENOM_UTIL'] . "</td><td></td><td>" . $ligne['COMMENT_EXP'] . "</td><td class=\"text-center\"><a class=\"bouton\" href=\"admin_voir_resa.php?id_resa=".$ligne['ID_RES']."\">Voir</a></td></tr>";
                }

                $table .= "</table>";
                echo "<section class = \"boxSite\">";    
                echo $table;
                echo "<div id=\"erreurSupp\" class=\"red\">";
                if (isset($_GET["erreur_supp"])) {

                    echo $_GET["erreur_supp"];
                }
                echo "</div></section>";
            } catch (Exception $e) {

                die('Erreur : ' . $e->getMessage());
            } finally {

                $base = null; //fermeture de la connexion
            }
            ?>


        </main>
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