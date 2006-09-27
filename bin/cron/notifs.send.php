#!/usr/bin/php4 -q
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

require_once('./connect.db.inc.php');
require_once("../../include/notifs.inc.php");
require_once("diogenes/diogenes.hermes.inc.php");

$all = new AllNotifs();

foreach($all->_data as $u) {
    $week   = date("W - Y");

    $text =  "  ".($u['sexe'] ? 'Ch�re' : 'Cher')." {$u['prenom']},\n\n"
          .  "  Voici les �v�nements survenus dans la semaine �coul�e,\n"
          .  "et depuis ta derni�re visite sur le site.\n\n"
          .  "Tu trouveras les m�mes informations sur la page :\n"
          .  "    https://www.polytechnique.org/carnet/panel\n\n"
          .  "------------------------------------------------------------------------\n\n";

    $html  = <<<EOF
<html>
  <head>
    <title>Notifications de la semaine $week</title>
  </head>
  <body>
    <p>Voici les �v�nements survenus dans la semaine �coul�e, et depuis ta derni�re visite sur le site.</p>
    <p>Tu trouveras les m�mes informations sur <a href='https://www.polytechnique.org/carnet/panel'>cette page</a></p>
EOF;

    foreach($u['data'] as $cid=>$d) {
        $text .= "  {$all->_cats[$cid][(count($d)==1)?'mail_sg':'mail']} :\n\n";
        $html .= "<h1 style='font-size: 120%'>{$all->_cats[$cid][(count($d)==1)?'mail_sg':'mail']} :</h1>\n<ul>\n";

        foreach($d as $promo=>$x) {
            require_once('../../plugins/modifier.date_format.php');
            $date  = smarty_modifier_date_format($x['date'], '%d %b %Y');
            $text .= "    - (X{$x['promo']}) {$x['prenom']} {$x['nom']} le $date\n";
            $text .= "      https://www.polytechnique.org/profile/{$x['bestalias']}?force_login=1\n\n";
            $html .= "<li>(X{$x['promo']}) <a href='https://www.polytechnique.org/profile/{$x['bestalias']}?force_login=1'>{$x['prenom']} {$x['nom']}</a> le $date</li>\n";
        }
        $text .= "\n";
        $html .= "</ul>\n";
    }

    $text .= "-- \n"
           . "L'�quipe de Polytechnique.org\n\n"
           . "------------------------------------------------------------------------\n\n"
           . "Tu recois ce mail car tu as activ� la notification automatique \n"
           . "par mail des �v�nements que tu surveilles.\n\n"
           . "Tu peux changer cette option sur :\n"
           . "    https://www.polytechnique.org/carnet/notifs";
    $html .= <<<EOF
    <hr />
    <p>L'�quipe de Polytechnique.org</p>
    <br />
    <p>
    Tu recois ce mail car tu as activ� la notification automatique par mail des �v�nements que tu surveilles.
    </p>
    <p>Tu peux changer cette option sur la <a href="https://www.polytechnique.org/carnet/notifs">page
    de configuration des notifications</a>
    </p>
  </body>
</html>
EOF;
    
    $mailer = new HermesMailer();
    $mailer->setFrom("Carnet Polytechnicien <support_carnet@polytechnique.org>");
    $mailer->addTo("\"{$u['prenom']} {$u['nom']}\" <{$u['bestalias']}@polytechnique.org>");
    $mailer->setSubject("Notifications de la semaine $week");
    $mailer->setTxtBody($text);
    if ($u['mail_fmt'] == 'html') { $mailer->setHtmlBody($html); }
    $mailer->send();
}

?>
