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
        $Id: liste.tpl,v 1.7 2004-09-20 20:04:38 x2000habouzit Exp $
 ***************************************************************************}

{dynamic}

{if $no_list}

<p class='erreur'>La liste n'existe pas ou tu n'as pas le droit d'en voir les d�tails</p>

{else}

<div class="rubrique">
  Liste {$smarty.request.liste}
</div>

<table class='tinybicol' cellpadding='0' cellspacing='0'>
  <tr>
    <td class='titre'> Adresse </td>
    <td>{mailto address=$details.addr}</td>
  </tr>
  <tr>
    <td class='titre'> Sujet </td>
    <td>{$details.desc}</td>
  </tr>
  <tr>
    <td class='titre'> Visibilit� </td>
    <td>{if $details.priv eq 0}publique{elseif $details.priv eq 1}priv�e{else}admin{/if}</td>
  </tr>
  <tr>
    <td class='titre'> Diffusion </td>
    <td>{if $details.diff}mod�r�e{else}libre{/if}</td>
  </tr>
  <tr>
    <td class='titre'> Inscription </td>
    <td>{if $details.ins}mod�r�e{else}libre{/if}</td>
  </tr>
  <tr>
    <td colspan='2' class='center'>
      <a href='trombi.php?liste={$smarty.request.liste}'>trombino de la liste</a> (page longue � charger)
    </td>
  </tr>    
</table>

<div class='rubrique'>
  mod�rateurs de la liste
</div>

{if $owners|@count}
<table class='tinybicol' cellpadding='0' cellspacing='0'>
  {foreach from=$owners item=xs key=promo}
  <tr>
    <td class='titre'>{if $promo}{$promo}{else}non-X{/if}</td>
    <td>
      {foreach from=$xs item=x}
      {if $promo}
      <a href="javascript:x()" onclick="popWin('{"fiche.php"|url}?user={$x.l}')">{$x.n}</a><br />
      {else}
      {$x.l}<br />
      {/if}
      {/foreach}
    </td>
  </tr>
  {/foreach}
</table>
{/if}

<div class='rubrique'>
  membres de la liste
</div>

{if $members|@count}
<table class='bicol' cellpadding='0' cellspacing='0'>
  {foreach from=$members item=xs key=promo}
  <tr>
    <td class='titre'>{if $promo}{$promo}{else}non-X{/if}</td>
    <td>
      {foreach from=$xs item=x}
      {if $promo}
      <a href="javascript:x()" onclick="popWin('{"fiche.php"|url}?user={$x.l}')">{$x.n}</a><br />
      {else}
      {$x.l}<br />
      {/if}
      {/foreach}
    </td>
  </tr>
  {/foreach}
</table>
{/if}

{if $details.you > 1 || ($details.priv>1 && $smarty.session.perms eq admin)}
<div class='rubrique'>
  Administrer la liste
</div>

<p>
Pour entrer un utilisateur, il faut remplir les champs pr�vus � cet effet par son login,
c'est-�-dire "prenom.nom" ou "prenom.nom.promo"
</p>

<form method='post' action='{$smarty.server.REQUEST_URI}'>
  <table class='tinybicol'>
    <tr>
      <th>modifier les abonn�s</th>
      <th>modifier les mod�rateurs</th>
    </tr>
    <tr>
      <td>
        <input type='text' name='member' />
      </td>
      <td>
        <input type='text' name='owner' />
      </td>
    </tr>
    <tr class='center'>
      <td>
        <input type='submit' name='add_member' value='ajouter' />
        &nbsp;
        <input type='submit' name='del_member' value='supprimer' />
      </td>
      <td>
        <input type='submit' name='add_owner' value='ajouter' />
        &nbsp;
        <input type='submit' name='del_owner' value='supprimer' />
      </td>
    </tr>
  </table>
</form>

<p>
Un message est adress� automatiquement � toute personne ajout�e � la liste de diffusion.  Voici le
message actuellement envoy� : il est modifiable � volont� !
</p>
<p>
L'objet du mail est "Bienvenue sur la liste de diffusion {$details.name} !"<br />
Et si la personne fait "r�pondre �", le message arrive aux mod�rateurs de la liste.
</p>

<form method='post' action='{$smarty.server.REQUEST_URI}'>
  <div class='center'>
    <textarea cols='50' rows='8' name='welc'>{$details.welc}</textarea><br />
    <input type='submit' name='update' value='mettre � jour' />
  </div>
</form>

{/if}

{/if}

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
