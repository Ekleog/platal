{***************************************************************************
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
        $Id: utilisateurs.tpl,v 1.6 2004-08-31 11:25:39 x2000habouzit Exp $
 ***************************************************************************}


{if $smarty.session.suid}
<p class="erreur">
Attention, d�j� en SUID !!!
</p>
{/if}

<div class="rubrique">
  Gestion des utilisateurs
</div>

{dynamic}

{if $smarty.post.u_kill_conf}
<div class="center">
  <form id="yes" method="post" action="{$smarty.server.PHP_SELF}">
    <input type="hidden" name="login" value="{$smarty.request.login}" />
    Confirmer la suppression de {$smarty.request.login}&nbsp;&nbsp;
    <input type="submit" name="u_kill" value="continuer" />
  </form>
</div>
{/if}

{/dynamic}

<form id="add" method="post" action="{$smarty.server.PHP_SELF}">
  <table class="tinybicol" cellspacing="0" cellpadding="3">
    <tr>
      <th>
        Administrer
      </th>
    </tr>
    <tr>
      <td class="center">
        <input type="text" name="login" size="40" maxlength="255" value="{$login}" />
      </td>
    </tr>
    <tr>
      <td class="center">
        <input type="hidden" name="hashpass" value="" /> 
        <input type="submit" name="select" value=" edit " /> &nbsp;&nbsp;
        <input type="submit" name="suid_button" value=" su " />  &nbsp;&nbsp;
        <input type="submit" name="logs_button" value=" logs " />
      </td>
    </tr>
  </table>
</form>

{dynamic on="0`$smarty.request.select`"}
<p class="smaller">
Derni�re connexion le <strong>{$lastlogin|date_format:"%d %B %Y, %T"}</strong>
depuis <strong>{$mr.host}</strong>
</p>
<form id="edit" method="post" action="{$smarty.server.PHP_SELF}">
  <table cellspacing="0" cellpadding="0" class="admin">
    <tr> 
      <th class="login">
        Login
      </th>
      <th class="password"> 
        Password
      </th>
      <th class="perms"> 
        Perms
      </th>
    </tr>
    <tr> 
      <td class="login"> 
        <input type="hidden" name="hashpass" value="" />
        <input type="text" name="login" size="20" maxlength="50" value="{$mr.username}" />
      </td>
      <td class="password"> 
        <input type="text" name="newpass_clair" size="10" maxlength="10" value="********" />
        <input type="hidden" name="passw" size="32" maxlength="32" value="{$mr.password}" />
      </td>
      <td class="perms"> 
        <select name="permsN">
          <option value="user" {if $mr.perms eq "user"}selected="selected"{/if}>user</option>
          <option value="admin" {if $mr.perms eq "admin"}selected="selected"{/if}>admin</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td class="loginr"> 
        if (login!=prenom.nom)&nbsp;
      </td>
      <td class="login"> 
        <select name="homonyme">
          {if $mr.loginbis && ($mr.loginbis neq $mr.username)}
          <option value="1" selected="selected"> OUI </option>
          <option value="0"> NON </option>
          {else}
          <option value="1"> OUI </option>
          <option value="0" selected="selected"> NON </option>
          {/if}
        </select>
        /* pour homonymes */
      </td>
      <th class="action">
        &nbsp;
      </th>
    </tr>
    <tr> 
      <td class="loginr">
        then prenom.nom=
      </td>
      <td class="login">
        <input type="text" name="loginbis" size="24" maxlength="255" value="{$mr.loginbis}" />
      </td>
      <th class="action">
        Action
      </th>
    </tr>
    <tr> 
      <th>UID</th>
      <td>
        {$mr.user_id}
        <input type="hidden" name="olduid" size="6" maxlength="6" value="{$mr.user_id}" />
        <input type="hidden" name="oldlogin" size="100" maxlength="100" value="{$mr.username}" />
      </td>
      <td class="action">
        <input type="submit" name="u_kill_conf" value="DELETE" />
      </td>
    </tr>
    <tr> 
      <th class="detail">
        Matricule
      </th>
      <td class="detail"> 
        {$mr.matricule}
      </td>
      <td class="action"> 
        <input onclick="doEditUser(); return true;" type="submit" name="u_edit" value="UPDATE" />
      </td>
    </tr>
    <tr> 
      <th class="detail">
        Date de naissance
      </th>
      <td class="detail"> 
        <input type="text" name="naissanceN" size="10" maxlength="10" value="{$mr.naissance}" />
      </td>
      <td class="action">
        &nbsp;
      </td>
    </tr>
    <tr> 
      <th class="detail">
        Promo
      </th>
      <td class="detail"> 
        <input type="text" name="promoN" size="4" maxlength="4" value="{$mr.promo}" />
      </td>
      <td class="action">
        &nbsp;
      </td>
    </tr>
    <tr> 
      <th class="detail">
        Nom
      </th>
      <td class="detail">
        <input type="text" name="nomN" size="20" maxlength="255" value="{$mr.nom}" />
      </td>
      <td class="action">
        <a href="javascript:x()" onclick="popWin('{"x.php?x=`$mr.username`"|url}')">[Voir fiche]</a>
      </td>
    </tr>
    <tr> 
      <th class="detail">
        Pr�nom
      </th>
      <td class="detail">
        <input type="text" name="prenomN" size="20" maxlength="30" value="{$mr.prenom}" />
      </td>
      <td class="action">
        <a href="admin_trombino.php?uid={$mr.user_id}">[Trombino]</a>
      </td>
    </tr>
    <tr> 
      <th class="alias">
        Alias e-mail
      </th>
      <td class="alias"> 
        <input type="text" name="alias" size="20" maxlength="255" value="{$mr.alias}" />@m4x.org
      </td>
      <td class="action">
        &nbsp;
      </td>
    </tr>
    {foreach item=mail from=$xorgmails}
    <tr> 
      <th class="detail"> 
        e-mail forward {$mail.num} ({$mail.flags})
      </th>
      <td class="detail"> 
        <input type="text" name="fwd" size="29" maxlength="255" value="{$mail.email}" />
      </td>
      <td class="action"> 
        <input type="hidden" name="user_id" value="{$mr.user_id}" />
        <input type="hidden" name="login" value="{$mr.username}" />
        <input type="hidden" name="email" value="{$mail.email}" />
        <input type="hidden" name="select" value="edit" />
        <input type="submit" name="remove_email" value="Supprimer" />
      </td>
    </tr>
    {/foreach}
    <tr> 
      <th class="detail">
        Ajouter un email
      </th>
      <td class="detail"> 
        <input type="text" name="email" size="29" maxlength="60" value="" />
      </td>
      <td class="action">
        <input type="hidden" name="user_id" value="{$mr.user_id}" />
        <input type="hidden" name="login" value="{$mr.username}" />
        <input type="hidden" name="select" value="edit" />
        <input type="hidden" name="num" value="{$next_num}" />
        <input type="submit" name="add_email" value="Ajouter" />
      </td>
    </tr>
  </table>
</form>
<p class="erreur">
{$email_panne}
</p>
{/dynamic}
{* vim:set et sw=2 sts=2 sws=2: *}
