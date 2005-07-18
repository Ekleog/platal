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

<h1>Cr�ation d'un alias</h1>
<p class='descr'>
Les alias sont concus pour r�pondre aux probl�mes suivants :
</p>
<ul class='descr'>
  <li>
  redirections pour les postes des gens au sein du groupe : par exemple il est pratique d'avoir un alias
  president@..., ou bien tresorier@... qui pointent tout le temps vers la bonne personne du groupe.
  Une sorte d'adresse de �redirection � vie�.
  </li>
  <li>
  listes de diffusions pour de petits nombres de personnes (bureau@ ...)
  </li>
  <li>
  listes � vie courte (liste cr��e pour l'organisation d'un �venement ponctuel par exemple)
  </li>
  <li>
  f�d�rer plusieurs listes/alias sous un m�me nom (ce que ne peuvent faire les listes de diffusion).
  </li>
</ul>

<p class='descr'>
Pour les autres besoins de communications (notament pour un grand nombre de personnes, et pour b�n�ficier des outils
de mod�ration), il est recommand� de cr�er <a href="listes-create.php">une liste de diffusion</a>.
</p>
<form action='{$smarty.server.PHP_SELF}' method='post'>
  <table class='large'>
    <tr>
      <th colspan='2'>Caract�ristiques de l'alias</th>
    </tr>
    <tr>
      <td><strong>Addresse&nbsp;souhait�e&nbsp;:</strong></td>
      <td>
        <input type='text' name='liste' value='{$smarty.post.liste}' />@{$asso.mail_domain}
      </td>
    </tr>
  </table>
  <p class="center">
  <input name='submit' type='submit' value="Cr�er !" />
  </p>
</form>

{* vim:set et sw=2 sts=2 sws=2: *}
