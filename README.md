<h1>Déployer le projet:</h1></br>
</br>
1 - Mettre le projet dans un votre espace de travail</br>
2 - Importer la BDD ./sql/vide_grenierV0.2.2.sql</br>
3 - Editer les paramètres de connexion à la BDD dans ./php/inc_bdd.php ligne 3 :</br>
                <i>$base = new PDO('mysql:host=127.0.0.1:3309; dbname=vide_grenier', 'root', '');</i></br>
                $base = new PDO('<strong><i>TYPE_DE_LA_BASE</i></strong>:host=<strong><i>IP</i></strong>:<strong><i>PORT</i></strong>; dbname=<strong><i>NOM_DE_LA_BDD</i></strong>', '<strong><i>USER_NAME</i></strong>', '<strong><i>PASSWORD</i></strong>');</br>
