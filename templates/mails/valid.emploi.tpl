{* $Id: valid.emploi.tpl,v 1.1 2004-02-07 14:42:07 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="valid_emploi"}
{subject text="[Polytechnique.org/EMPLOI] Annonce emploi $entreprise"}
{from full=#from#}
{cc full=#cc#}
{if $answer eq "yes"}
Bonjour,

L'annonce � {$titre} � a �t� accept�e par les mod�rateurs. Elle appara�tra dans le forum emploi du site.

Nous vous remercions d'avoir propos� cette annonce

Cordialement,
L'�quipe Polytechnique.org
{elseif $answer eq 'no'}
Bonjour,

L'annonce � {$titre} � a �t� refus�e par les mod�rateurs.

Cordialement,
L'�quipe Polytechnique.org
{/if}
{* vim:set nocindent noautoindent textwidth=0: *}
