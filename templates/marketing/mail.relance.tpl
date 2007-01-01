{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2007 Polytechnique.org                             *}
{*  http://opensource.polytechnique.org/                                  *}
{*                                                                        *}
{*  This program is free software; you can redistribute it and/or modify  *}
{*  it under the terms of the GNU General Public License as published by  *}
{*  the Free Software Foundation; either version 2 of the License, or     *}
{*  (at your option) any later version.                                   *}
{*                                                                        *}
{*  This program is distributed in the hope that it will be useful,       *}
{*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *}
{*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *}
{*  GNU General Public License for more details.                          *}
{*                                                                        *}
{*  You should have received a copy of the GNU General Public License     *}
{*  along with this program; if not, write to the Free Software           *}
{*  Foundation, Inc.,                                                     *}
{*  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA               *}
{*                                                                        *}
{**************************************************************************}

{config_load file="mails.conf" section="marketing_relance"}
{if !$html_version}
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

{$baseurl}/register/end/{$lins_id}

Si en cliquant dessus tu n'y arrives pas, copie int�gralement l'adresse dans la barre de ton navigateur.

En cas de difficult�, nous sommes bien entendu � ton enti�re disposition !

Bien cordialement,
Polytechnique.org
"Le portail des �l�ves & anciens �l�ves de l'Ecole polytechnique"

{/if}
{* vim:set et sw=2 sts=2 sws=2: *}
