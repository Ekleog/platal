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

    <tr>
      <td colspan="5" class="pflags">
        <table class="flags" summary="Flags" cellpadding="0" cellspacing="0">
          <tr>
            <td class="vert">
              <input type="radio" name="{$name}" value="public" {if $val eq 'public'}checked="checked"{/if} />
            </td>
            <td class="texte">
              site public
            </td>
            <td class="orange">
              <input type="radio" name="{$name}" value="ax" {if $val eq 'ax'}checked="checked"{/if} />
            </td>
            <td class="texte">
              transmis � l'AX
            </td>
            <td class="rouge">
              <input type="radio" name="{$name}" value="private" {if $val eq 'private'}checked="checked"{/if} />
            </td>
            <td class="texte">
              prive
            </td>
            <td class="texte">
              <a href="{"docs/faq.php"|url}#flags" class="popup_800x240">Quelle couleur ??</a>
            </td>
          </tr>
        </table>
      </td>
    </tr>