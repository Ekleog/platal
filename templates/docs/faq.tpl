{* $Id: faq.tpl,v 1.4 2004-02-11 13:15:34 x2000habouzit Exp $ *}

<div class="rubrique">
  Foire aux questions
</div>
<p class="normal">
  Cette rubrique est sans doute incompl�te. N'h�site pas � nous demander
  de la compl�ter sur un sujet en rapport avec le site si tu estimes
  que des informations manquent.
</p>
<hr />
<div class="ssrubrique">
  Questions g�n�rales
</div>
<ul>
  <li> 
    <a href="#pop">Comment r�cup�rer mon courrier sur polytechnique.org ?</a>
  </li>
  <li>
    <a href="#smtp">Comment envoyer mon courrier avec comme champ exp�diteur 
    (From) mon adresse en polytechnique.org ?</a>
  </li>
  <li>
    <a href="#nntp">Comment lire les forums avec mon logiciel de courrier �l�ctronique ?</a> 
  </li>
  <li>
    <a href="#carva">Quelle est l'origine du nom de domaine carva.org ?</a>
  </li>
</ul>
<div class="ssrubrique">
  Remplissage des champs
</div>
<ul>
  <li> 
    <a href="#mails1">Quelle est la diff�rence entre les mails promo, emploi, 
    et les autres mails collectifs ?</a>
  </li>
  <li>
    <a href="#flags">Quelle est la diff�rence entre les cases de visibilit� vert ou orange ?</a>
  </li>
  <li>
    <a href="#niveau_langue">A quoi correspondent les niveaux de langues ?</a>
  </li>
  <li>
    <a href="#cv">Faut-il remplir le CV et comment ?</a>
  </li>
</ul>
<div class="ssrubrique">
  Probl�mes de connexion
</div>
<ul>
  <li> 
    <a href="#config">Quels sont les param�tres et la configuration n�cessaires 
    pour se connecter correctement ?</a>
  </li>
  <li>
    <a href="#passe">J'ai perdu mon mot de passe, que faire ?</a>
  </li>
  <li>
    <a href="#acces">Je n'arrive pas � me connecter ! Que faut-il essayer ?</a>
  </li>
</ul>
<div class="ssrubrique">
  Utilisation post-connexion
</div>
<ul>
  <li>
    <a href="#ethique">Quelle est l'�thique que vous privil�giez pour les mails 
    collectifs ?</a>
  </li>
  <li>
    <a href="#mails2">Puis-je envoyer un mail � des X et comment ?</a>
  </li>
  <li>
    <a href="#secu">Puis-je utiliser le m�me mot de passe qu'ailleurs ?</a>
  </li>
  <li>
    <a href="#secu2">Quel est le niveau de s�curit� de Polytechnique.org ?</a>
  </li>
  <li>
    <a href="#panne">Vous tombez souvent en panne ?</a>
  </li>
</ul>
<br /><br />
<hr />
<div class="ssrubrique">
  Questions g�n�rales
</div>
<a id="pop" name="pop"></a>
<div class="sstitre">
  Comment r�cup�rer mon courrier sur polytechnique.org ?
</div>
<div class="explication">
  <p>
    Les mails envoy�s sur polytechnique.org sont redirig�s vers la ou les adresses e-mails 
    que tu as pr�cis�e(s) dans ton profil (premier sous-menu dans "Mes Param�tres"). Tu 
    dois donc r�cup�rer ton courrier sur cette (ces) adresse(s) comme tu en as l'habitude, 
    aucun changement n'est introduit par l'existence de ton adresse sur polytechnique.org.
  </p>
</div>   
<a id="smtp" name="smtp"></a> 
<div class="sstitre">
  Comment envoyer mon courrier avec comme champ exp�diteur (From) mon adresse en 
  polytechnique.org ?
</div>
<div class="explication">
  <p>
    Normalement, il suffit de <a href="<?php echo url("docs/doc_emails.php")?>">configurer son identit�</a>
    avec l'adresse en polytechnique.org, mais certains serveurs SMTP
    (la premi�re machine qui prend en charge l'exp�dition du courrier)
    refusent que le champ From contienne une adresse quelconque
    (c'est le cas de ifrance, dont le serveur smtp.ifrance.com n'accepte que
    les champs contenant une adresse @ifrance.com). Dans ce cas, tu peux utiliser <a 
    href="<?php echo url("docs/doc_smtp.php")?>">le serveur SMTP de polytechnique.org</a>. 
    Quand tu n'as pas acc�s au un logiciel de courrier �lectronique, tu peux aussi 
    utiliser <a href="<?php echo url("sendmail.php")?>">cette page</a> pour envoyer un petit courriel.
  </p>
</div>

<a id="nntp" name="nntp"></a> 
<div class="sstitre">
  Comment lire les forums avec mon logiciel de courrier �lectronique ?
</div>
<div class="explication">
  <p>
    En compl�ment de l'interface web il t'est possible d'acc�der aux forums
    de Polytechnique.org directement depuis ton logiciel de courrier
    �lectronique.  Les explications se trouvent
    <a href="<?php echo url("docs/doc_nntp.php")?>">ici</a>.
  </p>
</div>

<a id="carva" name="carva"></a>
<div class="sstitre">
  Quelle est l'origine du nom de domaine carva.org ?
</div>
<div class="explication">
  <p>
    Dans le jargon de l'�cole, un 'carva' signifiait un 'X' lorsque celle-ci �tait 
    sur la montagne Ste Genevi�ve. <br /><br />
  </p>
  <p>
    <strong>D�finition de Carva:</strong>
  </p>
  <ul>
    <li> 
      Mod. Ecole polytechnique, ou, n. Polytechnique (argot: l'X, Pipo, et, pour 
      les �l�ves Carva), nom donn� en 1795 � l'�cole cr��e en 1794 pour former 
      les ing�nieurs des divers services de l'Etat (mines, ponts et chauss�es...) 
      et les officiers de certain armes (artillerie, g�nie...); P�pini�re, cit. 2, 
      Balzac). Pr�paration � Polytechnique.
    </li>
    <li>
      Taupe. El�ve ancien �l�ve de Polytechnique. Promotions ("rouge" et "jaune") 
      de Polytechnique; Polytechnique et Normale (� Elite, cit.)
    </li>
    <li>
      Sortir de Polytechnique. 6. Botte, 2. bottier. 1. Je n'ose confier qu'� vous 
      le secret de sa nullit�, abrit�e par le renom de l'Ecole Polytechnique. 
      (Balzac, Le Cur� de village, Pl. t. VIII, p. 695).
    </li>
  </ul>
  <p>
    (Dictionnaire de la langue fran�aise, Le Robert, Paris 1987)
  </p>
</div>
<hr />
<div class="ssrubrique">
  Remplissage des champs
</div>
<a id="mails1" name="mails1"></a> 
<div class="sstitre">
  Quelle est la diff�rence entre les mails promo, emploi, et les autres mails collectifs ?
</div>
<div class="explication">
  <p>
    Les mails promo concernent des �v�nements promo, r�union, informations sur les 
    cocons, bref la vie d'une promo. Il y a seulement quelques personnes par promo qui 
    peuvent les envoyer, pour �viter que chacun le fasse de son c�t�. Le mieux si tu 
    souhaites envoyer une information � toute ta promo, est de passer par un kessier 
    ou un responsable du web de ta promo, qui se chargera �ventuellement de nous demander 
    un envoi propre � tous les inscrits ayant accept� les mails promo dans leur profil.
  </p>
  <p>
    Les mails emplois sont assez mal d�finis � l'heure actuelle. Ca peut aller de 
    proposition d'embauche ou de stage venant de camarades ou d'entreprises, jusqu'� 
    pr�sentation d'entreprises. Dans la mesure du possible, ces mails seront dirig�s 
    vers les mailings lists correspondantes du secteur int�ress�, et � d�faut aux 
    e-mails des profils d'inscrits appropri�s ayant par ailleurs accept� ce type de 
    mail collectif.
  </p>
  <p>
    Tous les autres mails collectifs, c'est-�-dire envoyer un mail � une liste de 
    destinataires, ensemble ou individuellement, sup�rieure � 20, ne sont pas 
    autoris�s (sauf �videmment mailing lists). 
  </p>
</div>
<a id="flags" name="flags"></a> 
<div class="sstitre">
  Quelle est la diff�rence entre les cases de visibilit� ?
</div>
<div class="explication">
  <p>
    Pour chaque information, il est possible de choisir son degr� de visibilit�.
    Certaines informations peuvent �tre mises sur le site public accessible par
    les non-polytechniciens : si tu le souhaites, coche la case verte "site
    public" correspondante. Ces informations peuvent par ailleurs �tre
    transmises � l'AX pour la mise � jour de l'annuaire papier et de son
    annuaire en ligne sur polytechniciens.com : si tu le souhaites, coche la
    case orange "transmis � l'AX".
    Certains champs sont rouges comme le CV, c'est-�-dire qu'ils sont
    exclusivement vus sur la partie priv�e de Polytechnique.org, r�serv�e
    aux polytechniciens.
  </p>
</div>
<a id="niveau_langue" name="niveau_langue"></a>
<div class="sstitre">
  A quoi correspondent les niveaux de langues ?
  </div>
  <div class="explication">
    <p>
    <ul>
    <li>Niveau 6 : Ma�trise compl�te de la langue.
    <p>Tu comprends tout ce que tu lis ou �coutes dans des
    domaines vari�s. Tu saisis les nuances de la langue et
    interpr�tes avec finesse des documents complexes.
    Tu t'exprimes spontan�ment avec justesse et fluidit�.
    Tu sais argumenter sur des sujets complexes.
    </p>
    <li>Niveau 5 : Bonne ma�trise de la langue.
    <p>
    Tu comprends dans le d�tail des textes complexes et des
    productions orales sur des sujets relatifs � la vie sociale et
    professionnelle.
    Tu t'exprimes avec assurance et pr�cision sur des sujets
    vari�s.
    </p>
    <li>Niveau 4 : Ma�trise g�n�rale de la langue.
    <p>
    Tu comprends les informations d�taill�es des textes ou des
    productions orales traitant d'un sujet familier, concret ou
    abstrait.
    Tu t'exprimes clairement sur des sujets en relation avec
    ton
    domaine d'int�r�t.
    </p>
    <li>Niveau 3 : Ma�trise limit�e de la langue.
    <p>
    Tu comprends les informations significatives des textes et des
    productions orales se rapportant � des situations connues ou
    pr�visibles.
    Tu t'exprimes de mani�re compr�hensible sur des sujets de
    la vie quotidienne.
    </p>
    <li>Niveau 2 : Ma�trise des structures de base de la langue.
    <p>
    Tu comprends les informations pratiques de la vie courante
    dans les messages simples.
    Tu peux te faire comprendre dans des situations famili�res
    et pr�visibles.
    </p>
    <li>Niveau 1 : Connaissance basique de la langue.
    <p>
    Tu comprends de courts �nonc�s s'ils sont connus et r�p�t�s.
    Tu sais exprimer des besoins �l�mentaires.
    </p>
    </ul>
    </p>
</div>

<a id="cv" name="cv"></a>
<div class="sstitre">
  Faut-il remplir le CV et comment ?
</div>
<div class="explication">
  <p>
    D'abord, le CV reste d'acc�s limit� aux inscrits, il n'est pas possible de 
    l'afficher dans les recherches publiques. D'autre part, nous ne le transmettrons 
    jamais, � quiconque.
  </p>
  <p>
    Ton CV complet, si tu veux le mettre, a plut�t sa place sur ta page web et pas 
    sur Polytechnique.org. L'id�e du CV ici, c'est surtout d'avoir des mots-cl�s qui 
    permettent de faire des recherches plus �volu�es. Ainsi, les loisirs peuvent �tre 
    mis dans le champ CV aussi bien que des exp�riences professionnelles et autres.
    Un remplissage succinct comme ci-dessous est donc bien adapt� au champ en question. 
    N�anmoins, la place dans nos bases de donn�es n'est pas limit�e et sois libre de 
    remplir ce champ avec toutes les informations que tu souhaites. A priori, tu ne 
    peux qu'y gagner.
  </p>
  <div class="center">
    <form action="">
      <textarea name="cv_example" rows="7" cols="34">
* internet e-commerce startup
1996-1999 Amazon.com USA Washington Ing�nieur 
1999-2001 ... ... 

* loisirs
parapente cin�ma styx ...

* ...
      </textarea>
    </form>
  </div>
</div>
<hr />
<a id="connect" name="connect"></a>
<div class="ssrubrique">
  Probl�mes de connexion
</div>
<a id="config" name="config"></a>
<div class="sstitre">
  Quels sont les param�tres et la configuration n�cessaires pour se connecter 
  correctement ?
</div>
<div class="explication">
  <p>
    Il faut un navigateur qui ex�cute le javascript. 
    Ce point est absolument n�cessaire pour acc�der au site sans probl�me. 
    Il y a de grandes chances que ton probl�me vienne de l�, nous te conseillons de 
    v�rifier d�j� que ce param�tre est bien activ� avant de continuer.
  </p>
</div>    
<a id="passe" name="passe"></a>
<div class="sstitre">
  J'ai perdu mon mot de passe, que faire ?
</div>
<div class="explication">
  <p>
    Rends toi sur la page "me connecter", l� o� tu aurais tap� ton mot de passe 
    si tu t'en souvenais. Il y a un lien "j'ai perdu mon mot de passe". Clique 
    dessus. Il te sera alors propos� une proc�dure de r�cup�ration automatique 
    de ton mot de passe !
  </p>
</div>
<a id="acces" name="acces"></a>
<div class="sstitre">
  Je n'arrive pas � me connecter ! Que faut-il essayer ?
</div>
<div class="explication">
  <p>
    Bon, il y a beaucoup de possibilit�s, on va les prendre dans l'ordre.
  </p>
  <p>
    As-tu d�j� acc�d� au site ?
  </p>
  <p>
    Si oui, v�rifie que tu rentres correctement ton login (d�but de ton adresse 
    en polytechnique.org sans @polytechnique.org) et ton mot de passe. Un 
    copier/coller avec un espace de trop est vite fait, un clavier qwerty au lieu 
    d'azerty ou l'inverse aussi, et la touche "CAPS LOCK" enfonc�e n'arrange pas 
    non plus les choses.
  </p>
  <p>
    Une fois que tu es s�r de ton mot de passe et de ton login, v�rifie que ton 
    browser ex�cute correctement le javascript. Par exemple, la date est-elle 
    correctement affich�e en haut de la page ? Le javascript est compl�tement 
    n�cessaire, car ton mot de passe doit �tre crypt� localement pour ne pas 
    passer en clair sur Internet. C'est � �a qu'il sert notamment pour la 
    connexion.
  </p>
  <p>
    Sinon, tu n'es peut-�tre pas inscrit (en es-tu vraiment s�r ?). Pour
    le savoir, v�rifie que ton adresse en polytechnique.org r�pond. Si c'est le 
    cas, tu es inscrit, sinon rends-toi sur la page d'inscription : pour une 
    raison quelconque, ton inscription n'existe pas dans notre base. Tu viens de 
    t'inscrire et l'acc�s ne marche pas ? Attention, tu n'as pas d� confirmer ta 
    pr�-inscription. Une inscription ce n'est pas juste un formulaire � remplir 
    et puis voil�. C'est un �change de mails ensuite, et enfin la visite d'une 
    page web bien pr�cise re�ue par e-mail. Si tu n'as rien re�u par e-mail, tu 
    t'es tromp� dans ton adresse e-mail ou alors elle �tait en panne au moment 
    o� le serveur t'a envoy� l'e-mail de demande de confirmation. V�rifie que tu 
    as re�u une confirmation par mail et que tu l'as bien effectu�e. Ton login/mot 
    de passe n'est actif qu'apr�s. Dans le cas contraire, refais une inscription, 
    de toute fa�on, les doublons ne peuvent pas exister.
  </p>
</div>
<hr />
<div class="ssrubrique">
  Utilisation post-connexion
</div>
<a id="ethique" name="ethique"></a>
<div class="sstitre">
  Quelle est l'�thique que vous privil�giez pour les mails collectifs ?
</div>
<div class="explication">
  <p>
    Nous ne faisons pas d'�thique. C'est � toi de dire ce que tu es pr�t � recevoir 
    et pas � nous. Les r�gles impos�es concernent avant tout le bon fonctionnement 
    du service, aussi bien du point de vue purement technique (surcharge) que 
    satisfaction des inscrits (publi-mailing).
  </p>
</div>
<a id="mails2" name="mails2"></a> 
<div class="sstitre">
  Puis-je envoyer un mail � des X et comment ?
</div>
<div class="explication">
  <p>
    Oui, bien s�r. Si tu as une information promo, envoie-la aux responsables web 
    de ta promo (qui ne sont pas forc�ment des kessiers) qui se chargeront de l'envoi 
    avec nous (ils jouent le r�le de filtre pour �viter que chaque personne ne 
    d�cide de son c�t� d'envoyer un mail promo). Cependant, nous faisons remarquer 
    que des outils de communication promo sont ou seront mis en place sur le site. 
    Comme le message au login, ou les forums. Evite les mails promo quand tu peux !
  </p>
  <p>
    Tu veux recruter des X pour des stages ou des embauches ? Il n'y a pas de r�gle 
    g�n�rale dans ce domaine, il faut nous contacter pour voir � qui on peut l'envoyer. 
    Si tu es inscrit, tu peux commencer par l'envoyer � une mailing list bien choisie 
    si elle existe d�j�... Sinon, s'il faut tirer des profils de la base de donn�es 
    correspndant � ta demande, car tu n'as pas acc�s aux champs d'autorisation de 
    mail emploi. Ne fais surtout pas ta s�lection toi-m�me au moyen des recherches 
    puis un envoi massif, tu inclurais ainsi des gens qui ne sont pas d'accord pour 
    recevoir ce type de mail, en plus de ne pas respecter les conditions g�n�rales 
    du service.
  </p>
  <p>
    Tu as besoin d'envoyer un mail � 50 X assez souvent ? Malheureusement pour ton 
    mail, la configuration actuelle va bloquer au bout du 20�me mail. Ce besoin est 
    exactement celui d'une mailing list. Pour l'instant, coupe ton mail en plusieurs 
    envois.
  </p>
</div>
<a id="secu" name="secu"></a>
<div class="sstitre">
  Puis-je utiliser le m�me mot de passe qu'ailleurs ?
</div>
<div class="explication">
  <p>
    D'une mani�re g�n�rale, le syst�me le mieux s�curis� p�tit de l'utilisation du
    m�me mot de passe dans un syst�me moins s�curis�. En effet, le syst�me s�curis� 
    ne craint pas normalement que ton mot de passe soit perc�. Par contre, en 
    l'utilisant dans un autre syst�me moins s�curis�, tu diminues d'autant la s�curit� 
    du premier (puisqu'il suffit de trouver le mot de passe sur le second pour acc�der 
    au premier). Le site www.polytechnique.org a actuellement une s�curit�  tr�s forte 
    pour ton mot de passe (plus forte qu'un site bancaire par exemple), vu que celui-ci 
    est crypt� irr�versiblement (contrairement � HTTPS qui est r�versible). Ainsi, si 
    tu utilises le m�me mot de passe qu'ailleurs, c'est Polytechnique.org qui risque 
    d'en �tre victime. Mais d'un autre c�t�, nous avons forc� sur la s�curit� alors que 
    les informations derri�re sont finalement peu strat�giques (pas de mot de passe 
    visible, pas de num�ro de carte bancaire). Donc, � notre avis, tu peux utiliser 
    le m�me mot de passe qu'ailleurs, le risque est limit� pour nous et nul pour 
    l'autre syst�me.
  </p>
</div>

<a id="secu2" name="secu2"></a>
<div class="sstitre">
  Quel est le niveau de s�curit� de Polytechnique.org ?
</div>
<div class="explication">
  <p>
    Concernant le mot de passe de l'utilisateur : le plus �lev� imaginable puisqu'il 
    circule de mani�re crypt�e irr�versible. En fait, avant m�me d'�tre envoy� sur 
    Internet, ton ordinateur le chiffre sur place irr�versiblement gr�ce au javascript 
    (d'o� son utilit� pour se connecter). Puis il est m�lang� � un challenge envoy� par 
    le serveur, et enfin seulement la r�ponse part sur le Web.
  </p>
  <p>
    Concernant la protection des informations du site en g�n�ral, le niveau de s�curit� 
    est correct par rapport au type d'information contenu. Il est possible de simuler 
    un acc�s � partir de la connaissance d'un mot de passe crypt� et d'un challenge, 
    mais comme d'un autre c�t� de nombreuses informations sont publiques, y a-t-il 
    vraiment int�r�t � d�velopper toute cette ing�nierie pour si peu ?
  </p>
</div>

<a id="panne" name="panne"></a>
<div class="sstitre">
  Vous tombez souvent en panne ?
</div>
<div class="explication">
  <p>
    En fait, il arrive au service d'�tre interrompu, bien que nous n'y puissions rien.
    En un an, on a d�nombr� quatre arr�ts de deux jours dus � nos prestataires, et un 
    d� � notre changement important de configuration, serveur, scripts, etc.... Il faut 
    savoir que dans ce cas, le mail n'est en g�n�ral pas perdu (quand il est perdu, 
    l'envoyeur est inform�). Il arrive en retard de deux jours, ce qui peut �tre assez 
    g�nant mais reste vraiment exceptionnel. Quant � l'acc�s web, il est maintenant 
    compl�tement ind�pendant de l'e-mail. Il se peut donc tout � fait que le site web 
    ne r�ponde pas tout en pouvant utiliser l'e-mail normalement. En tout cas, ces cas 
    de figure sont rares et ont toujours �t� pr�vus et pr�venus (maintenance r�guli�re). 
    Tous les d�veloppeurs de polytechnique.org ne peuvent plus se passer de leur adresse 
    sur ce site, et nous recevons tous largement une cinquantaine de mails par jour, donc 
    un jour d'arr�t vaut au moins 100 mails le suivant, sans compter les mails d'insulte 
    m�me si le probl�me ne nous est pas imputable (panne chez notre fournisseur
    d'acc�s � Internet par exemple...)
  </p>
</div>

{* vim:set et sw=2 sts=2 sws=2: *}
