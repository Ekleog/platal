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

{include wiki=Xorg.Antispam part=1}

{javascript name=ajax}
<script type="text/javascript">//<![CDATA[
  {literal}
  function bogoUpdated()
  {
    showTempMessage('bogo-msg', "Le changement de réglage de l'antispam a bien été effectué.", true);
  }
  {/literal}
</script>
  <fieldset>
    <legend><strong>Choisis ton propre réglage&nbsp;:</strong></legend>
    <input id='s0' type='radio' name='statut_filtre' value='0' {if $filtre eq 0}checked="checked"{/if} onclick="Ajax.update_html(null, '{$globals->baseurl}/emails/antispam/'+this.value, bogoUpdated)" />
    <label for='s0'>(1) le filtre anti-spam n'agit pas sur tes emails</label>
    <br />
    <input id='s1' type='radio' name='statut_filtre' value='1' {if $filtre eq 1}checked="checked"{/if} onclick="Ajax.update_html(null, '{$globals->baseurl}/emails/antispam/'+this.value, bogoUpdated)" />
    <label for='s1'>(2) le filtre anti-spam marque les emails</label>
    <br />
    <input id='s2' type='radio' name='statut_filtre' value='2' {if $filtre eq 2}checked="checked"{/if} onclick="Ajax.update_html(null, '{$globals->baseurl}/emails/antispam/'+this.value, bogoUpdated)" />
    <label for='s2'>(3) le filtre anti-spam marque les emails, et élimine les spams avec des notes les plus hautes</label>
    <br />
    <input id='s3' type='radio' name='statut_filtre' value='3' {if $filtre eq 3}checked="checked"{/if} onclick="Ajax.update_html(null, '{$globals->baseurl}/emails/antispam/'+this.value, bogoUpdated)" />
    <label for='s3'>(4) le filtre anti-spam élimine les emails détectés comme spams</label>
  </fieldset>

  <div id="bogo-msg" style="position:absolute;"></div><br />

{include wiki=Xorg.Antispam part=2}

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}