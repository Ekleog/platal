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


<h1>
{if $actif}Modification du mot de passe SMTP/NNTP{else}Activation de ton compte SMTP/NNTP{/if}  
</h1>

{literal}
<script type="text/javascript">
  <!--
  function CheckResponse() {
    pw1 = document.forms.smtppass_form.smtppass1.value;
    pw2 = document.forms.smtppass_form.smtppass2.value;
    if (pw1 != pw2) {
      alert ("\nErreur : les deux champs ne sont pas identiques !");
      exit;
      return false;
    }
    if (pw1.length < 6) {
      alert ("\nErreur : le nouveau mot de passe doit faire au moins 6 caract�res !");
      exit;
      return false;
    }
    document.forms.smtppass_form.op.value='Valider';
    document.forms.smtppass_form.submit();
    return true;
  }

  function SupprimerMdp() {
    document.forms.smtppass_form.op.value='Supprimer';
    document.forms.smtppass_form.submit();
  }
  // -->
</script>
{/literal}

<p>
  <a href="docs/doc_smtp.php">Pourquoi et comment</a> utiliser le serveur SMTP de Polytechnique.org. <br />
  <a href="docs/doc_nntp.php">Pourquoi et comment</a> utiliser le serveur NNTP de Polytechnique.org. <br />
</p>
<p>
{if $actif}
  Clique sur <strong>"Supprimer"</strong> si tu veux supprimer ton compte SMTP/NNTP.
{else}
  Pour activer un compte SMTP/NNTP sur <strong>ssl.polytechnique.org</strong>, tape un mot de passe ci-dessous.
{/if}
</p>
<form action="{$smarty.server.REQUEST_URI}" method="post" id="smtppass_form">
  <table class="tinybicol" cellpadding="3" summary="D�finition du mot de passe">
    <tr>
      <th colspan="2">
        D�finition du mot de passe
      </th>
    </tr>
    <tr>
      <td class="titre">
        Mot de passe :
      </td>
      <td>
        <input type="password" size="15" maxlength="15" name="smtppass1" />
      </td>
    </tr>
    <tr>
      <td class="titre">
        Retape-le une fois (pour v�rification):
      </td>
      <td>
        <input type="password" size="15" maxlength="15" name="smtppass2" />
      </td>
    </tr>
    <tr>
      <td colspan="2" class="center">
        <input type="hidden" name="op" value="" />
        <input type="submit" value="Valider" onclick="CheckResponse(); return false;" />
{if $actif}
        &nbsp;&nbsp;<input type="submit" value="Supprimer" onclick="SupprimerMdp();" />
{/if}
      </td>
    </tr>
  </table>
</form>
<p>
  Ce mot de passe peut �tre le m�me que celui d'acc�s au site. Il doit faire au
  moins <strong>6 caract�res</strong> quelconques. Attention au type de clavier que tu
  utilises (qwerty?) et aux majuscules/minuscules.
</p>

{* vim:set et sw=2 sts=2 sws=2: *}
