<?php
require("auto.prepend.inc.php");
new_skinned_page('pattecassee.tpl',AUTH_COOKIE);
    
function valide_email($str) {

   $em = trim(rtrim($str));
   $em = str_replace("<", "", $em);
   $em = str_replace(">", "", $em);
   list($ident, $dom) = explode("@", $em);
   if ($dom == "m4x.org" or $dom == "polytechnique.org") {
       list($ident1) = explode("_", $ident);
       list($ident) = explode("+", $ident1);
   }
   return $ident . "@" . $dom;
}

if (array_key_exists('email', $_GET) && array_key_exists('action', $_GET)) {
    $email = valide_email($_GET['email']);
    // v�rifications d'usage
    $sel = $globals->db->query(
      "SELECT e.uid, a.username
       FROM emails AS e
       INNER JOIN auth_user_md5 AS a ON e.uid = a.user_id
       WHERE e.email='$email'");
    if (list($uid, $dest) = mysql_fetch_row($sel)) {
	// envoi du mail
	$message = "Bonjour !
	
Ce mail a �t� g�n�r� automatiquement par le service de patte cass�e de
Polytechnique.org car un autre utilisateur, "
.$_SESSION["prenom"]." ".$_SESSION["nom"].",
nous a signal� qu'en t'envoyant un mail, il avait re�u un message d'erreur
indiquant que ton adresse de redirection " . $email . "
ne fonctionnait plus !

Nous te sugg�rons de v�rifier cette adresse, et le cas �ch�ant de mettre
� jour sur le site <https://www.polytechnique.org/emails.php> tes adresses
de redirection...

Pour plus de rensignements sur le service de patte cass�e, n'h�sites pas �
consulter la page <https://www.polytechnique.org/pattecassee.php>.


A bient�t sur Polytechnique.org !
L'�quipe d'administration <support@polytechnique.org>";

    require_once("diogenes.mailer.inc.php");
	$mail = new DiogenesMailer('Polytechnique.org <support@polytechnique.org>', $dest, "Une de tes adresse de redirection Polytechnique.org ne marche plus !!", false);
	$mail->setBody($message);
	$mail->send();
        $page->assign('erreur', "Mail envoy� ! :o)");
    }
} elseif (array_key_exists('email', $_POST)) {
    $email = valide_email($_POST['email']);
    $page->assign('email',$email);
    $sel = $globals->db->query("SELECT e1.uid, e1.panne != 0 AS panne, count(e2.uid) AS nb_mails, u.nom, u.prenom, u.promo
                        FROM emails as e1
                        LEFT JOIN emails as e2 ON(e1.uid = e2.uid AND FIND_IN_SET('active', e2.flags) AND e1.num != e2.num)
                        INNER JOIN auth_user_md5 as u ON(e1.uid = u.user_id)
                        WHERE e1.email ='$email'
                        GROUP BY e1.uid");
    if ($x = mysql_fetch_assoc($sel)) {
        // on �crit dans la base que l'adresse est cass�e
        if (!$x['panne'])
            $globals->db->query("UPDATE emails SET panne='".date("Y-m-d")."' WHERE email =  '".$email."'");
        $page->assign_by_ref('x',$x);
    }
}

$page->run();
?>
