{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2010 Polytechnique.org                             *}
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

{if !$is_admin}
<h1>{$asso->nom}&nbsp;: Événements</h1>
{else}
<h1>
  {$asso->nom}&nbsp;: 
  {if $archive}[<a href="{$platal->ns}events">Événements</a>] {else}Événements {/if}
  {if $archive}Archives {else}[<a href="{$platal->ns}events/archive">Archives</a>] {/if}
</h1>

{if $updated}
<p class='error'>
  La modification de l'inscription a été prise en compte&nbsp;!
  {if $updated.topay > $updated.paid}
    <br/>N'oublie pas de payer {math equation="a-b" a=$updated.topay b=$updated.paid}&nbsp;&euro;
    {if $updated.paid > 0}
    (tu as déjà payé {$updated.paid|replace:'.':','}&nbsp;&euro;)
    {/if}
    {if $updated.paiement_id}
    [<a href="{$platal->ns}payment/{$updated.paiement_id}?montant={math equation="a-b" a=$updated.topay b=$updated.paid}">
    Payer en ligne</a>]
    {/if}
  {/if}
</p>
{/if}

{if !$archive}
<p class="center">
  [<a href="{$platal->ns}events/edit">Annoncer un nouvel événement</a>]
</p>
{/if}
{/if}

{foreach from=$evenements item=e}

<table class="bicol" cellspacing="0" cellpadding="0">
  <colgroup>
    <col width='25%' />
  </colgroup>
  <tr>
    <th colspan="2"{if !$e.inscr_open} class="grayed"{/if}>
      <a href="{$platal->ns}events/ical/{$e.short_name|default:$e.eid}/{$e.short_name|default:$e.eid}.ics" style="display: block; float: left;">
        {icon name=calendar_view_day title="Événement iCal"}
      </a>
      {$e.intitule}
      {if !$e.inscr_open}
      (<span class="error">Inscriptions closes</span>)
      {/if}
      {if $is_admin}
      <br />
      [<a href="{$platal->ns}events/edit/{$e.short_name|default:$e.eid}">
        modifier
        {icon name=date_edit title="Édition de l'événement"}</a>]
      &nbsp;
      [<a href="javascript:dynpostkv('{$platal->pl_self()}?token={xsrf_token}',{if !$archive}'archive'{else}'unarchive'{/if},{$e.eid})">
        {if !$archive}
          archiver
          {icon name=package_add title="Archivage"}</a>]
        {else}
          désarchiver
          {icon name=package_delete title="Désarchivage"}</a>]
        {/if}
      &nbsp;
      [<a href="javascript:dynpostkv('{$platal->ns}events?token={xsrf_token}','del',{$e.eid})"
        onclick="return confirm('Supprimer l\'événement effacera la liste des inscrits et des paiements.\n Es-tu sûr de vouloir supprimer l\'événement&nbsp;?')">
        supprimer
      {icon name=delete title='Suppression'}</a>]
      {/if}
    </th>
  </tr>

  <tr>
    <td class="titre">Date&nbsp;:</td>
    <td>{$e.date}</td>
  </tr>

  <tr>
    <td class="titre">Annonceur&nbsp;:</td>
    <td>{profile user=$e.organisateur_uid promo=true groupperms=false}</td>
  </tr>

  {if $is_admin || $e.show_participants || ($e.deadline_inscription && $e.inscr_open)}
  <tr>
    <td class="titre">Informations&nbsp;:</td>
    <td class='actions'>
      {if $is_admin || $e.show_participants}
      <a href="{$platal->ns}events/admin/{$e.short_name|default:$e.eid}">
        consulter la liste des participants
        {icon name=group title="Liste des participants"}
      </a><br />
      {/if}
      {if $e.deadline_inscription && $e.inscr_open}
        dernières inscriptions
        le {$e.deadline_inscription|date_format:"%d %B %Y"}
      {/if}
    </td>
  </tr>
  {/if}

  <tr>
    <td class="titre">
      État inscription&nbsp;:
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
        Tu viendras avec {$m.nb-1} personne{if $m.nb > 2}s{/if}
        {/if} à <em>{$m.titre}</em>.<br />
        {/foreach}
      {/if}

      {if $e.topay}
      <span class="error">
        {if !$e.paid}
        Tu dois payer {$e.topay|replace:'.':','}&nbsp;&euro;.
        {elseif $e.paid < $e.topay}
        Tu dois encore payer {math equation="a-b" a=$e.topay b=$e.paid|replace:'.':','}&nbsp;&euro;
        (tu as déjà payé {$e.paid|replace:'.':','}&nbsp;&euro;).
        {else}
        Tu as déjà payé les {$e.paid|replace:'.':','}&nbsp;&euro; de ton inscription.
        {/if}
        {if $e.paiement_id &&  $e.paid < $e.topay}
        [<a href="{$platal->ns}payment/{$e.paiement_id}?montant={math equation="a-b" a=$e.topay b=$e.paid}">
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
      <a href='{$platal->ns}events/sub/{$e.short_name|default:$e.eid}'>
        Gérer mon inscription et voir les détails de l'événement.
      </a>
      </strong>
    </td>
  </tr>
  {/if}

</table>

<br />

{foreachelse}

<p class="descr">
{if $archive}
  Aucun événement n'a été archivé par les animateurs du groupe.
{else}
  Aucun événement n'a été référencé par les animateurs du groupe.
{/if}
</p>

{/foreach}

{if $undisplayed_events neq 0}
<p class="descr">
  Il y a {$undisplayed_events} événement{if $undisplayed_events > 1}s non affichés car ils sont réservés
  {else} non affiché car il est réservé{/if} aux membres de ce groupe.
</p>
{/if}

{if $evenements}
<p class="descr">
  En cliquant sur l'icône {icon name=calendar_view_day title="Événement iCal"} associée à un événement,
  tu peux télécharger la version iCal de l'événement qui permet de l'ajouter dans ton agenda électronique.
</p>
{/if}

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}
