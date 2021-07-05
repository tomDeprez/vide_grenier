<?php


include 'inc_bdd.php';
$idEmplacement = "";
if (isset($_POST['idEmplacement'])) {
    $idEmplacement = $_POST['idEmplacement'];
}else{
    die;
}
$select = 'SELECT * FROM planposition WHERE ID_POSITION = :id';
$info_position = $base->prepare($select);
$info_position->bindParam(':id', $idEmplacement);
$info_position->execute();
$tab_info = $info_position->fetch();
echo json_encode($tab_info);