{* $Id: public.tpl,v 1.2 2004-07-17 11:23:09 x2000habouzit Exp $ *}

{dynamic}
{if $smarty.request.num}

{if $smarty.request.valide}

<p class=\"normal\">
  Merci de nous avoir communiqu� cette information !  Un administrateur de Polytechnique.org va
  envoyer un email de proposition d'inscription � Polytechnique.org � {$prenom} {$nom} dans les
  toutes prochaines heures (ceci est fait � la main pour v�rifier qu'aucun utilisateur malveillant
  ne fasse mauvais usage de cette fonctionnalit�...).
</p>
<p class=\"normal\">
  <strong>Merci de ton aide � la reconnaissance de notre site !</strong> Tu seras inform� par email de
  l'inscription de {$prenom} {$nom} si notre camarade accepte de rejoindre la communaut� des X sur
  le web !
</p>

{else}

{if $prenom}
<div class="rubriqu">
  Et si nous proposions � {$prenom} {$nom} de s'inscrire � Polytechnique.org ?
</div>

<p class="normal">
  En effet notre camarade n'a pour l'instant pas encore rejoint la communaut� des X sur le web...
  C'est dommage, et en nous indiquant son adresse email, tu nous permettrais de lui envoyer une
  proposition d'inscription.
</p>
<p class="normal">
  Si tu es d'accord, merci d'indiquer ci-dessous l'adresse email de {$prenom} {$nom} si tu la
  connais.  Nous nous permettons d'attirer ton attention sur le fait que nous avons besoin d'�tre
  s�rs que cette adresse est bien la sienne, afin que la partie priv�e du site reste uniquement
  accessible aux seuls polytechniciens. Merci donc de ne nous donner ce renseignement uniquement si
  tu es certain de sa v�racit� !
</p>
<p class="normal">
  Nous pouvons au choix lui �crire au nom de l'�quipe Polytechnique.org, ou bien, si tu le veux
  bien, en ton nom. A toi de choisir la solution qui te para�t la plus adapt�e !! Une fois {$prenom}
  {$nom} inscrit, nous t'enverrons un email pour te pr�venir que son inscription a r�ussi.
</p>

<form method="post" action="{$smarty.server.PHP_SELF}">
  <input type="hidden" name="num" value="{$smarty.request.num}" />
  <table class="bicol" summary="Fiche camarade">
    <tr class="impair"><td>Nom :</td><td>{$nom}</td></tr>
    <tr class="pair"><td>Pr�nom :</td><td>{$prenom}</td></tr>
    <tr class="impair"><td>Promo :</td><td>{$promo}</td></tr>
    <tr class="pair">
      <td>Adresse email :</td>
      <td>
        <input type="text" name="mail" size="30" maxlength="50" />
      </td>
    </tr>
    <tr class="impair">
      <td>Nous lui �crirons :</td>
      <td>
        <input type="radio" name="origine" value="perso" checked="checked" /> en ton nom<br />
        <input type="radio" name="origine" value="equipe" /> au nom de l'�quipe Polytechnique.org
      </td>
    </tr>
  </table>
  <br />
  <input type="submit" name="valide" value="Valider" />
</form>
{/if}

{/if}

{/if}
{/dynamic}


{* vim:set et sw=2 sts=2 sws=2: *}
