{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2004 Polytechnique.org                             *}
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

<p class="descr">
  Un �v�nement peut �tre une r�union, un s�minaire, une conf�rence, un voyage promo,
  etc... Pour en organiser un et b�n�ficier des outils de suivi d'inscription et de
  paiement offerts, il te faut remplir les quelques champs du formulaire ci-dessous.
</p>
<p class="descr">
  Tu as la possibilit�, pour un �v�nement donn�, de distinguer plusieurs "moments"
  distincts. Par exemple, dans le cas d'une r�union suivie d'un d�ner, il peut �tre
  utile de comptabiliser les pr�sents � la r�union d'une part, et de compter ceux
  qui s'inscrivent au repas d'autre part (en g�n�ral certains participants � la r�union
  ne restent pas pour le d�ner...), de sorte que tu sauras combien de chaises pr�voir
  pour le premier "moment" (la r�union), et pour combien de personnes r�server le
  restaurant.
</p>

<form method="post" action="{$smarty.server.PHP_SELF}">
  <hr />
  <table>
    <tr>
      <td>Intitul� de l'�v�nement :</td>
      <td>
        <input type="hidden" name="eid" value="{$evt.eid}" />
        <input type="text" name="intitule" value="{$evt.intitule}" size="45" maxlength="100" />
      </td>
    </tr>
    <tr>
      <td>Ev�nement en raccourci (pour les mailings listes) :</td>
      <td><input type="text" name="short_name" value="{$evt.short_name}" size="20"/></td>
    </tr>
    <tr>
      <td>Descriptif :</td>
      <td><textarea name="descriptif" cols="45" rows="6">{$evt.descriptif}</textarea></td>
    </tr>
    <tr>
      <td>Date de d�but :</td>
      <td>
        le
        {html_select_date prefix='deb_' end_year='+5' day_value_format='%02d' field_order='DMY' field_separator=' / ' month_format='%m' time=$evt.debut}
        �
        {html_select_time use_24_hours=true display_seconds=false time=$evt.debut prefix='deb_' minute_interval=5}
      </td>
    </tr>
    <tr>
      <td>Date de fin :</td>
      <td>
        le
        {html_select_date prefix='fin_' end_year='+5' day_value_format='%02d' field_order='DMY' field_separator=' / ' month_format='%m' time=$evt.fin}
        �
        {html_select_time use_24_hours=true display_seconds=false time=$evt.fin prefix='fin_' minute_interval=5}
      </td>
    </tr>
    <tr>
      <td colspan="2">Ouvert aux membres du groupe uniquement :
        <input type="radio" name="membres_only" value="1" {if $evt.membres_only}checked="checked"{/if} /> oui
        <input type="radio" name="membres_only" value="0" {if !$evt.membres_only}checked="checked"{/if} /> non
      </td>
    </tr>
    <tr>
      <td colspan="2">Annoncer l'�v�nement publiquement sur le site :
        <input type="radio" name="advertise" value="1" {if $evt.advertise}checked="checked"{/if} /> oui
        <input type="radio" name="advertise" value="0" {if !$evt.advertise}checked="checked"{/if} /> non
      </td>
    </tr>
    <tr>
      <td colspan="2">Montrer la liste des participants � tous les membres :
        <input type="radio" name="show_participants" value="1" {if $evt.show_participants}checked="checked"{/if} /> oui
        <input type="radio" name="show_participants" value="0" {if !$evt.show_participants}checked="checked"{/if}/> non
      </td>
    </tr>
    <tr>
      <td>R�f�rence de paiement :
      </td>
      <td>
        <select name="paiement" onchange="document.getElementById('new_pay').style.display=(value &lt; 0?'block':'none')">
          {if $evt.paiement_id eq -2}
          <option value='-2'>Paiement en attente de validation</option>
          {/if}
          <option value=''>Pas de paiement</option>
          <option value='-1'>- Nouveau paiement -</option>
          {html_options options=$paiements selected=$evt.paiement_id}
        </select>
      </td>
    </tr>
  </table>
  <div id="new_pay" style="display:none">
    Nouveau paiement, message de confirmation&nbsp;:<br />
    <textarea name="confirmation" rows="12" cols="65">&lt;salutation&gt; &lt;prenom&gt; &lt;nom&gt;,

      Ton inscription � [METS LE NOM DE L'EVENEMENT ICI] a bien �t� enregistr�e et ton paiement de &lt;montant&gt; a bien �t� re�u. 
      [COMPLETE EN PRECISANT LA DATE ET LA PERSONNE A CONTACTER]

      A tr�s bientot,

      [SIGNE ICI]</textarea><br />
    Le nouveau paiement n'est pas rajout� automatiquement mais doit �tre valid� par le tr�sorier de l'association Polytechnique.org, ce qui sera fait sous peu.<br /><br />
    Page internet de l'�v�nement&nbsp;:<br />
    <input size="40" name="site" value="{$asso.site}" />
  </div>
  
  {foreach from=$moments item=i}
  {assign var='moment' value=$items[$i]}
  <hr />
  <table>
    <tr><td colspan="2" align="center"><strong>"Moment" {$i}</strong></td></tr>
    <tr>
      <td>Intitul� :</td>
      <td><input type="text" name="titre{$i}" value="{$moment.titre}" size="45" maxlength="100" /></td>
    </tr>
    <tr>
      <td>D�tails pratiques :</td>
      <td><textarea name="details{$i}" rows="6" cols="45">{$moment.details}</textarea></td>
    </tr>
    <tr>
      <td>Montant par participant :<br /><small>(0 si gratuit)</small></td>
      <td><input type="text" name="montant{$i}" value="{if $moment.montant}{$moment.montant|replace:".":","}{else}0,00{/if}" size="7" maxlength="7" /> &#8364;</td>
    </tr>
  </table>
  {/foreach}
 
  <div class="center">
    <input type="submit" name="valid" value="Valider" />
    &nbsp;
    <input type="reset" value="Annuler" />
  </div>

</form>
{* vim:set et sw=2 sts=2 sws=2: *}
