{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2010 Polytechnique.org                             *}
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

<h1>Marketing Polytechnique.org</h1>

<table class="bicol" cellpadding="3" summary="Système">
  <tr>
    <th>actions disponibles</th>
  </tr>
  <tr class="impair">
    <td>
      <a href="search?nonins=1">Chercher un non inscrit</a>
      &nbsp;&nbsp;|&nbsp;&nbsp;
      <a href="marketing/promo">Marketing promo</a>
      &nbsp;&nbsp;|&nbsp;&nbsp;
      <a href="marketing/volontaire">Adresses données par les inscrits</a>
    </td>
  </tr>
</table>

<br />

<p>
Nombre d'X vivants d'après notre base de données&nbsp;: {$stats.vivants}<br />
Nombre d'X vivants inscrits à Polytechnique.org&nbsp;: {$stats.inscrits}<br />
Soit un pourcentage d'inscrits de&nbsp;: {$stats.ins_rate} %<br />
</p>

<p>
Parmi ceux-ci&nbsp;:<br />
Nombre d'X vivants depuis 1972 d'après notre base de données&nbsp;: {$stats.vivants72}<br />
Nombre d'X vivants depuis 1972 inscrits à Polytechnique.org&nbsp;: {$stats.inscrits72}<br />
Soit un pourcentage d'inscrits de&nbsp;: {$stats.ins72_rate} %<br />
</p>

<p>
Nombre de Polytechniciennes vivantes&nbsp;: {$stats.vivantes}<br />
Nombre de Polytechniciennes vivantes et inscrites&nbsp;: {$stats.inscrites}<br />
Soit un pourcentage d'inscrites de&nbsp;: {$stats.inse_rate} %<br />
</p>

<p>
Nombre d'<a href="marketing/this_week">inscrits ces 7 derniers jours</a>&nbsp;: {$nbInsSem}<br />
Nombre d'<a href="marketing/relance">inscriptions en cours</a> (2ème phase non terminée)&nbsp;: {$nbInsEnCours}
</p>

<table class="bicol">
  <tr>
    <th colspan="4">Marketings</th>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td class="titre">Abouti</td>
    <td class="titre">Non abouti</td>
    <td class="titre">Total</td>
  </tr>
  <tr>
    <td>Personnel</td>
    <td>{$nbInsMarketOkPerso}</td>
    <td>{$nbInsMarketNoPerso}</td>
    <td>{$nbInsMarketOkPerso+$nbInsMarketNoPerso}</td>
  </tr>
  <tr>
    <td>Par Polytechnique.org</td>
    <td>{$nbInsMarketOkXorg}</td>
    <td>{$nbInsMarketNoXorg}</td>
    <td>{$nbInsMarketOkXorg+$nbInsMarketNoXorg}</td>
  </tr>
  <tr>
    <td>Cette semaine</td>
    <td>{$nbInsMarketOkWeek}</td>
    <td>{$nbInsMarketNoWeek}</td>
    <td>{$nbInsMarketOkWeek+$nbInsMarketNoWeek}</td>
  </tr>
  <tr>
    <td class="titre">Total</td>
    <td>{$nbInsMarketOkPerso+$nbInsMarketOkXorg}</td>
    <td>{$nbInsMarketNoPerso+$nbInsMarketNoXorg}</td>
    <td>{$nbInsMarketOkPerso+$nbInsMarketOkXorg+$nbInsMarketNoPerso+$nbInsMarketNoXorg}</td>
  </tr>
</table>

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}
