{* $Id: epouse.tpl,v 1.2 2004-08-24 23:06:04 x2000habouzit Exp $ *}

<div class="rubrique">
  Nom de mariage
</div>

{if $not_femme}

<p class="erreur">
  Tu n'es pas autoris� � avoir acc�s � cette page !
</p>

{else}

  {dynamic}
  {if $same}
  <p class="erreur">
      Si ton nom de mariage est identique � ton nom � l'X, il n'est pas
      n�cessaire de le saisir ici!
  </p>
  {else}
    {if $epouse_old}
    <p class="normal">
      Ta demande de suppression de ton nom de mariage ainsi que de tes
      alias {$alias_old}@polytechnique.org et
      {$alias_old}@m4x.org a bien �t� enregistr�e. 
    </p>
    {/if}

    {if $epouse_req}
    <p class="normal">
      Ta demande d'ajout de ton nom de mariage a bien �t� enregistr�e. Sa
      validation engendrera la cr�ation des alias
      <strong>{$myepouse->alias}@polytechnique.org</strong> et
      <strong>{$myepouse->alias}@m4x.org</strong>.
    </p>
    {/if}
    
    <p class="normal">
      Tu recevras un mail d�s que les changements demand�s auront �t� effectu�s. 
      Encore merci de nous faire confiance pour tes e-mails !
    </p>
  {/if}
  {/dynamic}

{/if}
  
<p class="normal">
Afin d'�tre joignable � la fois sous ton nom � l'X et sous ton nom de mariage, tu peux
saisir ici ce dernier. Il appara�tra alors dans l'annuaire et tu disposeras
des adresses correspondantes @m4x.org et @polytechnique.org, en plus de
celles que tu poss�des d�j�.
</p>

<br />

<form action="{$smarty.server.PHP_SELF}" method="post" name="epouse_dem">
<table class="bicol" cellpadding="4" summary="Nom d'epouse">
  <tr>
    <th>Nom de mariage</th>
  </tr>
  <tr>
    <td class="center"><input type="text" name="epouse" value="{$epouse_old}" /></td>
  </tr>
  <tr>
    <td class="center"><input type="submit" name="submit" value="Envoyer" /></td>
  </tr>
</table>
</form>

{* vim:set et sw=2 sts=2 sws=2: *}
