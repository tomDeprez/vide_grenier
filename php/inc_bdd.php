<?php

    $base = new PDO('mysql:host=localhost; dbname=vide_grenier', 'root', 'root');
    $base->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $base->exec("SET NAMES utf8");

?>