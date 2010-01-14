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

{config_load file="mails.conf" section="xnet_unsubscription"}
{if $mail_part eq 'head'}
{from full=#from#}
{subject text="[`$group`] Désinscription de `$prenom` `$nom`"}
{elseif $mail_part eq 'wiki'}
Chers animateurs du groupe {$group},

{if $selfdone}
{$prenom} {$nom} ({$mail}) vient de se désinscrire du groupe.
{else}
{$prenom} {$nom} ({$mail}) vient d'être désinscrit du groupe par {$smarty.session.prenom} {$smarty.session.nom}.
{/if}

Cordialement,\\
L'Equipe de Polytechnique.org
{/if}
{* vim:set et sw=2 sts=2 sws=2: *}
