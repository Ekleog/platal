<?php
require("auto.prepend.inc.php");
new_skinned_page('paiment/index.tpl', AUTH_MDP);
require('profil.inc.php');
setlocale(LC_NUMERIC,'fr_FR');


// initialisation
$op = isset($_REQUEST['op']) ? $_REQUEST['op'] : 'select';
$methode = isset($_REQUEST['methode']) ? $_REQUEST['methode'] : 0;
$erreur = Array();

// on recupere les infos relatives a la transaction choisie
$ref = isset($_REQUEST['ref']) ? $_REQUEST['ref'] : 0;
$res = $globals->db->query("SELECT text,url,flags,mail,montant_min,montant_max,montant_def FROM paiement.paiements WHERE id=$ref");

if (!list($ref_text,$ref_url,$ref_flags,$ref_mail,$montant_min,$montant_max,$montant_def) = mysql_fetch_row($res)) {
    $erreur[] = "La transaction selectionn�e n'est pas valide.";
}
$ref_flags = new flagset($ref_flags);

if($ref_flags->hasflag('old')){
    $erreur[] = "La transaction selectionn�e est p�rim�e.";
    //Don x.org, toujours valable :)
    $ref = 0;
    $res = $globals->db->query("SELECT text,url,flags,mail,montant_min,montant_max,montant_def FROM paiement.paiements WHERE id=$ref");
    if (!list($ref_text,$ref_url,$ref_flags,$ref_mail,$montant_min,$montant_max,$montant_def) = mysql_fetch_row($res)) {
        $erreur[] = "La transaction selectionn�e n'est pas valide.";
    }
    $ref_flags = new flagset($ref_flags);
}

// on remplace les points par des virgules
$montant_min=strtr($montant_min,".",",");
$montant_max=strtr($montant_max,".",",");
$montant_def=strtr($montant_def,".",",");

// on recupere les infos relatives � la methode choisie
$methode = isset($_REQUEST['methode']) ? $_REQUEST['methode'] : 0;
$res = $globals->db->query("SELECT include FROM paiement.methodes WHERE id=$methode");
if (!list($methode_include) = mysql_fetch_row($res)) {
    $erreur[] = "La m�thode de paiement s�lectionn�e n'est pas valide.";
}

// verifications
$montant = (($op=="submit") && isset($_REQUEST['montant'])) ? $_REQUEST['montant'] : $montant_def;
$montant = strtr($montant, ".", ",");

// on ajoute les centimes
if (ereg("^[0-9]+$",$montant))
$montant .= ",00";
elseif (ereg("^[0-9]+,[0-9]$",$montant))
$montant .= "0";

// on verifie que le montant est bien formatt�
if (!ereg("^[0-9]+,[0-9]{2}$",$montant)) {
    $erreur[] = "Montant invalide.";
    $montant = $montant_def;
}

if ($montant < $montant_min) {
    $erreur[] = "Montant inf�rieur au minimum autoris� ($montant_min).";
    $montant = $montant_min;
}

if ($montant > $montant_max) {
    $erreur[] = "Montant sup�rieur au maximum autoris� ($montant_max).";
    $montant = $montant_max;
}

$page->assign('op',$op);
$page->assign('erreur',$erreur);
$page->assign('montant',$montant);

$page->assign('methode',$methode);
$page->assign('methode_include',$methode_include);

$page->assign('ref',$ref);
$page->assign('ref_url',$ref_url);

$page->run();
?>
