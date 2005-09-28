{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2004 Polytechnique.org                             *}
{*  http://opensource.polytechnique.org/                                  *}
{*                                                                        *}
{*  This program is free software; you can redistribute it and/or modify  *}
{*  it under the terms of the GNU General Public License as published by  *}
{*  the Free Software Foundation; either version 2 of the License, or     *}
{*  (at your option) any later version.                                   *}
{*                                                                        *}
{*  This program is distributed in the hope that it will be useful,       *}
{*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *}
{*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *}
{*  GNU General Public License for more details.                          *}
{*                                                                        *}
{*  You should have received a copy of the GNU General Public License     *}
{*  along with this program; if not, write to the Free Software           *}
{*  Foundation, Inc.,                                                     *}
{*  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA               *}
{*                                                                        *}
{**************************************************************************}


<div class="center">
  <table>
    <tr>
      <td>
        <img src="{rel}/images/cadenas_rouge.png" alt=" [ CADENAS ROUGE ] " />
      </td>
      <td>
        <span class="smaller">
          <strong>
            Pour des raisons de s�curit�, il est obligatoire de taper ton mot de passe, m�me
            avec l'acc�s permanent, pour certaines op�rations sensibles.
          </strong>
        </span>
      </td>
    </tr>
  </table>
</div>

<form action="{$smarty.server.REQUEST_URI}" method="post" id="login" onsubmit='doChallengeResponse(); return false;'>
  <table class="tinybicol" cellpadding="4" summary="Formulaire de login">
    <tr>
      <td class="titre">
        Mot de passe:
      </td>
      <td>
        <input type="password" name="password" size="10" maxlength="10" />
      </td>
    </tr>
    <tr>
      <td></td>
      <td {popup caption='Connexion permanente' width='300' text="D�coche cette case pour que le site oublie ce navigateur.<br />
        Il est conseill� de d�cocher la case si cette machine n'est pas <b>strictement</b> personnelle"}>
        <input type="checkbox" name="remember" checked="checked" /> Garder l'acc�s aux services apr�s d�connexion
      </td>
    </tr>
    <tr>
      <td>
        <img src="{rel}/images/pi.png" alt=" [ ? ] " />
        <a href="{rel}/recovery.php">Mot de passe perdu ?</a>
      </td>
      <td class="right">
        <input  type="submit" name="submitbtn" value="Envoyer" />
      </td>
    </tr>
  </table>
</form>
<br />
{if $smarty.request.response}<!-- failed login code -->
<div class="erreur">
  Erreur d'identification. Essaie � nouveau !
</div>
{/if}

<!-- Set up the form with the challenge value and an empty reply value -->
<form action="{$smarty.server.REQUEST_URI}" method="post" id="loginsub">
  <div>
    <input type="hidden" name="challenge" value="{$smarty.session.session->challenge}" />
    <input type="hidden" name="username"  value="{$smarty.cookies.ORGuid}" />
    <input type="hidden" name="remember"  value="" />
    <input type="hidden" name="response"  value="" />
  </div>
</form>

{literal}
<script type="text/javascript">
  <!--
  // Activate the appropriate input form field.
  document.forms.login.password.focus();
  // -->
</script>
{/literal}

{* vim:set et sw=2 sts=2 sws=2: *}
