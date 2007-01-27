<?php

// renvoie un texte html � partir d'un texte classique
// en remplacant les url par des liens (�ventuellement les mails)
function url_catcher($texte, $mails = true) {
    $patterns = array();
    $replacement = array();

    // url commencant par http, https ou ftp
    $patterns[] = '/((?:https?|ftp):\/\/(?:\.*,*[\w@~%$��&i#\-+=_\/\?;])*)/i';
    $replacement[] = '<a href="\\0">\\0</a>';

    // url commencant par www.
    $patterns[] = '/(\s|^)www\.((?:\.*,*[\w@~%$��&i#\-+=_\/\?;])*)/i';
    $replacement[] = '\\1<a href="http://www.\\2">www.\\2</a>';

    if ($mails) {
        $patterns[] = '/(?:mailto:)?([a-z0-9.\-+_]+@([\-.+_]?[a-z0-9])+)/i';
        $replacement[] = '<a href="mailto:\\0">\\0</a>';
    }

    return preg_replace($patterns, $replacement, $texte);
}
?>
