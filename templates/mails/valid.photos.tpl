{* $Id: valid.photos.tpl,v 1.1 2004-02-07 18:32:42 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="valid_photos"}
{subject text="[Polytechnique.org/PHOTO] Changement de photo de $username"}
{from full=#from#}
{to addr="$username@polytechnique.org"}
{cc full=#cc#}
{if $answer eq "yes"}
Cher(e) camarade,

  La demande de changement de photo que tu as demand�e vient d'�tre effectu�e.

Cordialement,
L'�quipe X.org
{elseif $answer eq 'no'}
Cher(e) camarade,

  La demande de changement de photo que tu avais faite a �t� refus�e.
La raison de ce refus est :
{$smarty.request.motif}

Cordialement,
L'�quipe X.org
{/if}
{* vim:set nocindent noautoindent textwidth=0: *}
