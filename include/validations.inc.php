<?php
/* vim: set expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=100:
 * $Id: validations.inc.php,v 1.1 2004-01-26 22:29:02 x2000habouzit Exp $
 *
 */

define('SIZE_MAX', 32768);

/** classe listant les objets dans la bd */
class ValidateIterator {
    /** variable interne qui conserve l'�tat en cours de la requ�te */
    var $sql;
    
    /** constructeur */
    function ValidateIterator () {
        $this->sql = mysql_query("SELECT data,stamp FROM requests ORDER BY stamp");
    }

    /** renvoie l'objet suivant, ou false */
    function next () {
        if(list($result,$stamp) = mysql_fetch_row($this->sql)) {
            $result = unserialize($result);
            $result->stamp = $stamp;
            return($result);
        } else {
            mysql_free_result($this->sql);
            return(false);
        }
    }
}

/** classe "virtuelle" � d�river pour chaque nouvelle impl�mentation
 * XXX attention, dans l'impl�mentation de la classe, il ne faut jamais faire confiance au timestamp
 * de l'objet qui sort du BLOB de la BD, on met donc syst�matiquement le champt $this->stamp depuis
 * le TIMESTAMP de la BD
 * Par contre, � la sortie de toute fonction il faut que le stamp soit valide !!! XXX
 */
class Validate {
    /** l'uid de la personne faisant la requ�te */
    var $uid;
    /** le time stamp de la requ�te */
    var $stamp;
    /** indique si la donn�e est unique pour un utilisateur donn� */
    var $unique;
    /** donne le type de l'objet (certes redonant, mais plus pratique) */
    var $type;
    
    /** fonction statique qui renvoie la requ�te dans le cas d'un objet unique de l'utilisateur d'id $uid
     * @param   $uid    l'id de l'utilisateur concern�
     * @param   $type   le type de la requ�te
     *
     * XXX fonction "statique" XXX
     * XXX � d�river XXX
     * � utiliser uniquement pour r�cup�rer un objet <br>unique</br>
     */
    function get_unique_request($uid,$type) {
        $sql = mysql_query("SELECT data,stamp FROM requests WHERE user_id='$uid' and type='$type'");
        if(list($result,$stamp) = mysql_fetch_row($sql)) {
            $result = unserialize($result);
            // on ne fait <b>jamais</b> confiance au timestamp de l'objet,
            $result->stamp = $stamp;
            if(!$result->unique) // on v�rifie que c'est tout de m�me bien un objet unique
                $result = false;
        } else
            $result = false;

        mysql_free_result($sql);
        return $result;
    }

    /** fonction statique qui renvoie la requ�te de l'utilisateur d'id $uidau timestamp $t
     * @param   $uid    l'id de l'utilisateur concern�
     * @param   $type   le type de la requ�te
     * @param   $stamp  le timestamp de la requ�te
     *
     * XXX fonction "statique" XXX
     * � utiliser uniquement pour r�cup�rer un objet dans la BD avec Validate::get_request(...)
     */
    function get_request($uid, $type, $stamp) {
        $sql = mysql_query("SELECT data,stamp"
            ." FROM requests"
            ." WHERE user_id='$uid' and type = '$type' and stamp='$stamp'");
        if(list($result,$stamp) = mysql_fetch_row($sql)) {
            $result = unserialize($result);
            // on ne fait <b>jamais</b> confiance au timestamp de l'objet,
            $result->stamp = $stamp;
        } else
            $result = false;

        mysql_free_result($sql);
        return($result);
    }

    /** constructeur
     * @param       $_uid       user id
     * @param       $_unique    requ�te pouvant �tre multiple ou non
     * @param       $_type      type de la donn�e comme dans le champ type de x4dat.requests
     * @param       $_stamp     stamp de cr�ation, 0 si c'estun nouvel objet
     */
    function Validate($_uid, $_unique, $_type, $_stamp=0) {
        $this->uid = $_uid;
        $this->stamp = $_stamp;
        $this->unique = $_unique;
        $this->type = $_type;
    }
    
    /** fonction � utiliser pour envoyer les donn�es � la mod�ration
     * cette fonction supprimme les doublons sur un couple ($user,$type) si $this->unique est vrai
     */
    function submit () {
        global $no_update_bd;
        if($no_update_bd) return false;
        mysql_query("LOCK requests"); // le lock est obligatoire pour r�cup�rer le dernier stamp !
        
        if($this->unique)
            mysql_query("DELETE FROM requests WHERE user_id='".$this->uid
                    .   "' AND type='".$this->type."'");
       
        mysql_query("INSERT INTO requests SET user_id='".$this->uid."', type='".$this->type
                .   "', data='".addslashes(serialize($this))."'");

        // au cas o� l'objet est r�utilis� apr�s un commit, il faut mettre son stamp � jour
        $sql = mysql_query("SELECT MAX(stamp) FROM requests "
                .   "WHERE user_id='".$this->uid."' AND type='".$this->type."'");
        list($this->stamp) = mysql_fetch_row($sql);
        mysql_free_result($sql);

        mysql_query("UNLOCK requests");
        return true;
    }
    
    /** fonction � utiliser pour nettoyer l'entr�e de la requ�te dans la table requests
     * attention, tout est supprim� si c'est un unique
     */
    function clean () {
        global $no_update_bd;
        if($no_update_bd) return false;
        return mysql_query("DELETE FROM requests WHERE user_id='".$this->uid."' AND type='".$this->type."'"
                .($this->unique ? "" : " AND stamp='".$this->stamp."'"));
    }
    
    /** doit afficher le fomulaire de validation de la donn�e
     * XXX la fonction est "virtuelle" XXX
     * XXX doit d�finir les variables $uid et $stamp en hidden XXX
     */
    function echo_formu() { }
    /** fonction � r�aliser en cas de valistion du formulaire
     * XXX la fonction est "virtuelle" XXX
     */
    function handle_formu () { }
    /** fonction � utiliser pour ins�rer les donn�es dans x4dat
     * XXX la fonction est "virtuelle" XXX
     */
    function commit () { }
}

//***************************************************************************************
//
// IMPLEMENTATIONS
//
//***************************************************************************************

require("valid_aliases.inc.php");
require("valid_epouses.inc.php");
require("valid_photos.inc.php");
require("valid_ml.inc.php");
require("valid_sondages.inc.php");
require("valid_emploi.inc.php");
require("valid_evts.inc.php");

?>
