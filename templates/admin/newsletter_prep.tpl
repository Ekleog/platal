{* $Id: newsletter_prep.tpl,v 1.2 2004-02-11 13:15:34 x2000habouzit Exp $ *}

{if $erreur}

<p class="erreur">{$erreur}</p>

{else}

{dynamic}

{if $action_msg}
<p class="erreur">{$action_msg}</p>
{/if}

<div class="rubrique">
  Pr�parer la Newsletter
</div>

<form action="{$smarty.server.REQUEST_URI}" method="POST">
  <p class="conseil">
    Conseil : enregistre souvent tes modifs pour �viter de les perdre si 
    le navigateur plante et pour �viter d'oublier
  </p>
  <p class="conseil">
    V�rifie bien que les lignes ne d�passent pas la largueur du cadre, 
    certains navigateurs sautent � la ligne automatiquement
  </p>
  
{if $own_lock}
  <p class="normal">
    Tu poss�des un verrou, tu peux �diter la newsletter.
  </p>
  <p class="normal">
    <span class="erreur">Pense � relacher le verrou quand tu as fini.</span>
  </p>
  <div class="center">
    <input type="submit" name="submit" value="Sauver et relacher le verrou" />
    <input type="submit" name="submit" value="Sauver" />
    <br />
    <input type="submit" name="submit" value="Ne pas sauver et relacher le verrou" />
  </div>
{elseif $is_lock}
  <p class="normal">
    <span class="erreur">{$id_lock} est en train d'�diter la newsletter depuis le
      {$date_lock|date_format:"%c"}
    </span>, tu ne peux pas �diter la newsletter ni prendre de verrou. Si l'admin 
    pr�c�dent a oubli� de supprimer (c'est mal) son verrou, tu
    peux le supprimer quand m�me avec le bouton ci-dessous, mais il faut que tu sois
    vraiment certain qu'il n'est plus en train d'�diter, sinon, il risque d'y
    avoir des pertes dans les modifications faites � la lettre...
  </p>
  <div class="center">
    <input type="submit" name="submit" value="Relacher quand meme" />
  </div>
  <br />
{else}
  <p class="normal">
    Pas de lock sur le fichier, tu peux en prendre un.
  </p>
  <div class="center">
    <input type="submit" name="submit" value="Prendre un verrou" />
  </div>
  <p class="normal">
    ou bien envoyer la newsletter tel qu'elle.
  </p>
  <div class="center">
    <input type="text" name="test_to" size="40" value="{$smarty.session.username}@m4x.org" />
    <input type="submit" name="submit" value="Envoi Test" />
    <br />
    <input type="submit" name="submit" value="Envoi Definitif" style="color:red;" />
  </div>
  <br />
{/if}
  <table class="bicol" cellpadding="3" summary="Newsletter">
    <tr>
      <th>
        Pr�paration de la newsletter
      </th>
    </tr>
    <tr>
      <td class="titre">
        Sujet
      </td>
    </tr>
    <tr>
      <td>
        <input type="text" name="sujet" value="{$sujet}" size="55" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Contenu
      </td>
    </tr>
    <tr>
      <td>
        <textarea name='contenu' rows="100" cols="70" {if !$own_lock}readonly="readonly"{/if}>{$contenu}</textarea>
      </td>
    </tr>
{if $own_lock}
    <tr>
      <td class="bouton">
        <input type="submit" name="submit" value="Sauver" />
      </td>
    </tr>
{/if}
  </table>
</form>
{/dynamic}
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
