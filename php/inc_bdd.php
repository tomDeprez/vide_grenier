<?php

    $base = new PDO('mysql:host=localhost:3309; dbname=vide_grenier', 'root', '');
    $base->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $base->exec("SET NAMES utf8");

?>