{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2006 Polytechnique.org                             *}
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

<h1>{$asso.nom} : Ev�nements</h1>

{if $admin}
<p class="center">
  [<a href="{$platal->ns}events/edit">Annoncer un nouvel �v�nement</a>]
</p>
{/if}

{foreach from=$evenements item=e}

<table class="bicol" cellspacing="0" cellpadding="0">
  <colgroup>
    <col width='25%' />
  </colgroup>
  <tr>
    <th colspan="2">
      {$e.intitule}
      {if $admin}
      <br />
      [<a href="{$platal->ns}events/edit/{$e.eid}">
        modifier
        <img src="images/profil.png" title="Edition de l'�v�nement" alt="Edition" />
      </a>]
      &nbsp;&nbsp;&nbsp;&nbsp;
      [<a href="javascript:dynpostkv('{$platal->ns}events', 'del', {$e.eid})"
        onclick="return confirm('Supprimer l\'�v�nement effacera la liste des inscrits et des paiements.\n Es-tu s�r de vouloir supprimer l\'�v�nement ?')">
        supprimer
      {icon name=delete title='Suppression'}</a>]
      {/if}
    </th>
  </tr>

  <tr>
    <td class="titre">date :</td>
    <td>
      {if $e.fin and $e.fin neq $e.debut}
        {if $e.debut_day eq $e.fin_day}
          le {$e.debut|date_format:"%d %B %Y"} de {$e.debut|date_format:"%H:%M"} � {$e.fin|date_format:"%H:%M"}
        {else}
          du {$e.debut|date_format:"%d %B %Y � %H:%M"}<br />
          au {$e.fin|date_format:"%d %B %Y � %H:%M"}
        {/if}
      {else}
        le {$e.debut|date_format:"%d %B %Y � %H:%M"}
      {/if}
    </td>
  </tr>

  <tr>
    <td class="titre">annonceur :</td>
    <td>
      <a href='https://www.polytechnique.org/profile/{$e.alias}' class='popup2'>{$e.prenom} {$e.nom} ({$e.promo})</a>
    </td>
  </tr>

  <tr>
    <td class="titre">Informations :</td>
    <td class='actions'>
      {if $admin || $e.show_participants}
      <a href="{$platal->ns}events/admin/{$e.eid}">
        consulter la liste des participants
        {icon name=group title="Liste des participants"}
      </a><br />
      {/if}
      {if $e.deadline_inscription}
        {if $e.inscr_open}
          derni�res inscriptions
          le {$e.deadline_inscription|date_format:"%d %B %Y"}
        {else}
          <span class='error'>Inscriptions closes.</span><br />
        {/if}
      {/if}
    </td>
  </tr>

  <tr>
    <td class="titre">
      �tat inscription
      {if $e.inscr_open}
        <input type="hidden" name="evt_{counter}" value="{$e.eid}" />
      {/if}
    </td>
    <td>
      {if !$e.inscrit}
      <span class='error'>Non inscrit</span><br />
      {else}
        {foreach from=$e.moments item=m}
        {if !$m.nb}
        Tu ne viendras pas
        {elseif $m.nb eq 1}
        Tu viendras seul
        {else}
        Tu viendras avec {$m.nb} personne{if $m.nb > 2}s{/if}
        {/if} � <em>{$m.titre}</em><br />
        {/foreach}
      {/if}

      {if $e.topay}
      <span class="error">
      Tu dois payer {$e.topay|replace:'.':','}&nbsp;&euro;
      {if $e.paid > 0}
      (tu as d�j� pay� {$e.paid|replace:'.':','}&nbsp;&euro;)
      {/if}
      {if $e.paiement_id}
        [<a href="https://www.polytechnique.org/payment/{$e.paiement_id}?montant={$e.topay}}">
        Payer en ligne</a>]
      {/if}
      </span>
      {/if}
    </td>
  </tr>

  {if $e.inscr_open}
  <tr>
    <td colspan='2' class='center'>
      <strong>
      <a href='{$platal->ns}events/sub/{$e.eid}'>
        g�rer mon inscription
      </a>
      </strong>
    </td>
  </tr>
  {/if}

</table>

<br />

{foreachelse}

<p class="descr">
  Aucun �v�nement n'a �t� r�f�renc� par les animateurs du groupe.
</p>

{/foreach}

{* vim:set et sw=2 sts=2 sws=2: *}
