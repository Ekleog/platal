<?php
/***************************************************************************
 *  Copyright (C) 2003-2010 Polytechnique.org                              *
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

// {{{ function user_cmp

function user_cmp($prenom, $nom, $_prenom, $_nom)
{
    $_nom    = mb_strtoupper($_nom);
    $_prenom = mb_strtoupper($_prenom);
    $nom     = mb_strtoupper($nom);
    $prenom  = mb_strtoupper($prenom);

    $is_ok   = mb_strtoupper($_prenom) == mb_strtoupper($prenom);

    $tokens  = preg_split("/[ \-']/", $nom, -1, PREG_SPLIT_NO_EMPTY);
    $maxlen  = 0;

    foreach ($tokens as $str) {
        $is_ok &= strpos($_nom, $str)!==false;
        $maxlen = max($maxlen, strlen($str));
    }

    return $is_ok && ($maxlen > 2 || $maxlen == strlen($_nom));
}

// }}}
// {{{ function check_mat

function check_mat($promo, $mat, &$nom, &$prenom, &$ourmat, &$ourid, &$watch, &$naiss)
{
    if (!preg_match('/^[0-9][0-9][0-9][0-9][0-9][0-9]$/', $mat)) {
        return "Le matricule doit comporter 6 chiffres.";
    }

    $year = intval(substr($mat, 0, 3));
    $rang = intval(substr($mat, 3, 3));
    if ($year > 200) { $year /= 10; };
    if ($year < 96) {
        return "ton matricule est incorrect";
    } else {
        $ourmat = sprintf('%04u%04u', 1900+$year, $rang);
    }

    $res = XDB::query(
            'SELECT  user_id, promo, perms IN ("admin","user"), nom, prenom, FIND_IN_SET(\'watch\', flags), naissance_ini
              FROM  auth_user_md5
             WHERE  matricule={?} and deces = 0', $ourmat);
    list ($uid, $_promo, $_already, $_nom, $_prenom, $watch, $naiss) = $res->fetchOneRow();
    if ($_already) { return "tu es déjà inscrit ou ton matricule est incorrect !"; }
    if ($_promo != $promo) { return "erreur de matricule"; }

    if (!user_cmp($prenom, $nom, $_prenom, $_nom)) {
        return "erreur dans l'identification.  Réessaie, il y a une erreur quelque part !";
    }

    $nom = $_nom;
    $prenom = $_prenom;
    $ourid = $uid;
    return true;
}

// }}}
// {{{ function check_old_mat

function check_old_mat($promo, $mat, &$nom, &$prenom, &$ourmat, &$ourid, &$watch, &$naiss)
{
    $res = XDB::iterRow(
            'SELECT  user_id, nom, prenom, matricule, FIND_IN_SET(\'watch\', flags), naissance_ini
               FROM  auth_user_md5
              WHERE  promo={?} AND deces=0 AND perms="pending"', $promo);
    while (list($_uid, $_nom, $_prenom, $_mat, $watch, $naiss) = $res->next()) {
        if (user_cmp($prenom, $nom, $_prenom, $_nom)) {
            $nom = $_nom;
            $prenom = $_prenom;
            $ourid  = $_uid;
            $ourmat = $_mat;
            return true;
        }
    }

    $res = XDB::iterRow(
            'SELECT  user_id, nom, prenom, matricule, alias, FIND_IN_SET(\'watch\', u.flags), naissance_ini
               FROM  auth_user_md5 AS u
         INNER JOIN  aliases       AS a ON (u.user_id = a.id and FIND_IN_SET("bestalias", a.flags))
              WHERE  promo={?} AND deces=0 AND perms IN ("user","admin")', $promo);
    while (list($_uid, $_nom, $_prenom, $_mat, $alias, $watch, $naiss) = $res->next()) {
        if (user_cmp($prenom, $nom, $_prenom, $_nom)) {
            $ourid  = $_uid;
            $ourmat = $_mat;
            return "Tu es vraisemblablement déjà inscrit !";
        }
    }
    return "erreur: vérifie que tu as bien orthographié ton nom !";
}

// }}}
// {{{ function check_new_user

function check_new_user(&$sub)
{
    extract($sub);

    $prenom  = preg_replace("/[ \t]+/", ' ', trim($prenom));
    $prenom  = preg_replace("/--+/", '-', $prenom);
    $prenom  = preg_replace("/''+/", '\'', $prenom);
    $prenom  = make_firstname_case($prenom);

    $nom     = preg_replace("/[ \t]+/", ' ', trim($nom));
    $nom     = preg_replace("/--+/", '-', $nom);
    $nom     = preg_replace("/''+/", '\'', $nom);
    $nom     = mb_strtoupper($nom);

    if ($promo >= 1996) {
        $res = check_mat($promo, $mat, $nom, $prenom, $ourmat, $ourid, $watch, $naiss);
    } else {
        $res = check_old_mat($promo, $mat, $nom, $prenom, $ourmat, $ourid, $watch, $naiss);
    }
    if ($res !== true) { return $res; }

    $sub['nom']    = $nom;
    $sub['prenom'] = $prenom;
    $sub['ourmat'] = $ourmat;
    $sub['uid']    = $ourid;
    $sub['watch']  = $watch;
    $sub['naissance_ini'] = $naiss;

    return true;
}

// }}}
// {{{ function create_aliases

function create_aliases (&$sub)
{
    global $globals;
    extract ($sub);

    $mailorg = makeUsername($prenom, $nom);
    $mailorg2 = $mailorg.sprintf(".%02u", ($promo%100));

    $res = XDB::query("SELECT hruid FROM auth_user_md5 WHERE user_id = {?} AND hruid != ''", $uid);
    if ($res->numRows() == 0) {
        return "Tu n'as pas d'adresse à vie pré-attribuée.<br />"
            . "Envoie un mail à <a href=\"mailto:support@{$globals->mail->domain}</a>\">"
            . "support@{$globals->mail->domain}</a> en expliquant ta situation.";
    } else {
        // TODO: at the moment forlife == hruid, however we'll have to change
        // that behaviour when masters will be on plat/al.
        $forlife = $res->fetchOneCell();
    }

    $res = XDB::query('SELECT id, type, expire FROM aliases WHERE alias={?}', $mailorg);
    if ($res->numRows()) {
        list($h_id, $h_type, $expire) = $res->fetchOneRow();
        if ($h_type != 'homonyme' and empty($expire)) {
            XDB::execute('UPDATE aliases SET expire=ADDDATE(NOW(),INTERVAL 1 MONTH) WHERE alias={?}', $mailorg);
            XDB::execute('REPLACE INTO homonyms (homonyme_id,user_id) VALUES ({?},{?})', $h_id, $h_id);
            XDB::execute('REPLACE INTO homonyms (homonyme_id,user_id) VALUES ({?},{?})', $h_id, $uid);
            $res = XDB::query("SELECT alias FROM aliases WHERE id={?} AND expire IS NULL", $h_id);
            $als = $res->fetchColumn();

            $mailer = new PlMailer();
            $mailer->setFrom('"Support Polytechnique.org" <support@' . $globals->mail->domain . '>');
            $mailer->addTo("$mailorg@" . $globals->mail->domain);
            $mailer->setSubject("perte de ton alias $mailorg dans un mois !");
            $mailer->addCc('"Support Polytechnique.org" <support@' . $globals->mail->domain . '>');
            $msg =
                "Bonjour,\n\n".

                "Un homonyme vient de s'inscrire. La politique de Polytechnique.org est de fournir des\n".
                "adresses email devinables, nous ne pouvons donc pas conserver ton alias '$mailorg' qui\n".
                "correspond maintenant à deux personnes.\n\n".

                "Tu gardes tout de même l'usage de cet alias pour un mois encore à compter de ce jour.\n\n".

                "Lorsque cet alias sera désactivé, l'adresse $mailorg@polytechnique.org renverra vers un \n".
                "robot qui indiquera qu'il y a plusieurs personnes portant le même nom ;\n".
                "cela évite que l'un des homonymes reçoive des courriels destinés à l'autre.\n\n".

                "Pour te connecter au site, tu pourras utiliser comme identifiant n'importe lequel de tes\n".
                "autres alias :\n".
                "    ".join(', ', $als)."\n";
                "Commence dès aujourd'hui à communiquer à tes correspondants la nouvelle adresse que tu comptes utiliser !\n\n".

                "En nous excusant pour le désagrément occasionné,\n".
                "Cordialement,\n\n".

                "-- \n".
                "L'équipe de Polytechnique.org\n".
                "\"Le portail des élèves & anciens élèves de l'X\"";
            $mailer->SetTxtBody(wordwrap($msg,72));
            $mailer->send();
        }

        $sub['forlife']   = $forlife;
        $sub['bestalias'] = $mailorg2;
        $sub['mailorg2']  = null;
    } else {
        $sub['forlife']   = $forlife;
        $sub['bestalias'] = $mailorg;
        $sub['mailorg2']  = $mailorg2;
    }

    return true;
}

// }}}
// {{{ function finish_ins

function finish_ins($sub_state)
{
    global $globals;
    extract($sub_state);

    $hash = rand_url_id(12);
    XDB::execute(
            "UPDATE  auth_user_md5
                SET  last_known_email = {?}
              WHERE  matricule = {?}", $email, $mat);
    XDB::execute(
            "REPLACE INTO  register_pending (uid, forlife, bestalias, mailorg2, password, email, date, relance, naissance, hash, services)
                   VALUES  ({?}, {?}, {?}, {?}, {?}, {?}, NOW(), 0, {?}, {?}, {?})",
            $uid, $forlife, $bestalias, $mailorg2, $password, $email, $naissance, $hash, implode(',', $services));

    $mymail = new PlMailer('register/inscrire.mail.tpl');
    $mymail->assign('mailorg', $bestalias);
    $mymail->assign('lemail',  $email);
    $mymail->assign('baseurl', $globals->baseurl);
    $mymail->assign('hash',    $hash);
    $mymail->assign('subj',    $bestalias."@" . $globals->mail->domain);
    $mymail->send();
}

// }}}
// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
