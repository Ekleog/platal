{* $Id: index.tpl,v 1.4 2004-08-26 14:44:45 x2000habouzit Exp $ *}


<div class="rubrique">Marketing Polytechnique.org</div>

<table class="bicol" cellpadding="3" summary="Syst�me">
  <tr>
    <th>actions disponibles</th>
  </tr>
  <tr class="impair">
    <td>
      <span class="item">Premier contact : </span>
      <a href="utilisateurs_marketing.php">Chercher un non inscrit</a> &nbsp;&nbsp;|&nbsp;&nbsp;
      <a href="promo.php">Marketing promo</a> &nbsp;&nbsp;|&nbsp;&nbsp;
      <a href="envoidirect.php">Sollicitations faites</a>
    </td>
  </tr>
  <tr class="pair">
    <td>
      <span class="item">Relances : </span>
      <a href="ins_confirmees.php">Inscriptions confirm�es</a>
      &nbsp;&nbsp;|&nbsp;&nbsp;
      <a href="relance.php">Relance des �-inscrits</a>
    </td>
  </tr>
  <tr class="impair">
    <td>
      <span class="item">Emails : </span>
      <a href="volontaire.php">Utiliser les adresses donn�es par les inscrits</a>
    </td>
  </tr>
</table>

<br />

{dynamic}
<p>
Nombre d'X vivants d'apr�s notre base de donn�es : {$stats.vivants}<br />
Nombre d'X vivants inscrits � Polytechnique.org : {$stats.inscrits}<br />
Soit un pourcentage d'inscrits de : {$stats.ins_rate} %<br />
</p>

<p>
Parmi ceux-ci :<br />
Nombre d'X vivants depuis 1972 d'apr�s notre base de donn�es : {$stats.vivants72}<br />
Nombre d'X vivants depuis 1972 inscrits � Polytechnique.org : {$stats.inscrits72}<br />
Soit un pourcentage d'inscrits de : {$stats.ins72_rate} % <br />
</p>

<p>
Nombre de Polytechniciennes vivantes : {$stats.vivantes}<br />
Nombre de Polytechniciennes vivantes et inscrites : {$stats.inscrites} <br />
Soit un pourcentage d'inscrites de : {$stats.inse_rate} % <br />
</p>

<p>
Nombre d'inscrits depuis le d�but de la semaine : {$nbInsSem} <br />
Nombre d'inscriptions en cours (2�me phase non termin�e) : {$nbInsEnCours} <br />
Nombre d'envois marketing effectu�s n'ayant pas abouti : {$nbInsEnvDir}
</p>
{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
