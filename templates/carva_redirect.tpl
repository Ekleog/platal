{* $Id: carva_redirect.tpl,v 1.2 2004-01-29 16:21:53 x2000habouzit Exp $ *}

{dynamic on="0$message"}
<div class="rubrique">
  Mise � jour de la redirection
</div>
{$message}
{/dynamic}

<div class="rubrique">
  Redirection de page WEB
</div>

<div class="ssrubrique">
  Pourquoi une redirection de page WEB ?
</div>
<p class="normal">
  Dans la lign�e du service de redirection d'emails de <strong>Polytechnique.org</strong>,
  il est possible de faire pointer
{dynamic}
{if $alias}
  les adresses <strong>http://www.carva.org/{$smarty.session.username}</strong>
  et <strong>http://www.carva.org/{$alias}</strong>
{else}
  l'adresse <strong>http://www.carva.org/{$smarty.session.username}</strong>
{/if}
{/dynamic}
  vers la page WEB de ton choix. Pour de plus amples d�tails, consulte
  <a href="{"docs/doc_carva.php"|url}">cette page</a>
</p>

<div class="ssrubrique">
  Conditions d'usage
</div>
<p class="normal">
  L'utilisateur s'engage � ce que le contenu du site r�f�renc� soit en conformit�
  avec les lois et r�glements en vigueur et d'une mani�re g�n�rale ne porte pas
  atteinte aux droits des tiers
  (<a href="{"docs/doc_carva.php#charte"|url}">plus de pr�cisions</a>).
</p>

<div class="rubrique">
  Mise en place de la redirection
</div>
<p class="normal">
{dynamic}
{if $carva}
  Actuellement, l'adresse <a href="http://www.carva.org/{$smarty.session.username}">http://www.carva.org/{$smarty.session.username}</a>
  {if $alias}
  ainsi que l'adresse <a href="http://www.carva.org/{$alias}">http://www.carva.org/{$alias}</a>
  sont redirig�es
  {else}
  est redirig�e
  {/if}
  sur <a href="http://{$carva}">http://{$carva}</a>
{else}
  La redirection n'est pas utilis�e ...
{/if}
</p>

<p class="normal">
  Pour modifier cette redirection remplis le champ suivant et clique sur <strong>Modifier</strong>.
{if $carva}
  Si tu veux annuler ta redirection, clique sur <strong>Supprimer</strong>.
{/if}
</p>

<br />

<form action="{$smarty.server.REQUEST_URI}" method="POST">
  <table class="bicol" summary="[ redirection ]">
    <tr>
      <th colspan="2">
        Adresse de redirection
      </th>
    </tr>
    <tr>
      <td colspan="2" class="center">
        <strong>http://</strong>&nbsp;<input size=50 maxlength=255 name="url"
        value="{$smarty.post.url|default:$carva}">
      </td>
    </tr>
    <tr>
{if $carva}
      <td class="center">
        <input type="submit" value="Modifier" name="submit">
      </td>
      <td class="center">
        <input type="submit" value="Supprimer" name="submit">
      </td>
{else}
      <td colspan="2" class="center">
        <input type="submit" value="Valider" name="submit">
      </td>
{/if}
    </tr>
  </table>
</form>
{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
