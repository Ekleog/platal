{* $Id: doc_emails.tpl,v 1.2 2004-01-29 16:21:54 x2000habouzit Exp $ *}

<div class="rubrique">
    Mes Redirections d'adresses emails
</div>
<div class="ssrubrique">
    En quoi �a consiste, comment �a marche ?
</div>
<p class="normal">
    Polytechnique.org te fournit un service de redirection de tes mails � vie. Toute ta vie, tu auras
    l'adresse <strong>{dyn s=$smarty.session.username}@polytechnique.org</strong>
    � ta disposition. Cependant, il s'agit d'une redirection, il faut donc que tu aies une boite au
    lettres fonctionnelles pour recevoir ton courrier (il en existe des
    <a href="{"docs/doc_gratuits.php"|url}">gratuites</a>).
</p>
<p class="normal">
    Ainsi, durant toute ta vie, et malgr� d'eventuels nombreux changements d'adresses r�elles, tous
    tes correspondants pourront toujours te contacter sur
    <strong>{dyn s=$smarty.session.username}@polytechnique.org</strong> et 
    <strong>{dyn s=$smarty.session.username}@m4x.org</strong>.
</p>
<p class="normal">
    L'utilisation de ce service est tr�s simple. Sur <a href="{"emails.php"|url}">cette
    page</a>, tu trouveras un formulmaire pour ajouter de nouvelles adresses de redirection. Tous
    les courries envoy�s sur tes adresses @polytechnique.org et @m4x.org seront redirig�s vers
    <strong>toutes</strong> les boites de redirection que tu auras sp�cifi�es <strong>et</strong>
    activ�es.
</p>

<br />

<div class="ssrubrique">
    <a href="{"docs/from.php"|url}">Utiliser mon adresse @polytechnique.org dans FROM:</a> (150 Ko)
</div>
<p>
    Ce lien t'explique comment configurer facilement plusieurs comptes e-mail dans Outlook Express.
    Quel int�r�t? Tu peux �crire des e-mails en choisissant l'identit� de toi qui envoie le mail. Tu
    peux ainsi envoyer des mails en tant que "prenom.nom@polytechnique.org", ou "prenom.nom@m4x.org"
    ou encore ton e-mail professionnel, ou encore ton e-mail personnel. Ceci te permet de contr�ler
    aussi o� les gens te r�pondront.
</p>
<p>
    Et choisir ton identit� peut �tre int�ressant, on n'a pas toujours envie de montrer qui on est
    par son adresse e-mail. 
</p>
<br />

<div class="ssrubrique">
    Se prot�ger du courrier non solicit� (SPAM)
</div>
<p class="normal">
    Beaucoup d'entre vous se plaignent de recevoir du courrier non solicit�, commun�ment appel�
    SPAM. Tr�s souvent, cel� vient d'un manque de prudence. En effet, il faut bien faire attention
    de ne pas laisser son adresse mails trop facilement compr�hensible par des robots.
</p>
<p class="normal">
    Il existe plusieurs mani�res de se pr�munir de l'indexation de ton adresse mail par des robots :
</p>
<ul>
    <li>Utiliser son adresse <strong>@m4x.org</strong> plutot que @polytechnique.org, elle est plus discr�te
    </li>
    <li>rendre son adresse mail invalide : par exemple, sur les forums Usenet, il n'est pas rare de
    rencontrer des adresses mails du type &lt;j.dupont@_NOSPAM_wanadoo.fr&gt;. Tous les humains
    sauront enlever le <em>_NOSPAM_</em> qui a �t� ajout�, mais les robots non.
    </li>
    <li>Il est aussi possible d'utiliser des services comme ceux de
    <a href="http://marreduspam.com/">http://marreduspam.com/</a> qui reste de loin le moyen le plus
    sur de camoufler son adresse aux robots trop curieux
    </li>
</ul>
<br />

<div class="ssrubrique">
    Une infinit� d'alias e-mails en polytechnique.org et m4x.org
</div>
<p class="normal">
    Lorsque tu �cris � <strong>destinataire+truc@polytechnique.org</strong> ou
    <strong>destinataire_truc@polytechnique.org</strong> tout ce qui se trouve derri�re le + ou le _
    est ignor�.
</p>
<p class="normal">
    Autrement dit, c'est comme �crire � <strong>destinataire@polytechnique.org</strong>.
    Tu peux te servir de cette infinit� d'alias pour un tas d'usages diff�rents. Citons-en deux.
</p>
<ul>
    <li>
    Sur le web, tu t'exposes � recevoir des spams en communiquant ton adresse. Mais si tu fournis �
    Amazon une adresse prenom.nom+amazon@m4x.org, lorsque tu recevras un mail (spam) sur l'adresse
    prenom.nom+amazon@ tu pourras savoir d'o� vient la fuite... Et m�me �ventuellement bloquer
    sp�cifiquement l'adresse prenom.nom+amazon et pas l'adresse prenom.nom.<br />
    Tu peux utiliser cette technique conjointement � celles cit�es ci-dessus.
    </li>
    <li>
    En combinant cette fonction avec les comptes ci-dessus, tu peux m�me te cr�er des comptes
    d'envoi de mail du style prenom.nom+chose@. Si tu fais un mail o� tu attends de nombreuses
    r�ponses, tu peux par exemple l'�crire depuis prenom.nom+sondage et filtrer les r�ponses en
    fonction de l'adresse de utilis�e.
    </li>
</ul>
<p class="normal"><em>
    <strong>NB:</strong> Le _ a �t� ajout� car certains sites web refusent le + dans une adresse
    email, qui est pourtant parfaitement valide d'apr�s les RFCs...
</em></p>
{* vim:set et sw=2 sts=2 sws=2: *}
