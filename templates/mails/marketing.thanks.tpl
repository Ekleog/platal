{config_load file="mails.conf" section="marketing_thanks"}
{from full=#from#}
{to addr="$to"}
{subject text="$prenom $nom s'est inscrit � Polytechnique.org !"}
Bonjour,

Nous t'�crivons juste pour t'informer que {$prenom} {$nom} (X{$promo}), que tu avais incit� � s'inscrire � Polytechnique.org, vient � l'instant de terminer son inscription !! :o)

Merci de ta participation active � la reconnaissance de ce site !!!

Bien cordialement,
L'�quipe Polytechnique.org
"Le portail des �l�ves & anciens �l�ves de l'Ecole polytechnique"
