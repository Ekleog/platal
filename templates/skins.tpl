{* $Id: skins.tpl,v 1.6 2004-08-24 21:31:59 x2000habouzit Exp $ *}

<div class="rubrique">
  Skins Polytechnique.org
</div>
<p class="normal">
Tu n'aimes pas les couleurs ou l'apparence de Polytechnique.org ? Normal, les go�ts et les
couleurs, �a ne se discute pas. Certains pr�f�rent une page s�rieuse, d'autres plus
fantaisiste. A toi de voir :)
</p>
<p class="normal">
Note aux utilisateurs du navigateur Netscape 4.x ou �quivalent.
La fonctionalit� "skins" n'est h�las pas compatible avec ces navigateurs
qui ne respectent pas les standards du web. <br />
Pour profiter de toutes les fonctionnalit�s de Polytechnique.org,
nous te conseillons de t�l�charger une version r�cente de ton navigateur.
</p>
<p class="normal">
Pour toute information compl�mentaire, n'h�site pas � �crire �
{mailto address='support@polytechnique.org' subject='navigateurs'}
</p>

<form action="{$smarty.server.REQUEST_URI}" method="post">
  <div class="center">
    <input type="submit" value="Enregistrer" name="submit" />
    <br />
    <br />
  </div>
  <table id="skin" cellpadding="0" cellspacing="0" summary="Choix de skins">
{dynamic}
{foreach item=skin from=$skins}    
    <tr>
      <td class="skigauche">
        <input type="radio" name="newskin" value="{$skin.id}" {if $smarty.session.skin_id eq $skin.id}checked="checked"{/if} />
      </td>
      <td class="skimilieu">
        <strong>{$skin.name}</strong>
        ajout�e le {$skin.date|date_format:"%x"}<br />
        {$skin.comment}
        <br /><br />
        Cr��e par <strong>{$skin.auteur}</strong>
        <br /><br />
        Utilis�e par <strong>{$skin.nb}</strong> inscrit{if $skin.nb>1}s{/if}
      </td>
      <td class="skidroite">
        <img src="images/skins/{$skin.name}.{$skin.ext}" style="width:160px; height:160px;" alt=" [ CAPTURE D'ECRAN ] " />
      </td>
    </tr>
{/foreach}
{/dynamic}
  </table>
  <div class="center">
    <br />
    <input type="submit" value="Enregistrer" name="submit" />
  </div>

</form>

{* vim:set et sw=2 sts=2 sws=2: *}
