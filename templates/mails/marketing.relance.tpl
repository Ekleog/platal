{* $Id: marketing.relance.tpl,v 1.1 2004-07-17 14:16:47 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="valid_alias"}
{subject text="$subj"}
{from full=#from#}
{to addr="$lemail"}
Bonjour,

Il y a quelques temps, le {$fdate}, tu as commenc� ton inscription � Polytechnique.org ! Tu n'as toutefois pas tout � fait termin� cette inscription, aussi nous nous permettons de te renvoyer cet email pour te rappeler tes param�tres de connexion, au cas o� tu souhaiterais terminer cette inscription, et acc�der � l'ensemble des services que nous offrons aux {$nbdix} Polytechniciens d�j� inscrits (email � vie, annuaire en ligne, etc...).

UN SIMPLE CLIC sur le lien ci-dessous et ton compte sera activ� !

Apr�s activation, tes param�tres seront :

login        : {$lusername}
mot de passe : {$nveau_pass}

(ceci annule les param�tres envoy�s par le mail initial)

Rends-toi sur la page web suivante afin d'activer ta pr�-inscription, et de changer ton mot de passe en quelque chose de plus facile � m�moriser :

{$baseurl}/step4.php?ref={$lins_id}

Si en cliquant dessus tu n'y arrives pas, copie int�gralement l'adresse dans la barre de ton navigateur.

En cas de difficult�, nous sommes bien entendu � ton enti�re disposition !

Bien cordialement,
Polytechnique.org
"Le portail des �l�ves & anciens �l�ves de l'Ecole polytechnique"

{* vim:set nocindent noautoindent textwidth=0: *}
