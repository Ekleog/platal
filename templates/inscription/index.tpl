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
        $Id: index.tpl,v 1.1 2004-09-05 22:01:11 x2000habouzit Exp $
 ***************************************************************************}


<form action="{"inscription/step1.php"|url}" method="post">
  <div class="rubrique">
    Conditions g�n�rales
  </div>
  <p>
  L'enregistrement se d�roule <strong>en deux �tapes</strong>. La pr�-inscription te prendra moins
  de 5 minutes. La seconde �tape est une phase de validation o� c'est nous qui te
  recontactons pour te fournir un mot de passe et te demander de le changer.
  </p>
  {include file="docs/charte.tpl"}
  <div class="center">
    <input type="submit" value="J'accepte ces conditions" name="submit" />
  </div>
</form>


{* vim:set et sw=2 sts=2 sws=2: *}
