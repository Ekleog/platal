{* $Id: doc_from.tpl,v 1.4 2004-08-30 12:18:40 x2000habouzit Exp $ *}

<div class="texte">
  <div class="rubrique">
    Polytechnique.org comme e-mail dans le champ FROM
  </div>
  <p>
  Comme pour toute aide � la configuration, la premi�re �tape
  consiste souvent � mettre � jour ses logiciels install�s.
  En effet, la page suivante a �t� �crite pour la version
  5.5 d'Outlook Express qui est la derni�re version actuellement
  disponible, elle marche correctement et nous recommandons la mise �
  jour pour tout type de configuration d'ordinateur.
  </p>
  <p>
  <a href="http://windowsupdate.microsoft.com/">Clique ici pour faire la mise �
    jour � partir du site de Microsoft.</a>
  </p>
  <p>
  La page suivante te propose de configurer diff�rents comptes de
  messagerie sur un m�me ordinateur, afin de pouvoir choisir ton adresse
  d'envoi � chaque e-mail envoy� (polytechnique.org, m4x.org,
  ton entreprise, ton fournisseur d'acc�s, etc).
  </p>
  <hr />
  <table class="etape" summary="Premiere �tape" cellpadding="5">
    <tr>
      <td>
        <p>
        Dans le menu principal d'Outlook Express, choisis le sous-menu
        <strong>&quot;Comptes&quot;</strong>.
        </p>
        <p>
        La fen�tre qui s'affiche � l'�cran suivant montre la liste des
        comptes actuellement param�tr�s.
        </p>
      </td>
      <td>
        <img src="{"images/docs_from1.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <hr />
  <table class="etape" summary="Deuxi�me �tape" cellpadding="5">
    <tr>
      <td>
        <p>
        Un compte est d�sign� par un nom, ici c'est <em>adupont@mail.com</em>
        qui d�signe le compte utilis� dans l'exemple. Le plus souvent,
        la diff�rence entre deux comptes est l'adresse e-mail d'envoi uniquement,
        mais parfois, les comptes se diff�rencient aussi par les serveurs
        utilis�s pour recevoir ou envoyer un e-mail.
        </p>
        <p>
        Nous allons cr�er un nouveau compte pour utiliser polytechnique.org
        comme adresse d'envoi. Clique sur <strong>&quot;Ajouter&quot;</strong>, puis
        <strong>&quot;Courrier...&quot;</strong>.
        </p>
      </td>
      <td>
        <img src="{"images/docs_from2.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <hr />
  <table class="etape" summary="Troisieme �tape" cellpadding="5">
    <tr>
      <td>
        <p>
        Mettre Polytechnique.org dans le champ FROM (ou "De"), il faut bien
        comprendre que c'est une op�ration essentiellement formelle. Tes mails
        restent stock�s sur le m�me serveur, et Outlook Express utilise le m�me
        autre serveur pour poster les mails sortants. En fait, on cr�e plut�t un
        compte virtuel qu'un v�ritable compte.
        </p>
        <p>
        Le <strong>&quot;Nom complet&quot;</strong>, c'est la fa�on dont ton identit�
        appara�t dans le logiciel d'e-mail de tes destinataires. Tu peux
        taper absolument ce que tu veux, y compris un surnom pourquoi pas.
        </p>
        <p>
        Ensuite, clique sur <strong>&quot;Suivant &gt;&quot;</strong>.
        </p>
      </td>
      <td>
        <img src="{"images/docs_from3.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <hr />
  <table class="etape" cellpadding="5" summary="Quatri�me �tape">
    <tr>
      <td>
        <p>
        L'�cran suivant te demande l'adresse e-mail que tu veux afficher
        dans tes correspondances.
        </p>
        <p>
        Tu peux cr�er autant de comptes que tu veux sur le m�me ordinateur
        avec tes diff�rentes adresses e-mail, ce qui te permettra de choisir,
        au moment de composer un nouvel e-mail, quelle adresse tu veux utiliser.
        </p>
        <p>
        Ainsi, tu peux utiliser ton adresse professionnelle, ton adresse �
        la maison, ou ton adresse � vie. Nous te conseillons de refaire toute
        la proc�dure autant de fois que tu as d'adresses e-mail.
        </p>
        <p>
        Dans le cas pr�sent, nous cr�ons un compte qui envoie des e-mails sous
        l'identit�<br />
        &quot;Alice DUPONT &lt;
        <a href="mailto:alice.dupont@m4x.org/">alice.dupont@m4x.org</a>&gt;&quot;.
        </p>
        <p>
        Clique sur <strong>&quot;Suivant &gt;&quot;</strong>.
        </p>
      </td>
      <td>
        <img src="{"images/docs_from4.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <hr />
  <table class="etape" cellpadding="5" summary="Cinqui�me �tape">
    <tr>
      <td>
        <p>
        Cet �cran te demande quels serveurs utiliser pour ce compte.
        </p>
        <p>
        <strong>Le serveur POP3</strong>, c'est celui sur lequel l'ordinateur va chercher ton
        mail. Si tu as ouvert une adresse e-mail gratuite sur www.netcourrier.com par
        exemple, ce serveur est pop.netcourrier.com. D'une mani�re g�n�rale,
        cette ligne n'a pas d'importance pour un compte formel (le mail reste au
        m�me endroit). En effet, comme le logiciel dispose d�j� du compte habituel
        configur� avec l'indication du serveur POP3, ton ordinateur sait d�j� o�
        aller chercher ton mail. Tape donc n'importe quoi dans la case, �a marchera
        tr�s bien. On va d'ailleurs dire plus loin de ne pas tenir compte de ce
        r�glage.
        </p>
        <p>
        L'autre case est par contre tr�s importante. Il s'agit du <strong>serveur
          SMTP</strong>, qui est utilis� pour envoyer un e-mail. En g�n�ral, tu n'as
        pas le choix, il s'agit du serveur indiqu� par ton fournisseur d'acc�s
        � Internet. Chez wanadoo, c'est smtp.wanadoo.fr, chez libertysurf,
        c'est smtp.libertysurf.fr. Au travail, le serveur SMTP appartient �
        l'entreprise et pour conna�tre son nom, il faut regarder sur le compte
        d�j� configur� par d�faut, ou alors demander � un administrateur syst�me.
        Si tu utilises <strong>plusieurs fournisseurs d'acc�s</strong> ou que ton serveur
        SMTP refuse les champs From avec une adresse en polytechnique.org, utilise
        <strong>le serveur SMTP de polytechnique.org</strong>, dans ce cas,
        <a href="doc_smtp.php">regarde la configuration</a>.
        </p>
        <p>
        Clique ensuite sur <strong>&quot;Suivant &gt;&quot;</strong>.
        </p>
      </td>
      <td>
        <img src="{"images/docs_from5.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <p>
  L'�cran suivant te demande un compte et un mot de passe pour rechercher
  ton mail. Laisse-le tomber pour la m�me raison que le serveur POP3.
  Tu as d�j� un compte par d�faut qui v�rifie ton e-mail, il est inutile
  de reconfigurer le compte ici et d'aller v�rifier une seconde fois tes
  mails sur le m�me serveur.
  </p>
  <p>
  -> Le seul cas o� cet �cran a de l'importance, c'est si ton mail est stock� �
  plusieurs endroits sur Internet. Exemple typique : ton e-mail au travail est
  stock� sur un serveur au travail, ton e-mail netcourrier est stock� sur
  pop.netcourrier.com. Dans ce cas, tu peux configurer un deuxi�me compte avec
  un autre acc�s POP3. Quand tu rechercheras ton mail, tu verras appara�tre non
  seulement tes e-mails professionnels, mais bien s&ucirc;r aussi ceux personnels
  recherch�s sur netcourrier.com. Ce cas est trait� tout � la fin dans le
  paragraphe "configuration avanc�e".
  </p>
  <p>
  Clique ensuite sur <strong>&quot;Suivant &gt;&quot;</strong>, puis enfin
  <strong>&quot;Terminer&quot;</strong>.
  </p>
  <hr />
  <table class="etape" summary="Sixi�me �tape" cellpadding="5">
    <tr>
      <td>
        <p>
        Voil� maintenant la physionomie de la liste des comptes.
        </p>
        <p>
        Le nouveau compte a �t� nomm� du nom du serveur sur lequel les mails
        sont stock�s (le serveur POP3) en l'occurrence dans notre exemple, il
        s'agit de pop.netcourrier.com (ou n'importe quoi si tu as rentr� n'importe
        quoi plus haut).
        </p>
        <p>
        S�lectionne-le et clique sur <strong>&quot;Propri�t�s&quot;</strong>.
        </p>
      </td>
      <td>
        <img src="{"images/docs_from6.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <hr />
  <table class="etape" cellspacing="5" summary="Septi�me �tape">
    <tr>
      <td>
        <p>
        Cet �cran permet d'�diter directement tous les param�tres rentr�s
        au fur et � mesure de l'assistant de cr�ation de nouveau compte
        d�taill� ci-dessus.
        </p>
        <p>
        Dans l'onglet <strong>&quot;G�n�ral&quot;</strong>, on trouve l'adresse d'envoi
        du compte, et le <strong>&quot;Nom&quot;</strong> affich�.
        </p>
        <p>
        La petite case <strong>&quot;Inclure ce compte&quot; </strong>est importante.
        Si tu la coches, cela veut dire que ce compte est r�el et pas seulement
        formel. En gros, si elle n'est pas coch�e, le compte sert uniquement
        pour envoyer un mail avec l'adresse e-mail sp�cifi�e, qui sera utilis�e
        aussi pour la r�ponse, et si elle est coch�e, Outlook Express va aller
        v�rifier sur le serveur POP3 les e-mails. Dans l'�tape de tout � l'heure,
        on avait tap� n'importe quoi pour le serveur POP3, pour �tre coh�rent, il
        ne faut pas cocher la case ici, sinon une erreur sera affich�e � chaque
        v�rification de mail. En d'autres termes, le compte cr�e dans cet exemple
        n'est pas un compte de r�ception mais un compte d'envoi, on ne va donc pas
        l'inclure en r�ception !
        </p>
      </td>
      <td>
        <img src="{"images/docs_from7.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <hr />
  <table class="etape" cellspacing="5" summary="Huiti�me �tape">
    <tr>
      <td>
        <p>
        Et voil� le r�sultat ! Quand tu composes un nouveau mail, Outlook Express
        te donne le choix de l'adresse que ton destinataire va voir et � laquelle
        il te r�pondra.
        </p>
        <p>
        Tu peux donc �crire � qui tu veux avec une adresse en polytechnique.org
        ou en m4x.org. Pour cr�er autant de comptes virtuels que d'adresses e-mail,
        il suffit de recommencer au d�but.
        </p>
      </td>
      <td>
        <img src="{"images/docs_from8.png"|url}" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
  </table>
  <hr />
  <div class="rubrique">
    Configuration avanc�e
  </div>
  <p>
  Prenons un exemple. Tu travailles chez MyCompany o� tu as un e-mail
  prenom.nom@mycompany.fr et d'autre part, tu as ouvert un email chez netcourrier.com
  de la forme truc@netcourrier.com.
  </p>
  <p>
  De plus, tu reroutes polytechnique.org vers ton adresse e-mail personnelle
  chez netcourrier.com mais pas sur ton adresse professionnelle pour des
  raisons �thiques/de s�curit�/de confidentialit�.
  </p>
  <p>
  Cependant, tu souhaiterais pouvoir acc�der � ton e-mail en polytechnique.org �
  ton travail ou sur ton portable par exemple. C'est en effet toujours tr�s
  ennuyeux de lire son e-mail � des endroits diff�rents.
  </p>
  <p>
  Dans ce cas, la bonne configuration est la suivante.
  </p>
  <p class="sstitre">
  Premier compte :
  </p>
  <p>
  <strong>E-mail:</strong> prenom.nom@mycompany.fr<br />
  <strong>Serveur POP3:</strong>
  pop.mycompany.fr (v�rifier le nom au cas par cas)<br />
  <strong>Serveur SMTP:</strong>
  smtp.mycompany.fr (m�me remarque)<br />
  <strong>Case &quot;inclure ce compte&quot;:</strong> coch�e
  </p>
  <p class="sstitre">
  Deuxi�me compte :
  </p>
  <p>
  <strong>E-mail:</strong> prenom.nom@polytechnique.org<br />
  <strong>Serveur POP3:</strong> pop.netcourrier.com<br />
  <strong>Serveur SMTP:</strong> smtp.mycompany.fr<br />
  <strong>Case &quot;inclure ce compte&quot;:</strong> coch�e<br />
  </p>
  <p>
  A supposer maintenant que tu es r�ellement sur un portable. Quand
  tu le ram�nes chez toi, que tu te connectes via libertysurf, tu
  �cris un e-mail avec le compte polytechnique.org ci-dessus, et quand tu l'envoies,
  une erreur s'affiche dont le message est du style &quot;Relaying
  denied&quot;.<br /><br />
  </p>
  <p>
  <strong>Explication:</strong> chez toi, tu es reli� directement aux serveurs de libertysurf
  avant m�me d'atteindre Internet. Lorsque tu envoies un e-mail, libertysurf refuse
  d'�tre uniquement un transit vers le serveur utilis� pour envoyer l'email, en
  l'occurrence smtp.mycompany.fr pour le compte polytechnique.org ci-dessus
  (le serveur SMTP).
  </p>
  <p>
  Pourquoi ce refus de transmettre ton mail au serveur de smtp.mycompany.fr
  pour l'envoi ?
  </p>
  <p>
  Car un FAI (founisseur d'acc�s � Internet) a une responsabilit� lorsqu'il
  fournit l'acc�s � Internet � une personne. S'il autorisait le relaying, tu
  pourrais tout � fait envoyer un spam en utilisant un serveur de mycompany en
  �tant connect� par libertysurf, ou bien aussi des attaques e-mail (virus
  notamment) via toujours ce serveur de mycompany. Or, seul ton FAI sait exactement
  qui tu es, � la fois techniquement et en terme de responsabilit�. Si un virus
  mondial part gr�ce au serveur de mycompany, et que mycompany est incapable
  d'identifier l'envoyeur (il sait juste qu'il a transit� par libertysurf juste
  avant d'arriver chez lui, rien de plus), on imagine bien les cons�quences sur
  l'entreprise MyCompany.
  </p>
  <p>
  <strong>Conclusion:</strong> le serveur SMTP est toujours celui du prestataire le plus
  proche de toi sur le r�seau (celui qui te relie � Internet en clair). Quand tu
  es au travail, connect� par le r�seau de ton entreprise, tu envoies un email
  gr�ce au serveur SMTP smtp.mycompany.fr, quand tu es � la maison, connect� �
  Internet par l'interm�diaire des serveurs de Libertysurf, tu dois utiliser
  smtp.libertysurf.fr pour envoyer un e-mail. Et ainsi de suite.
  </p>
  <p>
  Pour r�soudre le probl�me initial du portable � la maison, il faut donc cr�er
  un nouveau compte, cette fois-ci "formel", car il ne va pas aller chercher de
  mails ailleurs que les deux premiers, il va juste servir � envoyer du mail par
  un serveur diff�rent des deux premiers comptes qui utilisent tous les deux
  smtp.mycompany.fr.
  </p>
  <p class="sstitre">
  Troisi�me compte :
  </p>
  <p>
  <strong>E-mail:</strong> prenom.nom@polytechnique.org<br />
  <strong>Serveur POP3:</strong> <em>peu importe, inutilis�</em><br />
  <strong>Serveur SMTP:</strong> smtp.libertysurf.fr (ce compte sert
  quand le premier serveur rencontr� sur le r�seau est un serveur libertysurf)<br />
  <strong>Case &quot;inclure ce compte&quot;:</strong> non coch�e (en effet,
  ce compte sert � envoyer un email en �tant connect� � Libertysurf, pas � en
  r�ceptionner)
  </p>
  <p>
  Voil�, le principe est simple une fois qu'on a saisi les petites
  subtilit�s de vocabulaire. Une personne avec deux adresses e-mails
  qu'elle veut pouvoir utiliser � la maison et au bureau sur la m�me
  machine a donc quatre comptes configur�s. Et si en plus on rajoute
  la possibilit� d'utiliser des alias comme m4x.org, il faut rajouter
  autant de comptes n�cessaires. Avec l'habitude, cr�er un
  nouveau compte ou en �diter un prend � peine quelques minutes. Allez,
  un peu de pratique!
  </p>
</div>

{* vim:set et sw=2 sts=2 sws=2: *}
