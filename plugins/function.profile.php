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

function smarty_function_profile($params, &$smarty)
{
    $params = new PlDict($params);
    $with_promo = $params->b('promo', false);
    $with_sex   = $params->b('sex', true);
    $with_link  = $params->b('link', true);
    $with_groupperms = $params->b('groupperms', true);
    $user = $params->v('user');
    if (is_int($user) || ctype_digit($user)) {
        $user = User::getWithUID($user);
    }

    $name = pl_entities($user->fullName());
    if ($with_sex && $user->isFemale()) {
        $name = '&bull;' . $name;
    }
    if ($with_promo) {
        $promo = $user->promo();
        if ($promo) {
            $name .= ' (' . pl_entities($promo) . ')';
        }
    }
    if ($with_link) {
        $profile = ($user instanceof Profile) ? $user : $user->profile();
        if ($profile) {
            $name = '<a href="profile/' . $profile->hrid() . '" class="popup2">' . $name . '</a>';
        }
    }
    if ($with_groupperms && $user instanceof User && $user->group_perms == 'admin') {
        $name = '<strong>' . $name . '</strong>';
    }
    return $name;
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>