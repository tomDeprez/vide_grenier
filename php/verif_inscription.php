<?php
session_start();
// Test des variables si existe

$valueMail = $_POST['mail'] ?? '';
$valueNom = $_POST['nom'] ?? '';
$valueTel = $_POST['tel'] ?? '';
$valueMdp = $_POST['password'] ?? '';

if ($valueMail != "" && $valueMdp !="" && $valueTel && $valueNom) {
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription | CIL de la Gravière</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/monstyle.css">
</head>

<body>
    <?php
    include 'inc_header.php';
    ?>

    <!-- Partie BDD inscription -->
    <?php

    try {
        include 'inc_bdd.php';

        // Test compte existent

        $mail = htmlspecialchars($valueMail);

        $select_util =  "SELECT * FROM utilisateur WHERE EMAIL_UTIL = :doublon";

        $resultat_select = $base->prepare($select_util);

        $resultat_select->bindParam(':doublon', $mail);
        $resultat_select->execute();

        $okDoublon = false;

        // On test si un résultat est retourné
        while ($ligneDoublon = $resultat_select->fetch()) {

            $okDoublon = true;
        }

        // Si true, alors on renvois le visiteur, son addresse mail est déjà utilisée
        if ($okDoublon) {

            header("Location:inscription.php?erreur_inscription=" . urlencode("*Cette adresse e-mail est déjà utilisée"));
        } else {

            $insert_util = "INSERT INTO utilisateur (NOM_UTIL, TEL_UTIL, EMAIL_UTIL, MDP_UTIL, ID_ROL) VALUES (:nom, :tel, :mail, :mdp, 1)";
            $resultat_insert = $base->prepare($insert_util);

            if($valueMail !== '')
            {
                $resultat_insert->bindParam(':mail', $mail);
            }

            if($valueMdp !== '')
            {
                $password = htmlspecialchars($valueMdp);
                $resultat_insert->bindParam(':mdp', $password);
            }

            if($valueNom !== '')
            {
                $nom = htmlspecialchars($valueNom);
                $resultat_insert->bindParam(':nom', $nom);
            }

            if($valueTel !== '')
            {
                $tel = htmlspecialchars($valueTel);
                $resultat_insert->bindParam(':tel', $tel);
            }
            $resultat_insert->execute();

            $insert_util_mailing = "CALL inscriptionMailing(:mail)";

            $insertToBdd = $base->prepare($insert_util_mailing);

            $insertToBdd->bindParam(':mail', $mail);
            $insertToBdd->execute();

            echo "<section id=\"inscriptionValidée\" class=\"boxSite\">Votre inscription est validée!<br/>
        <a class=\"nav-link\" href=\"connexion.php\">Connexion</a></section>";
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



    header("Location:accueil.php?erreur_login=1");
}
?>