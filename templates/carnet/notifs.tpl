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
        $Id: notifs.tpl,v 1.6 2004-11-05 13:49:16 x2000habouzit Exp $
 ***************************************************************************}

{dynamic}

<h1>Notifications automatiques</h1>

<p>Les mails sont hebdomadaires (pour �viter une trop grosse charge du serveur de mails et de ta boite mail).
S'il n'y a rien � te signaler le mail ne t'est pas envoy�.</p>

<p>tu peux ici activer la surveillance de tes contacts, ce qui te permet :</p>
<ul>
  <li>d'�tre notifi� lorsque tes contacts changent leur fiche</li>
  <li>d'�tre notifi� lorsque un de tes contacts d�c�de</li>
  <li>si tu le d�sires, lorsque tu es notifi� du d�c�s d'un de tes camarades, il peut �tre automatiquement retir� de ta liste de contact.
  (dans cec as ta liste de contact est vid�e de tous les camarades qui sont d�c�d�s)
  </li>
</ul>

<form action="{$smarty.server.PHP_SELF}" method="post">
  <fieldset>
    <legend>Contacts</legend>
    <input type='checkbox' name='contacts' {if $notifs->flags->hasflag('contacts')}checked="checked"{/if} /> Surveiller mes contacts<br />
    <input type='checkbox' name='deaths' {if $notifs->flags->hasflag('deaths')}checked="checked"{/if}/> Supprimer les camarades d�c�d�s de mes contacts
  </fieldset>
  <div class='center'>
    <input type='submit' name='flags' value='valider' />
  </div>
</form>

<br />
<h1>Surveiller des promos</h1>

<p>
Pour les promos, tu es notifi� lorsque un camarade de cette promo s'inscrit, et lorsque un camarade de cette promo d�c�de.
</p>

<form action="{$smarty.server.PHP_SELF}" method="post">
  <fieldset>
    <legend>Ajouter une promo</legend>
    <input type='text' name='add_promo' maxlength='4' size='4' />
    <input type='submit' value='ajouter' />
    <span class='smaller'>mettre la promo sur quatre chiffres </span>
    <br />
    {if $notifs->promos|@count eq 0}
    <p>Tu ne surveilles actuellement aucune promo.</p>
    {else}
    <p>Tu surveilles {if $notifs->promos|@count eq 1}la promo{else}les promos{/if} :</p>
    <ul>
      {foreach from=$notifs->promos item=p}
      <li>{$p} <a href="?del_promo={$p}"><img src="{"images/retirer.gif"|url}" alt="retirer cette promo" /></a></li>
      {/foreach}
    </ul>
    {/if}
  </fieldset>
</form>

<h1>Surveiller des non inscrits</h1>

<p>
Pour les non-inscrits, tu es notifi� lorsqu'il s'inscrit, ou lorsque ce camarade d�c�de.
</p>

<p>
Si un non-inscrit que tu surveille s'inscrit, il sera automatiquement ajout� � tes contacts.
</p>
<!--
<form action="{$smarty.server.PHP_SELF}" method="post">
  <fieldset>
    <legend>Ajouter un non-inscrit</legend>
    <input type='text' name='' />
    <input type='submit' value='ajouter' />
    <span class='smaller'>Il faut entrer le "login" (prenom.nom ou prenom.nom.promo).</span>
  </fieldset>
</form>
-->
<table class='tinybicol' cellpadding="0" cellspacing="0">
  <tr>
    <td>
      {if $notifs->nonins|@count eq 0}
      <p>Tu ne surveilles actuellement aucun non-inscrit.</p>
      {elseif $notifs->nonins|@count}
      <p>Tu surveilles {if $notifs->nonins|@count eq 1}le non-inscrit{else}les non-inscrits{/if} :</p>
      <ul>
        {foreach from=$notifs->nonins item=p}
        <li>
        {$p.prenom} {$p.nom} ({$p.promo}) <a href="?del_nonins={$p.uid}"><img src="{"images/retirer.gif"|url}" alt="retirer" /></a>
        </li>
        {/foreach}
      </ul>
      {/if}
    </td>
  </tr>
</table>

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
