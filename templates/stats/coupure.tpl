{* $Id: coupure.tpl,v 1.1 2004-02-04 19:47:48 x2000habouzit Exp $ *}

{dynamic}

{if $cp}

<table class="bicol" summary="Ruptures de service">
  <tr>
    <th colspan="2">d�tails de l'interruption de service<th>
  </tr>
  <tr>
    <td class="titre">d�but</td>
    <td>{$cp.debut|date_forma:"%d/%m/%Y, %Hh%M"}</td>
  </tr>
  <tr>
    <td class="titre">dur�e</td>
    <td>{$cp.duree}</td>
  </tr>
  <tr>
    <td class="titre">r�sum�</td>
    <td>{$cp.resume}</td>
  </tr>
  <tr>
    <td class="titre">services</td>
    <td>
    {insert name="serv_to_str" arg=$cp.services script="insert.pattecassee.inc.php"}
    </td>
  </tr>
  <tr>
    <td class="titre">description </td>
    <td>{$cp.description}</td>
  </tr>
</table>

<p class="center">
<a href="{$smarty.server.PHP_SELF}">retour � la liste</a>
</p>

{else}

<p class="normal">
  Tu trouveras ici les interruptions de service de Polytechnique.org qui ont �t�
  constat�es <b>durant les trois derni�res semaines</b>, ou qui sont pr�vues dans le futur.
  Il est � noter qu'� ce jour la quasi-totalit� des coupures proviennent 
  de d�faillances du r�seau de l'Ecole, o� nos serveurs sont h�berg�s (rupture de la
  connexion internet de l'Ecole, probl�me �lectrique, etc...).
</p>
<p class="normal">
  Pour avoir les d�tails d'une interruption particuli�re il te suffit de cliquer dessus.
</p>

<table class="bicol" align="center" summary="D�tail de la coupure">
  <tr>
    <th>date</th>
    <th>r�sum�</th>
    <th>services affect�s</th>
  </tr>
{foreach item=cp from=$coupures}
  <tr class="{cycle values="pair,impair"}">
    <td>
      <span class="smaller">
        {$cp.debut|date_format:"%d/%m/%Y"}
      </span>
    </td>
    <td>
      <span class="smaller">
        <a href="{$smarty.server.PHP_SELF}?cp_id={$cp.id}">{$cp.resume}</a>
      </span>
    </td>
    <td>
      <span class="smaller">
        {$cp.services}
      </span>
    </td>
  </tr>
{/foreach}
</table>

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
