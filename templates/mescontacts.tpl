{* $Id: mescontacts.tpl,v 1.7 2004-08-29 16:04:48 x2000habouzit Exp $ *}

{dynamic}
<p class="erreur">{$erreur}</p>
{/dynamic}

<div class="rubrique">
  Ma liste personnelle de contacts
</div>

<form action="{$smarty.server.PHP_SELF}" method="post">
<p>
  Ajouter la personne suivante � ma liste de contacts (prenom.nom) :
  <input type="hidden" name="action" value="ajouter" />
  <input type="text" name="user" size="20" maxlength="70" />&nbsp;
  <input type="submit" value="Ajouter" />
</p>
</form>
<p>
  Tu peux �galement rajouter des camarades dans tes contacts lors d'une recherche dans l'annuaire : 
  il te suffit de cliquer sur l'ic�ne <img src="images/ajouter.gif" alt="ajout contact" /> en face de son nom dans les r�sultats !
</p>

{dynamic}
{if $nb_contacts}
<p>
  Pour r�cup�rer ta liste de contacts dans un PDF imprimable :<br />
  [<a href="mescontacts_pdf.php/mes_contacts.pdf?order=promo" onclick="return popup(this)"><strong>Tri�e par promo</strong></a>]
  [<a href="mescontacts_pdf.php/mes_contacts.pdf" onclick="return popup(this)"><strong>Tri�e par noms</strong></a>]
</p>

<br />

<div class="contact-list">
{foreach item=contact from=$contacts}
{include file=include/x_inscrit.tpl c=$contact show_action="retirer"}
{/foreach}
</div>

{else}
<p>Actuellement ta liste de contacts est vide...</p>
{/if}
{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
