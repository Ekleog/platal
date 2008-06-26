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

// {{{ class MarkReq

class MarkReq extends Validate
{
    // {{{ properties

    var $perso;

    var $m_id;
    var $m_email;
    var $m_nom;
    var $m_prenom;
    var $m_promo;
    
    // }}}
    // {{{ constructor

    function MarkReq($sender, $mark_id, $email, $perso = false) {
        global $globals;
        $this->Validate($sender, false, 'marketing');
        $this->m_id    = $mark_id;
        $this->m_email = $email;
        $this->perso   = $perso;

        $res = $globals->xdb->query('SELECT nom, prenom, promo FROM auth_user_md5 WHERE user_id = {?}', $mark_id);
        list ($this->m_nom, $this->m_prenom, $this->m_promo) = $res->fetchOneRow(); 
    }

    // }}}
    // {{{ function formu()

    function formu()
    { return 'include/form.valid.mark.tpl'; }

    // }}}
    // {{{ function _mail_subj
    
    function _mail_subj()
    {
        return "[Polytechnique.org] Marketing de {$this->m_prenom} {$this->m_nom} ({$this->m_promo})";
    }

    // }}}
    // {{{ function _mail_body

    function _mail_body($isok)
    {
        if ($isok) {
            return "  Un mail de marketing vient d'�tre envoy� "
                .($this->perso ? 'en ton nom' : 'en notre nom')
                ." � {$this->m_prenom} {$this->m_nom} ({$this->m_promo}) pour l'encourrager � s'inscrire !\n\n"
                ."Merci de ta participation !\n";
        } else {
            return "  Nous n'avons pas jug� bon d'envoyer de mail de marketing � {$this->m_prenom} {$this->m_nom} ({$this->m_promo}).";
        }
    }

    // }}}
    // {{{ function commit()

    function commit()
    {
        global $globals;
        require_once('marketing.inc.php');
        mark_send_mail($this->m_id, $this->m_email);
        return true;
    }

    // }}}
}

// }}}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker:
?>
