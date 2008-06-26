{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2004 Polytechnique.org                             *}
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

{config_load file="mails.conf" section="inscrire"}
{subject text="$subj"}
{from full=#from#}
{to addr="$lemail"}
Bonjour,

Ton inscription sur Polytechnique.org est presque termin�e, un clic sur le lien ci-dessous et c'est fini.

Apr�s activation, tes param�tres seront :

login        : {$mailorg}
mot de passe : {$pass}

Rends-toi sur la page web suivante afin d'activer ta pr�-inscription, et de changer ton mot de passe en quelque chose de plus facile � m�moriser :

{$baseurl}/register/end.php?hash={$hash}

Si en cliquant dessus tu n'y arrives pas, copie int�gralement l'adresse dans la barre de ton navigateur.

Nous esp�rons que tu profiteras pleinement des services en ligne de Polytechnique.org : s'ils te convainquent, n'oublie pas d'en parler aux camarades autour de toi !

Bien cordialement,
Polytechnique.org
"Le portail des �l�ves & anciens �l�ves de l'Ecole polytechnique"

{* vim:set et sw=2 sts=2 sws=2: *}
