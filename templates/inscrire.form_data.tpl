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
        $Id: inscrire.form_data.tpl,v 1.4 2004-08-31 11:25:39 x2000habouzit Exp $
 ***************************************************************************}


{include file="applis.js.tpl"}

<div class="rubrique">
  Formulaire de pr�-inscription
</div>

{dynamic}

{foreach from=$erreur item=err}
<p class="erreur">{$err|smarty:nodefaults}</p>
{/foreach}

<form action="{$gotourl|default:$smarty.server.REQUEST_URI}" method="post" name="infos">
  {if $homonyme}
  <p>
  Tu as un homonyme dans notre base de donn�es, nous ne pouvons donc pas te donner 
  l'adresse <strong>{$loginbis}@polytechnique.org</strong>, ton adresse sera 
  <strong>{$mailorg}@polytechnique.org</strong> et l'adresse pr�c�dente sera 
  redirig�e vers un auto-reply indiquant l'existence d'homonymes. Sache que tu peux 
  demander un alias qui te donne une autre adresse de ton choix.
  </p>
  {else}
  <p>
  Ton adresse sera :<br/>
  <strong>{$mailorg}@polytechnique.org</strong>
  </p>
  {/if}
  
  <p>
  Elle pointera sur les e-mails de ton choix, indique-s-en un pour commencer
  (tu pourras indiquer les autres une fois l'inscription termin�e).
  Attention, il doit <strong>imp�rativement �tre correct</strong> pour que nous puissions 
  te recontacter.
  </p>
  <table class="bicol" cellpadding="3" cellspacing="0" summary="Pr�inscription">
    <tr>
      <th colspan="2">
        Contact et s�curit�
      </th>
    </tr>
    <tr>
      <td class="titre">
        E-mail<br />
        <span class="smaller">(Premier forward)</span>
      </td>
      <td>
        <input type="text" size="35" maxlength="50" name="email" value="{$smarty.request.email}" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Date de naissance<br />
        <span class="smaller">(Format JJMMAAAA)</span>
      </td>
      <td>
        <input type="text" size="8" maxlength="8" name="naissance"  value="{$smarty.request.naissance}" />
        (demand�e si perte de mot de passe)
      </td>
    </tr>
    <tr>
      <th colspan="2">
        Fiche personnelle
      </th>
    </tr>
    <tr>
      <td class="titre">
        Identit�
      </td>
      <td>
        {$prenom} {$nom}, X{$smarty.request.promo}
      </td>
    </tr>
    <tr>
      <td class="titre">
        Nom de mariage
      </td>
      <td>
        Si ton nom de mariage est diff�rent de {$nom}, tu pourras le pr�ciser dans
        ton profil une fois que tu auras confirm� ton inscription.
      </td>
    </tr>
    <tr>
      <td class="titre">
        Nationalit�
      </td>
      <td>
        <select name="nationalite">
          {select_db_table table="nationalites" valeur=$smarty.request.nationalite}
        </select>
      </td>
    </tr>
    <tr>
      <td class="titre">
        Appli graduate
      </td>
      <td>
        <select name="appli_id1" onchange="fillType(this.form.appli_type1, this.selectedIndex-1);">
          {applis_options selected=$smarty.request.appli_id1}
        </select>
        <br />
        <select name="appli_type1">
          <option value=""></option>
        </select>
        <script type="text/javascript">
          <!--        
          fillType(document.infos.appli_type1, document.infos.appli_id1.selectedIndex-1);
          selectType(document.infos.appli_type1, '{$smarty.request.appli_type1}');
          //-->       
        </script>
      </td>
    </tr>
    <tr>
      <td class="titre">
        Post-graduate
      </td>
      <td>
        <select name="appli_id2" onchange="fillType(this.form.appli_type2, this.selectedIndex-1);">
          {applis_options selected=$smarty.request.appli_id2}
        </select>
        <br />
        <select name="appli_type2">
          <option value=""></option>
        </select>
        <script type="text/javascript">
          <!--        
          fillType(document.infos.appli_type2, document.infos.appli_id2.selectedIndex-1);
          selectType(document.infos.appli_type2, '{$smarty.request.appli_type2}');
          //-->       
        </script>
      </td>
    </tr>
    <tr>
      <td colspan="2" class="center">
        <input type="hidden" value="OUI" name="charte" />
        <input type="hidden" value="{$smarty.request.nom}" name="nom" />
        <input type="hidden" value="{$smarty.request.prenom}" name="prenom" />
        <input type="hidden" value="{$smarty.request.promo}" name="promo" />
        <input type="hidden" value="{$smarty.request.matricule}" name="matricule" />
        <input type="submit" value="Terminer la pr�-inscription" name="submit" />
      </td>
    </tr>
  </table>
</form>

{/dynamic}

{* vim:set et sw=2 sts=2 sws=2: *}
