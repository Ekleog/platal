<?php
require("auto.append.inc.php");
new_admin_page('admin/postfix.common.tpl');

if (isset($_REQUEST["del"]) && !empty($_REQUEST["del"])) {
    exec("/home/web/spam/effacerRetardes ".$_REQUEST["nomligne"]);
    $page->assign('erreur', "Action: DEL({$_REQUEST['nomligne']})");
}
	 
$retard = Array();
$fd = fopen ("/etc/postfix/spamdefer", "r");

while (!feof ($fd)) {
    $buffer = fgets($fd, 4096);
    if ($buffer[0]!='#' && (strlen($buffer)>1) { # FIXME $string[i] is deprecated
        $retard[] = $buffer;
    }
}
fclose($fd);

$page->assign_by_ref('list',$blacklist);
$page->assign('title','Mails retard�s de polytechnique.org');
$page->assign('expl','Les envoyeurs ici pr�sents verront leurs mails retard�s toutes les heures jusqu\'au d�lai de 5j (bounce). Placer ici uniquement des emails (pas de commentaires).');
$page->display();
?>
