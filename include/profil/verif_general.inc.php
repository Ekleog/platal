<?php

// validit� du mobile
if (strlen(strtok($mobile,"<>{}@&#~\/:;?,!�*_`[]|%$^=")) < strlen($mobile))
{
  $str_error = $str_error."Le champ 'T�l�phone mobile' contient un caract�re interdit.<BR />"; 
}

// correction du champ web si vide
if ($web=="http://" or $web == '') {
  $web='';
} elseif (!preg_match("{^(https?|ftp)://[a-zA-Z0-9._%#+/?=&~-]+$}i", $web)) {
  // validit� de l'url donn�e dans web
  $str_error = $str_error."URL incorrecte dans le champ 'Page web perso', une url doit commencer par http:// ou https:// ou ftp:// et ne pas contenir de caract�res interdits<BR />";
} else {
  $web = str_replace('&', '&amp;', $web);
}

//validit� du champ libre
if (strlen(strtok($libre,"<>")) < strlen($libre))
{
  $str_error = $str_error."Le champ 'Compl�ment libre' contient un caract�re interdit.<BR />";
}

?>
