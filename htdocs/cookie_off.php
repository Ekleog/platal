<?php
require("auto.prepend.inc.php");
new_skinned_page('index.tpl', AUTH_COOKIE);

setcookie('ORGaccess','',(time()+1),'/','',0);
$_SESSION['log']->log("cookie_off");

// si on a le cookie, et qu'on est pas identifi�,
// s'enlever le cookie revient � se d�connecter
if(!identified()) {
    session_destroy();
    $_SESSION = array();
}

$page->display();
?>
