<?
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
        $Id: step4.php,v 1.2 2004-10-10 13:51:13 x2000habouzit Exp $
 ***************************************************************************/

require("auto.prepend.inc.php");
new_skinned_page('inscription/step4.tpl', AUTH_PUBLIC);

require("inscription_listes_base.inc.php");
require("inscription_forums_base.inc.php");
require('tpl.mailer.inc.php');

define("ERROR_REF", 1);
define("ERROR_ALREADY_SUBSCRIBED", 2);
define("ERROR_DB", 3);

if (!empty($_REQUEST['ref'])) {
    $sql = "SELECT username,loginbis,matricule,promo,password".
	        ",nom,prenom,nationalite,email,naissance,date".
	        ",appli_id1,appli_type1,appli_id2,appli_type2".
	        " FROM en_cours WHERE ins_id='".$_REQUEST["ref"]."'";
    $res = $globals->db->query($sql);
    //v�rifions que la r�f�rence de l'utilisateur est 
    if (!list($forlife, $alias, $matricule, $promo, $password, $nom, $prenom,$nationalite, 
              $email, $naissance,$date,$appli_id1,$appli_type1,$appli_id2,$appli_type2) = mysql_fetch_row($res)) {
        $page->assign('error',ERROR_REF);
        $page->run();
    }
    $page->assign('forlife',$forlife);
    
    // v�rifions qu'il n'y a pas d�j� une inscription dans le pass�
    // ce qui est courant car les double-clic...
    $res = $globals->db->query("SELECT alias FROM aliases WHERE alias='$forlife'");
    if ( mysql_num_rows($res) != 0)  {
        $page->assign('error',ERROR_ALREADY_SUBSCRIBED);
        $page->run();
    }
    
    $nom = stripslashes($nom);
    $prenom = stripslashes($prenom);
    $sql = "INSERT INTO auth_user_md5 SET matricule='$matricule',promo=$promo, password='$password',
	    nom='".addslashes($nom)."',prenom='".addslashes($prenom)."',nationalite=$nationalite,
            date='$date',naissance=$naissance, date_ins = NULL";
    $globals->db->query($sql);
    
    // on v�rifie qu'il n'y a pas eu d'
    if ($globals->db->err()) {
        $page->assign('error',ERROR_DB);
        $page->assign('error_db',$globals->db->error());
        $page->run();
    }
    // ok, pas d'erreur, on 
    $uid=$globals->db->insert_id();

    $globals->db->query("INSERT INTO aliases (id,alias,type) VALUES ($uid,'$forlife','a_vie')");
    if($alias) {
	$globals->db->query("INSERT INTO aliases (id,alias,type) VALUES ($uid,'$alias','alias')");
	$globals->db->query("INSERT INTO aliases (id,alias,type) VALUES ($uid,'$alias.".($promo%100)."','alias')");
    }

    // on cree un objet logger et on log l'
    $logger = new DiogenesCoreLogger($uid);
    $logger->log("inscription",$email);

    /****************** insertion de l'email dans la table emails ***/
    require("email.classes.inc.php");
    $redirect = new Redirect($uid);
    $redirect->add_email($email);
    $globals->db->query("INSERT INTO emails
				 SET uid = $uid,
                                     email = '\"|maildrop /var/mail/.maildrop_filters/tag_spams $uid\"',
				     flags = 'filter'");
    /****************** ajout des formations ****************/
    if (($appli_id1>0)&&($appli_type1))
        $globals->db->query("insert into applis_ins set uid=$uid,aid=$appli_id1,type='$appli_type1',ordre=0");
    if (($appli_id2>0)&&($appli_type2))
        $globals->db->query("insert into applis_ins set uid=$uid,aid=$appli_id2,type='$appli_type2',ordre=1");
    /****************** envoi d'un mail au d�marcheur ***************/
    /* si la personne a �t� marketingnis�e, alors on pr�vient son d�marcheur */
    $res = $globals->db->query("SELECT  DISTINCT a.alias,e.date_envoi
                                  FROM  envoidirect AS e
			    INNER JOIN  aliases     AS a ON ( a.id = e.sender AND a.type='a_vie' )
                                 WHERE  e.matricule = '".$forlife."'");
    while (list($sender_usern, $sender_date) = mysql_fetch_row($res)) {
        $mymail = new TplMailer('marketing.thanks.tpl');
        $mymail->assign('to', $sender_usern);
        $mymail->assign('prenom', $prenom);
        $mymail->assign('nom',$nom);
        $mymail->assign('promo',$promo);
        $mymail->send();
    }
   

    /****************** inscription � la liste promo +nl ****************/
    $inspromo = inscription_listes_base($uid,$password,$promo);
    /****************** inscription aux forums de base   ****************/
    $insforumpromo = inscription_forum_promo($uid,$promo);
    $insforums = inscription_forums($uid);

    // effacer la pr�-inscription devenue 
    $globals->db->query("update en_cours set loginbis='INSCRIT' WHERE username='$forlife'");

    // ins�rer l'inscription dans la table des inscriptions confirm�
    $globals->db->query("INSERT INTO ins_confirmees SET id=$uid");

    // ins�rer une ligne dans user_changes pour que les coordonn�es compl�
    // soient envoy�es a l'
    $globals->db->query("insert into user_changes ($uid)");

    // envoi du mail � l'
    $mymail = new TplMailer('inscription.reussie.tpl');
    $mymail->assign('forlife', $forlife);
    $mymail->assign('prenom', $prenom);
    $mymail->send();

    // s'il est dans la table envoidirect, on le marque comme 
    $globals->db->query("update envoidirect set date_succes=NOW() where matricule = $matricule");
    start_connexion($uid,false);
} else
    $page->assign('error',ERROR_REF);

$page->assign('dev',(isset($site_dev) && $site_dev)?1:0);
$page->run();
?>
