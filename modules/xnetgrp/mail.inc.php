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

// {{{ get_all_redirects

function get_all_redirects($membres, $mls, &$client)
{
    global $globals;

    $tos = array();

    // TODO: add more filters to choose users
    if (!empty($membres)) {
        $uf = new UserFilter(new UFC_Group($globals->asso('id')));
        $tos = $uf->getUsers();
    }

    foreach ($mls as $ml) {
        if (list(,$members) = $client->get_members($ml)) {
            foreach ($members as $mem) {
                $uf = new UserFilter(new UFC_Mail($mem[1]));
                $user = $uf->getUsers();
                if ($user) {
                    $tos[] = $user;
                } else {
                    $tos[] = $mem[1];
                }
            }
        }
    }

    return $tos;
}

// }}}
// {{{ _send_xnet_mail

function _send_xnet_mail($user, $body, $wiki, $mailer, $replyto = null)
{
    if ($user instanceof PlUser) {
        $cher = $user->isFemale() ? 'Chère' : 'Cher';
        $nom  = $user->displayName();
        $pnom = '';
    } else {
        $cher = 'Cher(e)';
        $nom  = $user;
        $pnom = '';
    }

    $text = str_ireplace(array('<cher>', '<nom>', '<prenom>'),
                         array($cher, $nom, $pnom), $body);
    $mailer->addTo($user);
    if ($replyto) {
        $mailer->addHeader('Reply-To', $replyto);
    }
    if ($wiki) {
        $mailer->setWikiBody($text);
    } else {
        $mailer->setTxtBody(wordwrap($text, 72));
    }
    $mailer->send();
}

// }}}
// {{{ send_xnet_mails

function send_xnet_mails($from, $sujet, $body, $wiki, $tos, $replyto = null, $upload = null, $name = null)
{
    global $globals;
    $sent = array();

    $mailer = new PlMailer();
    $mailer->setSubject($sujet);
    $mailer->setFrom($from);
    if ($upload && $upload->exists()) {
        $mailer->addUploadAttachment($upload, $name);
    }

    foreach ($tos as $user) {
        if ($user instanceof $user) {
            $email = $user->bestEmail();
        } else {
            $email = $user;
        }
        if ($sent[$email]) {
            continue;
        }
        _send_xnet_mail($user, $body, $wiki, $mailer, $replyto);
        $sent[$email] = true;
    }
}

// }}}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>