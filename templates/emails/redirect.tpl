{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2010 Polytechnique.org                             *}
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
    Tes adresses de redirection
  </h1>
  <p>
  Tu configures ici les adresses emails vers lesquelles tes adresses (listées ci-dessous) sont redirigées&nbsp;:
  </p>
  <ul>
    {if $melix}
    <li>
    <strong>{$melix}@{#globals.mail.alias_dom#}</strong>,
    <strong>{$melix}@{#globals.mail.alias_dom2#}</strong>
    </li>
    {/if}
    {foreach from=$alias item=a}
    <li>
    <strong>{$a.alias}@{#globals.mail.domain#}</strong>
    {if $a.expire}<span class='erreur'>(expire le {$a.expire|date_format})</span>{/if}
    </li>
    {/foreach}
  </ul>
  <p>
    Le routage est en place pour les adresses dont la case "<strong>Actif</strong>" est cochée.
    Si tu modifies souvent ton routage, tu as tout intérêt à rentrer toutes les
    adresses qui sont susceptibles de recevoir ton routage, de sorte qu'en
    jouant avec les cases "<strong>Actif</strong>" tu pourras facilement mettre en place les unes
    ou bien les autres.
  </p>
  <p>
    Enfin, la <strong>réécriture</strong> consiste à substituer à ton adresse email habituelle
    (adresse gmail, orange, free&hellip;) ton adresse {#globals.mail.domain#} ou
    {#globals.mail.domain2#} dans l'adresse d'expédition de tes messages, lorsqu'un email
    passe par nos serveurs. Ceci arrive lorsque tu écris à un camarade sur son adresse {#globals.mail.domain#} ou
    {#globals.mail.domain2#}, ou lorsque tu utilises notre
    <a href="Xorg/SMTPSecurise">service d'envoi d'email SMTP sécurisé</a>.
  </p>

  <script type="text/javascript">//<![CDATA[
    {literal}
    function activeEnable()
    {
      var remove = $(".active_email:checked");
      if (remove.length <= 1) {
        remove.attr("disabled", "disabled");
        remove.parent('td').parent('tr').children('td').children('.remove_email').hide();
      } else {
        remove.removeAttr("disabled");
        $('.remove_email').show();
      }
    }

    function redirectUpdate()
    {
        $('#redirect-msg').tmpMessage("Tes redirections ont été mises à jour.", true);
        activeEnable();
    }

    function removeRedirect(link, email)
    {
        if (confirm("Supprimer l'adresse " + email + " ?")) {
          $.get(link.href, {},function() {
            $('#line_' + email.replace('@', '_at_').replace('.','\\.')).remove();
            showRemove();
            activeEnable();
          });
        }
        return false;
    }

    function showRemove()
    {
        var removeLinks = $('.remove_email');
        if (removeLinks.length == 1) {
            removeLinks.hide();
        } else {
            removeLinks.show();
        }
    }

    function updateRedirect(checked, email)
    {
        activeEnable();
        $.xget('emails/redirect/' + (checked ? '' : 'in') + 'active/' + email,
               'text', redirectUpdate);
    }

    function rewriteUpdate(mail, allow, box)
    {
        return function() {
                  if (!allow) {
                      if (box.value != '') {
                          alert("Un mail de validation vient d'être envoyé sur " + mail
                               + ". La réécriture ne sera active que lorsque tu auras cliqué sur le lien indiqué dans ce mail.");
                      }
                  }
                  redirectUpdate();
              };
    }

    {/literal}
  //]]></script>
  {test_email}
  <div id="redirect-msg" style="position:absolute;"></div><br />
  <div class="center">
    <form action="emails/redirect" method="post">
    <table class="bicol" summary="Adresses de redirection">
      <tr>
        <th>Redirection</th>
        <th>Actif</th>
        <th>Réécriture</th>
        <th>&nbsp;</th>
      </tr>
      {foreach from=$emails item=e name=redirect}
      <tr class="{cycle values="pair,impair"}" id="line_{$e->email|replace:'@':'_at_'}">
        <td>
          <strong>
            {if $e->broken}<span class="erreur">{assign var="erreur" value="1"}{/if}
            {if $e->panne neq '0000-00-00'}{assign var="panne" value="1"}{icon name=error title="En panne"}{/if}
            {$e->display_email}
            {if $e->broken}</span>{/if}
          </strong>
        </td>
        <td>
          <input type="checkbox" value="{$e->email}" {if $e->sufficient}class="active_email"{/if}
                 {if $e->active}checked="checked"{/if}
                 {if $smarty.foreach.redirect.total eq 1}disabled="disabled"{/if}
                 onchange="updateRedirect(this.checked, '{$e->email}')" /></td>
        <td style="text-align: left">
          {if $e->has_rewrite()}
          <select onchange="$.get('emails/redirect/rewrite/{$e->email}/'+this.value, 'text',  rewriteUpdate('{$e->email}', {$e->allow_rewrite|default:"0"}, this)); return false">
            <option value=''>--- aucune ---</option>
            {assign var=dom1 value=#globals.mail.domain#}
            {assign var=dom2 value=#globals.mail.domain2#}
            {foreach from=$alias item=a}
            <option {if $e->rewrite eq "`$a.alias`@`$dom1`"}selected='selected'{/if}
              value='{$a.alias}@{#globals.mail.domain#}'>{$a.alias}@{#globals.mail.domain#}</option>
            <option {if $e->rewrite eq "`$a.alias`@`$dom2`"}selected='selected'{/if}
              value='{$a.alias}@{#globals.mail.domain2#}'>{$a.alias}@{#globals.mail.domain2#}</option>
            {/foreach}
          </select>
          {if $e->rewrite neq '' && !$e->allow_rewrite}{icon name="error" title="en attente de validation"}{/if}
          {else}
          <em>pas de réécriture</em>
          {/if}
        </td>
        <td>
          {if $e->is_removable()}
          <a href="emails/redirect/remove/{$e->email}"
             class="remove_email"
             onclick="return removeRedirect(this, &quot;{$e->email}&quot;);" >
            {icon name=cross title="Supprimer"}
          </a>
          {else}
          {if $e->sufficient}<span class="remove_email"><span style="display:none">&nbsp;</span></span>{/if}
          <a href="emails/redirect#{$e->email}">{icon name=information title="Plus d'informations"}</a>
          {/if}
        </td>
      </tr>
      {/foreach}
        {cycle values="pair,impair" assign=class_combobox}
        {$error_email}
        {include file="include/emails.combobox.tpl" name="email" val=$email class=$class_combobox error=$error_email i="0"}
        <tr class="{$class_combobox}"><td colspan="4"><div>
          <input type="submit" value="ajouter" name="emailop" />
          {xsrf_token_field}
        </div></td></tr>
    </table>
    </form>
    <script type="text/javascript">showRemove(); activeEnable();</script>
  </div>
<p class="smaller center">
  Légende&nbsp;: {icon name=cross title="Supprimer"} Supprimer la redirection
  - {icon name=information title="Plus d'informations"} Plus d'informations
</p>
{if $panne}
<p class="smaller">
  <strong>
    {icon name=error title="En panne"}
    <a href="Xorg/Pannes">Panne&nbsp;:</a>
  </strong>
  les adresses marquées de cette icône sont des adresses de redirection pour lesquelles une panne
  a été détectée. Si le problème persiste, la redirection vers ces adresses sera désactivée.
</p>
{/if}
{if $erreur}
<p class="smaller">
  <strong>
    {icon name=error title="En panne"}
    <a href="Xorg/Pannes" style="color: #f00">Panne durable&nbsp;:</a>
  </strong>
  les adresses en rouge sont des adresses qui ont été désactivées en raison d'un grand nombre de pannes. Si tu penses que
  le problème est résolu, tu peux les réactiver, mais l'adresse sera redésactivée si les problèmes persistent.
</p>
{/if}
{if $smarty.session.mx_failures|@count}
<fieldset>
  <legend>{icon name=error} Des problèmes sont actuellement recontrés sur tes redirections suivantes</legend>
  {foreach from=$smarty.session.mx_failures item=mail}
  <div>
    <span class="erreur">{$mail.mail}</span>
    <div class="explication">{$mail.text}</div>
  </div>
  {/foreach}
</fieldset>
{/if}

{if #globals.mailstorage.googleapps_active# or #globals.mailstorage.imap_active# or hasPerm('admin') or $googleapps}
<h1>Tes comptes de stockage d'emails</h1>
{/if}
{if #globals.mailstorage.imap_active# or hasPerm('admin')}
<p id="imap">
  Polytechnique.org te propose de conserver les emails que tu reçois, pendant une durée limitée (environ 30 jours).
  Grâce à ce service, tu disposes d'une sauvegarde de tes emails en secours, au cas où, par exemple, tu effacerais
  un email par erreur.<br />
  <strong>Attention&nbsp;:</strong> il ne s'agit que d'un service de secours, dont la disponibilité n'est pas garantie.
</p>

<table class="bicol" summary="Compte de stockage">
  <col width="55%" />
  <col width="45%" />
  <tr>
    <th colspan="2">Compte de stockage</th>
  </tr>
  <tr class="pair">
    <td>
      <a href="Xorg/IMAP">
        <strong>Accès de secours aux emails (IMAP)</strong>
      </a><br />Hébergé par Polytechnique.org
    </td>
    <td style="text-align: center; vertical-align: middle">
      <a href="emails/redirect#line_imap">Voir l'état de la redirection vers l'IMAP</a>
    </td>
  </tr>
</table>
{/if}

{if #globals.mailstorage.googleapps_active# or hasPerm('admin') or $googleapps}
<br />
<p id="googleapps">
  Grâce à un partenariat avec Google, Polytechnique.org te propose également un compte
  <b>Google Apps</b>, qui te permet de disposer des services Google (GMail pour
  tes emails, Google Calendar, Google Docs&hellip;) sur une adresse polytechnique.org.
</p>

<table class="bicol" summary="Compte de stockage">
  <col width="55%" />
  <col width="45%" />
  <tr>
    <th colspan="2">Compte de stockage</th>
  </tr>
  <tr class="pair">
    {if $googleapps eq 'active'}
    <td>
      <a href="googleapps">
        <strong>Compte Google Apps / Polytechnique.org</strong>
      </a><br />Hébergé par Google
    </td>
    <td style="text-align: center; vertical-align: middle">
      Ton compte Google Apps est actif.<br />
      <a href="emails/redirect#line_googleapps">Voir l'état de la redirection vers GMail</a>
    </td>
    {else}
    <td colspan="2">
      {if $googleapps eq 'disabled'}
      Ton compte Google Apps est actuellement inactif.<br />
      {else}
      Tu n'as pas encore de compte Google Apps pour Polytechnique.org.<br />
      {/if}
      <a href="googleapps">Plus d'informations &hellip;</a>
    </td>
    {/if}
  </tr>
</table>
{/if}

{if $eleve}
<h1>Pour les élèves (non encore diplômés)</h1>
<p>
  L'X te fournit aussi une adresse à vie en <strong>«prenom.nom»@polytechnique.edu</strong> qui par défaut est
  une redirection vers «login»@poly.polytechnique.fr. <a href="https://www.mail.polytechnique.edu/">
  Tu peux modifier cette redirection</a> et la faire pointer vers ton adresse
  {$user->forlifeEmail()} (attention, cela demande de la concentration).
</p>
<p>
  Si tu utilises le service POP de poly pour récupérer tes emails dans ton logiciel de courrier,
  l'équipe de Polytechnique.org te conseille de rediriger&nbsp;:
</p>
<ul>
  <li>«prenom.nom»@polytechnique.edu vers {$user->forlifeEmail()}&nbsp;;</li>
  <li>{$user->forlifeEmail()} vers «login»@poly.polytechnique.fr.</li>
</ul>
<p>
  Attention à ne pas faire une boucle quand tu manipules tes redirections&nbsp;! Tes emails seraient
  alors perdus, jusqu'à ce que tu règles le problème.
</p>
{/if}

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}
