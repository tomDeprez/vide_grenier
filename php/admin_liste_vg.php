<?php
session_start();

if (isset($_SESSION['id_util']) && $_SESSION["admin"] == 1) {
?>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liste des vide-greniers | CIL de la Gravière</title>
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/monstyle.css">
    </head>

    <body>
        <?php
        include 'inc_header.php';
        ?>
        <main id="listeVG">


            <?php
                if (isset($_GET["erreur_prog"])) {
                    echo "<div id=\"erreurUpdateVG\" class=\"red boxSite\">";
                    echo $_GET["erreur_prog"];
                    echo "</div>";
                }

                try {
                    include 'inc_bdd.php';

                    $select_vg =  "SELECT *, COUNT(r.ID_RES) as nbParticipant FROM videgrenier LEFT JOIN reservation r on videgrenier.ID_VG = r.ID_VG GROUP BY videgrenier.ID_VG";

                    $resultat_select = $base->prepare($select_vg);
                    $resultat_select->execute();

                    $lignes = $resultat_select->fetchAll();

//                    var_dump($lignes);
//                    die();
            ?>
                <section class="boxSite">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Date</th>
                                <th>Emplacement initial</th>
                                <th>Emplacement restant</th>
                                <th>Prix</th>
                                <th>Nombre de participant</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($lignes as $ligne): $nbParticipant = 0; ?>
                                <tr>
                                    <td><?=$ligne[0];?></td>
                                    <td><?=$ligne['DATE_VG'];?></td>
                                    <td><?=$ligne['NBREEMPLINIT_VG'];?></td>
                                    <td><?=$ligne['NBREEMPLINDISPO_VG'];?></td>
                                    <td><?=$ligne['PRIXEMPL_VG'];?></td>
                                    <td><?= $nbParticipant = $ligne['nbParticipant'] != null ? $ligne['nbParticipant'] : $nbParticipant?></td>
                                    <td><a href="admin_update_vg.php?idVG=<?=$ligne[0];?>" class="bouton">Modifier</a></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </section>
            <?php
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