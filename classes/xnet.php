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

class Xnet extends Platal
{
    public function __construct()
    {
        $modules = func_get_args();
        parent::__construct($modules);

        global $globals;
        if ($globals->asso()) {
            if ($p = strpos($this->path, '/')) {
                $this->ns   = substr($this->path, 0, $p).'/';
                $this->path = '%grp'.substr($this->path, $p);
            } else {
                $this->ns   = $this->path.'/';
                $this->path = '%grp';
            }
        }
    }

    protected function find_nearest_key($key, array &$array)
    {
        global $globals;
        if (in_array('%grp', array_keys($array)) &&  $key == $globals->asso('diminutif')) {
            return '%grp';
        }
        return parent::find_nearest_key($key, $array);
    }

    public function near_hook()
    {
        global $globals;
        $link = str_replace('%grp', $globals->asso('diminutif'), parent::near_hook());
        if ($link != $this->path) {
            return $link;
        }
        return null;
    }

    public function pl_self($n = null)
    {
        global $globals;
        return str_replace('%grp', $globals->asso('diminutif'), parent::pl_self($n));
    }

    protected function find_hook()
    {
        $ans = parent::find_hook();
        $this->https = false;
        if ($ans && $this->ns) {
            $this->path    = $this->ns . substr($this->path, 5);
            $this->argv[0] = $this->ns . substr($this->argv[0], 5);
        }
        return $ans;
    }

    public function force_login(PlPage &$page)
    {
        http_redirect(S::v('loginX'));
    }
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
