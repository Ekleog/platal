<div class="rubrique">
  Inscrire manuellement un X
</div>
{dynamic}
{if $success eq "1"}
  <p>
    Param�tres � transmettre:<br />
    Login=<strong>{$mailorg}</strong><br />
    Password=<strong>{$pass_clair}</strong>
  </p>
  <p>
    Pour �diter le profil,
    <a href="../admin/utilisateurs.php?login={$mailorg}">clique sur ce lien.</a>
  </p>
{else}
<p>
  Les pr�nom, nom, promo sont pr�-remplis suivant la table d'identification.
  Modifie-les comme tu le souhaites. Une autre solution consiste � �diter
  d'abord la table d'identification (�cran pr�c�dent) avant d'inscrire cet X.
</p>
<div class="center">
<form action="{$smarty.server.PHP_SELF}" method="get">
    <table class="bicol" summary="Cr�er un login">
      <tr>
        <th colspan="2">
	      Cr�er un login
	    </th>
      </tr>
      <tr>
        <td class="titre">Pr�nom d'inscription</td>
        <td>
	      <input type="text" size="40" maxlength="60" value="{$row.prenom}" name="prenomN">
	    </td>
      </tr>
      <tr>
        <td class="titre">Nom d'inscription</td>
        <td>
	      <input type="text" size="40" maxlength="60" value="{$row.nom}" name="nomN">
	    </td>
      </tr>
      <tr>
        <td class="titre">Promotion</td>
        <td>
	      <input type="text" size="4" maxlength="4" value="{$row.promo}" name="promoN">
	    </td>
      </tr>
      <tr>
        <td class="titre">Login</td>
        <td>
	      <input type="text" size="40" maxlength="60" value="{$mailorg}" name="mailorg">
	    </td>
      </tr>
      <tr>
        <td class="titre">Date de naissance</td>
        <td>
	      <input type="text" size="8" maxlength="8" value="" name="naissanceN">
	    </td>
      </tr>
      <tr>
        <td colspan="2">
	      <input type="hidden" name="xmat" value="{$smarty.request.xmat}">
	      <input type="submit" name="submit" value="Creer le login">
	    </td>
      </tr>
    </table>
</form>
</div>
{/if}
{/dynamic}
