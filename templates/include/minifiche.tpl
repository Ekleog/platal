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
 ***************************************************************************}


{if !$c.inscrit || $c.dcd}<div class='grayed'>{/if}
<div class="contact" {if $c.inscrit}{min_auth level='cookie'}title="fiche mise � jour le {$c.date|date_format}"{/min_auth}{/if}>
  <div class="nom">
    {if $c.sexe}&bull;{/if}
    {min_auth level="cookie"}
    {if !$c.dcd && $c.inscrit}
    <a href="{"fiche.php"|url}?user={$c.forlife}" class="popup2">
    {/if}
    {/min_auth}
    {if $c.epouse}{$c.epouse} {$c.prenom}<br />(n�e {$c.nom}){else}{$c.nom} {$c.prenom}{/if}
    {min_auth level="cookie"}
    {if !$c.dcd && $c.inscrit}
    </a>
    {/if}
    {/min_auth}
  </div>
  <div class="appli">
    {if $c.iso3166}
    <img src='{"images/"|url}flags/{$c.iso3166}.gif' alt='{$c.nat}' height='14' title='{$c.nat}' />&nbsp;
    {/if}
    (X {$c.promo}{if $c.app0text}, {applis_fmt type=$c.app0type text=$c.app0text url=$c.app0url}
    {/if}{if $c.app1text}, {applis_fmt type=$c.app1type text=$c.app1text url=$c.app1url}{/if})
    {if $c.dcd}d�c�d�{if $c.sexe}e{/if} le {$c.deces|date_format}{/if}
    {min_auth level="cookie"}
    {if !$c.dcd && !$c.wasinscrit}
    <a href="{"marketing/public.php"|url}?num={$c.matricule}" class='popup'>clique ici si tu connais son adresse email !</a>
    {/if}
    {/min_auth}
  </div>
  {min_auth level="cookie"}{include file="include/minifiche_pvt.tpl"}{/min_auth}
  {only_public}<div class="long"></div>{/only_public}
</div>
{if !$c.inscrit || $c.dcd}</div>{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
