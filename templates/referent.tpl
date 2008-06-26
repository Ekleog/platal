{***************************************************************************
 *  Copyright (C) 2003-2004 Polytechnique.org                              *
 *  http://opensource.polytechnique.org/                                   *
 *                                                                         *
 *  This program is free software; you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation; either version 2 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with this program; if not, write to the Free Software            *
 *  Foundation, Inc.,                                                      *
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA                *
 ***************************************************************************}


{literal}
<script type="text/javascript">
  <!-- Begin
  function showPage( pNumber ) {
    document.forms.form_result.page_courante.value = pNumber;
    document.forms.form_result.submit();
  }
  // End -->
</script>
{/literal}

<h1>
  Rechercher un camarade pouvant m'aider � orienter mon parcours professionnel
</h1>
{if $recherche_trop_large}
<p>
Les crit�res de recherche que tu as rentr�s n'ont pas produit de r�sultats,
sans doute car ta requ�te �tait trop g�n�rale. Nous t'invitons �
<a href="referent.php">proc�der � une nouvelle recherche</a>, en essayant
d'�tre plus pr�cis.
</p>
{elseif $resultats}
<form action="{$smarty.server.PHP_SELF}" method="post" id="form_result">
  <div class="contact-list" style="clear:both" >
  <input type="hidden" name="pays" value="{$pays_selectionne}" />
  <input type="hidden" name="expertise" value="{$expertise_champ}" />
  <input type="hidden" name="secteur" value="{$secteur_selectionne}" />
  <input type="hidden" name="ss_secteur" value="{$ss_secteur_selectionne}" />
  <input type="hidden" name="page_courante" value="1" />
  <input type="hidden" name="Chercher" value="1" />
  {section name="resultat" loop=$personnes}
    <div class="contact">
      <div class="nom">
        {$personnes[resultat].nom} {$personnes[resultat].prenom}
      </div>
      <div class="appli">
        X{$personnes[resultat].promo}
      </div>
      <div class="bits" style="width: 40%;">
        <span class='smaller'>
        <a href="{"fiche.php"|url}?user={$personnes[resultat].bestalias}" class="popup2">
          <img src="images/loupe.gif" alt="voir sa fiche" title="Voir sa fiche" /></a> - 
          <a href="{"fiche_referent.php"|url}?user={$personnes[resultat].bestalias}" class="popup2">Voir sa fiche r�f�rent</a>
        </span>
      </div>
      <div class="long">
       <table cellspacing="0" cellpadding="0">
        <tr>
          <td class="lt">Expertise :</td>
          <td class="rt" colspan="2">{$personnes[resultat].expertise|nl2br}</td>
        </tr>
       </table>
      </div>
    </div>
  {/section}
  </div>
  <p>
    Pages&nbsp;:&nbsp;
    {section name="page_number" start=1 loop=$nb_pages_total+1}
    {if $smarty.section.page_number.index == $page_courante}
    {$page_courante} {else}
    <a href="javascript:showPage({$smarty.section.page_number.index})">{$smarty.section.page_number.index} </a> 
    {/if}
    {/section}
  </p>
</form>
{/if}
{if $show_formulaire}
<span class="erreur">
  Si tu utilises ce service pour la premi�re fois, lis attentivement le texte
  qui suit.
</span>
<p>
En <a href="profil.php">renseignant sa fiche dans l'annuaire</a>, chacun
d'entre nous a la possibilit� de renseigner, dans la section "Mentoring",
s'il accepte de recevoir des messages de la part de camarades qui pourraient
souhaiter lui poser quelques questions et recevoir quelques conseils.<br />
Ces informations sont rentr�es par chacun sur la base du volontariat et sont
totalement d�claratives. Chaque X qui compl�te cette rubrique accepte alors
de recevoir un courrier �lectronique des jeunes camarades qui sont en train
de b�tir leur projet professionnel, mais aussi des moins jeunes qui cherchent
� r�orienter leur carri�re. Bien entendu, chacun se r�serve le droit de ne
pas donner suite � une sollicitation !<br />
Pour que ce syst�me soit profitable, il est n�cessaire que dans ta recherche
de conseils professionnels, tu agisses sagement, en �vitant de contacter
un trop grand nombre de camarades. De m�me, pense bien que les quelques
personnes que tu vas �ventuellement contacter suite � ta recherche
accepteront �ventuellement de t'aider et de te guider <strong>sur la base du
  volontariat</strong>. Il va de soi que plus ton comportement lors de votre
contact sera �thique et reconnaissant, plus cette pratique de conseil
inter-g�n�rations sera encourag�e et bien per�ue par ceux qui la pratiquent.
<br />
Nous avons pein� � trouver un nom pour d�signer ceux qui sont volontaires
pour guider les camarades qui en ressentent le besoin : nous avons finalement
retenu le terme de <em>mentors</em> pour d�signer ceux qui sont pr�ts � aider de
mani�re suivie un camarade plus jeune, � plusieurs moments de sa carri�re,
et avons appel� <em>r�f�rents</em> ceux qui s'impliquent plut�t en tant que
"relai d'informations", dans le sens o� ils ont v�cu des exp�riences
professionnelles susceptibles d'int�resser certains d'entre nous (exp�rience
de stage ou d'emploi � l'�tranger), sans forc�ment souhaiter consacrer
autant de temps � quelqu'un que le ferait un mentor attentionn�.
La recherche propos�e ici permet de trouver les deux types d'aide.
</p>

<p>
Dans le formulaire ci-dessous, tu peux rechercher des avis en fonction des
domaines de comp�tence recherch�s, des cultures professionnelles des pays
connues par le r�f�rent, et enfin une derni�re case te permettra de faire
une recherche par mots-clefs.<br />
Nous t'incitons � prendre plut�t 2 ou 3 contacts qu'un seul, cela te
permettant certainement d'avoir une vision des choses plus compl�te.
</p>

<p>
Actuellement, {$mentors_number} mentors et r�f�rents se sont d�clar�s sur Polytechnique.org.
</p>

<form action="{$smarty.server.REQUEST_URI}" method="post">
  <table cellpadding="0" cellspacing="0" summary="Formulaire de recherche de referents" class="bicol">
    <tr class="impair">
      <td class="titre">
        Secteur de comp�tence <br /> du r�f�rent
      </td>
      <td >
        <select name="secteur" onchange="javascript:submit()">
          {html_options options=$secteurs selected=$secteur_selectionne}
        </select>
      </td>
    </tr>
    <tr class="pair">
      <td class="titre">
        Sous-Secteur
      </td>
      <td >
        <select name="ss_secteur">
          {html_options options=$ss_secteurs selected=$ss_secteur_selectionne}
        </select>
      </td>
    </tr>
    <tr class="impair">
      <td class="titre">
        Pays bien connu du r�f�rent
      </td>
      <td >
        <select name="pays">
          {html_options options=$pays selected=$pays_selectionne}
        </select>
      </td>
    </tr>
    <tr class="pair">
      <td colspan="2">
        &nbsp;
      </td>
    </tr>
    <tr class="impair">
      <td class="titre">
        Expertise (rentre un ou plusieurs mots cl�s)
      </td>
      <td >
        <input type="text" name="expertise" size="30" value="{$expertise_champ}" />
      </td>
    </tr>
  </table>
  <div class="center" style="margin-top: 1em;">
    <input type="submit" value="Chercher" name="Chercher" />
  </div>
</form>

{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
