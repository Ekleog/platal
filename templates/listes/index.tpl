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
        $Id: index.tpl,v 1.11 2004-10-09 12:49:38 x2000habouzit Exp $
 ***************************************************************************}

<div class="rubrique">
  Listes de diffusion de Polytechnique.org
</div>

<div class='ssrubrique'>
  L'inscription � une liste de diffusion
</div>

<p>
Pour t'inscrire � une liste il suffit de cliquer sur l'icone
<img src="{"images/ajouter.gif"|url}" alt="[ inscription ]" /> situ�e en fin de ligne.
</p>

<p>
Certaines listes sont � inscription mod�r�e, l'inscription n'y est pas
imm�diate.  Il faut en effet l'action d'un mod�rateur de la liste pour valider
(ou �ventuellement refuser) ta candidature.  Ces listes apparaissent avec l'icone 
<img src="{"images/flag.png"|url}" alt="[ en cours ]" />.
</p>

<p>
Pour se d�sinscrire, il suffit de la m�me mani�re de cliquer sur l'icone
<img src="{"images/retirer.gif"|url}" alt="[ d�sinscription ]" />.
</p>

<div class='ssrubrique'>
  La diffusion sur une liste de diffusion 
</div>
<p>
La diffusion a trois niveaux de mod�ration.  La diffusion peut �tre :
</p>
<ul>
  <li>libre : tout le monde peut y envoyer des mails, la diffusion y est
  imm�diate;</li>
  <li>restreinte : les membres de la liste peuvent envoyer librement des mails,
  les ext�rieurs sont mod�r�s;</li>
  <li>mod�r�e: l'envoi d'un mail � la liste est alors filtr� par des
  mod�rateurs, eux seuls peuvent accepter un message envoy� � la liste.</li>
</ul>

<p class='smaller'>
NB : les gestionnaires d'une liste sont aussi ses mod�rateurs.<br />
les listes avec une asterisque sont les listes dont tu es le gestionnaire.
</p>

<div class='ssrubrique'>
  Demander la cr�ation d'une liste de diffusion
</div>

<p>
Nos listes ont pour but de r�unir des X autour de th�mes ou centres d'int�r�t communs.  C'est un
moyen pratique et efficace de rassembler plusieurs personnes autour d'un projet commun ou d'une
th�matique particuli�re.
</p>
<p>
Tu peux demander <a href='create.php'>la cr�ation</a> d'une liste de diffusion sur le th�me de ton choix.  
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
  Listes de diffusion priv�es (et de promo)
</div>

<p>
Si tu te d�sinscrit de ces listes, tu ne seras plus capable de t'y r�inscrire par toi m�me !
</p>

{include file='listes/listes.inc.tpl' min=1}

<br />

<form method='post' action='{$smarty.server.REQUEST_URI}'>
  <table class='tinybicol' cellspacing='0' cellpadding='2'>
    <tr>
      <th colspan='2'>Inscription � une liste de diffusion promo</th>
    </tr>
    <tr>
      <td class='titre'>Promotion:</td>
      <td>
        <input type='text' size='4' maxlength='4' name='promo_add' />
        &nbsp;
        <input type='submit' value="m'inscrire" />
      </td>
    </tr>
  </table>
</form>

{perms level=admin}
<div class="rubrique">
  Listes d'administration
</div>

{include file='listes/listes.inc.tpl' min=2 max=4}

{/perms}

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
