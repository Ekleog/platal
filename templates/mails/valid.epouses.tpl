{* $Id: valid.epouses.tpl,v 1.1 2004-02-07 15:47:27 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="valid_epouses"}
{subject text="[Polytechnique.org/EPOUSE] Changement de nom de mariage de $username"}
{from full=#from#}
{to addr="$username@polytechnique.org"}
{cc full=#cc#}
{if $answer eq "yes"}
Ch�re camarade,

  La demande de changement de nom de mariage que tu as demand�e vient d'�tre effectu�e.

{if $oldepouse}  Les alias {$oldepouse}@polytechnique.org et {$oldepouse}@m4x.org ont �t� supprim�s.
{/if}
  De plus, les alias {$alias}@polytechnique.org et {$alias}@m4x.org ont �t� cr��s.

Cordialement,
L'�quipe X.org
{elseif $answer eq 'no'}
Ch�re camarade,

  La demande de changement de nom de mariage que tu avais faite a �t� refus�e.
{if $smarty.request.motif}
La raison de ce refus est :
{$smarty.request.motif}
{/if}

Cordialement,
L'�quipe X.org
{/if}
{* vim:set nocindent noautoindent textwidth=0: *}
