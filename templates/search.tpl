{dynamic}
{if $formulaire==0 and !$error}
  <div class="rubrique">
    R�sultats
  </div>
  {if $with_soundex==0}
    <a href="{$smarty.server.PHP_SELF}?public_directory={$public_directory}&with_soundex=1&rechercher=1&{$url_args}">
      Etendre � la recherche par proximit� sonore
    </a>
  {/if}
  <div class="right">
    <a href="{$smarty.server.PHP_SELF}?public_directory={$public_directory}">Nouvelle recherche</a>
  </div>
  <p class="smaller">
    {if $nb_resultats_total==0}Aucune{else}{$nb_resultats_total}{/if} r�ponse{if $nb_resultats_total>1}s{/if}.
  </p>
  <table class="bicol">
    {section name=resultat loop=$resultats}
    <tr class="{cycle values="pair,impair"}">
      {include file="search.result.public.tpl" result=$resultats[resultat]}
      {if $public_directory!=1}
        {include file="search.result.private.tpl" result=$resultats[resultat]}
      {/if}
    </tr>
    {/section}
  </table>
  {if $perpage<$nb_resultats_total}
  <p>
    {if $offset!=0}
      <a href="{$smarty.server.PHP_SELF}?public_directory={$public_directory}&with_soundex={$with_soundex}&rechercher=1&{$url_args}&offset={$offset-$perpage}">
        Pr�c�dent
      </a>
      &nbsp;
    {/if}
    {section name=offset loop=$offsets}
      {if $offset!=$smarty.section.offset.index*$perpage}
        <a href="{$smarty.server.PHP_SELF}?public_directory={$public_directory}&with_soundex={$with_soundex}&rechercher=1&{$url_args}&offset={$smarty.section.offset.index*$perpage}">
          {$smarty.section.offset.index+1}
        </a>
      {else}
        <strong>{$smarty.section.offset.index+1}</strong>
      {/if}
      &nbsp;
    {/section}
    {if $offset<$nb_resultats_total-$perpage}
      <a href="{$smarty.server.PHP_SELF}?public_directory={$public_directory}&with_soundex={$with_soundex}&rechercher=1&{$url_args}&offset={$offset+$perpage}">
        Suivant
      </a>
      &nbsp;
    {/if}
  </p>
  {/if}
{else}
  {include file="search.form.tpl"}
{/if}
{/dynamic}
