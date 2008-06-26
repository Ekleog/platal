{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2004 Polytechnique.org                             *}
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


{if $cp}
<table class="bicol" summary="Ruptures de service">
  <tr>
    <th colspan="2">d�tails de l'interruption de service</th>
  </tr>
  <tr class="pair">
    <td class="titre">d�but</td>
    <td>{$cp.debut|date_format:"%x %X"}</td>
  </tr>
  <tr class="pair">
    <td class="titre">dur�e</td>
    <td>{$cp.duree}</td>
  </tr>
  <tr class="impair">
    <td class="titre">r�sum�</td>
    <td>{$cp.resume}</td>
  </tr>
  <tr class="impair">
    <td class="titre">services</td>
    <td>
      {$cp.lg_services}
    </td>
  </tr>
  <tr class="pair">
    <td class="titre">description </td>
    <td>{$cp.description}</td>
  </tr>
</table>

<p class="center">
<a href="{$smarty.server.PHP_SELF}">retour � la liste</a>
</p>

{else}

<p>
  Tu trouveras ici les interruptions de service de Polytechnique.org qui ont �t�
  constat�es <strong>durant les trois derni�res semaines</strong>, ou qui sont pr�vues dans le futur.
  Il est � noter qu'� ce jour la quasi-totalit� des coupures proviennent 
  de d�faillances du r�seau de l'Ecole, o� nos serveurs sont h�berg�s (rupture de la
  connexion internet de l'Ecole, probl�me �lectrique, etc...).
</p>
<p>
  Pour avoir les d�tails d'une interruption particuli�re il te suffit de cliquer dessus.
</p>

<table class="bicol" summary="D�tail de la coupure">
  <tr>
    <th>date</th>
    <th>r�sum�</th>
    <th>services affect�s</th>
  </tr>
{iterate item=cp from=$coupures}
  <tr class="{cycle values="pair,impair"}">
    <td>
      <span class="smaller">
        {$cp.debut|date_format}
      </span>
    </td>
    <td>
      <span class="smaller">
        <a href="{$smarty.server.PHP_SELF}?cp_id={$cp.id}">{$cp.resume}</a>
      </span>
    </td>
    <td>
      <span class="smaller">
        {$cp.services}
      </span>
    </td>
  </tr>
{/iterate}
</table>
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
