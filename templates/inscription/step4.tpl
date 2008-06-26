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
{if !$error}
  <h1>
    Derni�re �tape
  </h1>
  <p>
    Tu as maintenant acc�s au site en utilisant les param�tres re�us par mail.
    Ton adresse �lectronique � vie <strong>{$forlife}@polytechnique.org</strong>
    est d�j� ouverte, essaie-la !
  </p>
  <p>
    Remarque: m4x.org est un domaine "discret" qui veut dire "mail for X" et
    qui comporte exactement les m�mes adresses que le domaine polytechnique.org.
  </p>
  <p>
  <strong><a href="{if $dev eq 0}https://www.polytechnique.org/motdepassemd5.php{else}{"motdepassemd5.php"|url}{/if}">Clique ici pour changer ton mot de passe.</a></strong>
  </p>
  <p>
    N'oublie pas : si tu perds ton mot de passe, nous n'avons aucun engagement, en
    particulier en termes de rapidit�, mais pas seulement, � te redonner acc�s au
    site. Cela peut prendre plusieurs semaines, les pertes de mot de passe sont
    trait�es avec la priorit� minimale.
  </p>
{elseif $error eq $smarty.const.ERROR_DB}
  {$error_db}

  <p>
    Une erreur s'est produite lors de la mise en place d�finitive de ton inscription,
    essaie � nouveau, si cela ne fonctionne toujours pas, envoie un mail �
    <a href="mailto:webmestre@polytechnique.org">webmaster@polytechnique.org</a>
  </p>
{elseif $error eq $smarty.const.ERROR_ALREADY_SUBSCRIBED}
  <p>
    Tu es d�j� inscrit � polytechnique.org. Tu as s�rement cliqu� deux fois sur le m�me lien de
    r�f�rence ou effectu� un double clic. Consultes tes mails pour obtenir ton identifiant et ton
    mot de passe.
  </p>
{elseif $error eq $smarty.const.ERROR_REF}
  <h1>
    OOOooups !
  </h1>
  <p>
    Cette adresse n'existe pas, ou plus, sur le serveur.
  </p>
  <p>
    Causes probables :
  </p>
  <ol>
    <li>
      V�rifie que tu visites l'adresse du dernier e-mail re�u s'il y en a eu plusieurs.
    </li>
    <li>
      Tu as peut-�tre mal copi� l'adresse re�ue par mail, v�rifie-la � la main.
    </li>
    <li>
      Tu as peut-�tre attendu trop longtemps pour confirmer. Les
      pr�-inscriptions sont annul�es tous les 30 jours.
    </li>
  </ol>
{/if}
{/dynamic}
{* vim:set et sw=2 sts=2 sws=2: *}
