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



<h1>
  Ma liste personnelle de contacts
</h1>

<form action="{$smarty.server.REQUEST_URI}" method="post">
<p>
  Ajouter la personne suivante � ma liste de contacts (prenom.nom) :<br />
  <input type="hidden" name="action" value="ajouter" />
  <input type="text" name="user" size="20" maxlength="70" />&nbsp;
  <input type="submit" value="Ajouter" />
</p>
</form>
<p>
  Tu peux �galement rajouter des camarades dans tes contacts lors d'une recherche dans l'annuaire : 
  il te suffit de cliquer sur l'ic�ne <img src="{"images/ajouter.gif"|url}" alt="ajout contact" /> en face de son nom dans les r�sultats !
</p>  

{if $trombi || $citer->total()}
<p>
Pour r�cup�rer ta liste de contacts dans un PDF imprimable :<br />
(attention, les photos font beaucoup grossir les fichiers !)
</p>
<ul>
  <li>avec les photos :
  [<a href="mescontacts_pdf.php/mes_contacts.pdf?order=promo&amp;photo" class='popup'><strong>tri par promo</strong></a>]
  [<a href="mescontacts_pdf.php/mes_contacts.pdf?photo" class='popup'><strong>tri par noms</strong></a>]
  </li>
  <li>sans les photos :
  [<a href="mescontacts_pdf.php/mes_contacts.pdf?order=promo" class='popup'><strong>tri par promo</strong></a>]
  [<a href="mescontacts_pdf.php/mes_contacts.pdf" class='popup'><strong>tri par noms</strong></a>]
  </li>
</ul>
{if $smarty.session.core_rss_hash}
<p>
  Tu peux r�cup�rer un calendrier iCal avec l'anniversaire de tes contacts.
</p>
  <div class="right">
    <a href='{rel}/carnet/calendar/{$smarty.session.forlife}/{$smarty.session.core_rss_hash}.ics'><img src='{rel}/images/icalicon.gif' alt='fichier ical' title='Anniversaires'/></a>
  </div>
{else}
<p>
  Pour r�cup�rer un calendrier iCal avec l'anniversaire de tes contacts, active les flux RSS dans <a href="{rel}/preferences.php">Mes pr�f�rences</a>.
</p>
{/if}


{if $trombi}

<h1>
  Mon trombino de contacts
</h1>

<p>
Pour afficher la liste d�taill�e de tes contacts: [<a href="{$smarty.server.PHP_SELF}?order={$order}&inv={$inv}"><strong>vue classique</strong></a>]
</p>

{include file=carnet/tricontacts.tpl order=$order}

{$trombi->show()|smarty:nodefaults}

{else}

<h1>
  Vue classique des contacts
</h1>

<p>
[<a href="?trombi=1&amp;order={$order}&amp;inv={$inv}"><strong>Afficher le trombi de tes contacts</strong></a>]
</p>

{include file=carnet/tricontacts.tpl order=$order}

<br />

<div class="contact-list">
{iterate from=$citer item=contact}
{include file=include/minifiche.tpl c=$contact show_action="retirer"}
{/iterate}
</div>

{/if}

{else}
<p>Actuellement ta liste de contacts est vide...</p>
{/if}


{* vim:set et sw=2 sts=2 sws=2: *}
