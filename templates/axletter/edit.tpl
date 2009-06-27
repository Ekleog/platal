{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2009 Polytechnique.org                             *}
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

<h1>Edition de message</h1>

<form action="{$platal->pl_self()}" method="post">
  {xsrf_token_field}
  {if $am}
  {include file="axletter/letter.tpl"}

  <p class="center">
    <input type="hidden" name="id" value="{$id}" />
    <input type="hidden" name="old_short_name" value="{$short_name}" />
    <input type="hidden" name="saved" value="{$saved}" />
    {if $echeance}
    <input type="hidden" name="echeance" value="{$echeance}" />
    {/if}
    {if !$new}
    <input type="submit" name="valid" value="Confirmer" />
    {/if}
  </p>
  {/if}

  <fieldset>
    <legend>Sujet de l'email&nbsp;: <input type="text" name="subject" value="{$subject}" size="60"/></legend>
    <p class="center">
      <a href="wiki_help" class="popup3">
        {icon name=information title="Syntaxe wiki"} Voir les marqueurs de mise en forme autorisés
      </a><br />
      <strong>Titre&nbsp;: </strong><input type="text" name="title" value="{$title}" size="60" /><br />
      <textarea name="body" rows="30" cols="78">{$body}</textarea><br />
      <strong>Signature&nbsp;: </strong><input type="text" name="signature" value="{$signature}" size="60" />
    </p>
  </fieldset>

  <table class="bicol">
    <tr>
      <th colspan="2">Options du message</th>
    </tr>
    <tr>
      <td class="titre">Nom raccourci</td>
      <td>
        <input type="text" name="short_name" value="{$short_name}" size="16" maxlength="16" />
        <span class="smaller">(uniquement lettres, chiffres ou -)</span>
      </td>
    </tr>
    {include file="include/field.promo.tpl" prefix=""}
    <tr>
      <td class="titre">Envoyer à une liste d'adresses</td>
      <td><textarea name="subset_to" rows="7" cols="78">{$subset_to}</textarea><br />
      <span class="smaller">Indiquez une liste d'adresses mails : la lettre sera envoyée uniquement aux personnes des promotions sélectionnées, dont l'adresse figure dans la liste, et qui souhaitent recevoir les mailings de l'AX.</span>
      </td>
    </tr>
    {if !$saved}
    <tr>
      <td class="titre">Echéance d'envoi</td>
      <td>
        le {valid_date name="echeance_date" value=$echeance_date from=3 to=15}
        vers <select name="echeance_time">{$echeance_time|smarty:nodefaults}</select>
      </td>
    </tr>
    {else}
    <tr>
      <td colspan="2" class="center">
        Envoi au plus tard le {$echeance|date_format:"%x vers %Hh"}<br />
        {if $is_xorg}
        [<a href="ax/edit/valid?token={xsrf_token}" onclick="return confirm('Es-tu sûr de vouloir valider l\'envoi de ce message ?');">{*
          *}{icon name=thumb_up} Valider l'envoi</a>]
        {else}
        [<a href="ax/edit/cancel?token={xsrf_token}" onclick="return confirm('Es-tu sûr de vouloir annuler l\'envoi de ce message ?');">{*
          *}{icon name=thumb_down} Annuler l'envoi</a>]
        {/if}
      </td>
    </tr>
    {/if}
  </table>

  <p class="center">
    <input type="hidden" name="id" value="{$id}" />
    <input type="hidden" name="old_short_name" value="{$short_name}" />
    <input type="hidden" name="saved" value="{$saved}" />
    {if $echeance}
    <input type="hidden" name="echeance" value="{$echeance}" />
    {/if}
    <input type="submit" name="valid" value="Aperçu" />
    {if !$new}
    <input type="submit" name="valid" value="Confirmer" />
    {/if}
  </p>
</form>

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}
