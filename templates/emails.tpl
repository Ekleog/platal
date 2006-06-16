{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2006 Polytechnique.org                             *}
{*  http://opensource.polytechnique.org/                                  *}
{*                                                                        *}
{*  This program is free software; you can redistribute it and/or modify  *}
{*  it under the terms of the GNU General Public License as published by  *}
{*  the Free Software Foundation; either version 2 of the License, or     *}
{*  (at your option) any later version.                                   *}
{*                                                                        *}
{*  This program is distributed in the hope that it will be useful,       *}
{*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *}
{*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *}
{*  GNU General Public License for more details.                          *}
{*                                                                        *}
{*  You should have received a copy of the GNU General Public License     *}
{*  along with this program; if not, write to the Free Software           *}
{*  Foundation, Inc.,                                                     *}
{*  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA               *}
{*                                                                        *}
{**************************************************************************}


<h1>
  Gestion de mes courriers �lectroniques
</h1>


<table class="bicol">
  <tr>
    <th>Mes adresses polytechniciennes � vie</th>
  </tr>
  <tr class="impair">
    <td>
      Tes adresses polytechniciennes sont :<br /><br />
      <form method='post' action='{$smarty.server.PHP_SELF}'>
        <div>
          {iterate from=$aliases item=a}
          <input type='radio' {if $a.best}checked="checked"{/if} name='best' value='{$a.alias}' onclick='this.form.submit()' />
          {if $a.a_vie}(**){/if}{if $a.cent_ans}(*){/if} <strong>{$a.alias}</strong>@{#globals.mail.domain#} et @{#globals.mail.domain2#}
          {if $a.expire}<span class='erreur'>(expire le {$a.expire|date_format})</span>{/if}
          <br />
          {/iterate}
        </div>
      </form>
      <br />
      L'adresse coch�e est celle que tu utilises le plus (et qui sera donc affich�e sur ta carte de visite, ta fiche, etc...).
      Coche une autre case pour en changer !
    </td>
  </tr>
  <tr class="pair">
    <td>
      (M4X signifie <em>mail for X</em>, son int�r�t est de te doter d'une adresse � vie
      moins "voyante" que l'adresse @{#globals.mail.domain#}).
    </td>
  </tr>
</table>

<p class="smaller">
(*) cette adresse email t'est r�serv�e pour une p�riode 100 ans apr�s ton entr�e � l'X (dans ton cas, jusqu'en
{$smarty.session.promo+100}).
</p>
<p class="smaller">
(**) cette adresse email t'est r�serv�e � vie.
</p>
<p class="smaller">
Si tu venais � avoir un homonyme X, l'alias prenom.nom@{#globals.mail.domain#} sera d�sactiv�. Si bien que
ton homonyme et toi-m�me ne disposeraient plus que des adresses de la forme prenom.nom.promo@{#globals.mail.domain#}.
</p>


<br />

<table class="bicol">
  <tr>
    <th>O� est-ce que je re�ois le courrier qui m'y est adress� ?</th>
  </tr>
  <tr class="impair">
    <td>
      Actuellement, tout courrier �lectronique qui t'y est adress�, est envoy�
      {if $mails->total() eq 1} � l'adresse {else} aux adresses {/if}
      <ul>
        {iterate from=$mails item=m}
        <li><strong>{$m.email}</strong></li>
        {/iterate}
      </ul>
      Si tu souhaites <strong>modifier ce reroutage de ton courrier,</strong>
      <a href="{rel}/emails/redirect.php">il te suffit de te rendre ici !</a>
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
    <th>Un alias sympathique : {#globals.mail.alias_dom#} !</th>
  </tr>
  <tr class="impair">
    <td>
      Tu peux ouvrir en suppl�ment une adresse synonyme de ton adresse @{#globals.mail.domain#},
      sur les domaines @{#globals.mail.alias_dom#} et @{#globals.mail.alias_dom2#} (melix = M�l X).
    </td>
  </tr>
  <tr class="impair">
    <td>
      {if $melix}
      Tu disposes � l'heure actuelle de l'alias <strong>{$melix}</strong>
      Pour <strong>demander � la place un autre alias @{#globals.mail.alias_dom#}</strong>,
      <a href="alias.php">il te suffit de te rendre ici</a>
      {else}
      A l'heure actuelle <strong>tu n'as pas activ� d'adresse @{#globals.mail.alias_dom#}</strong>.
      Si tu souhaites le faire, <a href="alias.php">il te suffit de venir ici</a>
      {/if}
    </td>
  </tr>
</table>


{* vim:set et sw=2 sts=2 sws=2: *}
