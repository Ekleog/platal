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
        $Id: index.tpl,v 1.4 2004-09-20 21:31:29 x2000habouzit Exp $
 ***************************************************************************}

<div class="rubrique">
  Listes de diffusion de Polytechnique.org
</div>

<p>
Les listes de diffusion publiques sont visibles par tous les X inscrits � Polytechnique.org.
</p>

<div class='ssrubrique'>
  L'inscription � une liste de diffusion
</div>

<p>
Certaines listes sont � inscription mod�r�e, pour t'y inscrire, il te faut envoyer un mail aux
mod�rateurs en cliquant sur le lien "s'inscrire", si tu es d�j� inscrit, le mot "inscrit" appara�t
pr�s de la case � cocher.  Les autres listes sont dites libres : il suffit de cocher la case �
cocher et de cliquer sur le bouton "Enregistrer".
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

{include file='listes/listes.inc.tpl' min=0}

<div class="rubrique">
  Listes de diffusion priv�es
</div>

{include file='listes/listes.inc.tpl' min=1}

{perms level=admin}
<div class="rubrique">
  Listes d'administration
</div>

{include file='listes/listes.inc.tpl' min=2 max=4}

{/perms}

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
