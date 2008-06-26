<?php

require 'xnet.inc.php';

new_skinned_page('xnet/groupe/asso.tpl', AUTH_PUBLIC);
if (!$globals->asso('id')) {
    header("Location: ../");
}
$page->setType(strtolower($globals->asso('cat')));
$page->assign('asso', $globals->asso());

// S�lection de toutes les associations ayant la m�me cat�gorie et le m�me domaine que l'activit� s�lectionn�e
$gps = $globals->xdb->iterator(
        "SELECT  diminutif, nom
           FROM  groupex.asso
          WHERE  cat = {?} AND  dom = {?}
       ORDER BY  nom", $globals->asso('cat'), $globals->asso('dom'));
$page->assign('gps', $gps);

$page->run();

?>
