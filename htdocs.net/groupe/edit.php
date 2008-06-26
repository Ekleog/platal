<?php

require 'xnet.inc.php';

new_groupadmin_page('xnet/groupe/edit.tpl');

// S�lection de toutes les associations ayant la m�me cat�gorie et le m�me domaine que l'activit� s�lectionn�e
$gps = $globals->xdb->iterator(
        "SELECT  diminutif, nom
           FROM  groupex.asso
          WHERE  cat = {?} AND  dom = {?}
       ORDER BY  nom", $globals->asso('cat'), $globals->asso('dom'));
$page->assign('gps', $gps);

$page->run();

?>
