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

// {{{ class ListeReq

class ListeReq extends Validate
{
    // {{{ properties

    public $liste;
    public $desc;
    public $asso;
    public $domain;

    public $advertise;
    public $modlevel;
    public $inslevel;

    public $owners;
    public $members;

    public $rules = "Refuser les listes de binets si elles ne sont pas datées (oui : apv2002@, non : apv@).
        Refuser également des listes qui pourraient nous servir (admin, postmaster&hellip;)";
    // }}}
    // {{{ constructor

    public function __construct(User &$_user, $_asso, $_liste, $_domain, $_desc, $_advertise,
                                $_modlevel, $_inslevel, $_owners, $_members, $_stamp=0)
    {
        parent::__construct($_user, false, 'liste', $_stamp);

        $this->asso      = $_asso;
        $this->liste     = $_liste;
        $this->domain    = $_domain;
        $this->desc      = $_desc;
        $this->advertise = $_advertise;
        $this->modlevel  = $_modlevel;
        $this->inslevel  = $_inslevel;
        $this->owners    = $_owners;
        $this->members   = $_members;
    }

    // }}}
    // {{{ function formu()

    public function formu()
    {
        return 'include/form.valid.listes.tpl';
    }

    // }}}
    // {{{ function editor()

    public function editor()
    {
        return 'include/form.valid.edit-listes.tpl';
    }

    // }}}
    // {{{ function handle_editor()

    protected function handle_editor()
    {
        global $globals;

        if (Env::has('listname')) {
            $this->liste = trim(Env::v('listname'));
        }
        if (Env::has('domainname')) {
            $this->domain = trim(Env::v('domainname'));
        }
        if (Env::has('assotype')) {
            $this->asso = trim(Env::v('assotype'));
        }
        if (!$this->asso) {
            $this->domain = $globals->mail->domain;
        }
        return true;
    }

    // }}}
    // {{{ function _mail_subj

    protected function _mail_subj()
    {
        return "[Polytechnique.org/LISTES] Demande de la liste {$this->liste}@{$this->domain}";
    }

    // }}}
    // {{{ function _mail_body

    protected function _mail_body($isok)
    {
        if ($isok) {
            return "  Suite à ta demande de création de liste de diffusion, nous avons créé l'adresse {$this->liste}@{$this->domain}, qui est maintenant à ta disposition.";
        } else {
            return "  La demande que tu avais faite pour la liste de diffusion {$this->liste}@{$this->domain} a été refusée.";
        }
    }

    // }}}
    // {{{ function commit()

    public function commit()
    {
        global $globals;

        if ($this->asso == "alias") {
            $new = $this->liste . '@' . $this->domain;
            XDB::query('INSERT INTO virtual (alias, type) VALUES({?}, "user")', $new);
            foreach ($this->members as $member) {
                $user = User::get($member);
                if ($user != null) {
                    XDB::query(
                        "INSERT INTO  virtual_redirect (vid, redirect)
                              SELECT  vid, {?}
                                FROM  virtual
                               WHERE  alias = {?}", $user->forlifeEmail(), $new);
                }
            }
            return 1;
        }

        $list = new MMList(S::user()->id(), $this->domain);
        $ret = $list->create_list($this->liste, utf8_decode($this->desc), $this->advertise,
                                  $this->modlevel, $this->inslevel,
                                  $this->owners, $this->members);
        $liste = strtolower($this->liste);
        if ($ret && !$this->asso) {
            foreach(Array($liste, $liste . "-owner", $liste . "-admin", $liste . "-bounces", $liste . "-unsubscribe") as $l) {
                XDB::execute("INSERT INTO aliases (alias, type) VALUES({?}, 'liste')", $l);
            }
        } elseif ($ret) {
            foreach (Array('', 'owner', 'admin', 'bounces', 'unsubscribe') as $app) {
                $mdir = $app == '' ? '+post' : '+' . $app;
                if (!empty($app)) {
                    $app  = '-' . $app;
                }
                $red = $this->domain . '_' . $liste;
                XDB::execute('INSERT INTO virtual (alias, type)
                                        VALUES({?}, {?})', $liste . $app . '@' . $this->domain, 'list');
                XDB::execute('INSERT INTO virtual_redirect (vid, redirect)
                                        VALUES ({?}, {?})', XDB::insertId(),
                                       $red . $mdir . '@listes.polytechnique.org');
                $list->mass_subscribe($liste, join(' ', $this->members));
            }
        }
        return $ret;
    }

    // }}}
}

// }}}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
