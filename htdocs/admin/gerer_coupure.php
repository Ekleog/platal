<?php
require('auto.prepend.inc.php');
new_admin_table_editor('coupures','id');

$editor->describe('debut','date',true,'timestamp');
$editor->describe('duree','dur�e',false);
$editor->describe('resume','r�sum�',true);
$editor->describe('services','services affect�s',true,'set');
$editor->describe('description','description',false,'textarea');

$editor->assign('title', 'Gestion des coupures');

$editor->run();
?>
