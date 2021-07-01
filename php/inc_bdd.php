<?php

<<<<<<< HEAD
    $base = new PDO('mysql:host=localhost:3309; dbname=vide_grenier', 'root', '');
=======
    $base = new PDO('mysql:host=localhost:3307; dbname=vide_grenier', 'root', '');
>>>>>>> master
    $base->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $base->exec("SET NAMES utf8");

?>