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
        $Id: index.tpl,v 1.5 2004-09-22 12:51:08 x2000habouzit Exp $
 ***************************************************************************}

{if $smarty.request.add}
<p class='erreur'>
Ta demande d'inscription sur {$smarty.request.add} a �t� prise en compte.
</p>
{/if}

<div class="rubrique">
  Listes de diffusion de Polytechnique.org
</div>

<div class='ssrubrique'>
  L'inscription � une liste de diffusion
</div>

<p>
Certaines listes sont � inscription mod�r�e, l'inscription n'y est pas
imm�diate.  Il faut en effet l'action d'un mod�rateur de la liste pour valider
(ou �ventuellement refuser) ta candidature.
</p>

<p>
Dans tous les cas, pour se d�sinscrire, il suffit de d�cocher la case et de cliquer sur
"Enregistrer".  
</p>

<div class='ssrubrique'>
  La diffusion sur une liste de diffusion 
</div>
<p>
Certaines listes sont � diffusion mod�r�e, l'envoi d'un mail � la liste est alors filtr� par des
mod�rateurs : eux seuls peuvent accepter un message envoy� � la liste.  Pour les autres listes, la
diffusion est imm�diate.
</p>
<p class='smaller'>
NB : les gestionnaires d'une liste sont aussi ses mod�rateurs.  
</p>

{dynamic}

<div class="rubrique">
  Listes de diffusion publiques
</div>

<p>
Les listes de diffusion publiques sont visibles par tous les X inscrits � Polytechnique.org.
</p>

{include file='listes/listes.inc.tpl' min=0}

<div class="rubrique">
  Listes de diffusion priv�es
</div>

<p>
Si tu te d�sinscrit de ces listes, tu ne seras plus capable de t'y r�inscrire par toi m�me !
</p>

{include file='listes/listes.inc.tpl' min=1}

{perms level=admin}
<div class="rubrique">
  Listes d'administration
</div>

{include file='listes/listes.inc.tpl' min=2 max=4}

{/perms}

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
