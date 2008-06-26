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
 ***************************************************************************}

<h1>{$asso.nom} : Cr�ation d'une liste de diffusion</h1>

<p class="descr">
<strong>Note :</strong> Les listes de diffusion sont un outil particuli�rement adapt� pour des
�changes entre 6 personnes, ou plus (newsletter, d�bat interne au groupe ...). En revanche, elles
s'av�rent peu praticables pour des discussions plus restreintes.  Il est alors pr�f�rable
d'utiliser <a href="alias-create.php">un alias</a>, � la gestion beaucoup plus souple.
</p>
<p class="descr">
D'autre part, il est impossible d'inscrire une liste de diffusion � une autre liste de diffusion.
Si tu as besoin de cette fonctionnalit�, il faut alors <strong>imp�rativement</strong> utiliser
<a href="alias-create.php">un alias</a> qui, lui, est capable de regrouper plusieurs listes.
</p>
<form action='{$smarty.server.PHP_SELF}' method='post'>
  <table class="large">
    <tr>
      <th colspan='2'>Caract�ristiques de la Liste</th>
    </tr>
    <tr>
      <td><strong>Addresse&nbsp;souhait�e&nbsp;:</strong></td>
      <td>
        <input type='text' name='liste' value='{$smarty.post.liste}' />@{$asso.mail_domain}
      </td>
    </tr>
    <tr>
      <td><strong>Sujet (bref) :</strong></td>
      <td>
        <input type='text' name='desc' size='40' value="{$smarty.post.desc}" />
      </td>
    </tr>
    <tr>
      <td><strong>Propri�t�s :</strong></td>
      <td>
        <table style='width: 100%' class="normal">
          <tr>
            <td>visibilit� :</td>
            <td>
              <input type='radio' name='advertise' value='0'
              {if $smarty.post.advertise && $smarty.post}checked='checked'{/if} />publique
            </td>
            <td>
              <input type='radio' name='advertise' value='1'
              {if !$smarty.post.advertise || !$smarty.post}checked='checked'{/if} />priv�e
            </td>
            <td></td>
          </tr>
          <tr>
            <td>diffusion :</td>
            <td>
              <input type='radio' name='modlevel' value='0'
              {if !$smarty.post.modlevel}checked='checked'{/if} />libre
            </td>
            <td>
              <input type='radio' name='modlevel' value='1'
              {if $smarty.post.modlevel eq 1}checked='checked'{/if} />restreinte
            </td>
            <td><input type='radio' name='modlevel' value='2'
              {if $smarty.post.modlevel eq 2}checked='checked'{/if} />mod�r�e
            </td>
          </tr>
          <tr>
            <td>inscription :</td>
            <td>
              <input type='radio' name='inslevel' value='0'
              {if !$smarty.post.inslevel && $smarty.post}checked='checked'{/if} />libre
            </td>
            <td>
              <input type='radio' name='inslevel' value='1'
              {if $smarty.post.inslevel || !$smarty.post}checked='checked'{/if} />mod�r�e
            </td>
            <td></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <p class="center"><input name='submit' type='submit' value="Cr�er !" /></p>
</form>

{* vim:set et sw=2 sts=2 sws=2: *}
