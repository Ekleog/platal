{* $Id: form_naissance.tpl,v 1.1 2004-02-07 15:50:36 x2000habouzit Exp $ *}
<div class="rubrique">
  Date de naissance
</div>

<form action="profil2.php" method="post">
  <p class="normal">
  Avant d'acc�der � ton profil pour la premi�re fois, tu dois donner 
  ta date de naissance au format JJMMAAAA. Elle ne sera plus demand�e
  par la suite et ne pourra �tre chang�e. Elle servira en cas de
  perte du mot de passe comme s�curit� suppl�mentaire, et uniquement 
  � cela. Elle n'est jamais visible ou lisible.
  </p>
  <br />
  <table class="tinybicol" cellpadding="4" cellspacing="0"  summary="Formulaire de naissance">
    <tr>
      <th colspan="2">
        Date de naissance
      </th>
    </tr>
    <tr>
      <td>
        <strong>Date</strong> (JJMMAAAA)
      </td>
      <td>
        <input type="text" size="8" maxlength="8" name="birth" />
      </td>
    </tr>
    <tr>
      <td class="center" colspan="2">
        <input type="submit" value="Enregistrer" name="submit" />
      </td>
    </tr>
  </table>
</form>

{* vim:set et sw=2 sts=2 sws=2: *}
