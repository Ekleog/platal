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


<h1>Micropaiments</h1>

{if $smarty.request.op eq "submit" and !$xorg_error->errs|count}

<table class="bicol">
  <tr>
    <th colspan="2">Paiement via {$meth->text}</th>
  </tr>
  <tr>
    <td><b>Transaction</b></td>
    <td>{$pay->text}</td>
  </tr>
  <tr>
    <td><b>Montant (euros)</b></td>
    <td>{$montant}</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <form method="post" action="{$pay->api->urlform}">
      <div>
	<!-- infos commercant -->
        {foreach from=$pay->api->infos.commercant key="name" item="value"}
	<input type="hidden" name="{$name}" value="{$value}" />
        {/foreach}
	<!-- infos client -->
        {foreach from=$pay->api->infos.client key="name" item="value"}
	<input type="hidden" name="{$name}" value="{$value}" />
        {/foreach}
	<!-- infos commande -->
        {foreach from=$pay->api->infos.commande key="name" item="value"}
	<input type="hidden" name="{$name}" value="{$value}" />
        {/foreach}
	
	<!-- infos divers -->
        {foreach from=$pay->api->infos.divers key="name" item="value"}
	<input type="hidden" name="{$name}" value="{$value}" />
        {/foreach}
	<input type="submit" value="Valider" />
      </div>
      </form>
    </td>
  </tr>
</table>
<p>
En cliquant sur "Valider", tu seras redirig�{if $smarty.session.sexe}e{/if} vers le site de {$pay->api->nomsite}, o� il te
sera demand� de saisir ton num�ro de carte bancaire.  Lorsque le paiement aura �t� effectu�, tu
recevras une confirmation par email.
</p>
{if $pay->api->text}
<p>
{$pay->api->text}
</p>
{/if}

{else}

<form method="post" action="{$smarty.server.PHP_SELF}">
  <p> Si tu ne souhaites pas utiliser notre interface de
  t�l�paiement, tu peux virer directement la somme de ton choix sur notre compte
  30004 00314 00010016782 60. Nous veillerons � ce que ton paiement parvienne �
  son destinataire.  Pense toutefois � le pr�ciser dans le motif du
  versement.
  <br /><br />
  </p>
  <table class="bicol">
    <tr>
      <th colspan="2">Effectuer un t�l�paiement</th>
    </tr>
    <tr>
      <td>Transaction</td>
      <td>
        <select name="ref" onchange="this.form.op.value='select'; this.form.submit();">
          {select_db_table table="`$prefix`paiements" valeur=$pay->id where=" WHERE FIND_IN_SET('old',flags)=0"}
        </select>
        {if $pay->url}
        <br />
        <a href="{$pay->url}">plus d'informations</a>
        {/if}
      </td>
    </tr>
    <tr>
      <td>M�thode</td>
      <td>
        <select name="methode">
          {select_db_table table="paiement.methodes" valeur=$methode}
        </select>
      </td>
    </tr>
    <tr>
      <td>Montant (euros)</td>
      <td><input type="text" name="montant" size="13" class='right' value="{$montant}" /></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
        <input type="hidden" name="op" value="submit" />
        <input type="submit" value="Continuer" />
      </td>
    </tr>
  </table>
</form>

{/if}


{* vim:set et sw=2 sts=2 sws=2: *}