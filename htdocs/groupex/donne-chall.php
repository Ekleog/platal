<?php

/* Ce script donne un challenge et un num�ro de session afin de permettre l'extraction de donn�es pour eConfiance tout en proc�dant � une identification pr�alable... */

session_start();
session_register("chall");
$_SESSION["chall"] = uniqid(rand(), 1);
echo $_SESSION["chall"] . "\n" . session_id();

?>
