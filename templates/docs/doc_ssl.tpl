{* $Id: doc_ssl.tpl,v 1.2 2004-01-29 16:21:54 x2000habouzit Exp $ *}

<div class="rubrique"><a id="ssl" name="ssl"></a>Le certificat SSL de Polytechnique.org</div>
<div class="ssrubrique">Pourquoi un certificat ?</div>
<p class="normal">
  En plus du serveur web s�curis�, Polytechnique.org met � ta diposition
  d'autres services s�curis�s comme le <a href="doc_smtp.php">
  serveur SMTP</a> ou le <a href="doc_nntp.php">serveur de news</a>.
  A ces services sont associ�es des cl�s de chiffrement et pour garantir
  l'authenticit� de ces cl�s, nous les signons avec notre certificat.
</p>

<div class="ssrubrique">Notre certificat</div>
<p class="normal">
  A l'installation, ton logiciel de courrier �lectronique n'a pas connaissance
  du certificat SSL de Polytechnique.org et il faut donc le lui fournir. Si ton
  logiciel de courrier �lectronique fonctionne de paire avec ton navigateur web
  (Outlook Express avec Internet Explorer, Netscape Mail avec Navigator, Mozilla
  Mail avec Mozilla, etc..) il te suffit de cliquer <a href="{"cacert.php/cacert.cer"|url}">ici</a>
  pour t�l�charger et installer notre certificat.
</p>
<div class="ssrubrique">Sous windows</div>
<p class="normal">
Apr�s avoir cliqu� sur <a href="{"cacert.php/cacert.cer"}|url">ce lien</a>, tu vas recevoir notre
  certificat. Ton navigateur devrait te demander si tu veux t�l�charger ce fichier,
  clique sur "ouvrir" :
</p>
<div class="center">
  <img src="{"images/docs_ssl_dl.png"|url}" alt="[t�l�chargement]" width="398" height="191" />
</div>
<p>
  Ceci devrait t'ouvrir la fen�tre suivante.
</p>
<div class="center">
    <img src="{"images/docs_ssl_install.png"|url}" alt="[Certificat]" width="409" height="476" />
</div>
<p>
  Choisis d'installer le certificat, cliques autant de fois sur "suivant" que n�cessaire,
  tu devrais alors voir la fen�tre suivante appara�tre, valide-la.
  Un message appara�t alors, te signifiant que tout s'est bien d�roul�
</p>
<div class="center">
    <img src="{"images/docs_ssl_accept.png"|url}" alt="[Valider]" width="629" height="204" />
</div>

{* vim:set et sw=2 sts=2 sws=2: *}
