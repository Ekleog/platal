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

{include file="listes/header_listes.tpl"}

<h1>
  Propri�t�s du mail en attente
</h1>

<table class='tinybicol' cellpadding='0' cellspacing='0'>
  <tr>
    <td class='titre'>�metteur</td>
    <td>{mailto address=$mail.sender}</td>
  </tr>
  <tr>
    <td class='titre'>sujet</td>
    <td>{$mail.subj|hdc}</td>
  </tr>
  <tr>
    <td class='titre'>taille</td>
    <td>{$mail.size} octets</td>
  </tr>
  <tr>
    <td class='titre'>date</td>
    <td>{$mail.stamp|date_format:"%X le %x"}</td>
  </tr>
</table>

<h1>
  Contenu du mail en attente
</h1>

{if $mail.parts_plain|@count}
<table class='bicol' cellpadding='0' cellspacing='0'>
  {foreach from=$mail.parts_plain item=part key=i}
  <tr><th>Partie n�{$i}</th></tr>
  <tr class='{cycle values="impair,pair"}'>
    <td><tt>{$part|qpd|nl2br}</tt></td>
  </tr>
  {/foreach}
</table>
<br />
{/if}

{if $mail.parts_html|@count}
<table class='bicol' cellpadding='0' cellspacing='0'>
  {foreach from=$mail.parts_html item=part key=i}
  <tr><th>Partie n�{$i} (Le texte original est format� en HTML)</th></tr>
  <tr class='{cycle values="impair,pair"}'>
    <td><tt>{$part|qpd|clean_html|nl2br}</tt></td>
  </tr>
  {/foreach}
</table>
<br />
{/if}

<form method='post' action='{$platal->pl_self(1)}'>
  <table class='tinybicol' cellpadding='0' cellspacing='0'>
    <tr>
      <th class='titre'>Mod�rer le mail</th>
    </tr>
    <tr>
      <td>raison (pour les refus) :
        <textarea cols='50' rows='10' name='reason' id='raison'>
-- 
{$smarty.session.prenom} {$smarty.session.nom} (X{$smarty.session.promo})
</textarea>
      </td>
    </tr>
    <tr>
      <td class='center'>
        <input type='hidden' name='mid' value='{$smarty.get.mid}' />
        <input type='submit' name='mok' value='Accepter !'
          onclick="return confirm('Es-tu s�r de vouloir Envoyer ce mail sur la liste ?')"/>&nbsp;
        <input type='submit' name='mno' value='Refuser !' 
          onclick="return confirm('Es-tu s�r de vouloir Refuser ce mail ?')"/>&nbsp;
        <input type='submit' name='mdel' value='D�truire !' style='color:red;'
          onclick="return confirm('Es-tu s�r de vouloir D�truire ce mail ?')"/>
      </td>
    </tr>
  </table>
  <ul>
    <li>� Refuser � rejette le mail avec un message � son auteur (celui que tu tapes dans le cadre)</li>
    <li>
    D�truire efface le mail sans autre forme de proc�s, et c'est � utiliser UNIQUEMENT pour les
    virus et les courriers ind�sirables
    </li>
  </ul>
</form>
<p>
En cas de refus, le mail envoy� � l'auteur du mail que tu mod�res actuellement sera de la forme suivante :
</p>
<pre>{$msg}</pre>


{* vim:set et sw=2 sts=2 sws=2: *}
