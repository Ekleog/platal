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


{dynamic}
{if $smarty.request.num}

{if $smarty.request.valide}

<p>
  Merci de nous avoir communiqu� cette information !  Un administrateur de Polytechnique.org va
  envoyer un email de proposition d'inscription � Polytechnique.org � {$prenom} {$nom} dans les
  toutes prochaines heures (ceci est fait � la main pour v�rifier qu'aucun utilisateur malveillant
  ne fasse mauvais usage de cette fonctionnalit�...).
</p>
<p>
  <strong>Merci de ton aide � la reconnaissance de notre site !</strong> Tu seras inform� par email de
  l'inscription de {$prenom} {$nom} si notre camarade accepte de rejoindre la communaut� des X sur
  le web !
</p>

{else}

{if $prenom}
<h1>
  Et si nous proposions � {$prenom} {$nom} de s'inscrire � Polytechnique.org ?
</h1>

<p>
  En effet notre camarade n'a pour l'instant pas encore rejoint la communaut� des X sur le web...
  C'est dommage, et en nous indiquant son adresse email, tu nous permettrais de lui envoyer une
  proposition d'inscription.
</p>
<p>
  Si tu es d'accord, merci d'indiquer ci-dessous l'adresse email de {$prenom} {$nom} si tu la
  connais.  Nous nous permettons d'attirer ton attention sur le fait que nous avons besoin d'�tre
  s�rs que cette adresse est bien la sienne, afin que la partie priv�e du site reste uniquement
  accessible aux seuls polytechniciens. Merci donc de ne nous donner ce renseignement uniquement si
  tu es certain de sa v�racit� !
</p>
<p>
  Nous pouvons au choix lui �crire au nom de l'�quipe Polytechnique.org, ou bien, si tu le veux
  bien, en ton nom. A toi de choisir la solution qui te para�t la plus adapt�e !! Une fois {$prenom}
  {$nom} inscrit, nous t'enverrons un email pour te pr�venir que son inscription a r�ussi.
</p>

<form method="post" action="{$smarty.server.PHP_SELF}">
  <table class="bicol" summary="Fiche camarade">
    <tr class="impair"><td>Nom :</td><td>{$nom}</td></tr>
    <tr class="pair"><td>Pr�nom :</td><td>{$prenom}</td></tr>
    <tr class="impair"><td>Promo :</td><td>{$promo}</td></tr>
    <tr class="pair">
      <td>Adresse email :</td>
      <td>
        <input type="text" name="mail" size="30" maxlength="50" />
      </td>
    </tr>
    <tr class="impair">
      <td>Nous lui �crirons :</td>
      <td>
        <input type="radio" name="origine" value="perso" checked="checked" /> en ton nom<br />
        <input type="radio" name="origine" value="equipe" /> au nom de l'�quipe Polytechnique.org
      </td>
    </tr>
  </table>
  <div>
    <br />
    <input type="hidden" name="num" value="{$smarty.request.num}" />
    <input type="submit" name="valide" value="Valider" />
  </div>
</form>
{/if}

{/if}

{/if}
{/dynamic}


{* vim:set et sw=2 sts=2 sws=2: *}
