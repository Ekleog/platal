{* $Id: pattecasser.nl.tpl,v 1.1 2004-02-11 13:57:06 x2000habouzit Exp $ *}
{config_load file="mails.conf" section="pattecassee_nl"}
{subject text="Une de tes adresses de redirection Polytechnique.org ne marche plus !!"}
{from full=#from#}
{to addr=$dest}

  Bonjour !
	
  Nous t'�crivons car lors de l'envoi de la lettre d'information mensuelle de Polytechnique.org � ton adresse polytechnicienne {$dest}@polytechnique.org, l'adresse {$email}, sur laquelle tu rediriges ton courrier, ne fonctionnait pas.
  Estimant que cette information serait susceptible de t'int�resser, nous avons pr�f�r� t'en informer. Il n'est pas impossible qu'il ne s'agisse que d'une panne temporaire.
  Si tu souhaites changer la liste des adresses sur lesquelles tu re�ois le courrier qui t'es envoy� � ton adresse polytechnicienne, il te suffit de te rendre sur la page :
  https://www.polytechnique.org/emails.php
  
  A bient�t sur Polytechnique.org !
  L'�quipe d'administration <support@polytechnique.org>
  
  PS : si jamais tu ne disposes plus du mot de passe te permettant d'acc�der au site, rends toi sur la page https://www.polytechnique.org/recovery.php ; elle te permettra de cr�er un nouveau mot de passe apr�s avoir rentr� ton login ({$dest}) et ta date de naissance !";
  
{* vim:set nocindent noautoindent textwidth=0: *}
