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


<h1>Perte du mot de passe</h1>


{if $ok}

<p>
<strong>Un certificat d'authentification</strong> vient de t'�tre attribu� et a �t� envoy� vers les redirections de
ton adresse en {#globals.mail.domain#}. Ce certificat te permet d'acc�der � un formulaire de changement de mot de passe.
<span class="erreur"> Il expire dans six heures.</span> Tu dois donc <strong>consulter ton mail avant son expiration</strong> et utiliser le certificat comme expliqu� dans le mail pour changer ton mot de passe.
</p>
<p>
Si tu n'acc�des pas � ton mail dans les 6 heures, sollicite un nouveau certificat sur cette page.
</p>

{else}

<form action="{$platal->ns}recovery" method="post">
  <p>
  Il est impossible de r�cup�rer le mot de passe perdu car nous n'avons que le r�sultat apr�s un
  chiffrement irr�versible de ton mot de passe. La proc�dure suivante va te permettre de choisir un
  nouveau mot de passe.
  </p>
  <p>
  Apr�s avoir compl�t� les informations suivantes, tu recevras � ton adresse {#globals.core.sitename#} un
  courrier �lectronique te permettant de choisir un nouveau mot de passe. Si tu d�sires que ce mail soit
  envoy� vers une de tes redirections en particulier, tu peux renseigner l'adresse de cette redirection dans
  le champ facultatif.
  </p>
  <p>
  Si tu ne re�ois pas ce courrier, n'h�site pas � contacter 
  <a href="mailto:support@polytechnique.org">le support technique</a>.
  </p>
  <table class="tinybicol" cellpadding="3" cellspacing="0" summary="R�cup�ration du mot de passe">
    <tr>
      <th colspan="2">
        Perte de mot de passe
      </th>
    </tr>
    <tr>
      <td class="titre">
        Login :<br />
        <span class="smaller">"prenom.nom" ou "prenom.nom.promo"</span>
      </td>
      <td>
        <input type="text" size="20" maxlength="50" name="login" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Date de naissance :<br />
        <span class="smaller">format JJMMAAAA soit 01032000<br />pour 1<sup>er</sup> mars 2000</span>
      </td>
      <td>
        <input type="text" size="8" maxlength="8" name="birth" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Adresse �lectronique : <span class="smaller">(facultatif)</span>
      </td>
      <td>
        <input type="text" size="20" maxlength="50" name="email" />
      </td>
    </tr>
    <tr>
      <td colspan="2" class="center">
        <input type="submit" value="Continuer" name="submit" />
      </td>
    </tr>
  </table>
</form>
{/if}

{* vim:set et sw=2 sts=2 sws=2: *}
