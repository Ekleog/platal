<?php
require('auto.prepend.inc.php');
new_admin_table_editor('groupesx_auth','id');

$editor->describe('name','nom',true);
$editor->describe('privkey','cl� priv�e',false);
$editor->describe('datafields','champs renvoy�s',true);

$editor->assign('title', 'Gestion de l\'authentification centralis�e');

$editor->run();
?>
