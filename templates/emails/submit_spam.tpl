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

<h1>Soumettre un spam</h1>

<form method="post" action="{$platal->pl_self()}" enctype="multipart/form-data">
  <table class="tinybicol">
    <tr>
      <td>
        Soumettre un
        <select name="type">
          <option value="spam" {if $smarty.request.type neq 'spam'}selected="selected"{/if}>spam</option>
          <option value="nonspam" {if $smarty.request.type eq 'nonspam'}selected="selected"{/if}>non-spam</option>
        </select>
        mal filtr�.
      </td>
    </tr>
    <tr>
      <td>
        <input type="file" name="mail" />
      </td>
    </tr>
  </table>

  <p class="center">
    <input type="submit" name="send_email" value="Envoyer" />
  </p>
</form>

<p>
  Pour soumettre un (non-)spam mal d�tect� par notre <a href="emails/antispam">antispam</a>, il suffit d'enregistrer
  les sources (regarde dans la documentation de ton client mail dans la liste ci-dessous) du mail en tant que fichier
  depuis ton client mail, puis de soumettre ce fichier � l'interface ci-dessus en s�lectionnant l'action adapt�e :
</p>
<ul>
  <li><strong>spam</strong> : pour soumettre un spam mal reconnu</li>
  <li><strong>nonspam</strong> : pour soumettre un mail l�gitime mal reconnu</li>
</ul>

{include file=../spool/wiki.d/cache_Xorg.Mails.tpl part=clients included=1}

{* vim:set et sw=2 sts=2 sws=2: *}
