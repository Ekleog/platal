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
        $Id: routage-mail.tpl,v 1.9 2004-10-24 14:41:11 x2000habouzit Exp $
 ***************************************************************************}

{dynamic}
{if $retour == $smarty.const.ERROR_INACTIVE_REDIRECTION}
  <p class="erreur">
  Tu ne peux pas avoir aucune adresse de redirection active, sinon ton adresse
  {$smarty.session.forlife}@polytechnique.org ne fonctionnerait plus.
  </p>
{/if}
{if $retour == $smarty.const.ERROR_INVALID_EMAIL}
  <p class="erreur">
  Erreur: l'email n'est pas valide.
  </p>
{/if}
{if $retour == $smarty.const.ERROR_LOOP_EMAIL}
  <p class="erreur">
  Erreur: {$smarty.session.forlife}@polytechnique.org doit renvoyer vers un email
  existant valide. En particulier, il ne peut pas �tre renvoy� vers lui-m�me,
  ni son �quivalent en m4x.org, ni vers son �quivalent polytechnique.edu.
  </p>
{/if}
{if $mtic == 1}
  <p>
  Ton adresse de redirection {$smarty.request.email} fait partie d'un domaine refusant
  que les messages internes passent par l'ext�rieur, ces messages seront donc retransmis en pi�ces jointes.
  </p>
{/if}
<form action="{$smarty.server.PHP_SELF}" method="post">
  <h1>
    Tes adresses de redirection
  </h1>
  <p>
  Tu configures ici les adresses emails vers lesquelles tes adresses (list�es ci-dessous) sont dirig�es :
  </p>
  <ul>
    {if $grx neq ""}<li><strong>{$grx}</strong>, <strong>{$domaine}org</strong></li>{/if}
    {foreach from=$alias item=a}
    <li>
    <strong>{$a.alias}@polytechnique.org</strong>
    {if $a.expire}<span class='erreur'>(expire le {$a.expire|date_format:"%d %b %Y"})</span>{/if}
    </li>
    {/foreach}
  </ul>
  <p>
    Le routage est en place pour les adresses dont la case "Actif" est coch�e.
    Si tu modifies souvent ton routage, tu as tout int�r�t � rentrer toutes les
    adresses qui sont susceptibles de recevoir ton routage, de sorte qu'en
    jouant avec les cases "Actif" tu pourras facilement mettre en place les unes
    ou bien les autres.
  </p>
  <p>
    Enfin, la r��criture consiste � substituer � ton adresse email habituelle
    (adresse wanadoo, yahoo, free, ou autre) ton adresse polytechnique.org ou
    m4x.org dans l'adresse d'exp�dition de tes messages, lorsque tu �cris
    � un camarade sur son adresse polytechnique.org.
  </p>
  <div class="center">
    <table class="bicol" summary="Adresses de redirection">
      <tr>
        <th>Email</th>
        <th>Actif</th>
        <th>R��criture</th>
        <th>&nbsp;</th>
      </tr>
      {foreach from=$emails item=e}
      <tr class="{cycle values="pair,impair"}">
        <td><strong>{$e->email}</strong></td>
        <td>
          <input type="checkbox" name="emails_actifs[]" value="{$e->email}" {if $e->active}checked="checked"{/if} /></td>
        <td>
          <select name="emails_rewrite[{$e->email}]">
            <option value=''>--- aucune ---</option>
            {foreach from=$alias item=a}
            <option {if $e->rewrite eq "`$a.alias`@polytechnique.org"}selected='selected'{/if}
              value='{$a.alias}@polytechnique.org'>{$a.alias}@polytechnique.org</option>
            <option {if $e->rewrite eq "`$a.alias`@m4x.org"}selected='selected'{/if}
              value='{$a.alias}@m4x.org'>{$a.alias}@m4x.org</option>
            {/foreach}
          </select>
        </td>
        <td><a href="{$smarty.server.PHP_SELF}?emailop=retirer&amp;email={$e->email}">retirer</a></td>
      </tr>
      {/foreach}
    </table>
    <br />
    <input type="submit" value="Mettre � jour les emails actifs" name="emailop" />
  </div>
</form>
  <p>
    Tu peux ajouter � cette liste une adresse email en la tapant ici et en cliquant sur Ajouter.
  </p>
<form action="{$smarty.server.PHP_SELF}" method="post">
  <div>
    <input type="text" size="35" maxlength="60" name="email" value="" />
    &nbsp;&nbsp;
    <input type="submit" value="ajouter" name="emailop" />
  </div>
</form>
{/dynamic}
{* vim:set et sw=2 sts=2 sws=2: *}
