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

      <div class="adresse">
      	<table>
        {if $address.entreprise}
        <tr>
          <td><em>Ent/Org: </em></td>
          <td><strong>{$address.entreprise}{if $address.web} [<a href='{$address.web}'>site</a>]{/if}</strong></td>
        </tr>
        {/if}
        {if $address.secteur}
        <tr>
          <td><em>Secteur: </em></td>
          <td><strong>{$address.secteur}{if $address.ss_secteur} ({$address.ss_secteur}){/if}</strong></td>
        </tr>
        {/if}

        {if $address.fonction}
        <tr>
          <td><em>Fonction: </em></td>
          <td><strong>{$address.fonction}</strong></td>
        </tr>
        {/if}
        {if $address.poste}
        <tr>
          <td><em>Poste: </em></td>
          <td><strong>{$address.poste}</strong></td>
        </tr>
        {/if}
        {if $address.email}
        <tr>
          <td><em>E-mail: </em></td>
          <td><strong>{$address.email}</strong></td>
        </tr>
        {/if}
        </table>
      </div>

{* vim:set et sws=2 sts=2 sw=2: *}