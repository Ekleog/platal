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
        $Id: valid.alias.tpl,v 1.3 2004-09-02 21:09:33 x2000habouzit Exp $
 ***************************************************************************}

{config_load file="mails.conf" section="valid_alias"}
{subject text="[Polytechnique.org/MELIX] Demande de l'alias $alias@melix.net par $forlife"}
{from full=#from#}
{to addr="$forlife@polytechnique.org"}
{cc full=#cc#}
{if $answer eq "yes"}
Cher(e) camarade,

  Les adresses e-mail {$alias}@melix.net et {$alias}@melix.org que tu avais demand�es viennent d'�tre cr��es, tu peux d�sormais les utiliser � ta convenance.

Cordialement,
L'�quipe X.org
{elseif $answer eq 'no'}

Cher(e) camarade,

  La demande que tu avais faite pour les alias {$alias}@melix.net et {$alias}@melix.org a �t� refus�e pour la raison suivante :
{$motif}

Cordialement,
L'�quipe X.org
{/if}
{* vim:set et sw=2 sts=2 sws=2: *}
