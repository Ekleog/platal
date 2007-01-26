{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2007 Polytechnique.org                             *}
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

<td style="width: 16px">
  {if $liste.own && $liste.sub}
  {icon name=wrench title="Mod�rateur"}
  {elseif $liste.own}
  {icon name=error title="Mod�rateur mais non-membre"}
  {elseif $liste.priv}
  {icon name=weather_cloudy title="Liste priv�e"}
  {/if}
</td>
<td>
  <a href='{$platal->ns}lists/members/{$liste.list}'>{$liste.list}</a> 
</td>
<td>
  {$liste.desc}<br/>
  {if $liste.subscriptions|@count}
  <strong>&bull; Demandes d'inscription</strong><br />
  {foreach from=$liste.subscriptions item=s}
    <a href='{$platal->ns}lists/moderate/{$liste.list}?sadd={$s.id}'
        onclick="return (is_IE || Ajax.update_html('list_{$liste.list}', '{$platal->ns}lists/ajax/{$liste.list}?sadd={$s.id}'));">
      {icon name=add title="Accepter"}
    </a>
    <a href='{$platal->ns}lists/moderate/{$liste.list}?sid={$s.id}'>
      {icon name=delete title="Refuser"}
    </a>
    {$s.name}
    {if $s.login}
    <a href="profile/{$s.login}" class="popup2">{icon name=user_suit title="Afficher la fiche"}</a>
    {/if}
    <br />
  {/foreach}
  {/if}
  {if $liste.mails|@count}
  <strong>&bull; Demandes de mod�ration</strong><br />
  <span class="smaller">
  {foreach from=$liste.mails item=m}
    <a href='{$platal->ns}lists/moderate/{$liste.list}?mid={$m.id}&amp;mok=1'
        onclick="return (is_IE || Ajax.update_html('list_{$liste.list}', '{$platal->ns}lists/ajax/{$liste.list}?mid={$m.id}&amp;mok=1'));">
      {icon name=add title="Valider le mail"}
    </a>
    <a href='{$platal->ns}lists/moderate/{$liste.list}?mid={$m.id}&amp;mdel=1'
        onclick="return (is_IE || Ajax.update_html('list_{$liste.list}', '{$platal->ns}lists/ajax/{$liste.list}?mid={$m.id}&amp;mdel=1'));">
      {icon name=delete title="D�truire"}
    </a>
    De : {$m.sender}<br />
    <a href='{$platal->ns}lists/moderate/{$liste.list}?mid={$m.id}'>
      {icon name=magnifier title="Voir le message"}
    </a>
    Sujet : {$m.subj|hdc|default:"[pas de sujet]"}<br />
  {/foreach}
  </span>
  {/if}
</td>
<td class='center'>
  {if $liste.diff eq 2}mod�r�e{elseif $liste.diff}restreinte{else}libre{/if}
</td>
<td class='center'>
  {if $liste.ins}mod�r�e{else}libre{/if}
</td>
<td class='right'>{$liste.nbsub}</td>
<td class='right'>
  {if $liste.sub eq 2}
  <a href='{$platal->ns}lists?del={$liste.list}'
      onclick="return (is_IE || Ajax.update_html('list_{$liste.list}', '{$platal->ns}lists/ajax/{$liste.list}?unsubscribe=1'));">
    {icon name=cross title="me d�sinscrire"}
  </a>
  {elseif $liste.sub eq 1}
  {icon name=flag_orange title='inscription en attente de mod�ration'}
  {else}
  <a href='{$platal->ns}lists?add={$liste.list}'
      onclick="return (is_IE || Ajax.update_html('list_{$liste.list}', '{$platal->ns}lists/ajax/{$liste.list}?subscribe=1'));">
    {icon name=add title="m'inscrire"}
  </a>
  {/if}
 </td>

{* vim:set et sw=2 sts=2 sws=2: *}
