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

<img src='getlogo.php' alt="LOGO" style="float: right;" />

<h1>{$asso.nom} : �diter l'accueil</h1>

<form method="post" action="{$smarty.server.PHP_SELF}" enctype="multipart/form-data">
  <table cellpadding="0" cellspacing="0">
    {perms level=admin}
    <tr>
      <td class="titre">
        Nom:
      </td>
      <td>
        <input type="text" size="40" value="{$asso.nom}" name="nom" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Diminutif:
      </td>
      <td>
        <input type="text" size="40" value="{$asso.diminutif}" name="diminutif" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Nom de Domaine:
      </td>
      <td>
        <input type="text" size="40" value="{$asso.mail_domain}" name="mail_domain" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Cat�gorie :
      </td>
      <td>
        <select name="cat">
          <option value="groupesx" {if $asso.cat eq GroupesX}selected="selected"{/if}>Groupes X</option>
          <option value="binets" {if $asso.cat eq Binets}selected="selected"{/if}>Binets</option>
          <option value="promotions" {if $asso.cat eq Promotions}selected="selected"{/if}>Promotions</option>
          <option value="institutions" {if $asso.cat eq Institutions}selected="selected"{/if}>Institutions</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="titre">
        Domaine:
      </td>
      <td>
        <select name="dom">
          <option value=""></option>
          {iterate from=$dom item=d}
          <option value="{$d.id}" {if $d.id eq $asso.id}selected="selected"{/if}>{$d.nom} [{$d.cat}]</option>
          {/iterate}
        </select>
      </td>
    </tr>
    <tr>
      <td colspan="2">&nbsp;</td>
    </tr>
    {/perms}

    <tr>
      <td class="titre">
        Logo:
      </td>
      <td>
        <input type="file" name="logo" />
      </td>
    </tr>

    <tr>
      <td class="titre">
        Site Web:
      </td>
      <td>
        <input type="text" size="40" value="{$asso.site}" name="site" />
      </td>
    </tr>

    <tr>
      <td class="titre">
        Contact:
      </td>
      <td>
        <input type="text" size="40" name="resp" value="{$asso.resp}" />
      </td>
    </tr>

    <tr>
      <td class="titre">
        Adresse mail:
      </td>
      <td>
        <input type="text" size="40" name="mail" value="{$asso.mail}" />
      </td>
    </tr>

    <tr>
      <td class="titre">
        Forum:
      </td>
      <td>
        <input type="text" size="40" name="forum" value="{$asso.forum}" />
      </td>
    </tr>

    <tr>
      <td class="titre">
        <strong>TODO: INSCRIPTION</strong>
      </td>
    </tr>

    <tr>
      <td class="titre center" colspan="2">
        <input type="checkbox" value="1" name="ax" {if $asso.ax}checked="checked"{/if} />
        groupe agr�� par l'AX
      </td>
    </tr>
  </table>

  <div class="center">
    <br />
    <textarea name="descr" cols="70" rows="15">{$asso.descr}</textarea>
    <input type="submit" name="submit" value="Enregistrer" />
  </div>
</form>

{* vim:set et sw=2 sts=2 sws=2: *}