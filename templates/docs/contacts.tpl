{* $Id: contacts.tpl,v 1.1 2004-01-28 17:19:47 x2000habouzit Exp $ *}

{if !$smarty.request.topic}
<div class="rubrique">
  Contacts
</div>

<table class="bicol" width="95%" align="center" cellspacing="0" cellpadding="4">
  <tr>
    <th>
      Merci de choisir une rubrique parmi les suivantes.
    </th>
  </tr>
  <tr class="impair">
    <td>
      <a href="contacts.php?topic=1">1) Je n'arrive pas � m'inscrire sur le site</a>
    </td>
  </tr>
  <tr class="pair">
    <td style="border-bottom: 1px solid inherit">
      <a href="contacts.php?topic=2">2) J'ai perdu mon mot de passe</a>
    </td>
  </tr>
  <tr class="impair">
    <td>
      <a href="contacts.php?topic=3">3) Ca ne marche pas, je ne comprends pas !</a>
    </td>
  </tr>
  <tr class="pair">
    <td style="border-bottom: 1px solid inherit">
      <a href="contacts.php?topic=4">4) J'ai une am�lioration/correction � proposer</a>
    </td>
  </tr>
  <tr class="impair">
    <td>
      <a href="contacts.php?topic=5">5) Je voudrais ajouter un article dans la newsletter</a>
    </td>
  </tr>
  <tr class="pair">
    <td>
      <a href="contacts.php?topic=6">6) Je voudrais vous contacter</a>
    </td>
  </tr>
</table>
<p class="normal">
Nous te remercions de bien choisir la rubrique qui est la plus adapt�e � ton besoin.
Cel� nous permettra d'�tre les plus efficaces possible et de traiter ta demande au plus vite.
</p>

{elseif $smarty.request.topic eq 1}
<div class="rubrique">
  Je n'arrive pas � m'inscrire sur le site
</div>
<p class="normal">
L'inscription se d�roule en <a href="inscrire.php">une �tape sur notre site web</a>,
suivie d'une �tape de confirmation bas�e sur l'e-mail que tu as donn�.
</p>
<p class="normal">
<b>En cas de probl�me pour t'enregistrer:</b>
</p>
<ul>
  <li class="item"> <b>Probl�me d'identification:</b> �cris-nous en pr�cisant bien tes pr�nom,
  nom, nom de mariage, promo, date de naissance, matricule (pour les X des promos plus r�centes que 1995 seulement), etc...
  </li>
  <li class="item"><b>Probl�me avec le site:</b>
  t�l�charge la derni�re version de ton navigateur et r�essaie avant de nous �crire.
  </li>
  <li class="item"><b>Tu ne re�ois rien par e-mail:</b> r�essaie avec un autre email, celui
  que tu utilisais �tait peut-�tre en panne ou mal orthographi�.
  </li>
</ul>
Pour toute question ou probl�me relatif � l'inscription, merci
d'utiliser uniquement l'adresse
{mailto address='register@polytechnique.org' encode='hex'}

{elseif $smarty.request.topic eq 2}
<div class="rubrique">
  J'ai perdu mon mot de passe
</div>
<p class="normal">
Il y a deux fa�ons de faire.
</p>
<p class="normal">
La premi�re m�thode est automatique, s�curis�e et te prendra environ 5 minutes.
Il faut que tu acc�des encore � tes emails en polytechnique.org
pour r�cup�rer tes param�tres par cette m�thode.
</p>
<a href="recovery.php"><b>Clique ici pour retrouver un mot de passe.</b></a>
<p class="normal">
La seconde m�thode est enti�rement manuelle. Pour cette raison, assure-toi de nous fournir
toutes les informations dont nous disposons sur toi dans ta derni�re fiche. En particulier :
login, promo, date de naissance, matricule, adresse/t�l�phone mobile. Les mots de passe sont
r�initialis�s environ toutes les deux semaines si tu as �t� correctement identifi�. Ainsi, <b>merci
  d'attendre au minimum deux semaines</b> dans le cas o� tu ne re�ois pas de r�ponse � ta premi�re
demande avant de nous r��crire.
</p>
<p class="normal">
L'adresse � utiliser est uniquement <strong>{mailto address='resetpass@polytechnique.org' encode='hex'}</strong>.
</p>

{elseif $smarty.request.topic eq 3}
<div class="rubrique">
  Ca ne marche pas, je ne comprends pas !
</div>
<p class="normal">
Deux solutions, ou bien c'est un bug du site, ce qui est rare mais peut
encore arriver. Ou bien un probl�me de configuration sur ton ordinateur/r�seau
t'emp�che d'utiliser correctement le site. Avant de nous �crire,
mets � jour ton navigateur et consulte �galement <a href="faq.php">notre FAQ</a>. Les r�ponses sur les
probl�mes de connexion y sont toutes trait�es.
</p>
<p class="normal">
En cas de probl�me persistant, tu peux nous �crire � l'adresse
<strong>{mailto address='support@polytechnique.org' encode='hex'}</strong>
</p>

{elseif $smarty.request.topic eq 4}
<div class="rubrique">
  J'ai une am�lioration/correction � proposer
</div>
<p class="normal">
Pour toute suggestion concernant la liste des binets, des groupes x, des pays, des formations
compl�mentaires, �cris-nous � l'adresse <strong>{mailto address='support@polytechnique.org' encode='hex'}</strong> :
nous essayerons de les rajouter au plus vite.
</p>
<p class="normal">
Pour les suggestions de fond, nous lisons les emails avec le plus grand
int�r�t, mais r�servons les changements � des versions ult�rieures
du site (c'est � dire qu'il faut attendre quelques semaines avant que
l'innovation propos�e, si elle est retenue, apparaisse sur le site).
</p>
<p class="normal">
Merci de nous aider � am�liorer la qualit� du site Polytechnique.org. Ecris �
<strong>{mailto address='support@polytechnique.org' encode='hex'}</strong>
ou poste un message sur le forum
<a href="<?php echo url('banana/thread.php?group=xorg.m4x.support') ?>">xorg.m4x.support</a>
pour toute id�e de d�veloppement ou d'am�lioration du site.
</p>

{elseif $smarty.request.topic eq 5}
<div class="rubrique">
  Je voudrais ajouter un article dans la newsletter
</div>
<p class="normal">
Par soucis de l�g�ret�, nous devons imposer quelques contraintes sur les annonces de
la newsletter : le texte du message doit faire au plus <b>8 lignes de 68 caract�res</b>
(le titre et les �ventuels num�ros de t�l�phones / sites web / adresses emails sont en
sus).
</p>
<p class="normal">
Une fois que ton article est pr�t et qu'il ne d�passe pas la taille indiqu�e, il te suffit
de nous le soumettre par email (�viter les pi�ces jointes) � cette adresse :
<strong>{mailto address='info_nlp@polytechnique.org' encode='hex'}</strong>.
</p>
<p class="normal">
Les anciennes newsletters de <b>Polytechnique.org</b> sont
<b><a href="newsletter.php">archiv�es</a></b> si tu veux t'en inspirer.
</p>

{elseif $smarty.request.topic eq 6}
<div class="rubrique">
  Je voudrais vous contacter
</div>
<p class="normal">
Polytechnique.org ne s'occupe que de l'Internet. Pour l'annuaire des
Polytechniciens sur papier et d'une mani�re g�n�rale le support papier, merci
de contacter l'Amicale des X � l'adresse <strong>{mailto address='ax@polytechnique.org' encode='hex'}</strong>.
</p>
<p class="normal">
Pour toute demande qui concerne le recrutement de polytechniciens, vous pouvez consulter
<a href="emploi_public.php"><b>la page sp�cifiquement consacr�e � l'emploi sur notre site.</b></a>
</p>
<p class="normal">
Pour toute question n'ayant aucun rapport avec l'utilisation du site, vous pouvez nous contacter �
l'adresse <strong>{mailto address='contact@polytechnique.org' encode='hex'}</strong>.
</p>

{/if}
{* vim:set et sw=2 sts=2 sws=2: *}
