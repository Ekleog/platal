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
        $Id: index.tpl,v 1.2 2004-09-10 21:28:53 x2000habouzit Exp $
 ***************************************************************************}

<div class="rubrique">
  Listes de diffusion de Polytechnique.org
</div>

<p>
Les listes de diffusion publiques sont visibles par tous les X inscrits � Polytechnique.org.
</p>

<div class='ssrubrique'>
  L'inscription � une liste de diffusion
</div>

<p>
Certaines listes sont � inscription mod�r�e, pour t'y inscrire, il te faut envoyer un mail aux
mod�rateurs en cliquant sur le lien "s'inscrire", si tu es d�j� inscrit, le mot "inscrit" appara�t
pr�s de la case � cocher.  Les autres listes sont dites libres : il suffit de cocher la case �
cocher et de cliquer sur le bouton "Enregistrer".
</p>

<p>
Dans tous les cas, pour se d�sinscrire, il suffit de d�cocher la case et de cliquer sur
"Enregistrer".  
</p>

<p>
Si tu vois une * derri�re le nom d'une liste, cela signifie que tu en es gestionnaire.  En cliquant
sur la liste, tu pourras administrer les abonn�s et les gestionnaires de la liste.
</p>

<div class='ssrubrique'>
  La diffusion sur une liste de diffusion 
</div>
<p>
Certaines listes sont � diffusion mod�r�e, l'envoi d'un mail � la liste est alors filtr� par des
mod�rateurs : eux seuls peuvent accepter un message envoy� � la liste.  Pour les autres listes, la
diffusion est imm�diate.
</p>
<p class='smaller'>
NB : les gestionnaires d'une liste sont aussi ses mod�rateurs.  
</p>

{dynamic}

<div class="rubrique">
  Listes de diffusion publiques
</div>

<table class='bicol' cellpadding='0' cellspacing='0'>
  <tr>
    <th>Liste</th>
    <th>Description</th>
    <th>Diffusion</th>
    <th>Inscription</th>
  </tr>
  {foreach from=$listes item=liste}
  {if $liste.priv eq 0}
  <tr class='{cycle values="impair,pair"}'>
    <td>{$liste.list}{if $liste.you>1}*{/if}</td>
    <td>{$liste.desc}</td>
    <td class='center'>{if $liste.diff}mod�r�e{else}libre{/if}</td>
    <td class='right'>{if $liste.you is odd}d�sinscription{elseif $liste.ins}ins mod�r�e{else}inscription{/if}</td>
  </tr>
  {/if}
  {/foreach}
</table>

<div class="rubrique">
  Listes de diffusion priv�es
</div>

<table class='bicol' cellpadding='0' cellspacing='0'>
  <tr>
    <th>Liste</th>
    <th>Description</th>
    <th>Diffusion</th>
    <th>Inscription</th>
  </tr>
  {foreach from=$listes item=liste}
  {if $liste.priv eq 1}
  <tr class='{cycle values="impair,pair"}'>
    <td>{$liste.list}{if $liste.you>1}*{/if}</td>
    <td>{$liste.desc}</td>
    <td class='center'>{if $liste.diff}mod�r�e{else}libre{/if}</td>
    <td class='right'>{if $liste.you is odd}d�sinscription{elseif $liste.ins}ins mod�r�e{else}inscription{/if}</td>
  </tr>
  {/if}
  {/foreach}
</table>

{perms level=admin}
<div class="rubrique">
  Listes d'administration
</div>

<table class='bicol' cellpadding='0' cellspacing='0'>
  <tr>
    <th>Liste</th>
    <th>Description</th>
    <th>Diffusion</th>
    <th>Inscription</th>
  </tr>
  {foreach from=$listes item=liste}
  {if $liste.priv > 1}
  <tr class='{cycle values="impair,pair"}'>
    <td>{$liste.list}{if $liste.you>1}*{/if}</td>
    <td>{$liste.desc}</td>
    <td class='center'>{if $liste.diff}mod�r�e{else}libre{/if}</td>
    <td class='right'>{if $liste.you is odd}d�sinscription{elseif $liste.ins}ins mod�r�e{else}inscription{/if}</td>
  </tr>
  {/if}
  {/foreach}
</table>
{/perms}

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
