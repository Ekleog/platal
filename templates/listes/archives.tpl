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
        $Id: archives.tpl,v 1.2 2004-11-29 21:42:08 x2000habouzit Exp $
 ***************************************************************************}

{dynamic}

{if $no_list}

<p class='erreur'>La liste n'existe pas ou tu n'as pas le droit d'en voir les d�tails</p>

{else}

{include file="listes/header_listes.tpl" on=archives}


{if $archs}
<h1>Archives de la liste {$smarty.request.liste}</h1>
<table class="tinybicol" cellspacing="0" cellpadding="0">
  <tr>
    <th>Ann�e</th>
    <th colspan="6">
      Mois
    </th>
  </tr>
  {foreach from=$archs item=m key=y}
  <tr class="center">
    <td class="titre" rowspan="2">{$y}</td>
    {foreach from=$range item=i}
    <td>
      {if $m[$i]}
      [<a href="?liste={$smarty.request.liste}&amp;rep={$y}/{$i|string_format:"%02u"}&amp;file=dates.html">{"0000-$i-01"|date_format:"%b"}</a>]
      {else}
      [&nbsp;&nbsp;&nbsp;]
      {/if}
    </td>
    {if $i eq 6}</tr><tr class="center">{/if}
    {/foreach}
  </tr>
  {/foreach}
</table>
{elseif $url}
{include file="$url"}
{/if}

{/if}

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
