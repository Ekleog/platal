<?php
require('auto.prepend.inc.php');
new_admin_page('admin/ax-xorg.tpl');

// liste des diff�rences
$sql = "SELECT i.promo,i.nom AS nom,i.prenom AS prenom,ia.nom AS nomax,ia.prenom AS prenomax,i.matricule AS mat,ia.matricule_ax AS matax
        FROM identification AS i
        INNER JOIN identification_ax AS ia ON i.matricule_ax = ia.matricule_ax
        WHERE (SOUNDEX(i.nom) != SOUNDEX(ia.nom) AND SOUNDEX(CONCAT(ia.particule,i.nom)) != SOUNDEX(ia.nom)
            AND SOUNDEX(i.nom) != SOUNDEX(ia.nom_patro) AND SOUNDEX(CONCAT(ia.particule,i.nom)) != SOUNDEX(ia.nom_patro))
            OR i.prenom != ia.prenom
	    OR (i.promo != ia.promo AND i.promo != ia.promo+1 AND i.promo != ia.promo-1)
	    ORDER BY i.promo,i.nom,i.prenom";
$page->mysql_assign($sql,'diffs','nb_diffs');

// gens � l'ax mais pas chez nous
$sql = "SELECT ia.promo,ia.nom,ia.nom_patro,ia.prenom
        FROM identification_ax as ia
        LEFT JOIN identification AS i ON i.matricule_ax = ia.matricule_ax
        WHERE i.nom IS NULL";
$page->mysql_assign($sql,'mank','nb_mank');

// gens chez nous et pas � l'ax
$sql = "SELECT promo,nom,prenom FROM identification WHERE matricule_ax IS NULL";
$page->mysql_assign($sql,'plus','nb_plus');


$page->run();
?>
