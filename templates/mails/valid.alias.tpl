{* $Id: valid.alias.tpl,v 1.1 2004-02-05 18:00:21 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="valid_alias"}
{subject text="[Polytechnique.org/MELIX] Demande de l'alias $alias@melix.net par $username"}
{from full=#from#}
{to addr="$username@polytechnique.org"}
{cc full=#cc#}
{if $answer eq "yes"}
Cher(e) camarade,

  Les adresses e-mail {$alias}@melix.net et {$alias}@melix.org que tu avais demand�es viennent d'�tre cr��es, tu peux d�sormais les utiliser � ta convenance.

Cordialement,
L'�quipe X.org
{elseif $answer eq 'no'}

Cher(e) camarade,

  La demande que tu avais faite pour les alias {$alias}@melix.net et {$alias}@melix.org a �t� refus�e pour la raison suivante :
{$motif}

Cordialement,
L'�quipe X.org
{/if}
{* vim:set nocindent noautoindent textwidth=0: *}
