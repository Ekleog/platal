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

<h1>Ann�e de sortie</h1>

{if $myorange}

<p>
  Tu recevras un mail d�s que les changements demand�s auront �t� effectu�s. 
  Encore merci de nous faire confiance pour tes e-mails !
</p>

{else}

<p>
  Afin de pouvoir �tre consid�r�(e) � la fois dans ta promotion d'origine et ta
  ou tes promotions d'adoption tu peux entrer ici ton ann�e de sortie de l'�cole.
  Plus pr�cis�ment, il s'agit de l'ann�e d'entr�e en quatri�me ann�e ou ann�e d'application.
  Pour tes cocons d'origine (X{$promo}) il s'agit de l'ann�e {math equation="a + b" a=$promo b=3}.
</p>

<br />

<form action="{rel}/profile/orange" method="post">
  <table class="bicol" cellpadding="4" summary="Ann�e de sortie">
    <tr>
      <th>Ann�e de sortie</th>
    </tr>
    <tr>
      <td class="center"><input type="text" name="promo_sortie" value="{$promo_sortie_old}" /></td>
    </tr>
    <tr>
      <td class="center"><input type="submit" name="submit" value="Envoyer" /></td>
    </tr>
  </table>
</form>

{/if}

<p>[<a href="profil.php">Revenir au profil</a>]</p>

{* vim:set et sw=2 sts=2 sws=2: *}
