<?php
    require 'xnet.inc.php';

    if (logged()) {
        header("Location: index.php");
    }

    new_skinned_page('index.tpl', AUTH_MDP);
    $page->run();
?>