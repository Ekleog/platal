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
  Nom d'usage
</h1>

{if $same}
<p class="erreur">
    Si ton nom d'usage est identique � ton nom � l'X, il n'est pas
    n�cessaire de le saisir ici!
</p>
{else}
  {if $myusage}
  {if $usage_old}
  <p>
    Ta demande de suppression de ton nom d'usage ainsi que de tes
    alias {$alias_old}@polytechnique.org et
    {$alias_old}@m4x.org a bien �t� enregistr�e. 
  </p>
  {/if}

  {if $myusage->alias}
  <p>
    Ta demande d'ajout de ton nom d'usage a bien �t� enregistr�e. Sa
    validation engendrera la cr�ation des alias
    <strong>{$myusage->alias}@polytechnique.org</strong> et
    <strong>{$myusage->alias}@m4x.org</strong>.
  </p>
  {/if}
  
  <p>
    Tu recevras un mail d�s que les changements demand�s auront �t� effectu�s. 
    Encore merci de nous faire confiance pour tes e-mails !
  </p>

{else}

  <p>
  Afin d'�tre joignable � la fois sous ton nom � l'X et sous ton nom d'usage, tu peux
  saisir ici ce dernier. Il appara�tra alors dans l'annuaire et tu disposeras
  des adresses correspondantes @m4x.org et @polytechnique.org, en plus de
  celles que tu poss�des d�j�.
  </p>

  <br />

  <form action="{$smarty.server.PHP_SELF}" method="post">
    <table class="bicol" cellpadding="4" summary="Nom d'usage">
      <tr>
        <th>Nom d'usage</th>
      </tr>
      <tr>
        <td class="center"><input type="text" name="nom_usage" value="{$usage_old}" /></td>
      </tr>
      <tr>
        <td class="center"><input type="submit" name="submit" value="Envoyer" /></td>
      </tr>
    </table>
  </form>
  {/if}
{/if}


{* vim:set et sw=2 sts=2 sws=2: *}
