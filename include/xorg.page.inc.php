<?php
require("diogenes.core.page.inc.php");

class XorgPage extends DiogenesCorePage {
  var $_page_type;
  var $_tpl;
  
  function XorgPage($tpl, $type=SKINNED) {
    global $site_dev,$marketing_admin;

    $this->_page_type = SKINNED;
    $this->_tpl = $tpl;

    $this->DiogenesCorePage();

    // if necessary, construct new session
    if (!session_is_registered('session')) {
      session_register('session');
      $_SESSION['session'] = new XorgSession;
    }

    $this->assign('site_dev',$site_dev);

    // si necessaire, c'est *ici* que se fait l'authentification
    $_no_legacy = true;
    $this->doAuth();
    $this->set_skin();
  }

  function display() {
      if($this->_page_type == POPUP)
          parent::display('skin/'.$_SESSION['skin_popup'], $this->make_id());
      else
          parent::display('skin/'.$_SESSION['skin'], $this->make_id());
  }

  function make_id() {
      $auth = (empty($_SESSION['auth']) ? 0 : $_SESSION['auth']);
      $perms = (empty($_SESSION['perms']) ? 0 : $_SESSION['perms']);
      return $this->_tpl."-$auth-$perms";
  }

  function doAuth() { }
  
  function set_skin() {
    if(logged()) {
      $result = mysql_query("SELECT skin FROM auth_user_md5 WHERE username = '{$_SESSION['uid']}'");
      if(list($skin) = mysql_fetch_row($result)) {
        $sql = "SELECT normal,popup FROM skins WHERE ";
        if ($_SESSION['skin'] == SKIN_STOCHASKIN_ID) {
          $sql .= " !FIND_IN_SET('cachee',type) order by rand() limit 1";
        } else {
          $sql .= "id='$skin'";
        }
        $res = mysql_query($sql);
        list($_SESSION['skin'], $_SESSION['skin_popup']) = mysql_fetch_row($res);
        mysql_free_result($res);
      } else {
        $_SESSION['skin'] = SKIN_COMPATIBLE;
        $_SESSION['skin_popup'] = SKIN_COMPATIBLE;
      }
      mysql_free_result($result);
    }

    if( !logged() || !isset($_SERVER['HTTP_USER_AGENT'])
        || ereg("Mozilla/4\.[0-9]{1,2} \[",$_SERVER['HTTP_USER_AGENT']) )
    {
      $_SESSION['skin'] = SKIN_COMPATIBLE;
      $_SESSION['skin_popup'] = SKIN_COMPATIBLE;
    }
  }

}


/** Une classe pour les pages n�cessitant l'authentification.
 * (equivalent de controlauthentification.inc.php)
 */
class XorgAuth extends XorgPage
{
  function XorgAuth($tpl, $type=SKINNED)
  {
    $this->XorgPage($tpl, $type);
  }

  function doAuth()
  {
    $_SESSION['session']->doAuth($this);
  }
}


/** Une classe pour les pages n�cessitant l'authentification permanente.
 * (equivalent de controlpermanent.inc.php)
 */
class XorgCookie extends XorgPage
{
  function XorgCookie($tpl, $type=SKINNED)
  {
    $this->XorgPage($tpl, $type);
  }

  function doAuth()
  {
    $_SESSION['session']->doAuthCookie($this);
  }
}


/** Une classe pour les pages r�serv�es aux admins (authentifi�s!).
 */
class XorgAdmin extends XorgAuth
{
  function XorgAdmin($tpl, $type=SKINNED)
  {
    $this->XorgAuth($tpl, $type);
    check_perms();
  }
}


/** ajoute le nb de ../ qvb
 * Cette fonction recherche login.php dans les chemins donn�s par INCLUDE_PATH
 * et renvoie l'url avec le nombre de .. qvb
 * @param $param URL relative (� la page web)
 * @return URL absolue (au site web)
 * @see getphoto.php
 * @see ax/PasswordPromptScreen.inc
 * @see include/footer.inc.php
 * @see include/form_data_maj.inc.php
 * @see include/header1.inc.php
 * @see include/header2.inc.php
 * @see include/header_all.inc.php
 * @see include/header_logged.inc.php
 * @see include/passwordpromptscreen.inc.php
 * @see include/passwordpromptscreenlogged.inc.php
 * @see listes/index.php
 * @see mescontacts.php
 */
function xorg_func_url($params)
{
  extract($params);

  if (empty($rel))
    return;

  $chemins = Array('.', '..', '/');
  foreach ($chemins as $ch) {
    if (file_exists("$ch/login.php") || file_exists("$ch/public/login.php"))
      return "$ch/$rel";
  }
  return "";
}
?>
