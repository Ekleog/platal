{* $Id: doc_nn.tpl,v 1.3 2004-01-31 10:20:16 x2000habouzit Exp $ *}

<p class="normal">
    [<a href="{"docs/doc_nn.php?doc=smtp"|url}">Configuration du smtp</a>]
    [<a href="{"docs/doc_nn.php?doc=nntp"|url}">Configuration du nntp</a>]
    [<a href="{"docs/doc_nn.php?doc=all"|url}">Doc. compl�te (gros)</a>]
</p>
<div class="rubrique">
    Utiliser le SMTP s�curis� et le NNTP s�curis� avec Netscape (ou Mozilla)
</div>
<div class="ssrubrique">
    Pr�requis
</div>
<p class="normal">
    Cette page est valable pour Netscape Communicator 4.x. Les copies d'�cran
		ont �t� r�alis�es avec la version 4.7 sous Windows, mais restent valables
		pour les autres versions de Netscape Communicator sous d'autres syst�mes
		d'exploitation.
    Cette page est tout � fait transposable � Netscape 6/7 et Mozilla.
</p>
<p class="normal">
    Tous les services de polytechnique.org �tant s�curis�s, il faut  commencer
		par faire accepter � ton syst�me d'exploitation les certificats de s�curit�s
		de polytechnique.org. Pour ceci, suis les instructions de la
		<a href="{"docs/doc_ssl.php"|url}">documentation ssl</a>.
</p>
<p class="normal">
    Il faut ensuite activer <a href="{"acces_smtp.php"|url}">ton compte SMTP/NNTP</a>.
    Dans la suite, ton <strong>login</strong> d�signe le logine que tu as utilises pour te connecter au site,
    et <strong>le mot de passe</strong> celui que tu as indiqu� lors de
    l'<a href="{"acces_smtp.php"|url}">activation de ton compte SMTP/NNTP</a>.
</p>
<div class="ssrubrique">
    SMTP, NNTP, qu'est-ce ?
</div>
<p class="normal">
    Le SMTP est la machine sur laquelle ton client de courrier �lectronique se connecte pour envoyer
    des mails. En g�n�ral, ton fournisseur d'acc�s internet t'en propose un. Mais il arrive souvent
    que ces serveurs aient des limitations (notament sur l'adresse mail que tu veux mettre dans le
    champ exp�diteur). Pour tous ses inscrits, Polytechnique.org en propose une version s�curis�e,
    accessible depuis tout le web.
</p>
<p class="normal">
  Le NNTP est un autre nom pour d�signer les <a href="{"banana/"|url}">forums</a> de
    discussions de Polytechnique.org. Il s'agit de les consulter depuis un logiciel comme Netscape,
    ce qui est tout de m�me bien plus pratique que le WebForum.
</p>
<div class="center">
  <span class="erreur">
    Avant toute op�ration, <a href="{"acces_smtp.php"|url}">active ton compte SMTP/NNTP</a>.
  </span>
</div>
<br />
{if $smarty.get.doc eq 'smtp' || $smarty.get.doc eq 'all'}
<div class="rubrique">
    Utiliser le SMTP s�curis�
</div>

<table summary="Premi�re �tape" cellpadding="5" width="604">
<tr> 
  <td colspan="3">
    <img src="{"images/docs_confnetscape0.png"|url}" width="604" height="476" alt=" [ CAPTURE D'ECRAN ] ">
  </td>
</tr>
<tr>
  <td>
      1. Dans le menu principal de Netscape Messenger, choisis le sous-menu 
      <strong>&quot;&Eacute;dition/Pr�f�rences&quot;</strong>.
  </td>
  <td>
      2. Choisis alors l'onglet <strong>Identit�</strong> dans <strong>Courrier et Forums</strong>.
      La fen�tre devrait alors correspondre � l'�cran suivant.
  </td>
  <td>
      3. Remplis alors les champs <strong>Nom</strong> et <strong>Adresse �lectronique</strong>
      comme il convient avec ton adresse en polytechnique.org.
  </td>
</tr>
</table>

<hr />

<table summary="Deuxi�me �tape" cellpadding="5" width="604">
<tr>
  <td colspan="3">
    <img src="{"images/docs_confnetscape1.png"|url}" width="604" height="477" alt=" [ CAPTURE D'ECRAN ] ">
  </td>
</tr>
<tr>
  <td>
    <p class="normal">
      1. Clique alors sur l'onglet <strong>Serveurs de courrier</strong>, la fen�tre devrait
      correspondre � l'�cran ci-contre.
		</p>
  </td>
  <td width="50%">
    <p class="normal">
      2. Dans la partie <strong>Serveur de courrier sortant</strong>, indique
			<code>ssl.polytechnique.org</code> dans le champ <strong>Serveur de
			courrier sortant (SMTP)</strong> puis ton <em>login</em> dans le champ 
			<strong>Utilisateur du serveur de courrier sortant</strong>, et enfin
			coche <strong>Toujours</strong> dans la partie <strong>utiliser SSL ou
			TLS</strong>.
		</p>
  </td>
  <td>
    <p class="normal">
      3. <strong>Important</strong>, n'oublie pas de cocher <strong>Toujours</strong>, sinon ton
			mot de passe risque de ne pas �tre chiffr� lors de l'envoi de courriels.
		</p>
  </td>
</tr>
</table>

<hr />

<table summary="Trois�me �tape" cellpadding="5">
<tr> 
 <td>
   <p class="normal">
      Si tu envoyes un courriel, tu verras appara�tre la fen�tre ci-contre.
      Tape le mot de passe que tu as indiqu� lors de l'<a href="{"acces_smtp.php"|url}">activation de ton compte</a>.
    </p>
  </td>
  <td>
    <img src="{"images/docs_confnetscape2.png"|url}" width="382"
			height="179" alt=" [ CAPTURE D'ECRAN ] " />
  </td>
</tr>
</table>

<hr /> 

Et maintenant quelques remarques :
<ul>
	<li>
		<p class="normal">
			Netscape Communicator ne permet pas de chosir le port du serveur SMTP.
			Il utilise par d�faut le port 25.  Avec Netscape 6/7 ou Mozilla, il est
			recommand� d'utiliser le port 587, qui est le port d�di�.
		</p>
	</li>
	<li>
		<p class="normal">
			Certaines <abbr title="direction des syst�mes informatiques">DSI</abbr>
			locales interdisent l'utilisation de ports inf�rieurs � 1024. Il suffit
			alors de sp�cifier comme num�ro de port SMTP non pas 587, mais 2525.
		</p>
	</li>
  </ul>
{/if}
{if $smarty.get.doc eq 'nntp' || $smarty.get.doc eq 'all'}
<br />
<div class="rubrique">
    Utiliser le NNTP s�curis�
</div>

<table summary="Premi�re �tape" cellpadding="5" width="603">
<tr> 
  <td colspan="3">
    <img src="{"images/docs_nntp_nn1.png"|url}" width="603" height="475" alt=" [ CAPTURE D'ECRAN ] ">
  </td>
</tr>
<tr>
  <td>
      1. Dans le menu principal de Netscape Messenger, choisis le sous-menu 
      <strong>&quot;Edition/Pr�f�rences&quot;</strong>.
  </td>
  <td>
      2. Choisis alors l'onglet <strong>Serveurs de forums</strong> dans <strong>Courrier et Forums</strong>.
      clique alors sur le bouton <strong>ajouter</strong>.
      La fen�tre devrait alors correspondre � l'�cran ci-dessus.
  </td>
  <td>
      3. Remplis alors les champs <strong>Serveur</strong> et <strong>Port</strong> comme montr� sur la capture d'�cran.
      N'oublie pas de cocher la case <strong>Supporte les connections chiffr�es (SSL)</strong>.
      Tu peux alors tout valider.
  </td>
</tr>
</table>

<hr />

<table summary="Deuxi�me �tape" cellpadding="5" width="604">
<tr>
  <td>
      1. Dans ton client apparait maintenant une nouvelle ligne de serveur de forums appell�e
      <strong>ssl.polytechnique.org</strong>. Clique avec le bouton droit de ta souris sur cette ligne, et
      demande de t'abonner � des forums.
  </td>
  <td>&nbsp;
  </td>
</tr>
<tr>
  <td>
      2. La boite ci contrea apparait alors, donne alors ton <strong>identifiant</strong> de la forme
      <em>prenom.nom</em>, puis valide.
  </td>
  <td>
    <img src="{"images/docs_nntp_nn2.png"|url}" width="384" height="183" alt=" [ CAPTURE D'ECRAN ] ">
  </td>
</tr>
<tr>
  <td>
      3. Netscape te demande alors de donner ton mot de passe, tape le mot de passe que tu as
      indiqu� lors de <a href="{"smtp_acces.php"|url}">l'activation de ton compte</a>.
  </td>
  <td>
    <img src="{"images/docs_nntp_nn3.png"|url}" width="384" height="183" alt=" [ CAPTURE D'ECRAN ] ">
  </td>
</tr>
</table>

<hr />

<table summary="Troisi�me �tape" cellpadding="5" width="668">
<tr> 
  <td>
    <img src="{"images/docs_nntp_nn4.png"|url}" width="668" height="466" alt=" [ CAPTURE D'ECRAN ] ">
  </td>
</tr>
<tr>
  <td>
    Tu vois alors un �cran proche de celui ci-dessus apparaitre, il ne te reste plus qu'� choisir
    les newsgroups qui t'int�ressent, et � t'y abonner.
  </td>
</tr>
</table>
{/if}
{* vim:set et sw=2 sts=2 sws=2: *}
