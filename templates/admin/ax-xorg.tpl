{* $Id: ax-xorg.tpl,v 1.3 2004-08-26 14:44:43 x2000habouzit Exp $ *}

<div class="rubrique">
  V�rifier notre table de correspondance entre l'annuaire de l'AX et le n�tre
</div>

<div class="ssrubrique">
  Liste des camarades qui n'apparaissent pas sous le m�me nom dans les deux annuaires
</div>

{dynamic}
<table class="bicol" summary="liste des absents de notre annuaire">
  <tr>
    <th>Promo</th>
    <th>Nom X.org</th>  <th>Pr�nom X.org</th>   <th>Mat X.org</th>
    <th>Nom AX</th>     <th>Pr�nom AX</th>      <th>Mat AX</th>
  </tr>
{foreach item=x from=$diffs}
  <tr class="{cycle values="impair,pair"}">
    <td>{$x.promo}</td>
    <td>{$x.nom}</td>   <td>{$x.prenom}</td>    <td>{$x.mat}</td>
    <td>{$x.nomax}</td> <td>{$x.prenomax}</td>  <td>{$x.matax}</td>
  </tr>
{/foreach}
</table>

<p>
  <strong>{$nb_diffs} camarades ont un �tat civil diff�rent dans les 2 annuaires.</strong>
</p>
{/dynamic}

<br />
<br />

<div class="ssrubrique">
  Liste des camarades de l'annuaire de l'AX qui manquent � notre annuaire
</div>

{dynamic}
<table class="bicol" summary="liste des absents de notre annuaire">
  <tr>
    <th>Promo</th>  <th>Nom</th>  <th>Pr�nom</th>
  </tr>
{foreach item=x from=$mank}
  <tr class="{cycle values="impair,pair"}">
    <td>{$x.promo}</td>
    <td>{$x.nom} {if $x.nom_patro neq $x.nom}({$c.nom_patro}){/if}</td>
    <td>{$x.prenom}</td>
  </tr>
{/foreach}
</table>
<p>
  <strong>{$nb_mank} camarades sont absents de notre annuaire.</strong>
</p>
{/dynamic}

<br />
<br />

<div class="ssrubrique">
  Liste des camarades de notre annuaire qui ne sont pas dans l'annuaire de l'AX
</div>

{dynamic}
<table class="bicol" summary="liste des absents de l'AX">
  <tr>
    <th>Promo</th>        <th>Nom</th>        <th>Pr�nom</th>
  </tr>
{foreach item=x from=$plus}
  <tr class="{cycle values="impair,pair"}">
    <td>{$x.promo}</td>   <td>{$x.nom}</td>   <td>{$x.prenom}</td>
  </tr>
{/foreach}
</table>

<p>
  <strong>{$nb_plus} camarades sont absents de l'annuaire de l'AX.</strong>
</p>
{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
