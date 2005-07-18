{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2004 Polytechnique.org                             *}
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


<p>
  [<a href="{"docs/doc_pocketpc.php?doc=smtp"|url}">Configuration du smtp</a>]
</p>

<h1>
  Utiliser le SMTP s�curis� avec Microsoft Windows Pocket PC
</h1>

<h2>Pr�requis</h2>

<p>
  Cette documentation a �t� �crite pour Windows CE 4.20.0.
</p>

<p>
  Cependant, les principes de cette configuration sont toujours les m�mes
  dans les autres versions du logiciel et il est simple de leur transposer
  cette explication.
</p>

<p>
  Il faut ensuite activer <a href="{"acces_smtp.php"|url}">ton compte SMTP/NNTP</a> dans Polytechnique.org.
  Par la suite, ton <strong>login</strong> d�signe l'identifiant que tu utilises pour te connecter au site,
  et <strong>le mot de passe</strong> celui que tu as indiqu� lors de
  l'<a href="{"acces_smtp.php"|url}">activation de ton compte SMTP/NNTP</a>.
</p>

<h2>SMTP, NNTP, qu'est-ce ?</h2>
<p>
  Le serveur SMTP est la machine sur laquelle ton client de courrier �lectronique se
  connecte pour envoyer des mails. En g�n�ral, ton fournisseur d'acc�s
  internet t'en propose un. Mais il arrive souvent que ces serveurs aient des
  limitations (notamment sur l'adresse mail que tu veux mettre dans le champ
  exp�diteur). Pour tous ses inscrits, Polytechnique.org propose un serveur
  s�curis�, accessible depuis tout internet.
</p>
<div class="center">
  <span class="erreur">
    Avant toute op�ration, <a href="{"acces_smtp.php"|url}">il faut avoir activ� ton compte SMTP/NNTP</a>.
  </span>
</div>
<br />

{if $smarty.get.doc eq 'smtp' || $smarty.get.doc eq 'all'}
<h1>
  La configuration pour utiliser le serveur SMTP de Polytechnique.org
</h1>

<table summary="Premi�re �tape" cellpadding="5">
<tr>
  <td class="middle">
    <p>
      Dans le menu d�marrer, choisis la <strong>&quot;Bo�te de R�ception&quot;</strong>. Puis dans le menu <strong>Comptes</strong>, choisis <strong>&quot;Nouveau compte...&quot;</strong>.
    </p>
    <p>
      La proc�dure de cr�ation du compte se d�roule en cinq �tapes plus trois �tapes d'options (n�cessaires pour ce qui nous concerne).
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc1.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />

<table summary="Deuxi�me �tape" cellpadding="5">
<tr> 
  <td class="middle">
    <p>
      1. Dans la premi�re �tape de configuration de la messagerie, tu peux indiquer l'adresse mail qui sera indiqu�e dans les mails que tu envoies.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc2.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />

<table summary="Troisi�me �tape" cellpadding="5">
<tr>
  <td class="middle">
    <p>
      2. On te propose alors de configurer automatiquement la messagerie. Accepte et passe � l'�tape suivante.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc3.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />

<table summary="Quatri�me �tape" cellpadding="5">
<tr>
  <td class="middle">
    <p>
      3. La troisi�me �tape te demande ton nom ainsi que ton nom d'utilisateur. Ce nom d'utilisateur doit obligatoirement �tre ton <strong>login</strong>. De m�me ton mot de passe doit �tre celui que tu as choisi lors de l'activation de ton compte SMTP s�curis�.
    </p>
    <p>
      Malheureusement cela t'oblige � avoir le m�me login pour ton compte mail que celui de ton compte polytechnique.org. Il faut �galement le m�me mot de passe.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc4.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />

<table summary="Cinqui�me �tape" cellpadding="5">
<tr>
  <td class="middle">
    <p>
      4. L'�tape quatre te permet de choisir le type de compte POP3 ou IMAP4. Tu peux choisir le type en fonction de ton h�bergeur de mail : il s'agit d'un param�tre de r�ception et non d'envoi. Si tu ne sais pas quoi choisir, la plupart du temps il faut mettre POP3.
    </p>
    <p>
      Le nom du compte, n'appara�tra nulle part dans les communications mais te permet simplement d'identifier ces param�tres sur ton PDA par rapport � d'autres comptes.
    </p>
    <p>
      Remarque : tu peux configurer plusieurs comptes mail sur ton PDA, mais tu ne peux te connecter qu'� un seul � la fois. Pour changer de compte, il faut d'abord se d�connecter du compte en cours.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc5.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />

<table summary="Sixi�me �tape" cellpadding="5">
<tr> 
  <td class="middle">
    <p>
      5. Le serveur de courrier entrant correspond � ton h�bergeur de mail. Par contre le serveur sortant doit �tre <strong>ssl.polytechnique.org</strong>.
    </p>
    <p>
      Clique maintenant sur Options pour param�trer les param�tres de s�curit�.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc6.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />

<table summary="Septi�me �tape" cellpadding="5">
<tr> 
  <td>
    <p>
      Nous te d�conseillons de r�cup�rer automatiquement les mails, notamment parce que ton PDA essaiera alors tr�s r�guli�remet de se connecter � Internet, m�me si tu n'as pas d�marr� ta bo�te de r�ception, ce qui peut est tr�s d�sagr�able.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc7.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>
<hr />
<table summary="Huiti�me �tape" cellpadding="5">
<tr> 
  <td class="middle">
    <p>
      Ces deux cases sont importantes � cocher. La <strong>connexion SSL</strong> �tablira un dialogue s�curis� entre le PDA et notre serveur pour ne pas envoyer ton mot de passe en clair.
      Comme pour le login la m�thode de connexion est commune au courrier entrant et sortant. Mais dans le cas d'un PDA, il est important de r�cup�rer ses mails de mani�re crypt� �galement.
    </p>
    <p>
      Coche �galement la case pour l'<strong>authentification</strong>.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc8.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>
<hr />
<table summary="Neufi�me �tape" cellpadding="5">
<tr>
  <td class="middle">
    <p>
      Enfin, pour terminer tu peux choisir de ne r�cup�rer que les en-t�tes des mails que tu re�ois. Ce qui �vite de surcharger ton PDA. Tu pourras ensuite, au cas par cas, choisir de r�cup�rer la totalit� des messages qui t'int�ressent.
    </p>
  </td>
  <td>
    <img src="{rel}/images/docs_pocketpc9.png" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />
<table summary="Conclusion" cellpadding="5">
<tr> 
  <td>
    <p>
      Voil�, c'est termin�, tes messages sont maintenant envoy�s par 
      Polytechnique.org, la connexion est authentifi�e et chiffr�e jusqu'� 
      notre serveur, donc ni ton mot de passe ni ton mail ne passe en clair
      entre toi et nous.
    </p>
  </td>
</tr>
</table>
<br />
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
