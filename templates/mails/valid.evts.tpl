{* $Id: valid.evts.tpl,v 1.1 2004-02-08 12:21:33 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="valid_evts"}
{subject text="[Polytechnique.org/EVENEMENTS] Proposition d'�v�nement"}
{from full=#from#}
{to addr="$username@polytechnique.org"}
{cc full=#cc#}
{if $answer eq "yes"}
Cher(e) camarade,

  L'annonce que tu avais propos�e ({$titre|strip_tags}) vient d'�tre valid�e.

Cordialement,
L'�quipe X.org
{elseif $answer eq 'no'}

Cher(e) camarade,

  L'annonce que tu avais propos�e ({$titre|strip_tags}) a �t� refus�e.

Cordialement,
L'�quipe X.org
{/if}
{* vim:set nocindent noautoindent textwidth=0: *}
