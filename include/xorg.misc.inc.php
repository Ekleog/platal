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
 ***************************************************************************
        $Id: xorg.misc.inc.php,v 1.6 2004-09-03 00:15:51 x2000bedo Exp $
 ***************************************************************************/

/** v�rifie si une adresse email (sans @) correspond � un alias (FIXME ou une liste)...
 * @param $email l'adresse email a verifier
 * @return BOOL
 */
function isvalid_email_local($email) {
  global $globals;
  
  $req = $globals->db->query("select count(*) from aliases where alias='$email'");
  list($nb)=mysql_fetch_row($req);
  mysql_free_result($req);
  if ($nb>0) return true;

  // reste � v�rifier si c'est pas une adresse dans /etc/aliases
  // surement possible en utilisant postmap -q $email hash:/etc/aliases

  return false;
}

/** v�rifie si une adresse email convient comme adresse de redirection 
 * @param $email l'adresse email a verifier
 * @return BOOL
 */
function isvalid_email_redirection($email) {
  return isvalid_email($email) && 
         !preg_match("/@(polytechnique\.(org|edu)|melix\.(org|net)|m4x\.org)$/", $email);
}

/* Un soundex en fran�ais post� par Fr�d�ric Bouchery
Voici une adaptation en PHP de la fonction soundex2 francis�e de Fr�d�ric BROUARD (http://sqlpro.developpez.com/Soundex/).
C'est une bonne d�monstration de la force des expressions r�guli�res compatible Perl.
trouv� sur http://expreg.com/voirsource.php?id=40&type=Chaines%20de%20caract%E8res */
function soundex_fr($sIn)
{ 
    // Si il n'y a pas de mot, on sort imm�diatement 
    if ( $sIn === '' ) return '    '; 
    // On met tout en minuscule 
    $sIn = strtoupper( $sIn ); 
    // On supprime les accents 
    $sIn = strtr( $sIn, '�������˼�������', 'AAASEEEEEIIOOUUU' ); 
    // On supprime tout ce qui n'est pas une lettre 
    $sIn = preg_replace( '`[^A-Z]`', '', $sIn ); 
    // Si la cha�ne ne fait qu'un seul caract�re, on sort avec. 
    if ( strlen( $sIn ) === 1 ) return $sIn . '   '; 
    // on remplace les consonnances primaires 
    $convIn = array( 'GUI', 'GUE', 'GA', 'GO', 'GU', 'CA', 'CO', 'CU', 'Q', 'CC', 'CK' ); 
    $convOut = array( 'KI', 'KE', 'KA', 'KO', 'K', 'KA', 'KO', 'KU', 'K', 'K', 'K' ); 
    $sIn = str_replace( $convIn, $convOut, $sIn ); 
    // on remplace les voyelles sauf le Y et sauf la premi�re par A 
    $sIn = preg_replace( '`(?<!^)[EIOU]`', 'A', $sIn ); 
    // on remplace les pr�fixes puis on conserve la premi�re lettre 
    // et on fait les remplacements compl�mentaires 
    $convIn = array( '`^KN`', '`^(PH|PF)`', '`^MAC`', '`^SCH`', '`^ASA`', '`(?<!^)KN`', '`(?<!^)(PH|PF)`', '`(?<!^)MAC`', '`(?<!^)SCH`', '`(?<!^)ASA`' ); 
    $convOut = array( 'NN', 'FF', 'MCC', 'SSS', 'AZA', 'NN', 'FF', 'MCC', 'SSS', 'AZA' ); 
    $sIn = preg_replace( $convIn, $convOut, $sIn ); 
    // suppression des H sauf CH ou SH 
    $sIn = preg_replace( '`(?<![CS])H`', '', $sIn ); 
    // suppression des Y sauf pr�c�d�s d'un A 
    $sIn = preg_replace( '`(?<!A)Y`', '', $sIn ); 
    // on supprime les terminaisons A, T, D, S 
    $sIn = preg_replace( '`[ATDS]$`', '', $sIn ); 
    // suppression de tous les A sauf en t�te 
    $sIn = preg_replace( '`(?!^)A`', '', $sIn ); 
    // on supprime les lettres r�p�titives 
    $sIn = preg_replace( '`(.)\1`', '$1', $sIn ); 
    // on ne retient que 4 caract�res ou on compl�te avec des blancs 
    return substr( $sIn . '    ', 0, 4); 
}

function make_forlife($prenom,$nom,$promo) {
  /* on traite le prenom */
  $prenomUS=replace_accent(trim($prenom));
  $prenomUS=stripslashes($prenomUS);
       
  /* on traite le nom */
  $nomUS=replace_accent(trim($nom));
  $nomUS=stripslashes($nomUS);
              
  // calcul du login
  $forlife = strtolower($prenomUS.".".$nomUS.".".$promo);
  $forlife = str_replace(" ","-",$forlife);
  $forlife = str_replace("'","",$forlife);
  return $forlife;
}
?>
