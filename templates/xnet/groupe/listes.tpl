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

{if $smarty.get.del_alias}

<p class="error">Est tu sur de supprimer l'alias {$smarty.get.del_alias} ?</p>
<form action='{$smarty.server.PHP_SELF}' method="post">
  <div class="center">
    <input type='submit' value="Oui, je suis sur" />
    <input type='hidden' name='del_alias' value="{$smarty.get.del_alias}" />
  </div>
</form>
<p>[<a href='listes.php'>retour � la page des listes</a>]</p>

{else}

<h1>{$asso.nom} : Listes de diffusion</h1>

<h2>Listes de diffusion du groupe {$asso.nom} :</h2>

<p class="descr">
Une liste dont <strong>la diffusion</strong> est mod�r�e est une liste dont les mails sont valid�s
par les administrateurs avant d'�tre transmis aux membres de la liste.  Une liste dont
<strong>l'inscription</strong> est mod�r�e est une liste pour laquelle l'abonnement est soumis �
l'accord pr�alable des responsables du groupe.
</p>
<p class="descr">
La derni�re colonne du tableau t'indique si tu es inscrit{if $smarty.session.femme}e{/if} ou non �
la liste. Dans le premier cas, une croix rouge te permet de te d�sabonner. Dans le second cas, une
croix verte te permet de t'inscrire, apr�s accord des responsables si l'inscription est mod�r�e.
</p>

<table cellpadding="0" cellspacing="0" class='large'>
  <tr>
    <th>Liste</th>
    <th>Description</th>
    <th>Diffusion</th>
    <th>Inscription</th>
    <th>Nb</th>
    <th>&nbsp;</th>
  </tr>
  {foreach from=$listes item=l}
  <tr>
    <td>
      <a href="mailto:{$l.list}@{$asso.mail_domain}"><img src="{rel}/images/mail.png" alt='[mail]' /></a>
      <a href='listes-members.php?liste={$l.list}'>{$l.list} {if $l.priv}<sup>#</sup>{/if}{if $l.own}<sup>o</sup>{/if}</a>
    </td>
    <td>{$l.desc}</td>
    <td class='center'>
      {if $l.diff eq 2}mod�r�e{elseif $l.diff eq 1}restreinte{else}libre{/if}
    </td>
    <td class='center'>{if $l.ins}mod�r�e{else}libre{/if}</td>
    <td align='right'>{$l.nbsub}</td>
    <td align='right'>
      {if $l.sub eq 2}
      <a href="?del={$l.list}"><img src="{rel}/images/del.png" alt="[d�sinscrire]" title="me d�sinscrire" /></a>
      {elseif $l.sub eq 1}
      <img src="{rel}/images/flag.png" alt="[en attente]" title="en attente de mod�ration" />
      {else}
      <a href="?add={$l.list}"><img src="{rel}/images/ajouter.gif" alt="[m'inscrire]" title="m'inscrire" /></a>
      {/if}
    </td>
  </tr>
  {foreachelse}
  <tr><td colspan='6'>Pas de listes pour ce groupe</td></tr>
  {/foreach}
</table>

<p class="descr">
<sup>o</sup>: tu es {if $smarty.session.femme}mod�ratrice{else}moderateur{/if} sur cette liste<br />
<sup>#</sup>: cette liste est invisible aux non-membres de la liste. S'en d�sabonner
t'emp�cherait de t'y r�abonner par la suite sans l'aide d'un administrateur.
</p>
        
<h2>Voici les alias existants pour le groupe {$asso.nom} :</h2>

{if $alias->total()}
<table cellspacing="0" cellpadding="0" class='large'>
  <tr>
    <th{if $may_update} colspan='3'{/if}>Alias</th>
  </tr>
  {iterate from=$alias item=a}
  <tr>
    {if $may_update}
    <td class="center"><a href='mailto:{$a.alias}'><img src='{rel}/images/mail.png' alt='[mail]' /></a></td>
    <td><a href="alias-admin.php?liste={$a.alias}">{$a.alias}</a></td>
    <td class="center"><a href="?del_alias={$a.alias}"><img src='{rel}/images/del.png' alt='[supprimer]' /></a></td>
    {else}
    <td><a href='mailto:{$a.alias}'><img src='{rel}/images/mail.png' alt='[mail]' /> {$a.alias}</a></td>
    {/if}
  </tr>
  {/iterate}
</table>
{else}
<p>Aucun alias pour ce groupe</p>
{/if}

{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
