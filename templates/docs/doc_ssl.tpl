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
        $Id: doc_ssl.tpl,v 1.11 2004-11-01 10:10:01 x2000chevalier Exp $
 ***************************************************************************}


<h1><a id="ssl"></a>Le certificat SSL de Polytechnique.org</h1>
<h2>Pourquoi un certificat ?</h2>
<p>
  En plus du serveur web s�curis�, Polytechnique.org met � ta disposition
  d'autres services s�curis�s comme le <a href="doc_smtp.php">
  serveur SMTP</a> ou le <a href="doc_nntp.php">serveur de news</a>.
  A ces services sont associ�es des cl�s de chiffrement et pour garantir
  l'authenticit� de ces cl�s, nous les signons avec notre certificat.
</p>

<h2>Notre certificat</h2>
<p>
  A l'installation, ton logiciel de courrier �lectronique n'a pas connaissance
  du certificat SSL de Polytechnique.org et il faut donc le lui fournir. Si ton
  logiciel de courrier �lectronique fonctionne de pair avec ton navigateur web
  (Outlook Express avec Internet Explorer, Netscape Mail avec Navigator, Mozilla
  Mail avec Mozilla, etc..) il te suffit de cliquer <a href="{"cacert.php/cacert.cer"|url}">ici</a>
  pour t�l�charger et installer notre certificat.
</p>
<h2>Sous windows</h2>
<p>
Apr�s avoir cliqu� sur <a href="{"cacert.php/cacert.cer"|url}">ce lien</a>, tu vas recevoir notre
  certificat. Ton navigateur devrait te demander si tu veux t�l�charger ce fichier,
  clique sur "ouvrir" :
</p>
<div class="center">
  <img src="{"images/docs_ssl_dl.png"|url}" alt="[t�l�chargement]" />
</div>
<p>
  Ceci devrait t'ouvrir la fen�tre suivante.
</p>
<div class="center">
    <img src="{"images/docs_ssl_install.png"|url}" alt="[Certificat]" />
</div>
<p>
  Choisis d'installer le certificat, cliques autant de fois sur "suivant" que n�cessaire,
  tu devrais alors voir la fen�tre suivante appara�tre, valide-la.
  Un message appara�t alors, te signifiant que tout s'est bien d�roul�
</p>
<div class="center">
    <img src="{"images/docs_ssl_accept.png"|url}" alt="[Valider]" />
</div>

{* vim:set et sw=2 sts=2 sws=2: *}
