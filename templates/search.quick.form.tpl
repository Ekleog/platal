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

<h1>Recherche simple dans l'annuaire</h1>

<form action="{"search.php"|url}" method="get"{if $show_js} id="quick_form"{/if}>
  <table class="bicol" cellspacing="0" cellpadding="4">
    <tr>
      <td style="width: 78%">
        <input type='text' name="quick" value="{$smarty.request.quick}" style="width: 100%" /><br />
        {min_auth level='cookie'}
        <input type='checkbox' name='mod_date_sort' {if $smarty.request.mod_date_sort}checked='checked'{/if} />
        mettre les fiches modifi�es r�cemment en premier
        {if $smarty.request.nonins}
        <br /><input type='checkbox' name='nonins' readonly="readonly" checked='checked' value='1' /> Chercher uniquement des non inscrits
        {/if}
        {/min_auth}
      </td>
      <td>
        <input type="submit" value="Chercher" />
        {min_auth level="cookie"}
        <br /><a class='smaller' href="advanced_search.php">Recherche&nbsp;avanc�e</a>
        {/min_auth}
      </td>
    </tr>
  </table>
</form>

<br />

{if $show_js}
{literal}
<script type="text/javascript">
  <!--
  // Activate the first search input field.
  document.getElementById("quick_form").quick.focus();
  // -->
</script>
{/literal}
{/if}
{* vim:set et sw=2 sts=2 sws=2: *}
