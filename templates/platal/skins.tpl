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

<h1>Skins {#globals.core.sitename#}</h1>

<p>
Tu n'aimes pas les couleurs ou l'apparence de {#globals.core.sitename#} ? Normal, les go�ts et les
couleurs, �a ne se discute pas. Certains pr�f�rent une page s�rieuse, d'autres plus
fantaisiste. A toi de voir :)
</p>
<p>
Note aux utilisateurs du navigateur Netscape 4.x ou �quivalent.
La fonctionalit� "skins" n'est h�las pas compatible avec ces navigateurs
qui ne respectent pas les standards du web. <br />
Pour profiter de toutes les fonctionnalit�s de {#globals.core.sitename#},
nous te conseillons de t�l�charger une version r�cente de ton navigateur.
</p>
<p>
Pour toute information compl�mentaire, n'h�site pas � �crire �
<a href="mailto:support@{#globals.mail.domain#}?subject=navigateur">support@{#globals.mail.domain#}</a>
</p>

<table id="skin" cellpadding="0" cellspacing="0" summary="Choix de skins">
  {iterate item=skin from=$skins}
  <tr>
    <td class="skigauche">
      <input type="radio" name="newskin" value="{$skin.id}" {if $skin_id eq $skin.id}checked="checked"{/if}
        onclick="dynpostkv('prefs/skin', 'newskin', {$skin.id})" />
    </td>
    <td class="skimilieu">
      <strong>{$skin.name}</strong>
      ajout�e le {$skin.date|date_format}<br />
      {$skin.comment}
      <br /><br />
      Cr��e par <strong>{$skin.auteur}</strong>
      <br /><br />
      Utilis�e par <strong>{$skin.nb}</strong> inscrit{if $skin.nb>1}s{/if}
    </td>
    <td class="skidroite">
      <img src="images/skins/{$skin.name}.{$skin.ext}" style="width:160px; height:160px;" alt=" [ CAPTURE D'ECRAN ] " />
    </td>
  </tr>
  {/iterate}
</table>

{* vim:set et sw=2 sts=2 sws=2: *}
