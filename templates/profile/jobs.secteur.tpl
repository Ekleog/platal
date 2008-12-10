{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2008 Polytechnique.org                             *}
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

<?xml version="1.0" encoding="utf-8"?>
<select name="jobs[{$id}][ss_secteur]"
 {if ($change)}onchange="updateJobSousSecteur({$id}, '{$jobid}', '{$jobpref}', ''); return true;"{/if}>
  <option value=""></option>
  {iterate from=$ssecteurs item=ssecteur}
  {if $ssecteur.optgroup}
  {if $gp}
  </optgroup>
  {/if}
  <optgroup label="{$ssecteur.label}">
  {assign var=1 name=gp}
  {else}
  <option value="{$ssecteur.id}" {if $ssecteur.id eq $sel}selected="selected"{/if}>{$ssecteur.label}</option>
  {/if}
  {if $gp}
  </optgroup>
  {/if}
  {/iterate}
</select>

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}
