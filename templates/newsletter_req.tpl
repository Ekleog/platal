{* $Id: newsletter_req.tpl,v 1.1 2004-02-09 17:36:44 x2000habouzit Exp $ *}

<div class="rubrique">
  Proposer un article pour la newsletter
</div>

<p class="normal">
  La newsletter mensuelle est un excellent moyen de faire passer une 
  information. Nous devons cependant nous astreindre � certaines r�gles
  dans la r�daction pour en conserver la qualit� et l'efficacit�.
</p>
<ul>
  <li>
    Longueur maximale du texte justifi� (hors t�l�phone, adresses, liens
    internet) : <strong>8 lignes de 68 caract�res</strong>
  </li>
  <li>
    Les liens internet (URL, mail) et adresses, t�l�phones, appara�tront
    en-dessous pour plus de clart�
  </li>
  <li>
    L'�quipe de r�daction se r�serve le droit de modifier la mise en 
    forme des articles
  </li>
</ul>

{dynamic}
{if $smarty.request.action}
  {if $erreur}
  {$erreur}
  {/if}
  
  {if $preview}
    <p class="normal">
      Le texte de ton annonce aura sensiblement l'allure suivante :
    </p>
    <div styleclass="center">
      <table class="bicol">
        <tr>
          <td "padding: 1em;">
            <tt>
              &lt;------------------------------------------------------------------&gt;<br />
              <br />
              {$preview|replace:" ":"&nbsp;"|nl2br}
              <br />
              <br />
              &lt;------------------------------------------------------------------&gt;
            </tt>
          </td>
        </tr>
      </table>

    {if $sent}
    <p class="erreur">
      Ton annonce a �t� envoy�e � l'�quipe de r�daction. Merci de ta contribution !
    </p>
    {elseif $nb_lines<9}
    <p class="normal">
    F�licitations, ton article respecte les r�gles de pagination de la 
    newsletter !!! Il pourra cependant �tre revu en fonction des 
    n�c�ssit�s de la newsletter.
    </p>
    <p class="normal">
    Tu peux le soumettre � l'�quipe de validation en validant ta demande.
    Tu seras recontact� par mail par un r�dacteur pour te confirmer la
    bonne r�c�ption de ta demande.
    </p>
    <form action="{$smarty.server.PHP_SELF}" method="POST">
      <input type="hidden" name="titre" value="{$titre}" />
      <input type="hidden" name="article" value="{$article}" />
      <input type="hidden" name="bonus" value="{$bonus}" />
      <input type="submit" name="action" value="valider" />
    </form>
    <p class="normal">
    Si tu n'es pas satisfait de ton annonce, tu peux la retravailler :
    </p>
    {elseif $nb_lines>9}
    <p class="erreur">
      Ton annonce est trop longue, il faut que tu la modifie pour qu'elle fasse moins de huit lignes
    </p>
    {/if}
  {/if}

{/if}

{if !$sent}
<form action="{$smarty.server.PHP_SELF}" method="POST">
  <table class="bicol" cellpadding="3" cellspacing="0" summary="Proposition d'article newsletter">
    <thead>
      <tr>
        <th>
          Proposition d'article
        </th>
      </tr>
    </thead>
    <tbody>
      <tr class="pair">
        <td class="bicoltitre">
          Titre
        </td>
      </tr>
      <tr class="pair">
        <td>
          <input type="text" value="{$titre}" name="titre" size="68">
        </td>
      </tr>
      <tr class="impair">
        <td class="bicoltitre">
          Article :
        </td>
      </tr>
      <tr class="impair">
        <td>
          <textarea cols="70" rows="10" name="article">{$article}</textarea>
        </td>
      </tr>
      <tr class="pair">
        <td class="bicoltitre">
          Adresses, url, mail, contact, t�l�phone, etc. :
        </td>
      </tr>
      <tr class="pair">
        <td>
          <textarea cols="70" rows="10" name="bonus">{$bonus}</textarea>
        </td>
      </tr>
      <tr class="impair">
        <td class="bouton">
          <input type="submit" name="action" value="Tester" />
        </td>
      </tr>
    </tbody>
  </table>
</form>
{/if}

{/dynamic}
{* vim:set et sw=2 sts=2 sws=2: *}
