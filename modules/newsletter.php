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

class NewsletterModule extends PLModule
{
    function handlers()
    {
        return array(
            'nl'                           => $this->make_hook('nl',            AUTH_COOKIE),
            'nl/show'                      => $this->make_hook('nl_show',       AUTH_COOKIE),
            'nl/submit'                    => $this->make_hook('nl_submit',     AUTH_MDP),
            'admin/newsletter'             => $this->make_hook('admin_nl',      AUTH_MDP, 'admin'),
            'admin/newsletter/categories'  => $this->make_hook('admin_nl_cat',  AUTH_MDP, 'admin'),
            'admin/newsletter/edit'        => $this->make_hook('admin_nl_edit', AUTH_MDP, 'admin'),
        );
    }

    function handler_nl(&$page, $action = null)
    {
        require_once 'newsletter.inc.php';

        $page->changeTpl('newsletter/index.tpl');
        $page->setTitle('Lettres mensuelles');

        switch ($action) {
          case 'out': Newsletter::unsubscribe(); break;
          case 'in':  Newsletter::subscribe(); break;
          default: ;
        }

        $page->assign('nls', Newsletter::subscriptionState());
        $page->assign('nl_list', Newsletter::listSent());
    }

    function handler_nl_show(&$page, $nid = 'last')
    {
        $page->changeTpl('newsletter/show.tpl');

        require_once 'newsletter.inc.php';

        try {
            $nl = new NewsLetter($nid);
            if (Get::has('text')) {
                $nl->toText($page, S::v('prenom'), S::v('nom'), S::v('femme'));
            } else {
                $nl->toHtml($page, S::v('prenom'), S::v('nom'), S::v('femme'));
            }
            if (Post::has('send')) {
                $res = XDB::query("SELECT  hash
                                     FROM  newsletter_ins
                                    WHERE  user_id = {?}",
                                  S::i('uid'));
                $nl->sendTo(S::user()->login(), S::user()->bestEmail(),
                            S::v('prenom'), S::v('nom'),
                            S::v('femme'), S::v('mail_fmt') != 'texte',
                            $res->fetchOneCell());
            }
        } catch (MailNotFound $e) {
            return PL_NOT_FOUND;
        }
    }

    function handler_nl_submit(&$page)
    {
        $page->changeTpl('newsletter/submit.tpl');

        require_once 'newsletter.inc.php';
        $wp = new PlWikiPage('Xorg.LettreMensuelle');
        $wp->buildCache();

        if (Post::has('see') || (Post::has('valid') && (!trim(Post::v('title')) || !trim(Post::v('body'))))) {
            if (!Post::has('see')) {
                $page->trigError("L'article doit avoir un titre et un contenu");
            }
            $art = new NLArticle(Post::v('title'), Post::v('body'), Post::v('append'));
            $page->assign('art', $art);
        } elseif (Post::has('valid')) {
            require_once('validations.inc.php');
            $art = new NLReq(S::user(), Post::v('title'),
                             Post::v('body'), Post::v('append'));
            $art->submit();
            $page->assign('submited', true);
        }
        $page->addCssLink('nl.css');
    }

    function handler_admin_nl(&$page, $new = false) {
        $page->changeTpl('newsletter/admin.tpl');
        $page->setTitle('Administration - Newsletter : liste');
        require_once("newsletter.inc.php");

        if($new) {
            Newsletter::create();
            pl_redirect("admin/newsletter");
        }

        $page->assign('nl_list', Newsletter::listAll());
    }

    function handler_admin_nl_edit(&$page, $nid = 'last', $aid = null, $action = 'edit') {
        $page->changeTpl('newsletter/edit.tpl');
        $page->addCssLink('nl.css');
        $page->setTitle('Administration - Newsletter : Edition');
        require_once("newsletter.inc.php");

        $nl  = new NewsLetter($nid);

        if($action == 'delete') {
            $nl->delArticle($aid);
            pl_redirect("admin/newsletter/edit/$nid");
        }

        if($aid == 'update') {
            $nl->_title     = Post::v('title');
            $nl->_title_mail= Post::v('title_mail');
            $nl->_date      = Post::v('date');
            $nl->_head      = Post::v('head');
            $nl->_shortname = strlen(Post::v('shortname')) ? Post::v('shortname') : null;
            if (preg_match('/^[-a-z0-9]*$/i', $nl->_shortname) && !is_numeric($nl->_shortname)) {
                $nl->save();
            } else {
                $page->trigError('Le nom de la NL n\'est pas valide');
                pl_redirect('admin/newsletter/edit/' . $nl->_id);
            }
        }

        if(Post::v('save')) {
            $art  = new NLArticle(Post::v('title'), Post::v('body'), Post::v('append'),
                    $aid, Post::v('cid'), Post::v('pos'));
            $nl->saveArticle($art);
            pl_redirect("admin/newsletter/edit/$nid");
        }

        if($action == 'edit' && $aid != 'update') {
            $eaid = $aid;
            if(Post::has('title')) {
                $art  = new NLArticle(Post::v('title'), Post::v('body'), Post::v('append'),
                        $eaid, Post::v('cid'), Post::v('pos'));
            } else {
        	   $art = ($eaid == 'new') ? new NLArticle() : $nl->getArt($eaid);
            }
            $page->assign('art', $art);
        }

        $page->assign_by_ref('nl',$nl);
    }

    function handler_admin_nl_cat(&$page, $action = 'list', $id = null) {
        $page->setTitle('Administration - Newsletter : Catégories');
        $page->assign('title', 'Gestion des catégories de la newsletter');
        $table_editor = new PLTableEditor('admin/newsletter/categories','newsletter_cat','cid');
        $table_editor->describe('titre','intitulé',true);
        $table_editor->describe('pos','position',true);
        $table_editor->apply($page, $action, $id);
    }
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
