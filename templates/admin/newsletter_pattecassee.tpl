{* $id$ *}

<div class="rubrique">
  V�rifier une patte cass�e suite � l'envoi de la newsletter
</div>

{dynamic}

{$erreur}

{if $smarty.post.email}

{if $no_more}
  <p class="erreur">
  D�sol� mais plus personne n'utilise l'adresse {$email} comme adresse de redirection.
  Il est donc probable que ce probl�me de redirection ait �t� corrig�.
  </p>
{elseif $nb_emails}
  <p class="erreur">
  <a href="{"x.php?x=$username"|url}">{"$prenom $nom (X$promo)"}</a>
  a � l'heure actuelle {$nb_emails} adresse(s) email(s) de redirection active(s)
  en dehors de celle que tu as indiqu�e.
  Cela ne veut pas forc�ment dire qu'il les avait d�j� activ�es
  lorsque la newsletter a �t� envoy�e, mais c'est fort probable.
  </p>
  <p class="erreur">
  Pour lui envoyer un mail qui l'avertira de son adresse en panne,
  <a href="{$smarty.server.PHP_SELF}?email={$email}&amp;action=mail">il suffit de cliquer !</a>
  </p>
{else}
  <p class="erreur">
  D�sol�, mais <a href="{"x.php?x=$username"|url}">{"$prenom $nom (X$promo)"}</a>,
  n'a actuellement aucune adresse email de redirection active
  autre que celle que tu viens de rentrer.
  L'id�al serait de contacter son kessier de promo pour l'en avertir
  et essayer de retrouver la trace de ce camarade !!
  </p>
{/if}

{/if}

{/dynamic}

<p class="normal">
Rentre dans la zone de saisie ci-dessous l'adresse email qui est revenue
en erreur suite � la distribution de la newsletter :
</p>
<br />
<form action="{$smarty.server.PHP_SELF}" method="post">
  <table class="tinybicol" cellpadding="3" summary="Saisie email en panne">
    <tr><th>Adresse email d�fectueuse</th></tr>
    <tr><td class="center"><input type="text" name="email" size="40" maxlength="70" /></td></tr>
    <tr><td class="center"><input type="submit" value="Ok" /></td></tr>
  </table>
</form>

{* vim:set et sw=2 sts=2 sws=2: *}
