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

function set_new_usage($uid, $usage, $alias=false) { 
    global $globals;

    $globals->xdb->execute("UPDATE auth_user_md5 set nom_usage={?} WHERE user_id={?}",$usage ,$uid);
    $globals->xdb->execute("DELETE FROM aliases WHERE FIND_IN_SET('usage',flags) AND id={?}", $uid);
    if ($alias && $usage) {
        $globals->xdb->execute("UPDATE aliases SET flags=flags & 255-1 WHERE id={?}", $uid);
        $globals->xdb->execute("INSERT INTO aliases VALUES({?}, 'alias', 'usage,bestalias', {?}, null)",
            $alias, $uid);
    }
    $r = $globals->xdb->query("SELECT alias FROM aliases WHERE FIND_IN_SET('bestalias', flags) AND id = {?}", $uid);
    if ($r->fetchOneCell() == "") {
        $globals->xdb->execute("UPDATE aliases SET flags = 1 | flags WHERE id = {?} LIMIT 1", $uid);
    }
    require_once 'user.func.inc.php';
    user_reindex($uid);
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker:
?>