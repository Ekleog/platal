{literal}
<script language="JavaScript" type="text/javascript">
<!-- Begin
    function showPage( pNumber ) {
        document.form_result.page_courante.value = pNumber;
        document.form_result.submit();
    }
// End -->
</script>
{/literal}
<div class="rubrique">
  Rechercher un camarade pouvant m'aider � orienter mon parcours professionnel
</div>
{dynamic}
{if $recherche_trop_large}
<p class="normal">
  Les crit�res de recherche que tu as rentr�s n'ont pas produit de r�sultats,
  sans doute car ta requ�te �tait trop g�n�rale. Nous t'invitons �
  <a href="referent.php">proc�der � une nouvelle recherche</a>, en essayant
  d'�tre plus pr�cis.
</p>
{elseif $resultats}
  <FORM action="{$smarty.server.PHP_SELF}" method="POST" name="form_result">
  <INPUT type="hidden" name="pays" value="{$pays_selectionne}">
  <INPUT type="hidden" name="expertise" value="{$expertise_champ}">
  <INPUT type="hidden" name="secteur" value="{$secteur_selectionne}">
  <INPUT type="hidden" name="ss_secteur" value="{$ss_secteur_selectionne}">
  <INPUT type="hidden" name="page_courante" value="1">
  <INPUT type="hidden" name="Chercher" value="1">
  <TABLE class="rechresult" border=0 cellpadding=0 cellspacing=0 summary="R�sultats">
{section name="resultat" loop=$personnes}
<TR>
  <TD class="rechnom">{$personnes[resultat].nom} {$personnes[resultat].prenom}</TD>
  <TD class="rechdetails"><span class="rechdiplo">X{$personnes[resultat].promo}</span></TD>
  <TD class="rechdetails" width="15%"><a style="font-size: smaller;" href="javascript:x()"  onclick="popWin('x.php?x={$personnes[resultat].username}')">voir sa fiche</a></TD>
  <TD class="rechdetails" width="25%"><a style="font-size: smaller;" href="javascript:x()"  onclick="popWin('fiche_referent.php?x={$personnes[resultat].username}')">voir sa fiche r�f�rent</a></TD>
</TR>
<TR>
  <TD class="rechtitreitem">Expertise :</TD>
  <TD class="rechitem" colspan="2">{$personnes[resultat].expertise}</TD>
</TR>
<TR>
<TD>
&nbsp;
</TD>
</TR>
{/section}
</TABLE>
<br />
<span style="font-size: normal;">Pages&nbsp;:&nbsp;
{section name="page_number" start=1 loop=$nb_pages_total+1}
{if $smarty.section.page_number.index == $page_courante}
{$page_courante} {else}
<a href="javascript:showPage({$smarty.section.page_number.index})">{$smarty.section.page_number.index} </a> 
{/if}
{/section}
</span>
</FORM>
{/if}
{if $show_formulaire}
<span class="erreur">
  Si tu utilises ce service pour la premi�re fois, lis attentivement le texte
  qui suit.
</span>
<p class="normal">
  En <a href="profil.php">renseignant sa fiche dans l'annuaire</a>, chacun
  d'entre nous a la possibilit� de renseigner, dans la section "Mentoring",
  s'il accepte de recevoir des messages de la part de camarades qui pourraient
  souhaiter lui poser quelques questions et recevoir quelques conseils.<br>
  Ces informations sont rentr�es par chacun sur la base du volontariat et sont
  totalement d�claratives. Chaque X qui compl�te cette rubrique accepte alors
  de recevoir un courrier �lectronique des jeunes camarades qui sont en train
  de b�tir leur projet professionnel, mais aussi des moins jeunes qui cherchent
  � r�orienter leur carri�re. Bien entendu, chacun se r�serve le droit de ne
  pas donner suite � une sollicitation !<br>
  Pour que ce syst�me soit profitable, il est n�cessaire que dans ta recherche
  de conseils professionnels, tu agisses sagement, en �vitant de contacter
  un trop grand nombre de camarades. De m�me, pense bien que les quelques
  personnes que tu vas �ventuellement contacter suite � ta recherche
  accepteront �ventuellement de t'aider et de te guider <u>sur la base du
  volontariat</u>. Il va de soi que plus ton comportement lors de votre
  contact sera �thique et reconnaissant, plus cette pratique de conseil
  inter-g�n�rations sera encourag�e et bien per�ue par ceux qui la pratiquent.
  <br>
  Nous avons pein� � trouver un nom pour d�signer ceux qui sont volontaires
  pour guider les camarades qui en ressentent le besoin : nous avons finalement
  retenu le terme de <i>mentors</i> pour d�signer ceux qui sont pr�ts � aider de
  mani�re suivie un camarade plus jeune, � plusieurs moments de sa carri�re,
  et avons appel� <i>r�f�rents</i> ceux qui s'impliquent plut�t en tant que
  "relai d'informations", dans le sens o� ils ont v�cu des exp�riences
  professionnelles susceptibles d'int�resser certains d'entre nous (exp�rience
  de stage ou d'emploi � l'�tranger), sans forc�ment souhaiter consacrer
  autant de temps � quelqu'un que le ferait un mentor attentionn�.
  La recherche propos�e ici permet de trouver les deux types d'aide.
</p>

<p class="normal">
  Dans le formulaire ci-dessous, tu peux rechercher des avis en fonction des
  domaines de comp�tence recherch�s, des cultures professionnelles des pays
  connues par le r�f�rent, et enfin une derni�re case te permettra de faire
  une recherche par mots-clefs.<br>
  Nous t'incitons � prendre plut�t 2 ou 3 contacts qu'un seul, cela te
  permettant certainement d'avoir une vision des choses plus compl�te.
</p>

<p class="normal">
  Actuellement, {$mentors_number} mentors et r�f�rents se sont d�clar�s sur Polytechnique.org.
</p>

<form action="{$smarty.server.REQUEST_URI}" method="post" name="form_ref">
<table width="83%" border="0" cellpadding="0" cellspacing="0"
    summary="Formulaire de recherche de referents" class="bicol">
  <tr class="impair">
     <td class="bicoltitre">
          Secteur de comp�tence <br> du r�f�rent
     </td>
     <td >
       <select name="secteur" OnChange="javascript:submit()">
         {html_options options=$secteurs selected=$secteur_selectionne}
       </select>
     </td>
  </tr>
  <tr class="pair">
     <td class="bicoltitre">
          Sous-Secteur
     </td>
     <td >
       <select name="ss_secteur">
         {html_options options=$ss_secteurs selected=$ss_secteur_selectionne}
       </select>
     </td>
  </tr>
  <tr class="impair">
     <td class="bicoltitre">
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
     <td class="bicoltitre">
          Expertise (rentre un ou plusieurs mots cl�s)
     </td>
     <td >
       <input type="text" name="expertise" size="30" value="{$expertise_champ}" />
     </td>
  </tr>
</table>
<div style="text-align: center; margin-top: 1em;">
      <input type="submit" value="Chercher" name="Chercher">
</div>
</form>

{/if}
{/dynamic}
