{* $Id: inscrire.mail.tpl,v 1.1 2004-07-19 08:58:04 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="inscrire"}
{subject text="$subj"}
{from full=#from#}
{to addr="$lemail"}
Bonjour,

Ton inscription sur Polytechnique.org est presque termin�e, un clic sur le lien ci-dessous et c'est fini.

Apr�s activation, tes param�tres seront :

login        : {$mailorg}
mot de passe : {$pass_clair}

Rends-toi sur la page web suivante afin d'activer ta pr�-inscription, et de changer ton mot de passe en quelque chose de plus facile � m�moriser :

{$baseurl}/step4.php?ref={$ins_id}

Si en cliquant dessus tu n'y arrives pas, copie int�gralement l'adresse dans la barre de ton navigateur.

Nous esp�rons que tu profiteras pleinement des services en ligne de Polytechnique.org : s'ils te convainquent, n'oublie pas d'en parler aux camarades autour de toi !

Bien cordialement,
Polytechnique.org
"Le portail des �l�ves & anciens �l�ves de l'Ecole polytechnique"

{* vim:set nocindent noautoindent textwidth=0: *}
