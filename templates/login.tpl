{* $Id: login.tpl,v 1.2 2004-01-26 19:40:51 x2000habouzit Exp $ *}

{if $date}
  <div class="rubrique">
    Assistant premi�re connexion
  </div>
  <p class="normal">
  Le programme a d�tect� que tu te connectes pour la premi�re fois
  sur ce site. Un certain nombre de param�tres ne sont donc pas �
  jour pour fonctionner correctement. La plupart se mettront eux-m�mes
  � jour sans que tu t'en aper�oives, mais d'autres n�cessitent
  ton intervention.
  </p>
  <p class="loinenbas">
    <a href="profil.php">Clique ici pour continuer.</a>
  </p>
{elseif $naissance}
{include file=form_naissance.tpl}
{else}

<div class="rubrique">Bienvenue {dyn s=$smarty.session.prenom} :o)
  </div>
  <div class="dernierlogin">
    Ta connexion pr�c�dente date du
    <strong>{dyn s=$smarty.session.lastlogin|date_format:"%x, %T"}</strong>
    depuis la machine <strong>{dyn s=$smarty.session.host}</strong>
  </div>
  
{dynamic on="0$fiche_incitation"}
  <p class="normal">La derni�re mise � jour de ta
  <a href="javascript:x()" onclick="popWin('x.php?x={$smarty.session.username}">fiche</a>
  date du {$fiche_incitation|date_format:"%x"}.
  Il est possible qu'elle ne soit pas � jour.
  Si tu souhaites la modifier, <a href=\"profil.php\">clique ici !</a>
  </p>
{/dynamic}

{dynamic on="0$photo_incitation"}
  <p class="normal">
    Tu n'as pas mis de photo de toi sur ta fiche, c'est dommage.
    Clique <a href="javascript:x()" onclick="popWin('trombino.php','trmb','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=750,height=480')">ici</a>
    si tu souhaites en ajouter une.
  </p>
{/dynamic}

<br />

{dynamic}
  <table class="bicol">
    <tr class="pair">
{foreach item=links from=$publicite}
      <td class="info">
{foreach key=url item=text from=$links}
        <a href="{$url}">{$text}</a><br />
{/foreach}
      </td>
{/foreach}
    </tr>
  </table>

  {foreach item=ev from=$evenement}
  <br />

  <table class="bicol">
    <tr>
      <th><a name="newsid{$ev.id}">{$ev.titre|nl2br}</a></th>
    </tr>
    <tr class="{cycle values="impair,pair"}">
      <td class="info">
        {$ev.texte|nl2br}
        <br />
        <p class="warning">Annonce propos�e par
        <a href="javascript:x()" onclick="popWin('x.php?x={$ev.username}')">
          {$ev.prenom} {$ev.nom} X{$ev.promo}
        </a>
        </p>
      </td>
    </tr>
  </table>
  {/foreach}
{/dynamic}

  <p class="warning">
  Nota Bene : les informations pr�sent�es ici n'engagent que leurs auteurs
  respectifs et sont publi�es � leur initiative. L'association Polytechnique.org
  ne pourrait en aucun cas �tre tenue responsable de la nature des propos relat�s
  sur cet espace d'expression et d'information. Elle se r�serve le droit de
  refuser ou de retirer toute information de nature diffamante ou pouvant �tre
  interpr�t�e comme pol�mique par un membre de la communaut� polytechnicienne.
  <p>

  <p class="normal">
  <a href="evenements.php">Proposer une information �v�nementielle</a>
  </p>
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
