{* $Id: doc_carva.tpl,v 1.1 2004-01-27 16:34:50 x2000habouzit Exp $ *}

<div class="rubrique">
  Redirection de page WEB
</div>

<div class="ssrubrique">
  Pourquoi une redirection de page WEB ?
</div>

<p class="normal">
  Dans la lign�e du service de redirection d'emails de <b>Polytechnique.org</b>, 
  il est possible de faire pointer 
{if $smarty.session.alias}
  l'adresse <b>http://www.carva.org/{dyn s=$smarty.session.username}</b>
{else}
  les adresses <b>http://www.carva.org/{dyn s=$smarty.session.username}</b>
  et <b>http://www.carva.org/{$smarty.session.alias}</b> ";
{/if}
  vers la page WEB de ton choix.
</p>
<p class="normal">
  La redirection fournie par <b>carva.org</b> t'offre ainsi une adresse Internet 
  simple et immuable pour r�f�rencer ton site personnel, quelle que soit la solution 
  d'h�bergement retenue (free.fr, wanadoo.fr, ifrance.com, etc.).
</p>
<div class="ssrubrique">
  Pourquoi le nom de domaine carva.org ?
</div>
<p class="normal">
  Dans le jargon de l'�cole, un 'carva' signifiait un 'X' lorsque celle-ci �tait 
  situ�e sur la montagne Ste Genevi�ve (<a href="javascript:x()" onclick="popWin('../aide.php#carva','remplissage','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=400,height=500')">
    voir la FAQ � ce sujet</a>). 
</p>
<br />

<div class="rubrique">
  <a name="charte"></a>Conditions d'usage de la redirection de page WEB
</div>
<p class="normal">
  L'utilisateur s'engage � ce que le contenu du site r�f�renc� soit en conformit� 
  avec les lois et r�glements en vigueur et d'une mani�re g�n�rale ne porte pas 
  atteinte aux droits des tiers.
</p>
<hr>
<p class="normal">
  Notamment, mais non exclusivement, l'utilisateur s'engage � ce que le contenu 
  du site r�f�renc� :
</p>
<ul>
  <li> 
    ne porte pas atteinte ou ne soit pas contraire � l'ordre public ou aux bonnes 
    m&oelig;urs ou ne puisse pas heurter la sensibilit� des mineurs ;
  </li>
  <li> 
    ne porte pas atteinte de quelque mani�re que ce soit aux droits, � la 
    r�putation, � la vie priv�e de tiers ;
  </li>
  <li>
    ne contienne pas de propos ou d'images d�nigrantes, diffamatoires ou portant 
    atteinte � l'image ou � la r�putation d'une marque ou d'une quelconque personne 
    physique ou morale de quelque que mani�re que ce soit ;
  </li>
  <li>
    ne pr�sente pas de caract�re pornographique ou p�dophile ;
  </li>
  <li>
    ne propose pas la vente, le don ou l'�change de biens vol�s ou issus d'un 
    d�tournement, d'une escroquerie, d'un abus de confiance ou de tout autre 
    infraction p�nale ;
  </li>
  <li>
    ne propose pas la vente, le don ou l'�change de biens pouvant pr�senter de 
    vices et de d�fauts de fabrication de nature � causer un danger pour les 
    personnes et les biens ;
  </li>
  <li>
    ne porte pas atteinte aux droits de propri�t� intellectuelle prot�g�s par la loi ;
  </li>
  <li>
    n'incite pas � la haine, � la violence, au suicide, au racisme, � l'antis�mitisme, 
    � la x�nophobie, ne fasse pas l'apologie des crimes de guerre ou des crimes contre 
    l'humanit� ;
  </li>
  <li>
    n'incite pas � la discrimination d'une personne ou d'une groupe de personne en 
    raison de son appartenance � une ethnie ou � une religion ;
  </li>
  <li>
    ne porte pas atteinte � la s�curit� ou � l'int�grit� d'un Etat ou d'un territoire, 
    quel qu'il soit ;
  </li>
  <li>
    n'incite pas � commettre un crime, un d�lit ou un acte de terrorisme ;
  </li>
  <li>
    ne permette pas � des tiers de se procurer des logiciels pirat�s ou des num�ros 
    de s�rie de logiciels, ou tout logiciel pouvant nuire ou porter atteinte, de 
    quelque mani�re que ce soit, aux droits ou aux biens des tiers.
  </li>
</ul>
<p class="normal">
  Cette liste doit �tre consid�r�e comme non limitative.
</p>
<p class="normal">
  Polytechnique.org ne peut �tre consid�r� comme responsable du contenu des pages 
  WEB redirig�es.
</p>

{* vim:set et sw=2 sts=2 sws=2: *}
