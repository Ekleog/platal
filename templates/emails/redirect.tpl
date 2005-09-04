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

{if $retour == $smarty.const.ERROR_INACTIVE_REDIRECTION}
  <p class="erreur">
  Tu ne peux pas avoir aucune adresse de redirection active, sinon ton adresse
  {$smarty.session.forlife}@{#globals.mail.domain#} ne fonctionnerait plus.
  </p>
{/if}
{if $retour == $smarty.const.ERROR_INVALID_EMAIL}
  <p class="erreur">
  Erreur: l'email n'est pas valide.
  </p>
{/if}
{if $retour == $smarty.const.ERROR_LOOP_EMAIL}
  <p class="erreur">
  Erreur: {$smarty.session.forlife}@{#globals.mail.domain#} ne doit pas �tre renvoy�
  vers lui-m�me, ni vers son �quivalent en {#globals.mail.domain2#} ni vers polytechnique.edu.
  </p>
{/if}
  <h1>
    Tes adresses de redirection
  </h1>
  <p>
  Tu configures ici les adresses emails vers lesquelles tes adresses (list�es ci-dessous) sont dirig�es :
  </p>
  <ul>
    {if $melix}
    <li>
    <strong>{$melix}@{#globals.mail.alias_dom#}</strong>,
    <strong>{$melix}@{#globals.mail.alias_dom2#}</strong>
    </li>
    {/if}
    {foreach from=$alias item=a}
    <li>
    <strong>{$a.alias}@{#globals.mail.domain#}</strong>
    {if $a.expire}<span class='erreur'>(expire le {$a.expire|date_format})</span>{/if}
    </li>
    {/foreach}
  </ul>
  <p>
    Le routage est en place pour les adresses dont la case "<strong>Actif</strong>" est coch�e.
    Si tu modifies souvent ton routage, tu as tout int�r�t � rentrer toutes les
    adresses qui sont susceptibles de recevoir ton routage, de sorte qu'en
    jouant avec les cases "<strong>Actif</strong>" tu pourras facilement mettre en place les unes
    ou bien les autres.
  </p>
  <p>
    Enfin, la <strong>r��criture</strong> consiste � substituer � ton adresse email habituelle
    (adresse wanadoo, yahoo, free, ou autre) ton adresse {#globals.mail.domain#} ou
    {#globals.mail.domain2#} dans l'adresse d'exp�dition de tes messages, lorsque le courrier
    passe par nos serveurs. Ceci arrive lorsque tu �cris � un camarade sur son adresse {#globals.mail.domain#} ou
    {#globals.mail.domain2#}, ou lorsque tu utilises notre
    <a href="{rel}/docs/doc_smtp.php">service d'envoi de courrier SMTP s�curis�</a>.
  </p>
<form action="{$smarty.server.PHP_SELF}" method="post">
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
      <tr class="{cycle values="pair,impair"}"><td colspan="4">
		&nbsp;<br />
		Ajouter une adresse email�:
        <input type="text" size="35" maxlength="60" name="email" value="" />
        &nbsp;&nbsp;<input type="submit" value="ajouter" name="emailop" />
      </td></tr>
    </table>
    <br />
    <input type="submit" value="Valider les modifications" name="emailop" />
  </div>
</form>

<h1>Pour les �l�ves (non encore dipl�m�s)</h1>
<p>
  L'X te fourni aussi une adresse � vie en <strong>�prenom.nom�@polytechnique.edu</strong> qui par d�faut est
  une redirection vers �login�@poly.polytechnique.fr. <a href="https://mail.polytechnique.edu/">
  Tu peux modifier cette redirection</a> et la faire pointer vers ton adresse
  {$smarty.session.forlife}@{#globals.mail.domain#} (attention, cela demande de la concentration).
</p>
<p>
  Si tu utilises le service POP de poly pour r�cup�rer tes mails dans ton logiciel de courrier,
  l'�quipe de Polytechnique.org te conseille de rediriger�:
</p>
<ul>
  <li>�prenom.nom�@polytechnique.edu vers {$smarty.session.forlife}@{#globals.mail.domain#}</li>
  <li>{$smarty.session.forlife}@{#globals.mail.domain#} vers �login�@poly.polytechnique.fr</li>
</ul>

{* vim:set et sw=2 sts=2 sws=2: *}
