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

<h1>{$asso.nom} : Gestion des t�l�paiements </h1>

<p class="descr">
Voici la liste des paiements en ligne possible pour le groupe {$asso.nom}
</p>

{foreach from=$titres item=p}

<fieldset>
<legend><a href="{$platal->ns}payment/{$p.id}">{icon name=money title="T�l�paiement"}{$p.text}</a></legend>

{if $event[$p.id]}
{assign var='ev' value=$event[$p.id]}
<p>
  {if $p.url}
  Plus d'informations sur ce t�l�paiement sont disponibles sur <a href="{$p.url}">cette page</a>.<br />
  {/if}
  {if $ev.eid}
  Ce paiement est associ� � l'�v�nement <a href="{$platal->ns}events">{$ev.title}</a>.<br />
    {if $ev.ins}
    Tu es inscrit � cet �v�nements.
      {if $ev.topay > $ev.paid}
      <a href="{$platal->ns}payment/{$p.id}?montant={math equation="a-b" a=$ev.topay b=$ev.paid}">
        Tu dois encore payer {math equation="a-b" a=$ev.topay b=$ev.paid}&euro;
      </a>
      {elseif $ev.topay eq $ev.paid}
      Tu as d�j� r�gl� l'int�gralit� de ton inscription ({$ev.topay}&euro;).
      {else}
      Tu as r�gl� {$ev.paid}&euro; alors que tu n'en devais que {$ev.topay}&euro;
      {/if}
    {else}
    <a href="{$platal->ns}events/sub/{$ev.eid}">Tu peux t'inscire � cet �v�nement.</a>
    {/if}
  {else}
    {if !$ev.paid}
    Tu n'as actuellement rien pay� sur ce t�l�paiement.
    {else}
    Tu as d�j� pay� {$ev.paid}&euro;.
    {/if}
  {/if}
</p>
{/if}

{if $is_admin && $trans[$p.id]}
<p>Liste des personnes ayant pay� (pour les administrateurs uniquement)&nbsp;:</p>
<table cellpadding="0" cellspacing="0" id="list_{$p.id}" class='tinybicol'>
  <tr>
    <th class="center">
      {if $order eq 'timestamp'}
        <a href='{$platal->ns}payment?order={$order}&order_inv={$order_inv}'>
          <img src="{$platal->baseurl}images/{if !$order_inv}dn{else}up{/if}.png" alt="" title="Tri {if $order_inv}d�{/if}croissant" />
      {else}
        <a href='{$platal->ns}payment?order=timestamp'>
      {/if}Date</a>
    </th>
    <th colspan="2" class="center">
      {if $order eq 'nom'}
        <a href='{$platal->ns}payment?order={$order}&order_inv={$order_inv}'>
          <img src="{$platal->baseurl}images/{if $order_inv}dn{else}up{/if}.png" alt="" title="Tri {if !$order_inv}d�{/if}croissant" />
      {else}
        <a href='{$platal->ns}payment?order=nom'>{/if}
      NOM Pr�nom</a>
    </th>
    <th class="center">
      {if $order eq 'promo'}
        <a href='{$platal->ns}payment?order={$order}&order_inv={$order_inv}'>
          <img src="{$platal->baseurl}images/{if $order_inv}dn{else}up{/if}.png" alt="" title="Tri {if !$order_inv}d�{/if}croissant" />
      {else}
        <a href='{$platal->ns}payment?order=promo'>
      {/if}Promo</a>
    </th>
    <th class="center">
      {if $order eq 'montant'}
        <a href='{$platal->ns}payment?order={$order}&order_inv={$order_inv}'>
          <img src="{$platal->baseurl}images/{if $order_inv}dn{else}up{/if}.png" alt="" title="Tri {if !$order_inv}d�{/if}croissant" />
      {else}
        <a href='{$platal->ns}payment?order=montant'>
      {/if}Montant</a>
    </th>
  </tr>
  {assign var="somme" value=0}
  {foreach from=$trans[$p.id] item=p name=people}
  {if $p.nom neq "somme totale"}
  <tr>
    <td class="center">{$p.date|date_format:"%d/%m/%y"}</td>
    <td>
      <a href="https://www.polytechnique.org/profile/{$p.alias}" class="popup2">
        {$p.nom|strtoupper} {$p.prenom}
       </a>
    </td>
    <td>
      <a href="mailto:{$p.alias}@polytechnique.org">{icon name=email title="mail"}</a>
    </td>
    <td class="center">{$p.promo}</td>
    <td class="right">{$p.montant}</td>
  </tr>
  {elseif $smarty.foreach.people.first}
  <tr>
    <td colspan="5" class="center">Personne n'a encore pay� pour ce t�l�paiement</td>
  </tr>
  {else}
  <tr class="pair">
    <td class="right" colspan="4"><strong>Total </strong></td>
    <th class="right">{$p.montant}</th>
  </tr>
  {/if}
  {/foreach}
</table>
{/if}
</fieldset>

{foreachelse}

<p class="descr">
<em>Pas de t�l�paiement en cours ...</em>
</p>

{/foreach}

{* vim:set et sw=2 sts=2 sws=2: *}
