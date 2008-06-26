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
<input type="hidden" name="eid" value="{$evt.eid}" />
  <hr />
  <table>
    <tr>
      <td>Intitul� de l'�v�nement :</td>
      <td><input type="text" name="intitule" value="{$evt.intitule}" size="45" maxlength="100" /></td>
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
	</select>
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
        <input type="radio" name="advertise" value="1" {if $evt.advertise}checked{/if} /> oui
        <input type="radio" name="advertise" value="0" {if !$evt.advertise}checked{/if} /> non
      </td>
    </tr>
    <tr>
      <td colspan="2">Montrer la liste des participants � tous les membres :
        <input type="radio" name="show_participants" value="1" {if $evt.show_participants}checked{/if} /> oui
        <input type="radio" name="show_participants" value="0" {if !$evt.show_participants}checked{/if}/> non
      </td>
    </tr>
  </table>
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
  <center>
    <input type="submit" name="valid" value="Valider" />
    &nbsp;
    <input type="reset" value="Annuler" />
  </center>

</form>
