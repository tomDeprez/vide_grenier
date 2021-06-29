<?php
// Noms valides
const PLAN_NB_CASES_VERTICALES = 104;
const PLAN_NB_CASES_HORIZONTALES = 16;
const HAUTEUR_CASE = 2;
const LARGEURE_CASE = 1;
?>

<table width="100%" border="1" style="border-collapse: collapse;">
<?php for ($numLigne = 1; $numLigne <= PLAN_NB_CASES_HORIZONTALES; $numLigne++) : ?>
    <tr style="height:20px;">
        <?php for ($numColonne = 1; $numColonne <= PLAN_NB_CASES_VERTICALES; $numColonne++) : ?>
            <?php include 'inc_bdd.php';
            
            $id_cellule = "l".$numLigne."c".$numColonne;

            $select_position = 'SELECT * FROM planposition INNER JOIN planlegende ON planposition.ID_PLANLEGENDE = planlegende.ID_LEGENDE WHERE ID_POSITION = :id';
            $info_position = $base->prepare($select_position);

            $info_position->bindParam(':id', $id_cellule);
            $info_position->execute();
            $tab_info_position = $info_position->fetch(); ?>

            <td id="<?= $id_cellule ?>" style="background-color: <?= $tab_info_position['COULEUR_LEGENDE'] ?>" colspan=<?= $tab_info_position['LARGEUR_POSITION'] ?>>
                <?= $tab_info_position['CONTENT_POSITION'] ?>
            </td>
        <?php endfor ?>
   </tr>
<?php endfor ?>
</table>