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
        $Id: epouse.tpl,v 1.6 2004-10-19 22:16:14 x2000habouzit Exp $
 ***************************************************************************}


<div class="rubrique">
  Nom de mariage
</div>

{dynamic}
{if !$is_femme}

<p class="erreur">
  Tu n'es pas autoris� � avoir acc�s � cette page !
</p>

{else}

  {if $same}
  <p class="erreur">
      Si ton nom de mariage est identique � ton nom � l'X, il n'est pas
      n�cessaire de le saisir ici!
  </p>
  {else}
    {if $myepouse}
    {if $epouse_old}
    <p>
      Ta demande de suppression de ton nom de mariage ainsi que de tes
      alias {$alias_old}@polytechnique.org et
      {$alias_old}@m4x.org a bien �t� enregistr�e. 
    </p>
    {/if}

    {if $myepouse->alias}
    <p>
      Ta demande d'ajout de ton nom de mariage a bien �t� enregistr�e. Sa
      validation engendrera la cr�ation des alias
      <strong>{$myepouse->alias}@polytechnique.org</strong> et
      <strong>{$myepouse->alias}@m4x.org</strong>.
    </p>
    {/if}
    
    <p>
      Tu recevras un mail d�s que les changements demand�s auront �t� effectu�s. 
      Encore merci de nous faire confiance pour tes e-mails !
    </p>

    {else}

    <p>
    Afin d'�tre joignable � la fois sous ton nom � l'X et sous ton nom de mariage, tu peux
    saisir ici ce dernier. Il appara�tra alors dans l'annuaire et tu disposeras
    des adresses correspondantes @m4x.org et @polytechnique.org, en plus de
    celles que tu poss�des d�j�.
    </p>

    <br />

    <form action="{$smarty.server.PHP_SELF}" method="post">
      <table class="bicol" cellpadding="4" summary="Nom d'epouse">
        <tr>
          <th>Nom de mariage</th>
        </tr>
        <tr>
          <td class="center"><input type="text" name="epouse" value="{$epouse_old}" /></td>
        </tr>
        <tr>
          <td class="center"><input type="submit" name="submit" value="Envoyer" /></td>
        </tr>
      </table>
    </form>
    {/if}
  {/if}
{/if}
{/dynamic}
  

{* vim:set et sw=2 sts=2 sws=2: *}
