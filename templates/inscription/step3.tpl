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
        $Id: step3.tpl,v 1.1 2004-09-05 22:01:11 x2000habouzit Exp $
 ***************************************************************************}


<div class="rubrique">
  Pr�-inscription r�ussie
</div>

<p>
La pr�-inscription que tu viens de soumettre a �t� enregistr�e.
</p>
{dynamic}
<p>
Les instructions te permettant notamment d'activer ton e-mail
<strong>{$forlife}@polytechnique.org</strong>, ainsi que ton mot de passe pour
acc&eacute;der au site viennent de t'�tre envoy�s � l'adresse
<strong>{$smarty.request.email}</strong>.
</p>
<p>
Tu n'as que quelques jours pour suivre ces instructions apr�s quoi la pr�-inscription
est effac�e automatiquement de nos bases et il faut tout recommencer. Si tu as soumis
plusieurs pr�-inscriptions, seul le dernier e-mail re�u est valable, les pr�c�dents
ne servant plus.
</p>
<p>
Si tu ne re�ois rien, v�rifie bien l'adresse <strong>{$smarty.request.email}</strong>.
</p>
{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
