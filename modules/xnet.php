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

class XnetModule extends PLModule
{
    function handlers()
    {
        return array(
            'index'       => $this->make_hook('index',     AUTH_PUBLIC),
            'exit'        => $this->make_hook('exit',      AUTH_PUBLIC),

            'admin'       => $this->make_hook('admin',     AUTH_MDP, 'admin'),
            'groups'      => $this->make_hook('groups',    AUTH_PUBLIC),
            'groupes.php' => $this->make_hook('groups2',   AUTH_PUBLIC),
            'plan'        => $this->make_hook('plan',      AUTH_PUBLIC),
            'photo'       => $this->make_hook('photo',     AUTH_MDP),
            'autologin'   => $this->make_hook('autologin', AUTH_MDP),
        );
    }

    function handler_photo(&$page, $x = null)
    {
        if (is_null($x)) {
            return PL_NOT_FOUND;
        }

        $res = XDB::query("SELECT attachmime, attach
                             FROM aliases
                       INNER JOIN photo ON(id = uid)
                            WHERE alias = {?}", $x);

        if ((list($type, $data) = $res->fetchOneRow())) {
            pl_cached_dynamic_content_headers("image/$type");
            echo $data;
        } else {
            pl_cached_dynamic_content_headers("image/png");
            echo file_get_contents(dirname(__FILE__).'/../htdocs/images/none.png');
        }
        exit;
    }

    function handler_index(&$page)
    {
        $page->nomenu = true;
        $page->changeTpl('xnet/index.tpl');
    }

    function handler_exit(&$page)
    {
        Platal::session()->stopSUID();
        Platal::session()->destroy();
        $page->changeTpl('xnet/deconnexion.tpl');
    }

    function handler_admin(&$page)
    {
        $page->changeTpl('xnet/admin.tpl');

        if (Get::has('del')) {
            $res = XDB::query('SELECT id, nom, mail_domain
                                           FROM groups WHERE diminutif={?}',
                                        Get::v('del'));
            list($id, $nom, $domain) = $res->fetchOneRow();
            $page->assign('nom', $nom);
            if ($id && Post::has('del')) {
                S::assert_xsrf_token();

                XDB::query('DELETE FROM group_members WHERE asso_id={?}', $id);
                $page->trigSuccess('membres supprimés');

                if ($domain) {
                    XDB::query('DELETE FROM  virtual_domains WHERE domain={?}', $domain);
                    XDB::query('DELETE FROM  virtual, virtual_redirect
                                                USING  virtual INNER JOIN virtual_redirect USING (vid)
                                                WHERE  alias LIKE {?}', '%@'.$domain);
                    $page->trigSuccess('suppression des alias mails');

                    $mmlist = new MMList(S::v('uid'), S::v('password'), $domain);
                    if ($listes = $mmlist->get_lists()) {
                        foreach ($listes as $l) {
                            $mmlist->delete_list($l['list'], true);
                        }
                        $page->trigSuccess('mail lists surpprimées');
                    }
                }

                XDB::query('DELETE FROM groups WHERE id={?}', $id);
                $page->trigSuccess("Groupe $nom supprimé");
                Get::kill('del');
            }
            if (!$id) {
                Get::kill('del');
            }
        }

        if (Post::has('diminutif') && Post::v('diminutif') != "") {
            S::assert_xsrf_token();

            $res = XDB::query('SELECT  COUNT(*)
                                 FROM  groups
                                WHERE  diminutif = {?}',
                              Post::v('diminutif'));

            if ($res->fetchOneCell() == 0) {
                XDB::execute('INSERT INTO  groups (id, diminutif)
                                   VALUES  (NULL, {?})',
                             Post::v('diminutif'));
                pl_redirect('../' . Post::v('diminutif') . '/edit');
            } else {
                $page->trigError('Le diminutif demandé est déjà pris.');
            }
        }

        $res = XDB::query('SELECT  nom, diminutif
                             FROM  groups
                         ORDER BY  nom');
        $page->assign('assos', $res->fetchAllAssoc());
    }

    function handler_plan(&$page)
    {
        $page->changeTpl('xnet/plan.tpl');

        $page->setType('plan');

        $res = XDB::iterator(
                'SELECT  dom.id, dom.nom as domnom, asso.diminutif, asso.nom
                   FROM  group_dom
             INNER JOIN  groups ON dom.id = asso.dom
                  WHERE  FIND_IN_SET("GroupesX", dom.cat) AND FIND_IN_SET("GroupesX", asso.cat)
               ORDER BY  dom.nom, asso.nom');
        $groupesx = array();
        while ($tmp = $res->next()) { $groupesx[$tmp['id']][] = $tmp; }
        $page->assign('groupesx', $groupesx);

        $res = XDB::iterator(
                'SELECT  dom.id, dom.nom as domnom, asso.diminutif, asso.nom
                   FROM  group_dom
             INNER JOIN  groups ON dom.id = asso.dom
                  WHERE  FIND_IN_SET("Binets", dom.cat) AND FIND_IN_SET("Binets", asso.cat)
               ORDER BY  dom.nom, asso.nom');
        $binets = array();
        while ($tmp = $res->next()) { $binets[$tmp['id']][] = $tmp; }
        $page->assign('binets', $binets);

        $res = XDB::iterator(
                'SELECT  asso.diminutif, asso.nom
                   FROM  groups
                  WHERE  cat LIKE "%Promotions%"
               ORDER BY  diminutif');
        $page->assign('promos', $res);

        $res = XDB::iterator(
                'SELECT  asso.diminutif, asso.nom
                   FROM  groups
                  WHERE  FIND_IN_SET("Institutions", cat)
               ORDER BY  diminutif');
        $page->assign('inst', $res);
    }

    function handler_groups2(&$page)
    {
        $this->handler_groups(&$page, Get::v('cat'), Get::v('dom'));
    }

    function handler_groups(&$page, $cat = null, $dom = null)
    {
        if (!$cat) {
            $this->handler_index(&$page);
        }

        $cat = mb_strtolower($cat);

        $page->changeTpl('xnet/groupes.tpl');
        $page->assign('cat', $cat);
        $page->assign('dom', $dom);

        $res  = XDB::query("SELECT  id,nom 
                              FROM  group_dom
                             WHERE  FIND_IN_SET({?}, cat)
                          ORDER BY  nom", $cat);
        $doms = $res->fetchAllAssoc();
        $page->assign('doms', $doms);

        if (empty($doms)) {
            $res = XDB::query("SELECT  diminutif, nom, site
                                 FROM  groups
                                WHERE  FIND_IN_SET({?}, cat)
                                ORDER  BY nom", $cat);
            $page->assign('gps', $res->fetchAllAssoc());
        } elseif (!is_null($dom)) {
            $res = XDB::query("SELECT  diminutif, nom, site
                                 FROM  groups
                                WHERE  FIND_IN_SET({?}, cat) AND dom={?}
                             ORDER BY  nom", $cat, $dom);
            $page->assign('gps', $res->fetchAllAssoc());
        }

        $page->setType($cat);
    }

    function handler_autologin(&$page)
    {
        $allkeys = func_get_args();
        unset($allkeys[0]);
        $url = join('/',$allkeys);
        pl_content_headers("text/javascript");
        echo '$.ajax({ url: "'.$url.'?forceXml=1", dataType: "xml", success: function(xml) { $("body",xml).insertBefore("body"); $("body:eq(1)").remove(); }});';
        exit;
    }
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
