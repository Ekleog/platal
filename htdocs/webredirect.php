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
new_skinned_page('webredirect.tpl', AUTH_MDP);

$log =& Session::getMixed('log');
$url = Env::get('url');

if ((Env::get('submit') == 'Valider' or Env::get('submit') == 'Modifier') and Env::has('url')) {
    // on change la redirection (attention � http://)
    $globals->db->query("update auth_user_quick set redirecturl = '$url' where user_id = ".Session::getInt('uid'));
    if (mysql_errno() == 0) {
        $log->log('carva_add', 'http://'.Env::get('url'));
        $page->trig("Redirection activ�e vers <a href='http://$url'>$url</a>");
    } else {
        $page->trig('Erreur de mise � jour');
    }
} elseif (Env::get('submit') == "Supprimer") {
    // on supprime la redirection
    $globals->db->query("update auth_user_quick set redirecturl = '' where user_id = ".Session::getInt('uid'));
    if (mysql_errno() == 0) {
        $log->log("carva_del", $url);
        Post::kil('url');
        $page->trig('Redirection supprim�e');
    } else {
        $page->trig('Erreur de suppression');
    }
}


$result      = $globals->db->query("select redirecturl from auth_user_quick where user_id = ".Session::getInt('uid'));
list($carva) = mysql_fetch_row($result);
mysql_free_result($result);
$page->assign('carva', $carva);

$page->run();
?>
