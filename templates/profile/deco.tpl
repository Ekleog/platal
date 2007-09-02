{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2007 Polytechnique.org                             *}
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


{literal}
<script type="text/javascript">//<![CDATA[
function update()
{
  var val = document.forms.prof_annu['medal_sel'].value;
  if (val == '' || document.getElementById('medal_' + val) != null) {
    document.getElementById('medal_add').display.style = 'none';
  } else {
    document.getElementById('medal_add').display.style = '';
  }
}

  var valid = new array();
  function medal_add()
  {
    var selid = document.forms.prof_annu.medal_sel.selectedIndex;
    document.forms.prof_annu.medal_id.value = document.forms.prof_annu.medal_sel.options[selid].value;
    document.forms.prof_annu.grade_id.value = document.forms.prof_annu.grade_sel.value;
    document.forms.prof_annu.medal_op.value = "ajouter";
    document.forms.prof_annu.submit();
  }

  function medal_del( id )
  {
    document.forms.prof_annu.medal_id.value = id;
    document.forms.prof_annu.medal_op.value = "retirer";
    document.forms.prof_annu.submit();
  }

  function medal_cancel(stamp)
  {
    document.forms.prof_annu.medal_id.value = stamp;
    document.forms.prof_annu.medal_op.value = "annuler";
    document.forms.prof_annu.submit();
  }
  var subgrades = new array();
  function getoption( select_input, j)
  {
    if (!document.all)
    {
      return select_input.options[j];
    }
    else
    {
      return j;
    }
  }
  function medal_grades( sel_medal )
  {
    var subg = subgrades[sel_medal.selectedIndex];
    document.getElementById("grade_sel_div").style.display = subg?"inline":"none";
    if (!subg) return;
    var select = document.getElementById("grade_sel");
    while (select.length > 1)
    {
      select.remove(1);
    }

    for (i=0; i < subg.length; i++)
    {
      var dmc = document.createElement("option");
      dmc.text= subg[i][1];
      dmc.value = subg[i][0];
      select.add(dmc,getoption(select,i));
    }
    var vide = document.createElement("option");
    vide.text = "";
    vide.value = 0;
    select.add(vide,getoption(select,0));
    select.remove(subg.length+1);
  }
  //]]>
{/literal}
{foreach from=$medal_list key=type item=list}
  {foreach from=$list item=m}{if $grades[$m.id]|@count}
    subgrades[{$m.id}] = new array({$grades[$m.id]|@count});
    i = 0;
    {foreach from=$grades[$m.id] item=g}
      subgrades[{$m.id}][i] = [{$g.gid},"{$g.text}"];
      i++;
    {/foreach}
  {/if}{/foreach}
{/foreach}

</script>

<table class="bicol">
  <tr>
    <th>
      Médailles, Décorations, Prix, ...
    </th>
  </tr>
  <tr>
    <td>
      <div class="flags">
        <div class="vert" style="float: left">
          <input type="checkbox" name="medals_pub"{if $medals_pub eq 'public'} checked="checked"{/if} />
        </div>
        <div class="texte">
          ces informations sont normalement publiques (JO, ...) mais tu peux choisir de les associer a ta fiche publique
        </div>
      </div>
      <div style="clear: both; margin-top: 0.2em">
        <select name="medal_sel" onchange="update()">
          <option value=''></option>
          {foreach from=$medal_list key=type item=list}
          <optgroup label="{$trad[$type]}...">
            {foreach from=$list item=m}
            <option value="{$m.id}">{$m.text}</option>
            {/foreach}
          </optgroup>
          {/foreach}
        </select>
        <span id="medal_add">
          <a href="javascript:add();">{icon name=add title="Ajouter cette médaille"}</a>
        </span>
      </div>
      {foreach from=$medals item=medal key=id}
      {include file="profile/deco.medal.tpl" medal=$medal id=$id}
      {/foreach}
    </td>
  </tr>
</table>

<script type="text/javascript">
update();
</script>

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}
