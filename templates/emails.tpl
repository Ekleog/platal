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
        $Id: emails.tpl,v 1.9 2004-10-24 14:41:11 x2000habouzit Exp $
 ***************************************************************************}


<h1>
  Gestion de mes courriers �lectroniques
</h1>

{dynamic}

<table class="bicol">
  <tr>
    <th>Mes adresses polytechniciennes � vie</th>
  </tr>
  <tr class="impair">
    <td>
      Tes adresses polytechniciennes sont :
      <ul>
        {foreach from=$aliases item=a}
        <li>
        {if $a.a_vie}(*){/if} <strong>{$a.alias}</strong>@polytechnique.org et @m4x.org 
        {if $a.expire}<span class='erreur'>(expire le {$a.expire|date_format:"%d %b %Y"})</span>{/if}
        </li>
        {/foreach}
      </ul>
    </td>
  </tr>
  <tr class="pair">
    <td>
      (M4X signifie <em>mail for X</em>, son int�r�t est de te doter d'une adresse � vie
      moins "voyante" que l'adresse @polytechnique.org).
    </td>
  </tr>
  <tr class="impair">
    <td>
      Elles seront prochainement <strong>compl�t�es d'une adresse @polytechnique.edu</strong>,
      plus lisible dans les pays du monde o� "Polytechnique" n'�voque pas grand chose,
      .edu �tant le suffixe propre aux universit�s et �tablissements d'enseignement sup�rieur.
    </td>
  </tr>
</table>

<p class="smaller">
(*) l'adresse email marqu�e d'une (*) t'est r�serv�e pour une p�riode 100 ans apr�s ton entr�e � l'X (dans ton cas, jusqu'en {$smarty.session.promo+100}).
Les autres te sont attribu�es a priori � vie, sauf si tu venais � avoir un homonyme X. Dans ce cas, ni ton homonyme ni toi-m�me n'auriez d'autres adresses que celles de la forme prenom.nom.promo@polytechnique.org.
</p>


<br />

<table class="bicol">
  <tr>
    <th>O� est-ce que je re�ois le courrier qui m'y est adress� ?</th>
  </tr>
  <tr class="pair">
    <td>
      Actuellement, tout courrier �lectronique qui t'y est adress�, est envoy�
      {if $nb_mails eq 1} � l'adresse {else} aux adresses {/if}
      <ul>
        {section name=mail loop=$mails}
        <li><strong>{$mails[mail].email}</strong>{if $smarty.section.mail.last}.{else}, {/if}</li>
        {/section}
      </ul>
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
  <tr class="impair">
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
  <tr class="pair">
    <td>
      Tu peux ouvrir en suppl�ment une adresse synonyme de ton adresse @polytechnique.org, 
      sur les domaines @melix.org et @melix.net (melix = M�l X).
    </td>
  </tr>
  <tr class="impair">
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

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
