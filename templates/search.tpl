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
        $Id: search.tpl,v 1.12 2004-08-31 22:21:05 x2000habouzit Exp $
 ***************************************************************************}

{dynamic}
{if $formulaire==0 and !$error}
  <div class="rubrique">
    R�sultats
  </div>
  <table style="width: 100%">
    <tr>
      <td class="titre">
        {if $nb_resultats_total==0}Aucune{else}{$nb_resultats_total}{/if} r�ponse{if $nb_resultats_total>1}s{/if}.
      </td>
      <td class="right titre">
        {if $with_soundex==0}
        <a href="{$smarty.server.PHP_SELF}?with_soundex=1&amp;rechercher=1&amp;{$url_args}">
          Recherche par proximit� sonore</a>&nbsp;
        {/if}
        <a href="{$smarty.server.PHP_SELF}">Nouvelle recherche</a>
      </td>
    </tr>
  </table>
  <div class="contact-list" style="clear:both">
    {section name=resultat loop=$resultats}
    <div class="contact">
    <div class="{if $resultats[resultat].inscrit==1}pri3{else}pri1{/if}">
      {include file="search.result.public.tpl" result=$resultats[resultat]}
      {min_auth level="cookie"}
	{include file="search.result.private.tpl" result=$resultats[resultat]}
      {/min_auth}
      <div class="long"></div>
    </div>
    </div>
    {/section}
  </div>
  {if $perpage < $nb_resultats_total}
  <p>
    {if $offset!=0}
      <a href="{$smarty.server.PHP_SELF}?with_soundex={$with_soundex}&amp;rechercher=1&amp;{$url_args}&amp;offset={$offset-$perpage}">
        Pr�c�dent
      </a>
      &nbsp;
    {/if}
    {section name=offset loop=$offsets}
      {if $offset!=$smarty.section.offset.index*$perpage}
        <a href="{$smarty.server.PHP_SELF}?with_soundex={$with_soundex}&amp;rechercher=1&amp;{$url_args}&amp;offset={$smarty.section.offset.index*$perpage}">
          {$smarty.section.offset.index+1}
        </a>
      {else}
        <strong>{$smarty.section.offset.index+1}</strong>
      {/if}
      &nbsp;
    {/section}
    {if $offset < $nb_resultats_total-$perpage}
      <a href="{$smarty.server.PHP_SELF}?with_soundex={$with_soundex}&amp;rechercher=1&amp;{$url_args}&amp;offset={$offset+$perpage}">
        Suivant
      </a>
      &nbsp;
    {/if}
  </p>
  {/if}
{else}
  {include file="search.form.tpl"}
{/if}
{/dynamic}
{* vim:set et sw=2 sts=2 sws=2: *}
