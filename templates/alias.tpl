{* $Id: alias.tpl,v 1.1 2004-01-26 22:29:02 x2000habouzit Exp $ *}

{if $success}
<p class="normal">
  a demande de cr�ation des alias <b>{dyn s=$success}@melix.net</b> et
  <b>{dyn s=$success}@melix.org</b> a bien �t� enregistr�e. Apr�s
  v�rification, tu recevras un mail te signalant l'ouverture de ces adresses.
</p>
<p class="normal">
  Encore merci de nous faire confiance pour tes e-mails !
</p>
{else}
{if $error}
<p class="normal">{dyn s=$error}</p>
{/if}

<div class="rubrique">
  Adresses e-mail personnalis�es
</div>

<p class="normal">
  Pour plus de <b>convivialit�</b> dans l'utilisation de tes mails, tu peux choisir une adresse
  e-mail discr�te et personnalis�e. Ce nouvel e-mail peut par exemple correspondre � ton surnom.
</p>
<p>
  Pour de plus amples informations sur ce service, nous t'invitons � consulter
  <a href="{"docs/doc_melix.php"|url}">cette documentation</a> qui r�pondra
  sans doute � toutes tes questions
</p>

{dynamic on="0$actuel"}
<p class='normal'>
<b>Note : tu as d�j� l'alias {$actuel}, or tu ne peux avoir qu'un seul alias � la fois.
  Si tu effectues une nouvelle demande l'ancien alias sera effac�.</b>
</p>
{/dynamic}

{dynamic on="0$demande"}
<p class='normal'>
<b>Note : tu as d�j� effectu� une demande pour {$demande->alias}, dont le traitement est
  en cours. Si tu souhaites modifier ceci refais une demande, sinon ce n'est pas la peine.</b>
</p>
{/dynamic}

<br />
<form action="{$smarty.server.PHP_SELF}" method="POST" name="alias_dem">
  <table class="tinybicol" align="center" cellpadding="4" summary="Demande d'alias">
    <tr>
      <th colspan="2">Demande d'alias</th>
    </tr>
    <tr align="left">
      <td>Alias demand� :</td>
    </tr>
    <tr align="center">
      <td><input type="text" name="alias" value="{dyn s=$r_alias}">@melix.net et @melix.org</td>
    </tr>
    <tr align="left">
      <td>Br�ve explication :</td>
    </tr>
    <tr align="center">
      <td><textarea rows="5" cols="50" name="raison">{dyn s=$r_raison}</textarea></td>
    </tr>
    <tr align="right">
      <td><input type="submit" name="submit"
        value="Envoyer"></td>
    </tr>
  </table>
</form>

{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
