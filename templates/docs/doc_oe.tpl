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
        $Id: doc_oe.tpl,v 1.9 2004-10-24 14:41:12 x2000habouzit Exp $
 ***************************************************************************}


<p>
  [<a href="{"docs/doc_oe.php?doc=smtp"|url}">Configuration du smtp</a>]
  [<a href="{"docs/doc_oe.php?doc=nntp"|url}">Configuration du nntp</a>]
  [<a href="{"docs/doc_oe.php?doc=all"|url}">Doc. compl�te (gros)</a>]
</p>

<h1>
  Utiliser le SMTP s�curis� et le NNTP s�curis� avec Outlook Express
</h1>

<div class="ssrubrique">
  Pr�requis
</div>

<p>
  Comme pour toute aide � la configuration, la premi�re �tape consiste
  souvent � mettre � jour ses logiciels install�s. En effet, la pr�sente page
  a �t� �crite pour la version 5.5 d'Outlook Express qui est une version d�ja
  ancienne, mais tu peux t'en inspirer pour configurer la derni�re version
  disponible (Outlook Express 6), elle marche correctement et nous
  recommandons la mise � jour pour tout type de configuration d'ordinateur.
</p>

<p>
  Cependant, les principes de cette configuration sont toujours les m�mes
  dans les autres versions du logiciel et il est simple de leur transposer
  cette explication.
  Clique <a href="http://windowsupdate.microsoft.com/">ici</a> pour faire
  la mise � jour � partir du site de Microsoft.
</p>

<p>
  Tous les services de polytechnique.org sont s�curis�s, il faut donc
  commencer par ajouter les certificats de s�curit� de polytechnique.org au
  panier des certificats de Windows. Pour ce faire, suis les instructions de
  la <a href="{"docs/doc_ssl.php"|url}">documentation ssl</a>.
</p>
<p>
  Il faut ensuite activer <a href="{"acces_smtp.php"|url}">ton compte SMTP/NNTP</a>.
  Par la suite, ton <strong>login</strong> d�signe l'identifiant que tu utilises pour te connecter au site,
  et <strong>le mot de passe</strong> celui que tu as indiqu� lors de
  l'<a href="{"acces_smtp.php"|url}">activation de ton compte SMTP/NNTP</a>.
</p>

<div class="ssrubrique">
  SMTP, NNTP, qu'est-ce ?
</div>
<p>
  Le serveur SMTP est la machine sur laquelle ton client de courrier �lectronique se
  connecte pour envoyer des mails. En g�n�ral, ton fournisseur d'acc�s
  internet t'en propose un. Mais il arrive souvent que ces serveurs aient des
  limitations (notament sur l'adresse mail que tu veux mettre dans le champ
  exp�diteur). Pour tous ses inscrits, Polytechnique.org propose un serveur
  s�curis�, accessible depuis tout internet.
</p>
<p>
  Le NNTP est un autre nom pour d�signer les <a href="{"banana/"|url}">forums</a> de
  discussions de Polytechnique.org. Il s'agit de les consulter depuis un
  logiciel comme Outlook Express,
  ce qui est plus configurable que la page web du site depuis laquelle tu 
  peux �galement les voir.
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
  <td colspan="2">
    <img src="{"images/docs_compte1.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
<tr>
  <td>
      1. Dans le menu principal d'Outlook Express, choisis le sous-menu 
      <strong>&quot;Comptes&quot;</strong>.
  </td>
  <td>
      2. La fen�tre qui s'affiche � l'�cran suivant montre la liste des comptes 
      actuellement param�tr�s.
  </td>
</tr>
</table>

<hr />

<table summary="Deuxi�me �tape" cellpadding="5">
<tr> 
  <td>
    <img src="{"images/docs_compte2.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
<tr>
  <td>
      Un compte est d�sign� par un nom, ici c'est <em>adupont@mail.com</em> 
      qui d�signe le compte utilis� dans l'exemple. Le plus souvent,
      la diff�rence entre deux comptes est l'adresse e-mail d'envoi uniquement,
      mais parfois, les comptes se diff�rencient aussi par les serveurs 
      utilis�s pour recevoir ou envoyer un e-mail. C'est ce que nous allons faire 
      ici. <br /><br />
      S�lectionne le compte que tu utilises pour envoyer ton courrier puis 
      clique sur le bouton <strong>Propri�t�s</strong>.
  </td>
</tr>
</table>

<hr />

<table summary="Troisi�me �tape" cellpadding="5">
<tr> 
  <td>
    <p>
      Cet �cran permet d'�diter directement tous les param�tres du compte.
    </p>
    <p>
      Dans l'onglet <strong>&quot;G�n�ral&quot;</strong>, on trouve l'adresse 
      d'envoi du compte, et le <strong>&quot;Nom&quot;</strong> affich&eacute;.
    </p>
    <p>
      La petite case <strong>&quot;Inclure ce compte&quot; </strong>est importante. 
      Si tu la coches, cela veut dire que ce compte est r�el et pas 
      seulement formel et Outlook Express va aller v�rifier la pr�sence 
      de messages sur le serveur POP3 (courrier entrant). Si elle n'est 
      pas coch�e, le compte sert uniquement pour envoyer un mail avec 
      l'adresse e-mail sp�cifi�e, qui sera utilis�e aussi pour la r�ponse.
    </p>
  </td>
  <td>
    <img src="{"images/docs_smtp1.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr />

<table summary="Quatri�me �tape" cellpadding="5">
<tr> 
  <td class="middle">
    <p>
      1. Dans l'onglet <strong>&quot;Serveurs&quot;</strong>, indique 
      <strong>ssl.polytechnique.org</strong> comme serveur SMTP
      et coche la case <strong>&quot;Mon serveur n�cessite une 
      authentification&quot;</strong>.
    </p>
    <p>
      2. Dans la case <strong>&quot;Courrier entrant (POP3)&quot;</strong>
      indique le serveur POP du compte mail o� tu redirige ton
      courrier (par exemple le serveur de courier entrant de ton
      fournisseur d'acc�s Internet).
    </p>
    <p>
      3. Tu peux alors cliquer sur le bouton <strong>&quot;Param�tres...&quot;</strong>
    </p>
  </td>
  <td>
    <img src="{"images/docs_smtp2.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>
<hr />
<table summary="Cinqui�me �tape" cellpadding="5">
<tr> 
  <td>
    <p>
      La bo�te ci-contre s'affiche alors. Indique ton <em>login</em> 
      et ton mot de passe,
    </p>
    <p>
      puis clique sur <strong>&quot;OK&quot;</strong>
    </p>
  </td>
  <td>
    <img src="{"images/docs_smtp3.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>
<hr />
<table summary="Sixi�me �tape" cellpadding="5">
<tr> 
  <td>
    <p>
      Enfin, dans l'onglet <strong>&quot;Avanc�e&quot;</strong>, sp�cifie le port <strong>465</strong>
      pour le <strong>Courrier sortant (SMTP)</strong> et coche la case 
      <strong>&quot;Ce serveur utilise une connexion SSL&quot;</strong>.
    </p>
    <p class="erreur">
      Cette derni�re �tape est indispensable, sinon ton mot de passe 
      risque de ne pas �tre chiffr� lors de l'envoi de courriels.
    </p>
  </td>
  <td>
    <img src="{"images/docs_smtp4.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>
<hr />

Et maintenant quelques remarques :
<ul>
	<li>
		<p>
			Le port de communication avec le serveur SMTP est officiellement le port
			587. Cependant, certaines versions d'Outlook Express ne fonctionnent
			qu'avec le port 465. L'�quipe de Polytechnique.org ne peut qu'insister
			sur le fait que les mises � jour sont importantes et doivent �tre
			effectu�es.
		</p>
	</li>
	<li>
		<p>
			Certaines <abbr title="direction des syst�mes informatiques">DSI</abbr>
			locales interdisent l'utilisation de ports inf�rieurs � 1024. Il faut
			alors sp�cifier comme num�ro de port non pas 587 ou 465, mais 2525 (ne
			fonctionne pas avec les anciennes versions de MSOE).
		</p>
	</li>
</ul>

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
    <p>
      La premi�re fois que tu enverras un mail par notre serveur tu auras 
      certainement un message t'expliquant que notre certificat n'est pas sign� 
      par une autorit� de confiance, c'est normal. Nous allons essayer de changer 
      cela mais de toute fa�on cela n'influe pas sur la s�curit� du syst�me. 
      Indique que tu fais confiance � notre certificat.
    </p>
  </td>
</tr>
</table>
<br />
{/if}
{if $smarty.get.doc eq 'nntp' || $smarty.get.doc eq 'all'}
<h1>
  <a id="nntp">La configuration pour utiliser le serveur NNTP de Polytechnique.org</a>
</h1>

<table summary="Premi�re �tape" cellpadding="5">
<tr> 
  <td colspan="2">
    <img src="{"images/docs_compte1.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
<tr>
  <td class="half">
      1. Dans le menu principal d'Outlook Express, choisis le sous-menu 
      <strong>&quot;Comptes&quot;</strong>.
  </td>
  <td>
      2. La fen�tre qui s'affiche � l'�cran suivant montre la liste des comptes 
      actuellement param�tr�s.
  </td>
</tr>
</table>
<hr />
<table summary="Deuxi�me �tape" cellpadding="5">
<tr> 
  <td colspan="2">
    <img src="{"images/docs_news1.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
<tr>
  <td class="half">
      1. Un compte est d�sign� par un nom de serveur. Il est possible que tu aies une liste
      vide la premi�re fois que tu ouvres cette boite.
      Ici tu vois � quoi tu devras arriver en fin de configuration.
  </td>
  <td>
      2. Choisis d'ajouter un nouveau serveur de news comme montr� sur l'image,
      en choisissant <strong>Ajouter</strong>, puis <strong>News</strong>
  </td>
</tr>
</table>

<hr />

<table summary="Troisi�me �tape" cellpadding="5">
<tr> 
  <td colspan="2">
    <img src="{"images/docs_news2.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
<tr>
  <td class="half">
      1. Tu vas alors arriver � l'�cran de configuration suivant
      (apr�s avoir �ventuellement du cliquer plusieurs fois sur <strong>suivant</strong>).
  </td>
  <td>
      2. Choisis <strong>ssl.polytechnique.org</strong> comme serveur puis clique autant de fois que n�cessaire
      sur <strong>Suivant</strong>, en remplissant les champs qui te seront demand�s. Valide par <strong>Terminer</strong>
      � la fin.
  </td>
</tr>
</table>
<hr />
<table summary="Quatri�me �tape" cellpadding="5">
<tr> 
  <td>
    <p>
      Il faut ensuite aller changer quelques options pour pouvoir utiliser les forums.
      Retourne dans le menu <strong>"Outils/Comptes"</strong> du d�but, puis choisis de modifier
      les <strong>"Propri�t�s"</strong> du compte de News que tu viens de cr�er.
    </p>
    <p>
      Choisis alors l'onglet <strong>"Serveur"</strong> et remplis le comme sur la capture
      d'�cran. Le <em>login</em> est ton identifiant <em>prenom.nom</em> et le mot
      de passe, le <a href="{"acces_smtp.php"|url}">mot de passe de ton compte NNTP/SMTP</a>.
    </p>
  </td>
  <td>
    <img src="{"images/docs_news3.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>
<hr />
<table summary="Cinqui�me �tape" cellpadding="5">
<tr> 
  <td>
    <p>
      Derni�re �tape, choisis l'onglet <strong>"Avanc�"</strong> et coche la case
      <strong>ce serveur n�cessite une connexion s�curis�e (SSL)</strong>,
      puis clique sur <strong>&quot;OK&quot;</strong>.
      Tu es alors pr�t � utiliser les news de polytechnique.org.<br />
      Bonne lecture !
    </p>
  </td>
  <td>
    <img src="{"images/docs_news4.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
