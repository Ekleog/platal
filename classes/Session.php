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

require_once 'diogenes/diogenes.misc.inc.php';
require_once 'diogenes/diogenes.core.logger.inc.php';

class Session
{
    function init()
    {
        @session_start();
        if (empty($_SESSION['challenge'])) {
            $_SESSION['challenge'] = sha1(uniqid(rand(), true));
        }
    }

    function destroy()
    {
        @session_destroy();
        unset($_SESSION);
    }



    function has($key)
    {
        return isset($_SESSION[$key]);
    }

    function kill($key)
    {
        unset($_SESSION[$key]);
    }

    function v($key, $default = null)
    {
        return isset($_SESSION[$key]) ? $_SESSION[$key] : $default;
    }


    function has_perms()
    {
        return Session::logged() && Session::v('perms') == PERMS_ADMIN;
    }

    function logged()
    {
        return Session::v('auth', AUTH_PUBLIC) >= AUTH_COOKIE;
    }

    function identified()
    {
        return Session::v('auth', AUTH_PUBLIC) >= AUTH_MDP;
    }
}

class S extends Session { }

// {{{ function check_perms()

/** verifie si un utilisateur a les droits pour voir une page
 ** si ce n'est pas le cas, on affiche une erreur
 * @return void
 */
function check_perms()
{
    global $page;
    if (!S::has_perms()) {
        if ($_SESSION['log']) {
            $_SESSION['log']->log("noperms",$_SERVER['PHP_SELF']);
        }
	$page->kill("Tu n'as pas les permissions nécessaires pour accéder à cette page.");
    }
}

// }}}

?>
