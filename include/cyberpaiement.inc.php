<?php

global $baseurl,$ref_flags,$ref_text,$ref_mail,$ref,$montant,
       $username, $nom, $prenom ;

// on construit l'adresse de retour pour le robot de la banque
$roboturl = str_replace("https://","http://",$baseurl)."/paiement/cyberpaiement_retour.php?uid={$_SESSION['uid']}&amp;CHAMPBPX";

// on construit l'adresse de retour pour l'utilisateur
$returnurl = "$baseurl/";
if (! isset($_COOKIE[session_name()]))
  $returnurl .= "?".SID;

// on constuit la reference de la transaction
$prefix = ($ref_flags->hasflag('unique')) ? str_pad("",15,"0") : rand_url_id();
$fullref = substr("$prefix-xorg-$ref",-15);

// on recupere les infos sur l'utilisateur
$res = mysql_query("select username, nom, prenom from auth_user_md5 where user_id={$_SESSION['uid']}");
list($username,$nom,$prenom) = mysql_fetch_row($res);
mysql_free_result($res);
?>

<form method="POST" action="https://ecom.cimetz.com/telepaie/cgishell.exe/epaie01.exe">
<!-- infos commercant -->
<input type="hidden" name="CHAMP000" value="510879" />
<input type="hidden" name="CHAMP001" value="5965" />
<input type="hidden" name="CHAMP002" value="5429159012" />
<input type="hidden" name="CHAMP003" value="I" />
<input type="hidden" name="CHAMP004" value="Polytechnique.org" />
<input type="hidden" name="CHAMP005" value="<?php echo $roboturl; ?>" />
<input type="hidden" name="CHAMP006" value="Polytechnique.org" />
<input type="hidden" name="CHAMP007" value="<?php echo $returnurl; ?>" />
<input type="hidden" name="CHAMP008" value="<?php echo $ref_mail; ?>" />
<!-- infos client -->
<input type="hidden" name="CHAMP100" value="<?php echo $nom; ?>" />
<input type="hidden" name="CHAMP101" value="<?php echo $prenom; ?>" />
<input type="hidden" name="CHAMP102" value="." />
<input type="hidden" name="CHAMP103" value="." />
<input type="hidden" name="CHAMP104" value="<?php echo $username; ?>@polytechnique.org" />
<input type="hidden" name="CHAMP106" value="." />
<input type="hidden" name="CHAMP107" value="." />
<input type="hidden" name="CHAMP108" value="." />
<input type="hidden" name="CHAMP109" value="." />
<input type="hidden" name="CHAMP110" value="." />
<!-- infos commande -->
<input type="hidden" name="CHAMP200" value="<?php echo $fullref; ?>" />
<input type="hidden" name="CHAMP201" value="<?php echo $montant; ?>" />
<input type="hidden" name="CHAMP202" value="EUR" />
<!-- infos divers -->
<input type="hidden" name="CHAMP900" value="01" />
<table class="bicol" width="98%">
  <tr>
    <th colspan="2">Paiement via CyberP@iement</th>
  </tr>
  <tr>
    <td><b>Transaction</b></td>
    <td><?php echo $ref_text; ?></td>
  </tr>
  <tr>
    <td><b>Montant (euros)</b></td>
    <td><?php echo $montant; ?></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" value="Valider" />
  </tr>
</table>
</form>

<p class="normal">
En cliquant sur "Valider", tu seras
redirig�<?php if ($_SESSION['femme']) echo "e"; ?> vers le site de la 
BP Lorraine Champagne, o� il te sera demand� de saisir ton num�ro de
carte bancaire. Lorsque le paiement aura �t� effectu�, tu recevras
une confirmation par email.
</p>

