{* $Id: inscrire.preins.tpl,v 1.1 2004-07-19 08:58:04 x2000habouzit Exp $ *}

<div class="rubrique">
  Pr�-inscription r�ussie
</div>

<p class="normal">
La pr�-inscription que tu viens de soumettre a �t� enregistr�e.
</p>
{dynamic}
<p class="normal">
Les instructions te permettant notamment d'activer ton e-mail
<strong>{$mailorg}@polytechnique.org</strong>, ainsi que ton mot de passe pour
acc&eacute;der au site viennent de t'�tre envoy�s � l'adresse
<strong>{$smarty.request.email}</strong>.
</p>
<p class="normal">
Tu n'as que quelques jours pour suivre ces instructions apr�s quoi la pr�-inscription
est effac�e automatiquement de nos bases et il faut tout recommencer. Si tu as soumis
plusieurs pr�-inscriptions, seul le dernier e-mail re�u est valable, les pr�c�dents
ne servant plus.
</p>
<p class="normal">
Si tu ne re�ois rien, v�rifie bien l'adresse <strong>{$smarty.request.email}</strong>.
</p>
{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
