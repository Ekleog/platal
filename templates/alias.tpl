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
        $Id: alias.tpl,v 1.9 2004-09-02 20:11:23 x2000habouzit Exp $
 ***************************************************************************}


{if $success}
  <p>
    a demande de cr�ation des alias <strong>{dyn s=$success}@melix.net</strong> et
    <strong>{dyn s=$success}@melix.org</strong> a bien �t� enregistr�e. Apr�s
    v�rification, tu recevras un mail te signalant l'ouverture de ces adresses.
  </p>
  <p>
    Encore merci de nous faire confiance pour tes e-mails !
  </p>
{else}
  {if $error}
  <p class="erreur">{dyn s=$error}</p>
  {/if}

  <div class="rubrique">
    Adresses e-mail personnalis�es
  </div>

  <p>
    Pour plus de <strong>convivialit�</strong> dans l'utilisation de tes mails, tu peux choisir une adresse
    e-mail discr�te et personnalis�e. Ce nouvel e-mail peut par exemple correspondre � ton surnom.
  </p>
  <p>
    Pour de plus amples informations sur ce service, nous t'invitons � consulter
    <a href="{"docs/doc_melix.php"|url}">cette documentation</a> qui r�pondra
    sans doute � toutes tes questions
  </p>

  {dynamic on="0$actuel"}
  <p>
  <strong>Note : tu as d�j� l'alias {$actuel}, or tu ne peux avoir qu'un seul alias � la fois.
    Si tu effectues une nouvelle demande l'ancien alias sera effac�.</strong>
  </p>
  {/dynamic}

  {dynamic on="0$demande"}
  <p>
  <strong>Note : tu as d�j� effectu� une demande pour {$demande->alias}, dont le traitement est
    en cours. Si tu souhaites modifier ceci refais une demande, sinon ce n'est pas la peine.</strong>
  </p>
  {/dynamic}

  <br />
  <form action="{$smarty.server.PHP_SELF}" method="post">
    <table class="bicol" cellpadding="4" summary="Demande d'alias">
      <tr>
        <th>Demande d'alias</th>
      </tr>
      <tr>
        <td>Alias demand� :</td>
      </tr>
      <tr>
        <td><input type="text" name="alias" value="{dyn s=$r_alias}" />@melix.net et @melix.org</td>
      </tr>
      <tr>
        <td>Br�ve explication :</td>
      </tr>
      <tr>
        <td><textarea rows="5" cols="50" name="raison">{dyn s=$r_raison}</textarea></td>
      </tr>
      <tr>
        <td><input type="submit" name="submit" value="Envoyer" /></td>
      </tr>
    </table>
  </form>
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
