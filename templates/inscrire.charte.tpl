{* $Id: inscrire.charte.tpl,v 1.1 2004-07-19 08:58:04 x2000habouzit Exp $ *}

<form action="{$smarty.server.REQUEST_URI}" method="post">
  <div class="rubrique">
    Conditions g�n�rales
  </div>
  <p class="normal">
  L'enregistrement se d�roule <strong>en deux �tapes</strong>. La pr�-inscription te prendra moins
  de 5 minutes. La seconde �tape est une phase de validation o� c'est nous qui te
  recontactons pour te fournir un mot de passe et te demander de le changer.
  </p>
  {include file="docs/charte.tpl"}
  <input type="hidden" value="OUI" name="charte" />
  <div class="center">
    <input type="submit" value="J'accepte ces conditions" name="submit" />
  </div>
</form>


{* vim:set et sw=2 sts=2 sws=2: *}
