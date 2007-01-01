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

{include file=search/quick.form.tpl show_js=1}
<h1>Comment faire une recherche ?</h1>

<h2>Nom, Prenom, Promo ...</h2>

<p>
La ligne de recherche ci-dessus accepte non seulement des m�langes de <strong>noms</strong> et de <strong>pr�noms</strong> ...
mais elle accepte de plus la syntaxe suivante pour les <strong>promos</strong> :
</p>
<ul>
  <li><code>1990</code> : signifie appartient � la promo 1990</li>
  <li><code>1990-2000</code> : signifie sur la promo 1990 � 2000</li>
  <li><code>&lt;1990</code> : signifie promos inf�rieures ou �gales � 1990</li>
  <li><code>&gt;1990</code> : signifie promos sup�rieures ou �gales � 1990</li>
</ul>
<p>
Ainsi, rechercher tous les "Dupont" sur les promos 1980 � 1990 et sur la promo 2000 se fait avec la recherche :
<code>Dupont 1980-1990 2000</code>
</p>

<h2>Astuce pour les noms ...</h2>
<p>
Parfois on ne sait plus si le nom qu'on recherche s'�crit � Lenormand �, � Le Normand � ou � Le-Normand � ...
</p>
<p>
Pour �viter ce genre d'�cueils, il suffit de chercher : <code>Le Normand</code><br />
En effet, le moteur de recherche va alors chercher tous les utilisateurs dont le nom contient 'Le' <strong>et</strong> 'Normand'
sans distinction de casse et sans tenir compte des accents.
</p>

{if $smarty.session.auth ge AUTH_COOKIE}
<h2>Barre de recherche pour Firefox</h2>
<script type="text/javascript">
{literal}
function addEngine() {
  if ((typeof window.sidebar == "object") && (typeof window.sidebar.addSearchEngine == "function")) {
   {/literal}
    window.sidebar.addSearchEngine(
      "{$baseurl|replace:"https":"http"}/xorg.src",
      "{$baseurl|replace:"https":"http"}/images/xorg.png",
      "Recherche rapide X.org",
      "Academic");
  {literal}
  } else { alert("Impossible d'installer la barre de recherche Firefox"); }
}
{/literal}
</script>
<p>Tu peux <a href="javascript:addEngine()">installer</a> la barre de recherche rapide directement dans ton navigateur.
</p>
{/if}

<h2>Polytechniciens des promotions 1919 et pr�c�dentes</h2>
<p>Notre base de donn�es ne contient que les polytechniciens depuis la promotion 1920. Pour effectuer des recherches dans les
promotions pr�c�dentes, il faut utiliser l'<a href="http://biblio.polytechnique.fr/F/">annuaire en ligne de la biblioth�que de
l'�cole</a>.</p>

{* vim:set et sw=2 sts=2 sws=2: *}
