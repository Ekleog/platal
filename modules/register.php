<?php
/***************************************************************************
 *  Copyright (C) 2003-2006 Polytechnique.org                              *
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

class RegisterModule extends PLModule
{
    function handlers()
    {
        return array(
            'register'         => $this->make_hook('register', AUTH_PUB),
            'register/end'     => $this->make_hook('end',      AUTH_PUB),
            'register/success' => $this->make_hook('success',  AUTH_MDP),
        );
    }

    function handler_register(&$page)
    {
        global $globals;

        $sub_state = Session::getMixed('sub_state', Array());
        if (!isset($sub_state['step'])) {
            $sub_state['step'] = 0;
        }
        if (Get::has('back') && Get::getInt('back') < $sub_state['step']) {
            $sub_state['step'] = max(0,Get::getInt('back'));
        }

        if (Env::has('hash')) {
            $res = $globals->xdb->query(
                    "SELECT  m.uid, u.promo, u.nom, u.prenom, u.matricule
                       FROM  register_marketing AS m
                 INNER JOIN  auth_user_md5      AS u ON u.user_id = m.uid
                      WHERE  m.hash={?}", Env::get('hash'));
            if (list($uid, $promo, $nom, $prenom, $ourmat) = $res->fetchOneRow()) {
                $sub_state['uid']    = $uid;
                $sub_state['hash']   = Env::get('hash');
                $sub_state['promo']  = $promo;
                $sub_state['nom']    = $nom;
                $sub_state['prenom'] = $prenom;
                $sub_state['ourmat'] = $ourmat;

                $globals->xdb->execute(
                        "REPLACE INTO  register_mstats (uid,sender,success)
                               SELECT  m.uid, m.sender, 0
                                 FROM  register_marketing AS m
                                WHERE  m.hash", $sub_state['hash']);
            }
        }

        switch ($sub_state['step']) {
            case 0:
                if (Post::has('step1')) {
                    $sub_state['step'] = 1;
                    if (isset($sub_state['hash'])) {
                        $sub_state['step'] = 3;
                        require_once('register.inc.php');
                        create_aliases($sub_state);
                    }
                }
                break;

            case 1:
                if (Post::has('promo')) {
                    $promo = Post::getInt('promo');
                    if ($promo < 1900 || $promo > date('Y')) {
                        $err = "La promotion saisie est incorrecte !";
                    } else {
                        $sub_state['step']  = 2;
                        $sub_state['promo'] = $promo;
                        if ($promo >= 1996 && $promo<2000) {
                            $sub_state['mat'] = ($promo % 100)*10 . '???';
                        } elseif($promo >= 2000) {
                            $sub_state['mat'] = 100 + ($promo % 100) . '???';
                        }
                    }
                }
                break;

            case 2:
                if (count($_POST)) {
                    require_once('register.inc.php');
                    $sub_state['prenom'] = Post::get('prenom');
                    $sub_state['nom']    = Post::get('nom');
                    $sub_state['mat']    = Post::get('mat');
                    $err = check_new_user($sub_state);

                    if ($err !== true) { break; }
                    $err = create_aliases($sub_state);
                    if ($err === true) {
                        unset($err);
                        $sub_state['step'] = 3;
                    }
                }
                break;

            case 3:
                if (count($_POST)) {
                    require_once('register.inc.php');
                    if (!isvalid_email(Post::get('email'))) {
                        $err[] = "Le champ 'E-mail' n'est pas valide.";
                    } elseif (!isvalid_email_redirection(Post::get('email'))) {
                        $err[] = $sub_state['forlife']." doit renvoyer vers un email existant ".
                            "valide, en particulier, il ne peut pas être renvoyé vers lui-même.";
                    }
                    if (!preg_match('/^[0-3][0-9][01][0-9][12][90][0-9][0-9]$/',
                                    Post::get('naissance')))
                    {
                        $err[] = "La 'Date de naissance' n'est pas correcte.";
                    }

                    if (isset($err)) {
                        $err = join('<br />', $err);
                    } else {
                        $birth = Env::get('naissance');
                        $sub_state['naissance'] = sprintf("%s-%s-%s",
                                                          substr($birth,4,4),
                                                          substr($birth,2,2),
                                                          substr($birth,0,2));
                        $sub_state['email']     = Post::get('email');
                        $sub_state['step']      = 4;
                        finish_ins($sub_state);
                    }
                }
                break;
        }

        $_SESSION['sub_state'] = $sub_state;
        $page->changeTpl('register/step'.intval($sub_state['step']).'.tpl');
        if (isset($err)) {
            $page->trig($err);
        }

        return PL_OK;
    }

    function handler_end(&$page, $hash = null)
    {
        global $globals;

        $page->changeTpl('register/end.tpl');

        require_once('user.func.inc.php');

        if ($hash) {
            $res = $globals->xdb->query(
                    "SELECT  r.uid, r.forlife, r.bestalias, r.mailorg2,
                             r.password, r.email, r.naissance, u.nom, u.prenom,
                             u.promo, u.flags
                       FROM  register_pending AS r
                 INNER JOIN  auth_user_md5    AS u ON r.uid = u.user_id
                      WHERE  hash={?} AND hash!='INSCRIT'", Env::get('hash'));
        }

        if (!$hash || !list($uid, $forlife, $bestalias, $mailorg2, $password, $email,
                            $naissance, $nom, $prenom, $promo, $femme) = $res->fetchOneRow())
        {
            $page->kill("<p>Cette adresse n'existe pas, ou plus, sur le serveur.</p>
                         <p>Causes probables :</p>
                         <ol>
                           <li>Vérifie que tu visites l'adresse du dernier
                               e-mail reçu s'il y en a eu plusieurs.</li>
                           <li>Tu as peut-être mal copié l'adresse reçue par
                               mail, vérifie-la à la main.</li>
                           <li>Tu as peut-être attendu trop longtemps pour
                               confirmer.  Les pré-inscriptions sont annulées
                               tous les 30 jours.</li>
                           <li>Tu es en fait déjà inscrit.</li>
                        </ol>");
        }



        /***********************************************************/
        /****************** REALLY CREATE ACCOUNT ******************/
        /***********************************************************/

        $globals->xdb->execute('UPDATE  auth_user_md5
                                   SET  password={?}, perms="user",
                                        date=NOW(), naissance={?}, date_ins = NOW()
                                 WHERE  user_id={?}', $password, $naissance, $uid);
        $globals->xdb->execute('REPLACE INTO auth_user_quick (user_id) VALUES ({?})', $uid);
        $globals->xdb->execute('INSERT INTO aliases (id,alias,type)
                                     VALUES ({?}, {?}, "a_vie")', $uid,
                                     $forlife);
        $globals->xdb->execute('INSERT INTO aliases (id,alias,type,flags)
                                     VALUES ({?}, {?}, "alias", "bestalias")',
                                     $uid, $bestalias);
        if ($mailorg2) {
            $globals->xdb->execute('INSERT INTO aliases (id,alias,type)
                                         VALUES ({?}, {?}, "alias")', $uid,
                                         $mailorg2);
        }

        require_once('emails.inc.php');
        $redirect = new Redirect($uid);
        $redirect->add_email($email);

        // on cree un objet logger et on log l'inscription
        $logger = new DiogenesCoreLogger($uid);
        $logger->log('inscription', $email);

        $globals->xdb->execute('UPDATE register_pending SET hash="INSCRIT" WHERE uid={?}', $uid);

        $globals->hook->subscribe($forlife, $uid, $promo, $password);

        require_once('xorg.mailer.inc.php');
        $mymail = new XOrgMailer('register/inscription.reussie.tpl');
        $mymail->assign('forlife', $forlife);
        $mymail->assign('prenom', $prenom);
        $mymail->send();

        start_connexion($uid,false);
        $_SESSION['auth'] = AUTH_MDP;

        /***********************************************************/
        /************* envoi d'un mail au démarcheur ***************/
        /***********************************************************/
        $res = $globals->xdb->iterRow(
                "SELECT  DISTINCT sa.alias, IF(s.nom_usage,s.nom_usage,s.nom) AS nom,
                         s.prenom, s.flags AS femme
                   FROM  register_marketing AS m
             INNER JOIN  auth_user_md5      AS s  ON ( m.sender = s.user_id )
             INNER JOIN  aliases            AS sa ON ( sa.id = m.sender
                                                       AND FIND_IN_SET('bestalias', sa.flags) )
                  WHERE  m.uid = {?}", $uid);
        $globals->xdb->execute("UPDATE register_mstats SET success=NOW() WHERE uid={?}", $uid);

        while (list($salias, $snom, $sprenom, $sfemme) = $res->next()) {
            require_once('diogenes/diogenes.hermes.inc.php');
            $mymail = new HermesMailer();
            $mymail->setSubject("$prenom $nom s'est inscrit à Polytechnique.org !");
            $mymail->setFrom('"Marketing Polytechnique.org" <register@polytechnique.org>');
            $mymail->addTo("\"$sprenom $snom\" <$salias@{$globals->mail->domain}>");
            $msg = ($sfemme?'Cher':'Chère')." $sprenom,\n\n"
                 . "Nous t'écrivons pour t'informer que {$prenom} {$nom} (X{$promo}), "
                 . "que tu avais incité".($femme?'e':'')." à s'inscrire à Polytechnique.org, "
                 . "vient à l'instant de terminer son inscription.\n\n"
                 . "Merci de ta participation active à la reconnaissance de ce site !!!\n\n"
                 . "Bien cordialement,\n"
                 . "L'équipe Polytechnique.org";
            $mymail->setTxtBody(wordwrap($msg, 72));
            $mymail->send();
        }

        $globals->xdb->execute("DELETE FROM register_marketing WHERE uid = {?}", $uid);

        redirect('success.php');
        $page->assign('uid', $uid);

        return PL_OK;
    }

    function handler_success(&$page)
    {
        global $globals;

        $page->changeTpl('register/success.tpl');

        if (Env::has('response2'))  {
            $_SESSION['password'] = $password = Post::get('response2');

            $globals->xdb->execute('UPDATE auth_user_md5 SET password={?}
                                     WHERE user_id={?}', $password,
                                   Session::getInt('uid'));

            $log =& Session::getMixed('log');
            $log->log('passwd', '');

            if (Cookie::get('ORGaccess')) {
                require_once('secure_hash.inc.php');
                setcookie('ORGaccess', hash_encrypt($password), (time()+25920000), '/', '' ,0);
            }

            $page->assign('mdpok', true);
        }

        $page->addJsLink('javascript/motdepasse.js');

        return PL_OK;
    }
}

?>
