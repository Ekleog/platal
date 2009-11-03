{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2009 Polytechnique.org                             *}
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

{literal}
<script type="text/javascript">//<![CDATA[
function chgMainWinLoc(strPage)
{
  strPage = platal_baseurl + strPage;
  if (parent.opener) {
    try {
      parent.opener.document.location = strPage;
      window.close();
    } catch(e) {
      window.open(strPage);
    }
  } else {
    document.location = strPage;
  }
}
//]]></script>
{/literal}

<div id="fiche">
  <div id="photo" class="part">
    {if $photo_url}<img alt="Photo de {$user->login()}" src="{$photo_url}" width="{$x.x}"/>{/if}
    {if $logged && ( $x.section|smarty:nodefaults || $x.binets_join|smarty:nodefaults || $x.gpxs_join|smarty:nodefaults)}
      <h2>À l'X&hellip;</h2>
      {if $x.section}<div><em class="intitule">Section&nbsp;: </em><span>{$x.section}</span></div>{/if}
      {if $x.binets_join}<div><em class="intitule">Binet{if count($x.binets) > 1}s{/if}&nbsp;: </em>
      <span>{$x.binets_join}</span></div>{/if}
      {if $x.gpxs_join}<div><em class="intitule">Groupe{if count($x.gpxs) > 1}s{/if} et institution{if count($x.gpxs) > 1}s{/if} X&nbsp;: </em>
      <span><br/>{$x.gpxs_join|smarty:nodefaults}</span></div>{/if}
    {/if}
    {if $x.freetext}
    <h2>Commentaires&nbsp;:</h2>
    <span>{$x.freetext|miniwiki|smarty:nodefaults}</span>
    {/if}
  </div>
  <div id="fiche_identite" class="part">
    <div class="civilite">
      {if $user->isFemale()}&bull;{/if}
      {$user->fullName()}{if $x.nom_usage neq ""} ({$x.nom}){/if}
      {if $logged}
      {if $x.nickname} (alias {$x.nickname}){/if}
      {/if}
      {if $x.web}&nbsp;<a href="{$x.web}">{icon name="world_go" title="Site Web"}</a>{/if}
      {if $logged}
      &nbsp;{if !$x.dcd}<a href="vcard/{$user->login()}.vcf">{*
        *}{icon name=vcard title="Afficher la carte de visite"}</a>{/if}
      {if !$x.is_contact}
      <a href="javascript:chgMainWinLoc('carnet/contacts?action=ajouter&amp;user={$user->login()}&amp;token={xsrf_token}')">
        {icon name=add title="Ajouter à mes contacts"}</a>
      {else}
      <a href="javascript:chgMainWinLoc('carnet/contacts?action=retirer&amp;user={$user->login()}&amp;token={xsrf_token}')">
        {icon name=cross title="Retirer de mes contacts"}</a>
      {/if}
      {if hasPerm('admin')}
      <a href="javascript:chgMainWinLoc('admin/user/{$user->login()}')">
        {icon name=wrench title="administrer user"}</a>
      {/if}
      {if $user->login() eq $smarty.session.hruid}
      <a href="javascript:chgMainWinLoc('profile/edit')">{icon name="user_edit" title="Modifier ma fiche"}</a>
      {/if}
      {/if}
    </div>
    {if $logged}
    <div class='maj'>
      Fiche mise à jour<br />
      le {$x.date|date_format}
    </div>
    {/if}
    {if $logged || $x.mobile}
    <div class="contact">
      {if $logged}
      <div class='email'>
        {if $x.dcd}
        Décédé{if $user->isFemale()}e{/if} le {$x.deces|date_format}
        {elseif !$x.actif}
        Ce{if $c.sexe}tte{/if} camarade n'a plus d'adresse de redirection valide,<br />
        <a href="marketing/broken/{$user->login()}" class="popup">clique ici si tu connais son adresse email&nbsp;!</a>
        {elseif !$x.inscrit}
        Cette personne n'est pas inscrite à Polytechnique.org,<br />
        <a href="marketing/public/{$user->login()}" class="popup">clique ici si tu connais son adresse email&nbsp;!</a>
        {else}
        {if $virtualalias}
        <a href="mailto:{$virtualalias}">{$virtualalias}</a><br />
        {/if}
        <a href="mailto:{$user->bestEmail()}">{$user->bestEmail()}</a>
        {if $user->bestEmail() neq $user->forlifeEmail()}<br />
        <a href="mailto:{$user->forlifeEmail()}">{$user->forlifeEmail()}</a>
        {/if}
        {/if}
      </div>
      {/if}
      {if $x.mobile}
      <div class="mob">
        <em class="intitule">{if $x.dcd}Dernier m{else}M{/if}obile&nbsp;: </em>{$x.mobile}
      </div>
      {/if}
      <div class='spacer'></div>
    </div>
    {/if}
    <div class='formation'>
      {if $x.iso3166}
      <img src='images/flags/{$x.iso3166}.gif' alt='{$x.nationalite}' height='11' title='{$x.nationalite}' />&nbsp;
      {/if}
      X {$user->promo()}
      {if $x.promo_sortie && ($x.promo_sortie-3 > $x.promo)}
        - X {math equation="a-b" a=$x.promo_sortie b=3}
      {/if}
      {if $x.applis_join}
        &nbsp;-&nbsp;Formation&nbsp;: {$x.applis_join|smarty:nodefaults}
      {/if}
      {if $logged && $x.is_referent}
      [<a href="referent/{$user->login()}" class='popup2'>Ma fiche référent</a>]
      {/if}
    </div>
  </div>
  {if $x.adr}
  <div class="part">
    <h2>Contact&nbsp;: </h2>
    {if $x.dcd}
      {assign var=address_name value="Dernière adresse"}
    {else}
      {assign var=address_name value="Adresse"}
    {/if}
    {foreach from=$x.adr item="address" name=adresses}
      {if $smarty.foreach.adresses.iteration is even}
        {assign var=pos value="right"}
      {else}
        {assign var=pos value="left"}
      {/if}
      {if $address.active}
      {include file="geoloc/address.tpl" address=$address titre_div=true titre=$address_name|@cat:" actuelle&nbsp;:"
               for="`$x.prenom` `$x.nom`" pos=$pos}
      {elseif $address.secondaire}
      {include file="geoloc/address.tpl" address=$address titre_div=true titre=$address_name|@cat:" secondaire&nbsp;:"
               for="`$x.prenom` `$x.nom`" pos=$pos}
      {else}
      {include file="geoloc/address.tpl" address=$address titre_div=true titre=$address_name|@cat:" principale&nbsp;:"
               for="`$x.prenom` `$x.nom`" pos=$pos}
      {/if}
      {if $smarty.foreach.adresses.iteration is even}<div class="spacer"></div>{/if}
    {/foreach}
  </div>
  {/if}
  {if $x.adr_pro}
  <div class="part">
    <h2>Informations professionnelles&nbsp;:</h2>
    {foreach from=$x.adr_pro item="address" key="i"}
      {if $i neq 0}<hr />{/if}
      {include file="include/emploi.tpl" address=$address}
      {include file="geoloc/address.tpl" address=$address titre="Adresse&nbsp;: " for=$address.entreprise pos="left"}
      <div class="spacer">&nbsp;</div>
    {/foreach}
  </div>
  {/if}
  {if $x.medals}
  <div class="part">
    <h2>Distinctions&nbsp;: </h2>
    {foreach from=$x.medals item=m}
    <div class="medal_frame">
      <img src="profile/medal/thumb/{$m.id}" height="50px" alt="{$m.medal}" title="{$m.medal}" style='float: left;' />
      <div class="medal_text">
        {$m.medal}<br />{$m.grade}
      </div>
    </div>
    {/foreach}
    <div class="spacer">&nbsp;</div>
  </div>
  {/if}
  {if $logged && $x.cv}
  <div class="part">
    <h2>Curriculum Vitae&nbsp;:</h2>
    {$x.cv|miniwiki:title|smarty:nodefaults}
  </div>
  {/if}
  {if $view eq 'public'}
  <div class="part">
    <small>
    Cette fiche est publique et visible par tout internaute,<br />
    vous pouvez aussi voir <a href="profile/private/{$user->login()}?display=light">celle&nbsp;réservée&nbsp;aux&nbsp;X</a>.
    </small>
  </div>
  {elseif $view eq 'ax'}
  <div class="part">
    <small>
    Cette fiche est privée et ne recense que les informations transmises à l'AX.
    </small>
  </div>
  {/if}
  <div class="spacer"></div>
</div>

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}
