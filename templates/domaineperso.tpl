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
        $Id: domaineperso.tpl,v 1.4 2004-08-31 11:25:38 x2000habouzit Exp $
 ***************************************************************************}


{include file='include/liste_domaines.tpl' result=$result nb_dom=$nbdom domaines=$domaines}

<div class="rubrique">
  G�re les emails de ton domaine perso
</div>

<p>
 Polytechnique.org te propose de g�rer les emails de ton domaine personnel.
</p>
<p>
  Effet, si tu disposes d'un domaine personnel comme ton-nom.org, tu dois utiliser un h�bergeur pour ta 
  DNS, pour tes adresses emails et pour ton espace web. En g�n�ral, c'est le m�me pour 
  les trois �l�ments, mais tu peux aussi utiliser des h�bergeurs diff�rents. Il en 
  existe certains qui sont gratuits (comme <a href="http://www.mydomain.com/">
  Mydomain</a>), mais pas toujours tr�s performants. Polytechnique.org te propose de 
  s'occuper de tes emails dans un premier temps.
</p>
<p>
  Pour que ton domaine soit g�r� par Polytechnique.org, active d'abord le domaine dans 
  le formulaire ci-dessous. Le domaine appara�t alors en haut de cette page, places-y 
  les alias que tu d�sires.
</p>
<p>
  Ensuite, configure ton serveur DNS pour que le champ MX de ton domaine soit 
  a.mx.polytechnique.org (ou a.mx.m4x.org pour �tre plus discret
  mais pas les deux, c'est la m�me machine).
</p>
<p>
  Laisse le temps � la DNS de se mettre � jour (24 � 48h), et le tour est jou�.
</p>
<p>
  Pour toute question, n'hesite pas � {mailto address='info@polytechnique.org' text='envoyer un mail' encode='javascript'}
</p>
<div class="ssrubrique">
  Indique le domaine que tu souhaites g�rer :
</div>
<form action="{$smarty.server.REQUEST_URI}" method="post">
  <table class="bicol" cellpadding="3" summary="Saisie du domaine � g�rer">
    <tr>
      <th colspan="2">
        Nom de domaine � g�rer
      </th>
    </tr>
    <tr>
      <td class="titre">
        Nom :
      </td>
      <td>
	<input type="text" name="dnom" value="" />
      </td>
    </tr>
    <tr>
      <td colspan="2" class="center">
	<input type="submit" name="submit" value="Envoyer" />
      </td>
    </tr>
  </table>
</form>
{* vim:set et sw=2 sts=2 sws=2: *}
