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
        $Id: index.tpl,v 1.2 2004-11-04 15:48:45 x2000habouzit Exp $
 ***************************************************************************}

<h1>Carnet polytechnicien</h1>

<table class="bicol">
  <tr>
    <th colspan="2">
      Tes contacts
    </th>
  </tr>
  <tr class="impair">
    <td>
      <div class="question">
        <a href="{"carnet/mescontacts.php"|url}">Page de tes contacts</a>
      </div>
      <div class="explication">
        Tu peux ici lister tes contacts, en ajouter et en retirer.
      </div>
    </td>
    <td>
      <div class="question">
        <a href="{"carnet/mescontacts.php?trombi=1"|url}">Le trombi de tes contacts</a>
      </div>
      <div class="explication">
        La m�me chose que la page de tes contacts... <strong>en images !</strong>
      </div>
    </td>
  </tr>
  <tr class="pair">
    <td colspan="2">
      <div class="question">
        <a href="{"carnet/notifs.php"|url}">Notifications hebdomadaires automatiques</a>
      </div>
      <div class="explication">
        �tre notifi� des inscriptions, d�c�s, changement de fiche, ...
      </div>
    </td>
  </tr>
</table>

{* vim:set et sw=2 sts=2 sws=2: *}
