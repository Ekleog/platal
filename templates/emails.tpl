{* $Id: emails.tpl,v 1.2 2004-02-12 02:03:08 x2000habouzit Exp $ *}

<div class="rubrique">
Gestion de mes courriers �lectroniques
</div>

{dynamic}

<table class="bicol">
  <tr>
    <th>Mes adresses polytechniciennes � vie {if !$is_homonyme}*{/if}</th>
  </tr>
  <tr class="impair">
    <td>
      Tes adresses polytechniciennes sont
      <strong>{$smarty.session.username}@polytechnique.org</strong> et
      <strong>{$smarty.session.username}@m4x.org</strong>
      (M4X signifie <em>mail for X</em>, son int�r�t est de te doter d'une adresse � vie
      moins "voyante" que l'adresse @polytechnique.org).
      {if $alias}
      Tu disposes �galement des adresses {$alias}@polytechnique.org et {$alias}@m4x.org
      {/if}
    </td>
  </tr>
  <tr class="pair">
    <td>
      Elles seront prochainement <strong>compl�t�es d'une adresse @polytechnique.edu</strong>,
      plus lisible dans les pays du monde o� "Polytechnique" n'�voque pas grand chose,
      .edu �tant le suffixe propre aux universit�s et �tablissements d'enseignement sup�rieur.
    </td>
  </tr>
</table>

<br />

<table class="bicol">
  <tr>
    <th>O� est-ce que je re�ois le courrier qui m'y est adress� ?</th>
  </tr>
  <tr>
    <td>
      Actuellement, tout courrier �lectronique qui t'y est adress�, est envoy�
      {if $nb_mails eq 1} � l'adresse {else} aux adresses {/if}
      {section name=mail loop=$mails}
      <strong>{$mails[mail].email}</strong>{if $smarty.section.mail.last}.{else}, {/if}
      {/section}
      <br />
      Si tu souhaites <strong>modifier ce reroutage de ton courrier,</strong>
      <a href="{"routage-mail.php"|url}">il te suffit de te rendre ici !</a>
    </td>
  </tr>
</table>

<br />

<table class="bicol">
  <tr>
    <th colspan="2">Antivirus, antispam</th>
  </tr>
  <tr>
    <td class="half">
      Tous les courriers qui te sont envoy�s sur tes adresses polytechniciennes sont
      <strong>filtr�s par un logiciel antivirus</strong> tr�s performant. Il te prot�ge de ces
      vers tr�s g�nants, qui se propagent souvent par le courrier �lectronique.
    </td>
    <td class="half">
      De m�me, un <strong>service antispam �volu�</strong> est en place. Tu peux lui demander
      de te d�barrasser des spams que tu re�ois. Pour en savoir plus, et l'activer,
      <a href="antispam.php">c'est tr�s simple, suis ce lien </a>!
      <br />
    </td>
  </tr>
</table>

<br />

<table class="bicol">
  <tr>
    <th>Un alias sympatique : melix !</th>
  </tr>
  <tr class="impair">
    <td>
      Tu peux ouvrir en suppl�ment une adresse synonyme de ton adresse @polytechnique.org, 
      sur les domaines @melix.org et @melix.net (melix = M�l X).
    </td>
  </tr>
  <tr class="pair">
    <td>
      {if $melix}
      Tu disposes � l'heure actuelle des adresses <strong>{$melix}net</strong> et <strong>{$melix}org</strong>.
      Pour <strong>demander � la place un autre alias melix</strong>,
      <a href="alias.php">il te suffit de te rendre ici</a>
      {else}
      A l'heure actuelle <strong>tu n'as pas activ� d'adresse melix</strong>.
      Si tu souhaites le faire, <a href="alias.php">il te suffit de venir ici</a>
      {/if}
    </td>
  </tr>
</table>


{if !$is_homonyme}
<p class="smaller">
* Tu les garderas toute ta vie, sauf si un jour un homonyme d'une autre promotion
s'inscrit � Polytechnique.org (les cas d'homonymie sont <em>tr�s</em> rares),
auquel cas ces adresses deviendraient
{$smarty.session.username}{$smarty.session.promo|regex_replace:"/^../":""}@polytechnique.org et
{$smarty.session.username}{$smarty.session.promo|regex_replace:"/^../":""}@m4x.org
</p>
{/if}

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
