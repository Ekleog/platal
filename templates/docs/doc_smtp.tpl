{* $Id: doc_smtp.tpl,v 1.1 2004-01-27 16:34:50 x2000habouzit Exp $ *}

<div class="rubrique">
  Le serveur SMTP de Polytechnique.org
</div>
<p class="normal">
  Polytechnique.org propose un serveur SMTP ouvert � tous les inscrits 
  <a href="{"acces_smtp.php"|url}">qui en font la demande</a>.
</p>
<div class="ssrubrique">
  A quoi sert le serveur SMTP ?
</div>
<p class="normal">
  Le serveur <abbr title="Simple Mail Transfert Protocol">SMTP</abbr> est la
	machine sur laquelle se connecte ton logiciel de courrier �lectronique
	(Outlook Express, Netscape, Eudora...) pour envoyer le courrier. On l'appelle
	aussi <em>serveur de courrier sortant</em>.
	<br />C'est la premi�re machine qui prend la responsabilit� d'envoyer le
	message, elle doit donc �tre capable d'identifier l'�metteur du courrier en
	cas de probl�me, sinon c'est la porte ouverte au spam (pollution des bo�tes
	aux lettres par envoi de courrier non sollicit�s).
      Ainsi, quand on utilise un ordinateur portable � la fois au bureau et � la maison, il faut sans cesse changer de serveur SMTP.
</p>
<div class="ssrubrique">
  Pourquoi un tel service ?
</div>
<ul>
  <li>
    <p class="normal">
      Afin d'�viter le spam, les serveurs SMTP sont g�n�ralement assez
			<strong>restrictifs</strong> sur les personnes autoris�es � les utiliser,
			ainsi pour
			utiliser le serveur SMTP de LibertySurf pour envoyer des messages, il est
			n�cessaire d'�tre connect�(e) � Internet par l'interm�diaire de
			LibertySurf. Si tu te connectes par un autre fournisseur d'acc�s, il
			faudra changer ta	configuration de ton logiciel de courrier, ce qui peut
			devenir ennuyeux si les changements sont fr�quents.
    </p>
  </li>
  <li>
    <p class="normal">
      De plus, certains serveurs SMTP n'autorisent dans le champ d'exp�diteur (
			<code>From:</code>) qu'une adresse mail se terminant par leur domaine, ce
			qui emp�che l'envoi de courrier avec une adresse d'exp�diteur en
			<code>@polytechnique.org</code>.
    </p>
  </li>
  <li>
    <p class="normal">
      Tu es dans une entreprise qui s'autorise la lecture des messages qui
			passent par son serveur SMTP et tu veux 
      envoyer un messsage qui ne pourra �tre intercept� par le service
			informatique de ton entreprise.
    </p>
  </li>
</ul>
<p class="normal">
  Pour toutes ces raisons (et d'autres moins parlantes),
  le serveur SMTP de Polytechnique.org apporte une bonne solution. 
  Pour des raisons d'identification, ce serveur te demandera un <i>login</i> 
  et un mot de passe, <a href="{"acces_smtp.php"|url}"><b>il faut
	donc activer ton compte</b></a> avant de continuer la configuration.
	&Eacute;videment, le SPAM est interdit en utilisant le serveur SMTP de
	Polytechnique.org, et si tu te rends coupable de spam, ton compte sera
	supprim�.
</p>

<div class="ssrubrique">Configuration</div>
<p class="normal">
  Avant toute chose, il faut avoir accept� le certificat SSL de
	Polytechnique.org.
  Si tu ne l'as jamais fait, avant de configurer ton logiciel de messagerie
  �lectronique, lis <a href="doc_ssl.php">ces instructions</a>.
</p>
<ul>
  <li><a href="{"docs/doc_oe.php?doc=smtp"|url}">Configuration sous Outlook Express</a> (page longue � charger)</li>
  <li><a href="{"docs/doc_nn.php?doc=smtp"|url}">Configuration sous Netscape</a> (page longue � charger)</li>
</ul>

<div class="ssrubrique">
  Attention !
</div>
<p class="normal">
  L'utilisation de <b>certains logiciels antivirus</b> (comme <i>Norton Antivirus</i>)
  n�cessite un �l�ment de configuration suppl�mentaire : il faut indiquer au
	logiciel de ne pas scanner le courrier sortant.
</p>

{* vim:set et sw=2 sts=2 sws=2: *}
