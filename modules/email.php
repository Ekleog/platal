<?php
/***************************************************************************
 *  Copyright (C) 2003-2009 Polytechnique.org                              *
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

class EmailModule extends PLModule
{
    function handlers()
    {
        return array(
            'emails'                  => $this->make_hook('emails',      AUTH_COOKIE),
            'emails/alias'            => $this->make_hook('alias',       AUTH_MDP),
            'emails/antispam'         => $this->make_hook('antispam',    AUTH_MDP),
            'emails/broken'           => $this->make_hook('broken',      AUTH_COOKIE),
            'emails/redirect'         => $this->make_hook('redirect',    AUTH_MDP),
            'emails/send'             => $this->make_hook('send',        AUTH_MDP),
            'emails/antispam/submit'  => $this->make_hook('submit',      AUTH_COOKIE),
            'emails/test'             => $this->make_hook('test',        AUTH_COOKIE, 'user', NO_AUTH),

            'emails/rewrite/in'       => $this->make_hook('rewrite_in',  AUTH_PUBLIC),
            'emails/rewrite/out'      => $this->make_hook('rewrite_out', AUTH_PUBLIC),

            'emails/imap/in'          => $this->make_hook('imap_in',     AUTH_PUBLIC),

            'admin/emails/duplicated' => $this->make_hook('duplicated',  AUTH_MDP,    'admin'),
            'admin/emails/watch'      => $this->make_hook('duplicated',  AUTH_MDP,    'admin'),
            'admin/emails/lost'       => $this->make_hook('lost',        AUTH_MDP,    'admin'),
            'admin/emails/broken'     => $this->make_hook('broken_addr', AUTH_MDP,    'admin'),
        );
    }

    function handler_emails(&$page, $action = null, $email = null)
    {
        global $globals;
        require_once 'emails.inc.php';

        $page->changeTpl('emails/index.tpl');
        $page->setTitle('Mes emails');

        $user = S::user();

        // Apply the bestalias change request.
        if ($action == 'best' && $email) {
            if (!S::has_xsrf_token()) {
                return PL_FORBIDDEN;
            }

            XDB::execute("UPDATE  aliases
                             SET  flags = TRIM(BOTH ',' FROM REPLACE(CONCAT(',', flags, ','), ',bestalias,', ','))
                           WHERE  id = {?}", $user->id());
            XDB::execute("UPDATE  aliases
                             SET  flags = CONCAT_WS(',', IF(flags = '', NULL, flags), 'bestalias')
                           WHERE  id = {?} AND alias = {?}", $user->id(), $email);

            // As having a non-null bestalias value is critical in
            // plat/al's code, we do an a posteriori check on the
            // validity of the bestalias.
            fix_bestalias($user);
        }

        // Fetch and display aliases.
        $sql = "SELECT  alias, (type='a_vie') AS a_vie,
                        (alias REGEXP '\\\\.[0-9]{2}$') AS cent_ans,
                        FIND_IN_SET('bestalias',flags) AS best, expire
                  FROM  aliases
                 WHERE  id = {?} AND type!='homonyme'
              ORDER BY  LENGTH(alias)";
        $page->assign('aliases', XDB::iterator($sql, $user->id()));

        // Check for homonyms.
        $homonyme = XDB::query(
                "SELECT  alias
                   FROM  aliases
             INNER JOIN  homonymes ON (id = homonyme_id)
                  WHERE  user_id = {?} AND type = 'homonyme'", $user->id());
        $page->assign('homonyme', $homonyme->fetchOneCell());

        // Display active redirections.
        $redirect = new Redirect($user);
        $page->assign('mails', $redirect->active_emails());

        // Display, when available, the @alias_dom email alias.
        $res = XDB::query(
                "SELECT  alias
                   FROM  virtual          AS v
             INNER JOIN  virtual_redirect AS vr USING(vid)
                  WHERE  (redirect={?} OR redirect={?})
                         AND alias LIKE '%@{$globals->mail->alias_dom}'",
                $user->forlifeEmail(),
                // TODO: remove this über-ugly hack. The issue is that you need
                // to remove all @m4x.org addresses in virtual_redirect first.
                $user->login() . '@' . $globals->mail->domain2);
        $page->assign('melix', $res->fetchOneCell());
    }

    function handler_alias(&$page, $action = null, $value = null)
    {
        require_once 'validations.inc.php';

        global $globals;

        $page->changeTpl('emails/alias.tpl');
        $page->setTitle('Alias melix.net');

        $user = S::user();
        $page->assign('demande', AliasReq::get_request($user->id()));

        // Remove the email alias.
        if ($action == 'delete' && $value) {
            S::assert_xsrf_token();

            XDB::execute(
                    "DELETE  virtual, virtual_redirect
                       FROM  virtual
                 INNER JOIN  virtual_redirect USING (vid)
                      WHERE  alias = {?} AND (redirect = {?} OR redirect = {?})",
                    $value, $user->forlifeEmail(),
                    // TODO: remove this über-ugly hack. The issue is that you need
                    // to remove all @m4x.org addresses in virtual_redirect first.
                    $user->login() . '@' . $globals->mail->domain2);
        }

        // Fetch existing @alias_dom aliases.
        $res = XDB::query(
                "SELECT  alias, emails_alias_pub
                   FROM  auth_user_quick, virtual
             INNER JOIN  virtual_redirect USING(vid)
                  WHERE  (redirect = {?} OR redirect = {?})
                         AND alias LIKE '%@{$globals->mail->alias_dom}' AND user_id = {?}",
                $user->forlifeEmail(),
                // TODO: remove this über-ugly hack. The issue is that you need
                // to remove all @m4x.org addresses in virtual_redirect first.
                $user->login() . '@' . $globals->mail->domain2, $user->id());
        list($alias, $visibility) = $res->fetchOneRow();
        $page->assign('actuel', $alias);

        if ($action == 'ask' && Env::has('alias') && Env::has('raison')) {
            S::assert_xsrf_token();

            //Si l'utilisateur vient de faire une damande
            $alias  = Env::v('alias');
            $raison = Env::v('raison');
            $public = (Env::v('public', 'off') == 'on')?"public":"private";

            $page->assign('r_alias', $alias);
            $page->assign('r_raison', $raison);
            if ($public == 'public') {
                $page->assign('r_public', true);
            }

            //Quelques vérifications sur l'alias (caractères spéciaux)
            if (!preg_match( "/^[a-zA-Z0-9\-.]{3,20}$/", $alias)) {
                $page->trigError("L'adresse demandée n'est pas valide."
                            . " Vérifie qu'elle comporte entre 3 et 20 caractères"
                            . " et qu'elle ne contient que des lettres non accentuées,"
                            . " des chiffres ou les caractères - et .");
                return;
            } else {
                //vérifier que l'alias n'est pas déja pris
                $res = XDB::query('SELECT COUNT(*) FROM virtual WHERE alias={?}',
                                            $alias.'@'.$globals->mail->alias_dom);
                if ($res->fetchOneCell() > 0) {
                    $page->trigError("L'alias $alias@{$globals->mail->alias_dom} a déja été attribué.
                                Tu ne peux donc pas l'obtenir.");
                    return;
                }

                //vérifier que l'alias n'est pas déja en demande
                $it = new ValidateIterator ();
                while($req = $it->next()) {
                    if ($req->type == "alias" and $req->alias == $alias . '@' . $globals->mail->alias_dom) {
                        $page->trigError("L'alias $alias@{$globals->mail->alias_dom} a déja été demandé.
                                    Tu ne peux donc pas l'obtenir pour l'instant.");
                        return ;
                    }
                }

                //Insertion de la demande dans la base, écrase les requêtes précédente
                $myalias = new AliasReq($user, $alias, $raison, $public);
                $myalias->submit();
                $page->assign('success',$alias);
                return;
            }
        } elseif ($action == 'set' && ($value == 'public' || $value == 'private')) {
            if (!S::has_xsrf_token()) {
                return PL_FORBIDDEN;
            }

            if ($value == 'public') {
                XDB::execute("UPDATE auth_user_quick SET emails_alias_pub = 'public'
                                         WHERE user_id = {?}", $user->id());
            } else {
                XDB::execute("UPDATE auth_user_quick SET emails_alias_pub = 'private'
                                         WHERE user_id = {?}", $user->id());
            }

            $visibility = $value;
        }

        $page->assign('mail_public', ($visibility == 'public'));
    }

    function handler_redirect(&$page, $action = null, $email = null)
    {
        global $globals;

        require_once 'emails.inc.php';

        $page->changeTpl('emails/redirect.tpl');

        $user = S::user();
        $page->assign_by_ref('user', $user);
        $page->assign('eleve', $user->promo() >= date("Y") - 5);

        $redirect = new Redirect($user);

        // FS#703 : $_GET is urldecoded twice, hence
        // + (the data) => %2B (in the url) => + (first decoding) => ' ' (second decoding)
        // Since there can be no spaces in emails, we can fix this with :
        $email = str_replace(' ', '+', $email);

        // Apply email redirection change requests.
        $result = SUCCESS;
        if ($action == 'remove' && $email) {
            $result = $redirect->delete_email($email);
        }

        if ($action == 'active' && $email) {
            $redirect->modify_one_email($email, true);
        }

        if ($action == 'inactive' && $email) {
            $redirect->modify_one_email($email, false);
        }

        if ($action == 'rewrite' && $email) {
            $rewrite = @func_get_arg(3);
            $redirect->modify_one_email_redirect($email, $rewrite);
        }

        if (Env::has('emailop')) {
            S::assert_xsrf_token();

            $actifs = Env::v('emails_actifs', Array());
            print_r(Env::v('emails_rewrite'));
            if (Env::v('emailop') == "ajouter" && Env::has('email')) {
                $result = $redirect->add_email(Env::v('email'));
            } elseif (empty($actifs)) {
                $result = ERROR_INACTIVE_REDIRECTION;
            } elseif (is_array($actifs)) {
                $result = $redirect->modify_email($actifs, Env::v('emails_rewrite', Array()));
            }
        }

        switch ($result) {
          case ERROR_INACTIVE_REDIRECTION:
            $page->trigError('Tu ne peux pas avoir aucune adresse de redirection active, sinon ton adresse '
                             . $user->forlifeEmail() . ' ne fonctionnerait plus.');
            break;
          case ERROR_INVALID_EMAIL:
            $page->trigError('Erreur: l\'email n\'est pas valide.');
            break;
          case ERROR_LOOP_EMAIL:
            $page->trigError('Erreur : ' . $user->forlifeEmail()
                             . ' ne doit pas être renvoyé vers lui-même, ni vers son équivalent en '
                             . $globals->mail->domain2 . ' ni vers polytechnique.edu.');
            break;
        }

        // Fetch the @alias_dom email alias, if any.
        $res = XDB::query(
                "SELECT  alias
                   FROM  virtual
             INNER JOIN  virtual_redirect USING(vid)
                  WHERE  (redirect={?} OR redirect={?})
                         AND alias LIKE '%@{$globals->mail->alias_dom}'",
                $user->forlifeEmail(),
                // TODO: remove this über-ugly hack. The issue is that you need
                // to remove all @m4x.org addresses in virtual_redirect first.
                $user->login() . '@' . $globals->mail->domain2);
        $melix = $res->fetchOneCell();
        if ($melix) {
            list($melix) = explode('@', $melix);
            $page->assign('melix',$melix);
        }

        // Fetch existing email aliases.
        $res = XDB::query(
                "SELECT  alias,expire
                   FROM  aliases
                  WHERE  id={?} AND (type='a_vie' OR type='alias')
               ORDER BY  !FIND_IN_SET('usage',flags), LENGTH(alias)", $user->id());
        $page->assign('alias', $res->fetchAllAssoc());
        $page->assign('emails', $redirect->emails);

        // Display GoogleApps acount information.
        require_once 'googleapps.inc.php';
        $page->assign('googleapps', GoogleAppsAccount::account_status($user->id()));
    }

    function handler_antispam(&$page, $statut_filtre = null)
    {
        require_once 'emails.inc.php';
        $wp = new PlWikiPage('Xorg.Antispam');
        $wp->buildCache();

        $page->changeTpl('emails/antispam.tpl');

        $bogo = new Bogo(S::user());
        if (isset($statut_filtre)) {
            $bogo->change($statut_filtre + 0);
        }
        $page->assign('filtre', $bogo->level());
    }

    function handler_submit(&$page)
    {
        $wp = new PlWikiPage('Xorg.Mails');
        $wp->buildCache();
        $page->changeTpl('emails/submit_spam.tpl');

        if (Post::has('send_email')) {
            S::assert_xsrf_token();

            $upload = PlUpload::get($_FILES['mail'], S::user()->login(), 'spam.submit', true);
            if (!$upload) {
                $page->trigError('Une erreur a été rencontrée lors du transfert du fichier');
                return;
            }
            $mime = $upload->contentType();
            if ($mime != 'text/x-mail' && $mime != 'message/rfc822') {
                $upload->clear();
                $page->trigError('Le fichier ne contient pas un email complet');
                return;
            }
            $type = (Post::v('type') == 'spam' ? 'spam' : 'nonspam');

            global $globals;
            $box    = $type . '@' . $globals->mail->domain;
            $mailer = new PlMailer();
            $mailer->addTo($box);
            $mailer->setFrom('"' . S::user()->fullName() . '" <web@' . $globals->mail->domain . '>');
            $mailer->setTxtBody($type . ' soumis par ' . S::user()->login() . ' via le web');
            $mailer->addUploadAttachment($upload, $type . '.mail');
            $mailer->send();
            $page->trigSuccess('Le message a été transmis à ' . $box);
            $upload->clear();
        }
    }

    function handler_send(&$page)
    {
        $page->changeTpl('emails/send.tpl');
        $page->addJsLink('ajax.js');

        $page->setTitle('Envoyer un email');

        // action si on recoit un formulaire
        if (Post::has('save')) {
            if (!S::has_xsrf_token()) {
                return PL_FORBIDDEN;
            }

            unset($_POST['save']);
            if (trim(preg_replace('/-- .*/', '', Post::v('contenu'))) != "") {
                $_POST['to_contacts'] = explode(';', @$_POST['to_contacts']);
                $_POST['cc_contacts'] = explode(';', @$_POST['cc_contacts']);
                $data = serialize($_POST);
                XDB::execute("REPLACE INTO  email_send_save
                                    VALUES  ({?}, {?})", S::i('uid'), $data);
            }
            exit;
        } else if (Env::v('submit') == 'Envoyer') {
            S::assert_xsrf_token();

            function getEmails($aliases)
            {
                if (!is_array($aliases)) {
                    return null;
                }
                $rel = Env::v('contacts');
                $ret = array();
                foreach ($aliases as $alias) {
                    $ret[$alias] = $rel[$alias];
                }
                return join(', ', $ret);
            }

            $error = false;
            foreach ($_FILES as &$file) {
                if ($file['name'] && !PlUpload::get($file, S::user()->login(), 'emails.send', false)) {
                    $page->trigError(PlUpload::$lastError);
                    $error = true;
                    break;
                }
            }

            if (!$error) {
                XDB::execute("DELETE FROM  email_send_save
                                    WHERE  uid = {?}", S::i('uid'));

                $to2  = getEmails(Env::v('to_contacts'));
                $cc2  = getEmails(Env::v('cc_contacts'));
                $txt  = str_replace('^M', '', Env::v('contenu'));
                $to   = Env::v('to');
                $subj = Env::v('sujet');
                $from = Env::v('from');
                $cc   = trim(Env::v('cc'));
                $bcc  = trim(Env::v('bcc'));

                if (empty($to) && empty($cc) && empty($to2) && empty($bcc) && empty($cc2)) {
                    $page->trigError("Indique au moins un destinataire.");
                    $page->assign('uploaded_f', PlUpload::listFilenames(S::user()->login(), 'emails.send'));
                } else {
                    $mymail = new PlMailer();
                    $mymail->setFrom($from);
                    $mymail->setSubject($subj);
                    if (!empty($to))  { $mymail->addTo($to); }
                    if (!empty($cc))  { $mymail->addCc($cc); }
                    if (!empty($bcc)) { $mymail->addBcc($bcc); }
                    if (!empty($to2)) { $mymail->addTo($to2); }
                    if (!empty($cc2)) { $mymail->addCc($cc2); }
                    $files =& PlUpload::listFiles(S::user()->login(), 'emails.send');
                    foreach ($files as $name=>&$upload) {
                        $mymail->addUploadAttachment($upload, $name);
                    }
                    if (Env::v('nowiki')) {
                        $mymail->setTxtBody(wordwrap($txt, 78, "\n"));
                    } else {
                        $mymail->setWikiBody($txt);
                    }
                    if ($mymail->send()) {
                        $page->trigSuccess("Ton email a bien été envoyé.");
                        $_REQUEST = array('bcc' => S::user()->bestEmail());
                        PlUpload::clear(S::user()->login(), 'emails.send');
                    } else {
                        $page->trigError("Erreur lors de l'envoi du courriel, réessaye.");
                        $page->assign('uploaded_f', PlUpload::listFilenames(S::user()->login(), 'emails.send'));
                    }
                }
            }
        } else {
            $res = XDB::query("SELECT  data
                                 FROM  email_send_save
                                WHERE  uid = {?}", S::i('uid'));
            if ($res->numRows() == 0) {
                PlUpload::clear(S::user()->login(), 'emails.send');
                $_REQUEST['bcc'] = S::user()->bestEmail();
            } else {
                $data = unserialize($res->fetchOneCell());
                $_REQUEST = array_merge($_REQUEST, $data);
            }
        }

        $res = XDB::query(
                "SELECT  u.prenom, u.nom, u.promo, a.alias as forlife
                   FROM  auth_user_md5 AS u
             INNER JOIN  contacts      AS c ON (u.user_id = c.contact)
             INNER JOIN  aliases       AS a ON (u.user_id=a.id AND FIND_IN_SET('bestalias',a.flags))
                  WHERE  c.uid = {?}
                 ORDER BY u.nom, u.prenom", S::v('uid'));
        $page->assign('contacts', $res->fetchAllAssoc());
        $page->assign('maxsize', ini_get('upload_max_filesize') . 'o');
        $page->assign('user', S::user());
    }

    function handler_test(&$page, $hruid = null)
    {
        require_once 'emails.inc.php';

        if (!S::has_xsrf_token()) {
            return PL_FORBIDDEN;
        }

        // Retrieves the User object for the test email recipient.
        if (S::admin() && $hruid) {
            $user = User::getSilent($hruid);
        } else {
            $user = S::user();
        }
        if (!$user) {
            return PL_NOT_FOUND;
        }

        // Sends the test email.
        $redirect = new Redirect($user);

        $mailer = new PlMailer('emails/test.mail.tpl');
        $mailer->assign('email', $user->bestEmail());
        $mailer->assign('redirects', $redirect->active_emails());
        $mailer->assign('display_name', $user->displayName());
        $mailer->assign('sexe', $user->isFemale());
        $mailer->send($user->isEmailFormatHtml());
        exit;
    }

    function handler_rewrite_in(&$page, $mail, $hash)
    {
        $page->changeTpl('emails/rewrite.tpl');
        $page->assign('option', 'in');
        if (empty($mail) || empty($hash)) {
            return PL_NOT_FOUND;
        }
        $pos = strrpos($mail, '_');
        if ($pos === false) {
            return PL_NOT_FOUND;
        }
        $mail{$pos} = '@';
        $res = XDB::query("SELECT  COUNT(*)
                             FROM  emails
                            WHERE  email = {?} AND hash = {?}",
                          $mail, $hash);
        $count = intval($res->fetchOneCell());
        if ($count > 0) {
            XDB::query("UPDATE  emails
                           SET  allow_rewrite = true, hash = NULL
                         WHERE  email = {?} AND hash = {?}",
                         $mail, $hash);
            $page->trigSuccess("Réécriture activée pour l'adresse " . $mail);
            return;
        }
        return PL_NOT_FOUND;
    }

    function handler_rewrite_out(&$page, $mail, $hash)
    {
        $page->changeTpl('emails/rewrite.tpl');
        $page->assign('option', 'out');
        if (empty($mail) || empty($hash)) {
            return PL_NOT_FOUND;
        }
        $pos = strrpos($mail, '_');
        if ($pos === false) {
            return PL_NOT_FOUND;
        }
        $mail{$pos} = '@';
        $res = XDB::query("SELECT  COUNT(*)
                             FROM  emails
                            WHERE  email = {?} AND hash = {?}",
                          $mail, $hash);
        $count = intval($res->fetchOneCell());
        if ($count > 0) {
            global $globals;
            $res = XDB::query("SELECT  e.email, e.rewrite, a.alias
                                 FROM  emails AS e
                           INNER JOIN  aliases AS a ON (a.id = e.uid AND a.type = 'a_vie')
                                WHERE  e.email = {?} AND e.hash = {?}",
                              $mail, $hash);
            XDB::query("UPDATE  emails
                           SET  allow_rewrite = false, hash = NULL
                         WHERE  email = {?} AND hash = {?}",
                        $mail, $hash);
            list($mail, $rewrite, $forlife) = $res->fetchOneRow();
            $mail = new PlMailer();
            $mail->setFrom("webmaster@" . $globals->mail->domain);
            $mail->addTo("support@" .  $globals->mail->domain);
            $mail->setSubject("Tentative de détournement de correspondance via le rewrite");
            $mail->setTxtBody("$forlife a tenté un rewrite de $mail vers $rewrite. Cette demande a été rejetée via le web");
            $mail->send();
            $page->trigWarning("Un mail d'alerte a été envoyé à l'équipe de " . $globals->core->sitename);
            return;
        }
        return PL_NOT_FOUND;
    }

    function handler_imap_in(&$page, $hash = null, $login = null)
    {
        $page->changeTpl('emails/imap_register.tpl');
        $user = null;
        if (!empty($hash) || !empty($login)) {
            $user = User::getSilent($login);
            if ($user) {
                $req = XDB::query("SELECT 1 FROM newsletter_ins WHERE user_id = {?} AND hash = {?}", $user->id(), $hash);
                if ($req->numRows() == 0) {
                    $user = null;
                }
            }
        }

        require_once('emails.inc.php');
        $page->assign('ok', false);
        if (S::logged() && (is_null($user) || $user->id() == S::i('uid'))) {
            $storage = new EmailStorage(S::user(), 'imap');
            $storage->activate();
            $page->assign('ok', true);
            $page->assign('prenom', S::v('prenom'));
            $page->assign('sexe', S::v('femme'));
        } else if (!S::logged() && $user) {
            $storage = new EmailStorage($user, 'imap');
            $storage->activate();
            $page->assign('ok', true);
            $page->assign('prenom', $user->displayName());
            $page->assign('sexe', $user->isFemale());
        }
    }

    function handler_broken(&$page, $warn = null, $email = null)
    {
        require_once 'emails.inc.php';
        $wp = new PlWikiPage('Xorg.PatteCassée');
        $wp->buildCache();

        global $globals;

        $page->changeTpl('emails/broken.tpl');

        if ($warn == 'warn' && $email) {
            S::assert_xsrf_token();

            $email = valide_email($email);
            // vérifications d'usage
            $sel = XDB::query("SELECT uid FROM emails WHERE email = {?}", $email);
            if (($uid = $sel->fetchOneCell())) {
                $dest = User::getSilent($uid);

                // envoi du mail
                $message = "Bonjour !

Cet email a été généré automatiquement par le service de patte cassée de
Polytechnique.org car un autre utilisateur, " . S::user()->fullName() . ",
nous a signalé qu'en t'envoyant un email, il avait reçu un message d'erreur
indiquant que ton adresse de redirection $email
ne fonctionnait plus !

Nous te suggérons de vérifier cette adresse, et le cas échéant de mettre
à jour sur le site <{$globals->baseurl}/emails> tes adresses
de redirection...

Pour plus de renseignements sur le service de patte cassée, n'hésite pas à
consulter la page <{$globals->baseurl}/emails/broken>.


À bientôt sur Polytechnique.org !
L'équipe d'administration <support@" . $globals->mail->domain . '>';

                $mail = new PlMailer();
                $mail->setFrom('"Polytechnique.org" <support@' . $globals->mail->domain . '>');
                $mail->addTo($dest->bestEmail());
                $mail->setSubject("Une de tes adresse de redirection Polytechnique.org ne marche plus !!");
                $mail->setTxtBody($message);
                $mail->send();
                $page->trigSuccess('Email envoyé&nbsp;!');
            }
        } elseif (Post::has('email')) {
            S::assert_xsrf_token();

            $email = valide_email(Post::v('email'));

            list(,$fqdn) = explode('@', $email);
            $fqdn = strtolower($fqdn);
            if ($fqdn == 'polytechnique.org' || $fqdn == 'melix.org' ||  $fqdn == 'm4x.org' || $fqdn == 'melix.net') {
                $page->assign('neuneu', true);
            } else {
                $page->assign('email',$email);
                $sel = XDB::query(
                        "SELECT  e1.uid, e1.panne != 0 AS panne,
                                 (count(e2.uid) + IF(FIND_IN_SET('googleapps', u.mail_storage), 1, 0)) AS nb_mails,
                                 u.nom, u.prenom, u.promo, u.hruid
                           FROM  emails as e1
                      LEFT JOIN  emails as e2 ON(e1.uid = e2.uid
                                                 AND FIND_IN_SET('active', e2.flags)
                                                 AND e1.email != e2.email)
                     INNER JOIN  auth_user_md5 as u ON(e1.uid = u.user_id)
                          WHERE  e1.email = {?}
                       GROUP BY  e1.uid", $email);
                if ($x = $sel->fetchOneAssoc()) {
                    // on écrit dans la base que l'adresse est cassée
                    if (!$x['panne']) {
                        XDB::execute("UPDATE emails
                                         SET panne=NOW(),
                                             last=NOW(),
                                             panne_level = 1
                                       WHERE email = {?}", $email);
                    } else {
                        XDB::execute("UPDATE emails
                                         SET panne_level = 1
                                       WHERE email = {?} AND panne_level = 0", $email);
                    }
                    $page->assign_by_ref('x', $x);
                }
            }
        }
    }

    function handler_duplicated(&$page, $action = 'list', $email = null)
    {
        $page->changeTpl('emails/duplicated.tpl');

        $states = array('pending'   => 'En attente...',
                        'safe'      => 'Pas d\'inquiétude',
                        'unsafe'    => 'Recherches en cours',
                        'dangerous' => 'Usurpations par cette adresse');
        $page->assign('states', $states);

        if (Post::has('action')) {
            S::assert_xsrf_token();
        }
        switch (Post::v('action')) {
          case 'create':
            if (trim(Post::v('emailN')) != '') {
                Xdb::execute('INSERT IGNORE INTO emails_watch (email, state, detection, last, uid, description)
                                          VALUES ({?}, {?}, CURDATE(), NOW(), {?}, {?})',
                             trim(Post::v('emailN')), Post::v('stateN'), S::i('uid'), Post::v('descriptionN'));
            };
            break;

          case 'edit':
            Xdb::execute('UPDATE emails_watch
                             SET state = {?}, last = NOW(), uid = {?}, description = {?}
                           WHERE email = {?}', Post::v('stateN'), S::i('uid'), Post::v('descriptionN'), Post::v('emailN'));
            break;

          default:
            if ($action == 'delete' && !is_null($email)) {
                Xdb::execute('DELETE FROM emails_watch WHERE email = {?}', $email);
            }
        }
        if ($action != 'create' && $action != 'edit') {
            $action = 'list';
        }
        $page->assign('action', $action);

        if ($action == 'list') {
            $sql = "SELECT  w.email, w.detection, w.state, a.alias AS forlife
                      FROM  emails_watch  AS w
                 LEFT JOIN  emails        AS e USING(email)
                 LEFT JOIN  aliases       AS a ON (a.id = e.uid AND a.type = 'a_vie')
                  ORDER BY  w.state, w.email, a.alias";
            $it = Xdb::iterRow($sql);

            $table = array();
            $props = array();
            while (list($email, $date, $state, $forlife) = $it->next()) {
                if (count($props) == 0 || $props['mail'] != $email) {
                    if (count($props) > 0) {
                        $table[] = $props;
                    }
                    $props = array('mail' => $email,
                                   'detection' => $date,
                                   'state' => $state,
                                   'users' => array($forlife));
                } else {
                    $props['users'][] = $forlife;
                }
            }
            if (count($props) > 0) {
                $table[] = $props;
            }
            $page->assign('table', $table);
        } elseif ($action == 'edit') {
            $sql = "SELECT  w.detection, w.state, w.last, w.description,
                            a1.alias AS edit, a2.alias AS forlife
                      FROM  emails_watch AS w
                 LEFT JOIN  aliases      AS a1 ON (a1.id = w.uid AND a1.type = 'a_vie')
                 LEFT JOIN  emails       AS e  ON (w.email = e.email)
                 LEFT JOIN  aliases      AS a2 ON (a2.id = e.uid AND a2.type = 'a_vie')
                     WHERE  w.email = {?}
                  ORDER BY  a2.alias";
            $it = Xdb::iterRow($sql, $email);

            $props = array();
            while (list($detection, $state, $last, $description, $edit, $forlife) = $it->next()) {
                if (count($props) == 0) {
                    $props = array('mail'        => $email,
                                   'detection'   => $detection,
                                   'state'       => $state,
                                   'last'        => $last,
                                   'description' => $description,
                                   'edit'        => $edit,
                                   'users'       => array($forlife));
                } else {
                    $props['users'][] = $forlife;
                }
            }
            $page->assign('doublon', $props);
        }
    }

    function handler_lost(&$page, $action = 'list', $email = null)
    {
        $page->changeTpl('emails/lost.tpl');

        $page->assign('lost_emails', XDB::iterator("
            SELECT  u.user_id, u.hruid
              FROM  auth_user_md5 AS u
         LEFT JOIN  emails        AS e ON (u.user_id = e.uid AND FIND_IN_SET('active', e.flags))
             WHERE  e.uid IS NULL AND FIND_IN_SET('googleapps', u.mail_storage) = 0 AND
                    u.deces = 0 AND u.perms IN ('user', 'admin', 'disabled')
          ORDER BY  u.promo DESC, u.nom, u.prenom"));
    }

    function handler_broken_addr(&$page)
    {
        require_once 'emails.inc.php';
        $page->changeTpl('emails/broken_addr.tpl');

        if (Env::has('sort_broken')) {
            S::assert_xsrf_token();

            $list = trim(Env::v('list'));
            if ($list == '') {
                $page->trigError('La liste est vide.');
            } else {
                $valid_emails = array();
                $invalid_emails = array();
                $broken_list = explode("\n", $list);
                sort($broken_list);
                foreach ($broken_list as $orig_email) {
                    $email = valide_email(trim($orig_email));
                    if (empty($email) || $email == '@') {
                        $invalid_emails[] = trim($orig_email) . ': invalid email';
                    } elseif (!in_array($email, $valid_emails)) {
                        $res = XDB::query('SELECT  COUNT(*)
                                             FROM  emails
                                            WHERE  email = {?}', $email);
                        if ($res->fetchOneCell() > 0) {
                            $valid_emails[] = $email;
                        } else {
                            $invalid_emails[] = "$orig_email: no such redirection";
                        }
                    }
                }

                $page->assign('valid_emails', $valid_emails);
                $page->assign('invalid_emails', $invalid_emails);
            }
        }

        if (Env::has('process_broken')) {
            S::assert_xsrf_token();

            $list = trim(Env::v('list'));
            if ($list == '') {
                $page->trigError('La liste est vide.');
            } else {
                global $platal;

                $broken_user_list = array();
                $broken_list = explode("\n", $list);
                sort($broken_list);
                foreach ($broken_list as $orig_email) {
                    $email = valide_email(trim($orig_email));
                    if (empty($email) || $email == '@') {
                        continue;
                    }

                    $sel = XDB::query(
                        "SELECT  e1.uid, e1.panne != 0 AS panne, count(e2.uid) AS nb_mails,
                                 u.nom, u.prenom, u.promo, a.alias
                           FROM  emails        AS e1
                      LEFT JOIN  emails        AS e2 ON (e1.uid = e2.uid AND FIND_IN_SET('active', e2.flags)
                                                         AND e1.email != e2.email)
                     INNER JOIN  auth_user_md5 AS u  ON (e1.uid = u.user_id)
                     INNER JOIN  aliases       AS a  ON (u.user_id = a.id AND FIND_IN_SET('bestalias', a.flags))
                          WHERE  e1.email = {?}
                       GROUP BY  e1.uid", $email);

                    if ($x = $sel->fetchOneAssoc()) {
                        if (!$x['panne']) {
                            XDB::execute('UPDATE  emails
                                             SET  panne=NOW(), last=NOW(), panne_level = 1
                                           WHERE  email = {?}',
                                          $email);
                        } else {
                            XDB::execute('UPDATE  emails
                                             SET  last = CURDATE(), panne_level = panne_level + 1
                                           WHERE  email = {?}
                                                  AND DATE_ADD(last, INTERVAL 14 DAY) < CURDATE()',
                                         $email);
                        }

                        if (!empty($x['nb_mails'])) {
                            $mail = new PlMailer('emails/broken.mail.tpl');
                            $mail->addTo("\"{$x['prenom']} {$x['nom']}\" <{$x['alias']}@"
                                         . $globals->mail->domain . '>');
                            $mail->assign('x', $x);
                            $mail->assign('email', $email);
                            $mail->send();
                        }

                        if (!isset($broken_user_list[$x['alias']])) {
                            $broken_user_list[$x['alias']] = array($email);
                        } else {
                            $broken_user_list[$x['alias']][] = $email;
                        }
                    }
                }

                XDB::execute("UPDATE  emails
                                 SET  panne_level = panne_level - 1
                               WHERE  flags = 'active' AND panne_level > 1
                                      AND DATE_ADD(last, INTERVAL 1 MONTH) < CURDATE()");
                XDB::execute("UPDATE  emails
                                 SET  panne_level = 0
                               WHERE  flags = 'active' AND panne_level = 1
                                      AND DATE_ADD(last, INTERVAL 1 YEAR) < CURDATE()");

                // Output the list of users with recently broken addresses,
                // along with the count of valid redirections.
                require_once 'include/notifs.inc.php';
                pl_content_headers("text/x-csv");

                $csv = fopen('php://output', 'w');
                fputcsv($csv, array('nom', 'prenom', 'promo', 'alias', 'bounce', 'nbmails', 'url'), ';');
                foreach ($broken_user_list as $alias => $mails) {
                    $sel = Xdb::query(
                        "SELECT  u.user_id, count(e.email) AS nb_mails, u.nom, u.prenom, u.promo
                           FROM  aliases       AS a
                     INNER JOIN  auth_user_md5 AS u ON a.id = u.user_id
                      LEFT JOIN  emails        AS e ON (e.uid = u.user_id
                                                        AND FIND_IN_SET('active', e.flags) AND e.panne = 0)
                          WHERE  a.alias = {?}
                       GROUP BY  u.user_id", $alias);

                    if ($x = $sel->fetchOneAssoc()) {
                        if ($x['nb_mails'] == 0) {
                            register_profile_update($x['user_id'], 'broken');
                        }
                        fputcsv($csv, array($x['nom'], $x['prenom'], $x['promo'], $alias,
                                            join(',', $mails), $x['nb_mails'],
                                            'https://www.polytechnique.org/marketing/broken/' . $alias), ';');
                    }
                }
                fclose($csv);
                exit;
            }
        }
    }
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
