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


<h1>
  Lettre de Polytechnique.org
</h1>

<p>
<strong>Pour demander l'ajout d'une annonce dans la prochaine lettre mensuelle</strong>,
utilise <a href='submit.php'>le formulaire d�di� !</a>
</p>

<h2>Ton statut</h2>

{if $nls eq html}
<p>
Tu es actuellement inscrit � la lettre mensuelle de Polytechnique.org dans sont format HTML !
</p>
{elseif $nls eq text}
<p>
Tu es actuellement inscrit � la lettre mensuelle de Polytechnique.org dans sont format texte !
</p>
{else}
<p>
Tu n'es actuellement pas inscrit � la lettre mensuelle de Polytechnique.org.
</p>
{/if}

{if $nls neq "text"}
<p>
Pour recevoir la version texte suis le lien :
</p>
<div class='center'>
  [<a href='?in=text'>m'inscrire pour le format texte</a>]
</div>
{/if}

{if $nls neq "html"}
<p>
Pour recevoir la version HTML suis le lien :
</p>
<div class='center'>
  [<a href='?in=html'>m'inscrire pour le format HTML</a>]
</div>
{/if}

{if $nls}
<p>
Pour te d�sinscrire suis le lien :
</p>
<div class='center'>
  [<a href='?out=1'>me d�sinscrire</a>]
</div>
{/if}

<h2>Les archives</h2>

<table class="bicol" cellpadding="3" cellspacing="0" summary="liste des NL">
  <tr>
    <th>date</th>
    <th>titre</th>
  </tr>
  {foreach item=nl from=$nl_list}
  <tr class="{cycle values="impair,pair"}">
    <td>{$nl.date|date_format}</td>
    <td>
      <a href="{"newsletter/show.php"|url}?nid={$nl.id}">{$nl.titre}</a>
    </td>
  </tr>
  {/foreach}
</table>


{* vim:set et sw=2 sts=2 sws=2: *}
