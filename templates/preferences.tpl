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
        $Id: preferences.tpl,v 1.7 2004-09-02 23:56:17 x2000habouzit Exp $
 ***************************************************************************}

<div class="rubrique">
  Pr�f�rences
</div>

<table class="bicol" summary="Pr�f�rences: services">
  <tr>
    <th colspan="2">Configuration des diff�rents services du site
    </th>
  </tr>
  <tr class="impair">
    <td><div class="question">
        <a href="{"emails.php"|url}">Mes adresses de redirection</a>
      </div>
      <div class="explication">
        Tu peux configurer tes diff�rentes redirections de mails ici.
      </div>
    </td>
    <td><div class="question">
        <a href="{"alias.php"|url}">Mon alias mail @melix.net/.org</a>
      </div>
      <div class="explication">
        Pour choisir un alias @melix.net et @melix.org (en choisir un nouveau annule l'ancien).
      </div>
    </td>
  </tr>
  <tr class="pair">
    <td><div class="question">
        <a href="{"carva_redirect.php"|url}">Ma redirection de page WEB</a>
      </div>
      <div class="explication">
        Tu peux configurer ta redirection WEB http://www.carva.org/{dyn s=$smarty.session.forlife}
      </div>
    </td>
    <td><div class="question">
        <a href="{"skins.php"|url}">Apparence du site (skins)</a>
      </div>
      <div class="explication">
        Tu peux changer les couleurs et les images du site.
      </div>
    </td>
  </tr>
</table>

<br />

<table class="bicol" summary="Pr�f�rences: mdp" cellpadding="3">
  <tr>
    <th>Mots de passe et acc�s au site</th>
  </tr>
  <tr class="impair">
    <td><div class="question">
        <a href="{"motdepassemd5.php"|url}">Changer mon mot de passe pour le site</a>
      </div>
      <div class="explication">
        permet de changer ton mot de passe pour acc�der au site Polytechnique.org
      </div>
    </td>
  </tr>
  <tr class="pair">
    <td><div class="question">
        <a href="{"acces_smtp.php"|url}">Activer l'acc�s SMTP et NNTP</a>
      </div>
      <div class="explication">
        Pour activer ton compte sur le serveur SMTP et NNTP de Polytechnique.org.
        Cela te permet d'envoyer tes mails plus souplement (SMTP), et de consulter
        les forums directement depuis ton logiciel habituel de courrier �lectronique.
      </div>
    </td>
  </tr>
  <tr class="impair">
    <td>
{if $has_cookie}
      <div class="question">
        <a href="cookie_off.php">Supprimer l'acc�s permanent</a>
      </div>
      <div class="explication">
        Clique sur le lien ci-dessus pour retirer l'acc�s sans mot de passe au site. Apr�s avoir
        cliqu�, tu devras � nouveau entrer ton mot de passe pour acc�der aux diff�rentes pages
        comme initialement.
      </div>
{else}
      <div class="question">
        <a href="cookie_on.php">Attribuer un cookie d'authentification permanente</a>
      </div>
      <div class="explication">
        Cette option te permet de ne plus avoir � entrer ton mot de passe pour la majorit� des pages
        du site. Ce dernier reste cependant n�cessaire pour le profil ou le changement de mot de
        passe. Il s'agit d'une option destin�e aux utilisateurs fr�quents du site, plut�t � l'aise
        avec l'informatique, et pour un ordinateur non partag�.
      </div>
{/if}
    </td>
  </tr>
</table>

{* vim:set et sw=2 sts=2 sws=2: *}
