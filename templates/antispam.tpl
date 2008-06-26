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
 ***************************************************************************}


<h1>Ton filtre anti-spam</h1>

<h2>Qu'est-ce qu'un spam ? Comment m'en d�barrasser ?</h2>
<p>
Un spam est un courrier �lectronique <strong>non sollicit�</strong>. Ce peut-�tre un
message de publicit�, une proposition commerciale, etc... qui t'est envoy�
par une personne que tu ne connais pas.<br />
Notre logiciel antispam tente de d�terminer, parmi les courriers �lectroniques
que tu re�ois, lesquels sont des spams, et lesquels n'en sont pas.
Trois r�glages sont possibles :
</p>
<ul>
  <li>soit le logiciel est coup� et <strong>ne filtre pas du tout</strong> tes courriels,</li>
  <li>soit les spams d�tect�s portent la mention [spam probable] dans leur
  objet, afin que tu puisses les <strong>identifier plus facilement</strong>,
  </li>
  <li>soit nous <strong>supprimons les courriels</strong> que tu re�ois dont notre
  logiciel pense que ce sont des spams.
  </li>
</ul>
<form action="{$smarty.server.PHP_SELF}" method="post">
  <table class="tinybicol" summary="filtre anti-spam">
    <tr>
      <td>
        <strong>Choisis ton propre r�glage :</strong><br />
        {dynamic}
        <input type='radio' name='statut_filtre' value='0' {if $filtre eq 0}checked="checked"{/if} />
        (1) le filtre anti-spam est coup�<br />
        <input type='radio' name='statut_filtre' value='1' {if $filtre eq 1}checked="checked"{/if} />
        (2) le filtre anti-spam est activ�, et marque les mails<br />
        <input type='radio' name='statut_filtre' value='2' {if $filtre eq 2}checked="checked"{/if} />
        (3) le filtre anti-spam est activ�, et �limine les mails d�tect�s comme spams<br />
        {/dynamic}
      </td>
    </tr>
    <tr>
      <td class="center">
        <input type="submit" name="filtre" value="Valider le filtre anti-spam" />
      </td>
    </tr>
  </table>
</form>

<p>
Evidement, <strong>le syst�me n'�tant pas infaillible, il est possible qu'un
  message normal soit class� comme spam</strong>, auquel cas, si tu as choisi
l'option (3), tu perdras un message que tu aurais sans doute souhait�
recevoir.
Aussi, <em>nous te conseillons, au moins dans un premier temps, d'utiliser
  l'option (2)</em>, qui elle n'efface aucun message, et te donne juste une
indication visuelle des messages qui semblent �tre des spams.
<br />
Si apr�s quelques temps d'utilisation de l'option (2), tu en es satisfait,
tu peux envisager d'opter pour l'option (3).
</p>

<h2>Que faire si jamais je me rends compte que le filtre s'est tromp� ?</h2>
<p>
Pour que le logiciel fonctionne bien, il est pr�f�rable de lui indiquer,
lorsqu'il s'est tromp�, qu'il a fait une erreur ! Il est plut�t intelligent,
et en tirera une le�on si on lui signale ses fautes, pour moins se tromper
par la suite. L'aide de tous est donc la bienvenue.<br />
Si un courriel qui est un spam n'est pas d�tect� comme tel, r�exp�die-le
� l'adresse <a href="mailto:spam@polytechnique.org">spam@polytechnique.org</a>
<strong>sous forme de pi�ce jointe</strong>.<br />
Inversement, si un message est consid�r� comme un spam alors que ce n'en est
pas un, il faut le r�exp�dier � l'adresse
<a href="mailto:nonspam@polytechnique.org">nonspam@polytechnique.org</a>
<strong>sous forme de pi�ce jointe</strong>.
Ainsi notre base de donn�es de spams restera � jour, et, alors
que les spammers enverront des spams de plus en plus durs � d�tecter,
tous nos camarades b�n�ficieront d'un filtre anti-spam de meilleure qualit�.
</p>
<h3 style="text-decoration: underline">Plus tu nous enverras tes spams, moins tu en recevras !!!</h3>

<h2>Et techniquement, comment �a marche ?</h2>
<p>
Le filtre anti-spam tente de rep�rer les spams en fonction des mots
qu'il contiennent, il extrait donc les mots d'un message et les comparer
� deux ensembles de r�f�rence l'un contenant des spams, l'autre des
messages normaux. Il calcule ainsi une probabilit� qu'un message soit
un spam et si cette probabilit� est forte, ce courriel est consid�r� comme
un spam.
</p>
<p>
Le marquage est fait de deux mani�res :
</p>
<ul>
  <li>la cha�ne "[spam probable]" est ajout�e au d�but du sujet pour permettre une reconnaissance visuelle facile des spams,</li>
  <li>un en-t�te "X-Spam-Flag: YES" est ajout� au message pour permettre l'ajout d'un filtre dans ton lecteur de mail pour trier le spam dans une bo�te ind�pendante, ce qui facilite la v�rification que les spams marqu�s sont bien des spams.</li>
</ul>

{* vim:set et sw=2 sts=2 sws=2: *}
