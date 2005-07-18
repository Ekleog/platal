<?php
/***************************************************************************
 *  Copyright (C) 2003-2004 Polytechnique.org                              *
 *  http://opensource.polytechnique.org/                                   *
 *                                                                         *
 *  This program is free software; you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation; either version 2 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with this program; if not, write to the Free Software            *
 *  Foundation, Inc.,                                                      *
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA                *
 ***************************************************************************/

require_once("xorg.inc.php");
require_once("diogenes/diogenes.hermes.inc.php");

/* sort en affichant une erreur */
function erreur($text) {
    $mymail = new HermesMailer();
    $mymail->addTo("telepaiement@polytechnique.org");
    $mymail->setFrom("webmaster@polytechnique.org");
    $mymail->setSubject("erreur lors d'un t�l�paiement (CyberPaiement)");
    $mymail->setTxtBody("\n\n".var_export($_REQUEST,true));
    $mymail->send();
    exit;
}

/* http://fr.wikipedia.org/wiki/Formule_de_Luhn */
function luhn($nombre) {
    $s = strrev($nombre);
    $sum = 0;
    for ($i = 0; $i < strlen($s); $i++) {
	$dgt = $s{$i};
        $sum += ($i % 2) ? (2*$dgt) % 9 : $dgt;
    }
    return $sum % 10;
}

/* calcule la cl� d'acceptation a partir de 5 champs */
function cle_accept($d1,$d2,$d3,$d4,$d5)
{
    $m1 = luhn($d1.$d5);
    $m2 = luhn($d2.$d5);
    $m3 = luhn($d3.$d5);
    $m4 = luhn($d4.$d5);
    $n = $m1 + $m2 + $m3 + $m4;
    $alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    return $alpha{$n-1}.$m1.$m2.$m3.$m4;
}

/* user id */
$uid = clean_request('uid');
/* reference banque (numero de transaction) */
$champ901 = clean_request('CHAMP901');
/* cle d'acceptation */
$champ905 = clean_request('CHAMP905');
/* code retour */
$champ906 = clean_request('CHAMP906');
/* email renvoye par la banque */
$champ104 = clean_request('CHAMP104');
/* reference complete de la commande */
$champ200 = clean_request('CHAMP200');
/* montant de la transaction */
$champ201 = clean_request('CHAMP201');
/* devise */
$champ202 = clean_request('CHAMP202');
$montant = "$champ201 $champ202";

/* on extrait les informations sur l'utilisateur */
$res = $globals->xdb->query("
    SELECT  a.prenom,a.nom,a.promo,l.alias,FIND_IN_SET(a.flags,'femme')
      FROM  auth_user_md5 AS a
INNER JOIN  aliases       AS l ON (a.user_id=l.id AND type!='homonyme')
     WHERE  a.user_id={?}", $uid);
if (!list($prenom,$nom,$promo,$forlife,$femme) = $res->fetchOneRow()) {
    erreur("uid invalide");
}


/* on extrait la reference de la commande */
if (!ereg('-xorg-([0-9]+)$',$champ200,$matches)) {
    erreur("r�f�rence de commande invalide");
}

echo ($ref = $matches[1]);
$res = $globals->xdb->query("SELECT mail,text,confirmation FROM paiement.paiements WHERE id={?}", $ref);
if (!list($conf_mail,$conf_title,$conf_text) = $res->fetchOneRow()) {
    erreur("r�f�rence de commande inconnue");
}

/* on extrait le code de retour */
if ($champ906 != "0000") {
    $res = $globals->xdb->query("SELECT  rcb.text,c.id,c.text
                                   FROM  paiement.codeRCB AS rcb
                              LEFT JOIN  paiement.codeC   AS c ON rcb.codeC=c.id
                                  WHERE  rcb.id='$champ906'");
    if (list($rcb_text, $c_id, $c_text) = $res->fetchOneRow()) {
        erreur("erreur lors du paiement : $c_text ($c_id)");
    } else{ 
        erreur("erreur inconnue lors du paiement");
    }
}

/* on fait l'insertion en base de donnees */
$globals->xdb->execute("INSERT INTO  paiement.transactions (id,uid,ref,fullref,montant,cle)
                             VALUES  ({?},{?},{?},{?},{?},{?})",
                        $champ901, $uid, $ref, $champ200, $montant, $champ905);

/* on genere le mail de confirmation */
$conf_text = str_replace("<prenom>",$prenom,$conf_text);
$conf_text = str_replace("<nom>",$nom,$conf_text);
$conf_text = str_replace("<promo>",$promo,$conf_text);
$conf_text = str_replace("<montant>",$montant,$conf_text);
$conf_text = str_replace("<salutation>",$femme ? "Ch�re" : "Cher",$conf_text);
$conf_text = str_replace("<cher>",$femme ? "Ch�re" : "Cher",$conf_text);

$mymail = new HermesMailer();
$mymail->setFrom($conf_mail);
$mymail->addTo("\"$prenom $nom\" <$forlife@polytechnique.org>");
$mymail->addCc($conf_mail);
$mymail->setSubject($conf_title);
$mymail->setTxtBody($conf_text);
$mymail->send();

/* on envoie les details de la transaction � telepaiement@ */
$mymail = new HermesMailer();
$mymail->setFrom("webmaster@polytechnique.org");
$mymail->addTo("telepaiement@polytechnique.org");
$mymail->setSubject($conf_title);
$msg = "utilisateur : $prenom $nom ($uid)\n".
       "mail : $forlife@polytechnique.org\n\n".
       "paiement : $conf_title ($conf_mail)\n".
       "reference : $champ200\n".
       "montant : $montant\n\n".
       "dump de REQUEST:\n".
       var_export($_REQUEST,true);
$mymail->setTxtBody($msg);
$mymail->send();

?>
