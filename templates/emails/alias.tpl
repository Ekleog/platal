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


{if $success}
  <p>
  La demande de cr�ation des alias <strong>{$success}@{#globals.mail.alias_dom#}</strong> et
  <strong>{$success}@{#globals.mail.alias_dom2#}</strong> a bien �t� enregistr�e. Apr�s
    v�rification, tu recevras un mail te signalant l'ouverture de ces adresses.
  </p>
  <p>
    Encore merci de nous faire confiance pour tes e-mails !
  </p>
{else}
  <h1>
    Adresses e-mail personnalis�es
  </h1>

{if $actuel}
<script type="text/javascript" src="javascript/ajax.js"></script>
  <table class="flags">
    <tr>
      <td class="orange">
        <input type="checkbox" {if $mail_public}checked="checked"{/if}
            onclick="
                Ajax.update_html(null,'{$globals->baseurl}/emails/alias/set/'+(this.checked?'public':'private'));
                document.getElementById('mail_public').innerHTML = (this.checked?'public et appara�t donc sur ta fiche':'priv� et n\'appara�t nulle part sur le site') + '.';
            " />
      </td>
      <td>
        Ton alias est actuellement : <strong>{$actuel}</strong>. Il est pour l'instant
        <span id="mail_public">{if $mail_public}public et appara�t donc sur ta fiche.{else}priv� et n'appara�t nulle part sur le site.{/if}</span>
      </td>
    </tr>
  </table>
    
{else}
  <p>
    Pour plus de <strong>convivialit�</strong> dans l'utilisation de tes mails, tu peux choisir une adresse
    e-mail discr�te et personnalis�e. Ce nouvel e-mail peut par exemple correspondre � ton surnom.
  </p>
{/if}

  <p>
    Pour de plus amples informations sur ce service, nous t'invitons � consulter
    <a href="Docs/MonAliasMailMelix-net">cette documentation</a> qui r�pondra
    sans doute � toutes tes questions
  </p>

  {if $actuel}
  <p>
  <strong>Note : tu as d�j� l'alias {$actuel}, or tu ne peux avoir qu'un seul alias � la fois.
    Si tu effectues une nouvelle demande l'ancien alias sera effac�.</strong>
  </p>
  {/if}

  {if $demande}
  <p>
  <strong>Note : tu as d�j� effectu� une demande pour {$demande->alias}, dont le traitement est
    en cours. Si tu souhaites modifier ceci refais une demande, sinon ce n'est pas la peine.</strong>
  </p>
  {/if}

  <br />
  <form action="emails/alias/ask" method="post">
    <table class="bicol" cellpadding="4" summary="Demande d'alias">
      <tr>
        <th>Demande d'alias</th>
      </tr>
      <tr>
        <td>Alias demand� :</td>
      </tr>
      <tr>
        <td><input type="text" name="alias" value="{$r_alias}" />@{#globals.mail.alias_dom#} et @{#globals.mail.alias_dom2#}</td>
      </tr>
      <tr>
        <td>
          <table class="flags" summary="Flags" cellpadding="0" cellspacing="0">
            <tr>
              <td class="orange">
                <input type="checkbox" name="public" {if $mail_public}checked="checked"{/if}/>
              </td>
              <td class="texte">
                adresse publique (appara�t sur ta fiche).
              </td>
             </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>Br�ve explication :</td>
      </tr>
      <tr>
        <td><textarea rows="5" cols="50" name="raison">{$r_raison}</textarea></td>
      </tr>
      <tr>
        <td><input type="submit" name="submit" value="Envoyer" /></td>
      </tr>
    </table>
  </form>
  {if $actuel}
  <form action="emails/alias/delete/{$actuel}" method="post"
      onsubmit="return confirm('Es-tu s�r de vouloir supprimer {$actuel} ?')">
    <table class="bicol" cellpadding="4" summary="Suppression d'alias">
      <tr>
        <th>Suppression d'alias</th>
      </tr>
      <tr>
        <td class="center">
          <input type="submit" value="Supprimer l'alias {$actuel}" />
        </td>
      </tr>
    </table>
  </form>
  {/if}
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
