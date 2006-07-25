{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2006 Polytechnique.org                             *}
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

{if !$smarty.session.auth}
<div class="menu_title">Polytechniciens</div>
<div class="menu_item"><a href="events">Me connecter !</a></div>
<div class="menu_item"><a href="register">M'inscrire</a></div>
<div class="menu_item"><a href="Docs/PourquoiM'Inscrire">Pourquoi M'inscrire ?</a></div>

<div class="menu_title">Visiteurs</div>
<div class="menu_item"><a href="search">Annuaire de l'X</a></div>
<div class="menu_item"><a href="http://www.polytechnique.net/">Associations X</a></div>
<div class="menu_item"><a href="http://www.manageurs.com/">Recrutement</a></div>

<div class="menu_title">Informations</div>
<div class="menu_item"><a href="Docs/APropos">A propos du site</a></div>
<div class="menu_item"><a href="Docs/NousContacter">Nous contacter</a></div>
<div class="menu_item"><a href="Docs/FAQ">FAQ</a></div>

{else}

{if $smarty.session.auth == AUTH_MDP}
<div class="menu_item"><a href="exit">D�connexion</a></div>
{elseif $smarty.cookies.ORGaccess}
<div class="menu_item"><a href="exit/forget">D�connexion totale</a></div>
{/if}

<div class="menu_title">Personnaliser</div>
<div class="menu_item"><a href="emails">Mes emails</a></div>
<div class="menu_item"><a href="profile/edit">Mon profil</a></div>
<div class="menu_item"><a href="carnet/contacts">Mes contacts</a></div>
<div class="menu_item"><a href="carnet">Mon carnet</a></div>
<div class="menu_item"><a href="password">Mon mot de passe</a></div>
<div class="menu_item"><a href="prefs">Mes pr�f�rences</a></div>

<div class="menu_title">Services</div>
<div class="menu_item"><a href="emails/send">Envoyer un mail</a></div>
<div class="menu_item"><a href="banana/">Forums & PA</a></div>
<div class="menu_item"><a href="lists">Listes de diffusion</a></div>
<div class="menu_item"><a href="payment">T�l�paiements</a></div>
<div class="menu_item"><a href="emails/broken">Patte cass�e</a></div>

<div class="menu_title">Communaut� X</div>
<div class="menu_item"><a href="search">Annuaire</a></div>
{if $globals->geoloc->use_map}
<div class="menu_item"><a href="geoloc">Planisph�re</a></div>
{/if}
<div class="menu_item"><a href="trombi">Trombi promo</a></div>
<div class="menu_item"><a href="referent/search">Conseil Pro.</a></div>
<div class="menu_item"><a href="http://www.polytechnique.net/plan">Groupes X</a></div>

<div class="menu_title">Informations</div>
<div class="menu_item"><a href="nl">Lettres mensuelles</a></div>
<div class="menu_item"><a href="Docs/">Documentations</a></div>
<div class="menu_item"><a href="Docs/NousContacter">Nous contacter</a></div>
<div class="menu_item"><a href="Docs/Emploi">Carri�res</a></div>

{if $smarty.session.perms eq admin}
<div class="menu_title">***</div>
<div class="menu_item"><a href="marketing">Marketing</a></div>
<div class="menu_item"><a href="admin/">Administration</a></div>
<div class="menu_item"><a href="purge_cache">Clear cache</a></div>
<div class="menu_item"><a href="http://trackers.polytechnique.org">Trackers</a></div>
<div class="menu_item"><a href="http://support.polytechnique.org">Support</a></div>

<table class="bicol" style="font-weight:normal;text-align:center; border-left:0px; border-right:0px; margin-top:0.5em; width:100%; margin-left: 0; font-size: smaller;">
  <tr><th>Valid</th></tr>
  <tr class="impair">
    <td><a href="admin/validate">{insert name="mkStats"}</a></td>
  </tr>
</table>
{/if}
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
