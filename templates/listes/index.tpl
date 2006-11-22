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

<h1>
  Listes de diffusion de Polytechnique.org
</h1>

<h2>L'inscription � une liste de diffusion</h2>

<ul>
  <li>Pour demander ton inscription � une liste de diffusion, il suffit
    de cliquer sur l'ic�ne {icon name=add} situ�e en fin de ligne</li>
  <li>Si la liste est � inscription mod�r�e, l'ic�ne {icon name=flag_orange title="en cours"} 
    appara�tra tant que ton inscription n'aura pas �t� valid�e par un mod�rateur</li>
  <li>Pour te d�sinscrire d'une liste dont tu es membre, il suffit de cliquer sur la croix
    {icon name=cross title="d�sinscription"} situ�e en fin de ligne</li>
</ul>

<h2>La diffusion sur une liste de diffusion</h2>
<p>
La diffusion a trois niveaux de mod�ration.  La diffusion peut �tre :
</p>
<ul>
  <li><strong>libre :</strong> tout le monde peut y envoyer des mails, la diffusion y est
  imm�diate;</li>
  <li><strong>restreinte :</strong> les membres de la liste peuvent envoyer librement des mails,
  les ext�rieurs sont mod�r�s;</li>
  <li><strong>mod�r�e:</strong> l'envoi d'un mail � la liste est alors filtr� par des
  mod�rateurs, eux seuls peuvent accepter un message envoy� � la liste.</li>
</ul>

<h1>Demander la cr�ation d'une liste de diffusion</h1>

<p>
Nos listes ont pour but de r�unir des X autour de th�mes ou centres d'int�r�t communs.  C'est un
moyen pratique et efficace de rassembler plusieurs personnes autour d'un projet commun ou d'une
th�matique particuli�re.
</p>

<p class="center">
{icon name=add title="Nouvelle liste"} <a href='lists/create'>
  Tu peux demander la cr�ation d'une liste de diffusion sur le th�me de ton choix.
</a>
</p>

{if $owner|@count}
<h1>Listes dont tu es mod�rateur</h1>

{include file='listes/listes.inc.tpl' lists=$owner}

<p class='smaller'>
{icon name=wrench title="Mod�rateur"} indique que tu es mod�rateur de la liste, les mod�rateurs jouent �galement le r�le de  seionnaire.<br />
{icon name=error title="Mod�rateur mais non-membre"} indque que tu es mod�rateur de la liste, mais que tu n'en es pas membre.
</p>
{/if}
{if $member|@count}
<h1>Listes dont tu es membre</h1>

{assign var="has_private" value=false}
{include file='listes/listes.inc.tpl' lists=$member}

<p class="smaller">Attention : Lorsqu'une liste � laquelle tu es abonn� est  priv�e, l'ic�ne {icon name=weather_cloudy} est affich�e en d�but de ligne.  Si tu t'en d�sinscrits, il ne te sera pas possible de t'y abonner de nouveau  sans l'action d'un mod�rateur</p>
{/if}
<h1>Listes de diffusion publiques auxquelles tu peux t'inscrire</h1>

<p>
Les listes de diffusion publiques sont visibles par tous les X inscrits � Polytechnique.org.
</p>

{if $public|@count}
{include file='listes/listes.inc.tpl' lists=$public}

<br />
{/if}

<form method='post' action='lists'>
  <table class='tinybicol' cellspacing='0' cellpadding='2'>
    <tr>
      <th colspan='2'>Inscription � une liste de diffusion promo</th>
    </tr>
    <tr>
      <td class='titre'>Promotion:</td>
      <td>
        <input type='text' size='4' maxlength='4' name='promo_add' />
        &nbsp;
        <input type='submit' value="m'inscrire" />
      </td>
    </tr>
  </table>
</form>

{* vim:set et sw=2 sts=2 sws=2: *}
