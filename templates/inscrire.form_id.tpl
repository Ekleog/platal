{* $Id: inscrire.form_id.tpl,v 1.2 2004-08-24 22:18:47 x2000habouzit Exp $ *}

{dynamic}

{foreach from=$erreur item=err}
<p class="erreur">{$err}</p>
{/foreach}

<form action="{$smarty.server.REQUEST_URI}" method="post">
  <div class="rubrique">
    Identification
  </div>
  <p class="normal">
    Renseigne tes nom, pr�nom et promotion, et si tu es d'une promotion
    post�rieure � la 1996, ton num�ro de matricule.
  </p>
  <table class="bicol" summary="Identification" cellpadding="3">
    <tr>
      <th>
        Promo &lt; 1996
      </th>
      <th>
        Promo depuis 1996
      </th>
    </tr>
    <tr>
      <td>
        Le num�ro d'identification n'est pas n�cessaire pour 
        l'inscription pour les promotions jusqu'� 1995 incluse.
      </td>
      <td>
        <span class="bicoltitre">Matricule X : </span>&nbsp;&nbsp;
        <input type="text" size="6" maxlength="6" name="matricule" value="{$smarty.request.matricule}" />
        <br />
        6 chiffres terminant par le num�ro d'entr�e<br />
        (ex: 960532 ou 100532)<br />
        Voir sur le GU ou un bulletin de solde pour trouver cette information<br /><br />
        Pour les �l�ves �trangers voie 2, il est du type :<br />
        Promotion: 1995, Matricule: 960XXX - Promotion: 2001, Matricule 102XXX.
      </td>
    </tr>
    <tr>
      <th colspan="2">
        Identification
      </th>
    </tr>
    <tr>
      <td class="titre"> 
        Nom<br />
        <span class="smaller">(Xettes mari�es : nom � l'X)</span>
      </td>
      <td>
        <input type="text" size="20" maxlength="30" name="nom" value="{$smarty.request.nom}" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Pr�nom
      </td>
      <td>
        <input type="text" size="15" maxlength="20" name="prenom" value="{$smarty.request.prenom}" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Promotion
      </td>
      <td>
        <input type="text" size="4" maxlength="4" name="promo" value="{$smarty.request.promo}" />
      </td>
    </tr>
    <tr>
      <td colspan="2" class="center">
        <input type="hidden" value="OUI" name="charte" />
        <input type="submit" value="Continuer l'inscription" name="submit" />
      </td>
    </tr>
  </table>
</form>

{/dynamic}
{* vim:set et sw=2 sts=2 sws=2: *}
