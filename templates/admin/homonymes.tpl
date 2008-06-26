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
 ***************************************************************************}


<h1>
  Gestion des homonymes
</h1>


{if $op eq 'mail'}
<p class="erreur">mail envoy� � {$forlife}</p>
{elseif $op eq 'correct'}
<p class="erreur">mail envoy� � {$forlife}, alias supprim�</p>
{/if}

{if $op eq 'list' || $op eq 'mail' || $op eq 'correct'}

<p>
  Les utilisateurs signal�s en rouge sont ceux qui conservent actuellement
  l'alias prenom.nom et emp�chent donc la mise en place du robot d�trompeur.
</p>

<table class="bicol">
  <tr>
    <th>alias concern�</th>
    <th>date de p�remption de l'alias</th>
    <th>op</th>
  </tr>
  {foreach from=$hnymes key=login item=row}
  <tr class="pair">
    <td colspan="3">
      <strong>{$login}</strong>
    </td>
  </tr>
  {foreach from=$row item=user}
  <tr class="impair">
    <td>&nbsp;&nbsp;
      {if $user.type eq 'alias'}
      <span class="erreur"><strong>{$user.forlife}</strong></span>
      {else}
      {$user.forlife}
      {/if}
    </td>
    <td>{$user.expire|date_format:"%d %b %Y"}</td>
    <td>
      <a href="{"fiche.php"|url}?user={$user.forlife}" class='popup2'>fiche</a>
      <a href="utilisateurs.php?login={$user.forlife}">edit</a>
      {if $user.type eq 'alias'}
      <a href="?op=mail-conf&amp;target={$user.user_id}">mailer</a>
      <a href="?op=correct-conf&amp;target={$user.user_id}">corriger</a>
      {/if}
    </td>
  </tr>
  {/foreach}
  {/foreach}
</table>

{elseif $op eq 'mail-conf'}

<form method="post" action="{$smarty.server.PHP_SELF}">
  <table class="bicol">
    <tr>
      <th>Envoyer un mail pour pr�venir l'utilisateur</th>
    </tr>
    <tr>
      <td>
        <textarea cols="80" rows="20" name="mailbody">
{$prenom},


Comme nous t'en avons inform� par mail il y a quelques temps,
pour respecter nos engagements en terme d'adresses e-mail devinables,
tu te verras bient�t retirer l'alias {$loginbis}@polytechnique.org pour
ne garder que {$forlife}@polytechnique.org.

Toute personne qui �crira � {$loginbis}@polytechnique.org recevra la
r�ponse d'un robot qui l'informera que {$loginbis}@polytechnique.org
est ambigu pour des raisons d'homonymie et signalera ton email exact.

L'�quipe Polytechnique.org
{$baseurl}
        </textarea>
      </td>
    </tr>
    <tr>
      <td>
        <input type="hidden" name="target" value="{$target}" />
        <input type="hidden" name="op" value="mail" />
        <input type="submit" value="Envoyer" />
      </td>
    </tr>
  </table>
</form>

{elseif $op eq 'correct-conf'}

<form method="post" action="{$smarty.server.PHP_SELF}">
  <table class="bicol">
    <tr>
      <th>Mettre en place le robot {$loginbis}@polytechnique.org</th>
    </tr>
    <tr>
      <td>
        <textarea cols="80" rows="20" name="mailbody">
{$prenom},
          
Comme nous t'en avons inform� par mail il y a quelques temps,
nous t'avons retir� de fa�on d�finitive l'adresse
{$loginbis}@polytechnique.org.

Toute personne qui �crit � {$loginbis}@polytechnique.org re�oit la
r�ponse d'un robot qui l'informe que {$loginbis}@polytechnique.org
est ambigu pour des raisons d'homonymie et signale ton email exact

Tu peux faire l'essai toi-m�me en �crivant � {$loginbis}@polytechnique.org.

L'�quipe Polytechnique.org
{$baseurl}
        </textarea>
      </td>
    </tr>
    <tr>
      <td>
        <input type="hidden" name="target" value="{$target}" />
        <input type="hidden" name="op" value="correct" />
        <input type="submit" value="Envoyer et corriger" />
      </td>
    </tr>
  </table>
</form>

{/if}


{* vim:set et sw=2 sts=2 sws=2: *}
