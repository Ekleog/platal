{***************************************************************************
 *  Copyright (C) 2003-2004 Polytechnique.org                              *
 *  http://opensource.polytechnique.org/                                   *
 *                                                                         *
 *  This program is free software; you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation; either version 2 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with this program; if not, write to the Free Software            *
 *  Foundation, Inc.,                                                      *
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA                *
 ***************************************************************************
        $Id: marketing.utilisateur.tpl,v 1.3 2004-09-05 22:25:46 x2000habouzit Exp $
 ***************************************************************************}

{subject text="Annuaire en ligne des Polytechniciens"}
{from full=$from}
{to addr=$to}
{if $femme}
Ch�re camarade,
{else}
Ch�r camarade,
{/if}

a fiche n'est pas � jour dans l'annuaire des Polytechniciens sur Internet. Pour la mettre � jour, il te suffit de visiter cette page ou de copier cette adresse dans la barre de ton navigateur :

==========================================================
{$baseurl}/inscription/maj.php?n={$user_id}
==========================================================

Il ne te faut que 5 minutes sur http://www.polytechnique.org/ pour rejoindre les {$num_users} camarades branch�s gr�ce au syst�me de reroutage de l'X et qui permet de joindre un camarade en connaissant seulement son nom et son pr�nom... et de b�n�ficier pour la vie d'une adresse prestigieuse {$mailorg}@polytechnique.org et son alias discret {$mailorg}@m4x.org (m4x = mail for X).
Pas de nouvelle bo�te aux lettres � relever, il suffit de la rerouter vers ton adresse personnelle et/ou professionnelle que tu indiques et que tu peux changer tous les jours si tu veux sans imposer � tes correspondants de modifier leur carnet d'adresses...

De plus, le site web offre les services d'annuaire (recherche multi-crit�res), de forums, de mailing-lists. Ce portail est g�r� par une dizaine de jeunes camarades, avec le soutien et les conseils de nombreux X de toutes promotions, incluant notamment des camarades de la K�s des �l�ves de l'X et d'autres de l'AX. Les serveurs sont h�berg�s au sein m�me de l'Ecole polytechnique, sur une connexion rapide, et les services �voluent en fonction des besoins exprim�s par la communaut� sur Internet.

N'h�site pas � transmettre ce message � tes camarades ou � nous �crire, nous proposer toute am�lioration ou suggestion pour les versions prochaines du site.


A bient�t sur http://www.polytechnique.org !

Bien � toi,

{$envoyeur}
--
Polytechnique.org
"Le portail des �l�ves & anciens �l�ves de l'X"
http://www.polytechnique.org/
http://www.polytechnique.net/

{* vim:set et sw=2 sts=2 sws=2: *}
