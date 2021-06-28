<?php
try {
    include 'inc_bdd.php';
    foreach (glob("../sql/*.sql") as $filename) {
        $query = file_get_contents($filename);
        $stmt = $base->prepare($query);
        $stmt->execute();
    }
    echo "Mise à jour de la bdd OK !";
} catch (\Throwable $th) {
    echo "Mise à jour de la bdd impossible !";
}