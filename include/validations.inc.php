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
 ***************************************************************************
    $Id: validations.inc.php,v 1.17 2004-11-22 07:24:56 x2000habouzit Exp $
 ***************************************************************************/

// {{{ DEFINES

define('SIZE_MAX', 32768);

// }}}
// {{{ class ValidateIterator

/**
 * Iterator class, that lists objects through the database
 */
class ValidateIterator
{
    // {{{ properties
    
    /** variable interne qui conserve l'�tat en cours de la requ�te */
    var $sql;

    // }}}
    // {{{ constuctor
    
    /** constructeur */
    function ValidateIterator ()
    {
        global $globals;
        $this->sql = $globals->db->query("SELECT data,stamp FROM requests ORDER BY stamp");
    }

    // }}}
    // {{{ function next()

    /** renvoie l'objet suivant, ou false */
    function next ()
    {
        if (list($result,$stamp) = mysql_fetch_row($this->sql)) {
            $result = unserialize($result);
            $result->stamp = $stamp;
            return($result);
        } else {
            mysql_free_result($this->sql);
            return(false);
        }
    }

    // }}}
}

// }}}
// {{{ class Validate

/** classe "virtuelle" � d�river pour chaque nouvelle impl�mentation
 * XXX attention, dans l'impl�mentation de la classe, il ne faut jamais faire confiance au timestamp
 * de l'objet qui sort du BLOB de la BD, on met donc syst�matiquement le champt $this->stamp depuis
 * le TIMESTAMP de la BD
 * Par contre, � la sortie de toute fonction il faut que le stamp soit valide !!! XXX
 */
class Validate
{
    // {{{ properties
    
    /** l'uid de la personne faisant la requ�te */
    var $uid;
    /** le time stamp de la requ�te */
    var $stamp;
    /** indique si la donn�e est unique pour un utilisateur donn� */
    var $unique;
    /** donne le type de l'objet (certes redonant, mais plus pratique) */
    var $type;

    // }}}
    // {{{ constructor
    
    /** constructeur
     * @param       $_uid       user id
     * @param       $_unique    requ�te pouvant �tre multiple ou non
     * @param       $_type      type de la donn�e comme dans le champ type de x4dat.requests
     * @param       $_stamp     stamp de cr�ation, 0 si c'estun nouvel objet
     */
    function Validate($_uid, $_unique, $_type, $_stamp=0)
    {
        $this->uid = $_uid;
        $this->stamp = $_stamp;
        $this->unique = $_unique;
        $this->type = $_type;
    }
    
    // }}}
    // {{{ function get_unique_request
    
    /** fonction statique qui renvoie la requ�te dans le cas d'un objet unique de l'utilisateur d'id $uid
     * @param   $uid    l'id de l'utilisateur concern�
     * @param   $type   le type de la requ�te
     *
     * XXX fonction "statique" XXX
     * XXX � d�river XXX
     * � utiliser uniquement pour r�cup�rer un objet <strong>unique</strong>
     */
    function get_unique_request($uid,$type)
    {
        global $globals;
        $sql = $globals->db->query("SELECT data,stamp FROM requests WHERE user_id='$uid' and type='$type'");
        if (list($result,$stamp) = mysql_fetch_row($sql)) {
            $result = unserialize($result);
            // on ne fait <strong>jamais</strong> confiance au timestamp de l'objet,
            $result->stamp = $stamp;
            if (!$result->unique) { // on v�rifie que c'est tout de m�me bien un objet unique
                $result = false;
            }
        } else
            $result = false;

        mysql_free_result($sql);
        return $result;
    }

    // }}}
    // {{{ function get_request()

    /** fonction statique qui renvoie la requ�te de l'utilisateur d'id $uidau timestamp $t
     * @param   $uid    l'id de l'utilisateur concern�
     * @param   $type   le type de la requ�te
     * @param   $stamp  le timestamp de la requ�te
     *
     * XXX fonction "statique" XXX
     * � utiliser uniquement pour r�cup�rer un objet dans la BD avec Validate::get_request(...)
     */
    function get_request($uid, $type, $stamp)
    {
        global $globals;
        $sql = $globals->db->query("SELECT data,stamp"
            ." FROM requests"
            ." WHERE user_id='$uid' and type = '$type' and stamp='$stamp'");
        if (list($result,$stamp) = mysql_fetch_row($sql)) {
            $result = unserialize($result);
            // on ne fait <strong>jamais</strong> confiance au timestamp de l'objet,
            $result->stamp = $stamp;
        } else {
            $result = false;
        }

        mysql_free_result($sql);
        return($result);
    }

    // }}}
    // {{{ function submit()

    /** fonction � utiliser pour envoyer les donn�es � la mod�ration
     * cette fonction supprimme les doublons sur un couple ($user,$type) si $this->unique est vrai
     */
    function submit ()
    {
        global $globals;
        if ($this->unique) {
            $globals->db->query("DELETE FROM requests WHERE user_id='{$this->uid}' AND type='{$this->type}'");
        }
       
        $globals->db->query("INSERT INTO  requests (user_id, type, user_id)
                                  VALUES  ('{$this->uid}', '{$this->type}, '".addslashes(serialize($this))."')");

        // au cas o� l'objet est r�utilis� apr�s un commit, il faut mettre son stamp � jour
        $sql = $globals->db->query("SELECT MAX(stamp) FROM requests
                                     WHERE user_id='{$this->uid}' AND type='{$this->type}'");
        list($this->stamp) = mysql_fetch_row($sql);
        mysql_free_result($sql);
        return true;
    }

    // }}}
    // {{{ function clean()
    
    /** fonction � utiliser pour nettoyer l'entr�e de la requ�te dans la table requests
     * attention, tout est supprim� si c'est un unique
     */
    function clean ()
    {
        global $globals;
        return $globals->db->query("DELETE FROM requests WHERE user_id='{$this->uid}' AND type='{$this->type}'"
                .($this->unique ? "" : " AND stamp='".$this->stamp."'"));
    }

    // }}}
    // {{{ function formu()
    
    /** nom du template qui contient le formulaire */
    function formu()
    { return null; }

    // }}}
    // {{{ function handle_formu()
    
    /** fonction � r�aliser en cas de valistion du formulaire
     * XXX la fonction est "virtuelle" XXX
     */
    function handle_formu()
    { }

    // }}}
    // {{{ function commit()
    
    /** fonction � utiliser pour ins�rer les donn�es dans x4dat
     * XXX la fonction est "virtuelle" XXX
     */
    function commit ()
    { }

    // }}}
}

// }}}
// {{{ IMPLEMENTATIONS

require("valid/aliases.inc.php");
require("valid/epouses.inc.php");
require("valid/photos.inc.php");
require("valid/evts.inc.php");
require("valid/listes.inc.php");

// }}}

/* vim: set expandtab shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=marker: */
?>
