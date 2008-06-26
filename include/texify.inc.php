<?php
/***************************************************************************
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
 ***************************************************************************/

/*
 * Fonctions de g�n�rations de tex pour les pages de .org
 * Auteur original : Pierre HABOUZIT
 */

/** Fonction qui g�re les pdflatexisations :)
 * Compile le code latex en pdf et le propose � l'upload
 * @param   $texte  le texte � texifier
 */
function tex_to_pdf($texte) {
    global $pdf_tmp_dir;
    set_time_limit(300); // timeout de 5 minutes au cas o� le texte serait gros
                         // et pdflatex lent
    $pdf_tmp_dir=('/tmp/mescontacts_'.Session::get('forlife'));
    // fonction pour effacer le rep temporaire
    function clean_tmp_dir() {
        global $pdf_tmp_dir;
        system("rm -rf $pdf_tmp_dir");
    }
    // n�toyage du repertoire avant tout
    clean_tmp_dir();

    // programme le n�toyage du r�pertoire � la fin du script
    // utile pour faire le n�toyage m�me en cas de fermeture pr�matur�e
    // de la connexion par le client
    register_shutdown_function("clean_tmp_dir");
    
    mkdir($pdf_tmp_dir, 0777);
    
    $texf = fopen("$pdf_tmp_dir/contacts.tex", "w");
    fwrite($texf, $texte);
    fclose($texf);
    system("cd $pdf_tmp_dir; pdflatex --interaction nonstopmode contacts.tex &>/dev/null");

    // sortie en PDF
    header("Pragma: ");
    header("Cache-Control: ");
    header("Content-type: application/pdf");
    // force le nom du fichier final 
#    header("Content-Disposition: attachment; filename=mes_contacts.pdf");

    readfile("$pdf_tmp_dir/contacts.pdf", "r");
    
    // le n�toyage du r�pertoire est fait par la fonction clean_tmp_dir
    // ex�cut�e � la fin du script gr�ce � register_shutdown_function.
}

/** Hearders LaTeX pour la feuille de contacts
 * @return en t�tes tex pour la feuille de contacts (imprimercontacts.php)
 */
function contacts_headers() {
    return "\\documentclass[twocolumn,a4paper,10pt,oneside]{article}\n"
	.  "\\usepackage[francais]{babel}\n"
	.  "\\usepackage[latin9]{inputenc}\n"
	.  "\\usepackage[T1]{fontenc}\n"
	.  "\\addtolength{\\hoffset}{-1.5cm} \\addtolength{\\textwidth}{3cm}\n"
	.  "\\addtolength{\\voffset}{-2cm} \\addtolength{\\textheight}{4cm}\n"
	.  "\\usepackage{tabularx,float}\n"
	.  "\n"
	.  "\\makeatletter\n"
	.  "\\renewcommand{\\@oddhead}{\\small\\hfill "
		." {\\bf\\Large Mes contacts sur Polytechnique.org\$^\\ast\$}"
	.  "\\renewcommand{\\@evenhead}{\\@oddhead}\n"
		." \\hfill}\n"
	.  "\\renewcommand{\\@oddfoot}{\\small\\hfill "
		." {\\bf \$^\\ast\$ Informations limit�es � un usage strictement personnel et non commercial}"
		." \\hfill}\n"
	.  "\\renewcommand{\\@evenfoot}{\\@oddfoot}\n"
	.  "\\makeatother\n"
	.  "\\newcolumntype{L}{@{\\hspace{1pt}}>{\\small\\sffamily\\bfseries}l}\n"
	.  "\\newcolumntype{T}{>{\\center\\bfseries}p{\\linewidth}}\n"
	.  "\\renewcommand{\\tabularxcolumn}[1]{>{\\small\\raggedright\\arraybackslash}p{#1}@{\\hspace{1pt}}}\n"
	.  "\n"
	.  "\\begin{document}\n"
	.  "\t\\floatstyle{plain}\n"
	.  "\t\\newfloat{contact}{thp}{lop}\n"
	.  "\t\\floatname{contact}{}\n"
	.  "\n";
}

/** Footers LaTeX pour la feuille de contacts
 * @return pied de page tex pour la feuille de contacts (imprimercontacts.php)
 */
function contacts_footer() {
    return "\n" . "\\end{document}\n";
}

/** pr�fixe de tableau de contact
 * @return Pr�fixe de construction d'une fiche. Contient l'en t�te avec le nom.
 * @param   $prenom pr�nom du contact
 * @param   $nom    nom du contact
 * @param   $epouse nom d'�pouse
 * @param   $promo  promo
 * @param   $maj    date de derni�re mise � jour de la fiche
 */
function contact_tbl_hdr($prenom, $nom, $epouse, $promo, $maj) {
    return "\t\\noindent\\parbox{\\linewidth}{\n"
	.  "\t\t\\begin{tabularx}{\\linewidth}{LX}\n"
	.  "\t\t\t\\multicolumn{2}{@{}T@{}}{\\noindent\\rule{\\linewidth}{1pt}\n\n"
	    . "\\vspace{-2pt}$prenom $nom" . ($epouse ? " �pouse $epouse" : "") . " ($promo) {\small $maj}}\\\\\n"
	.  "\t\t\t\\hline\n";
}

/** suffixe de tableau de contact
 * @return suffixe de construction d'une fiche.
 */
function contact_tbl_ftr() {
    return "\t\t\\end{tabularx}\n"
	.  "\t}\n"
	.  "\t\\vspace{-1.5em}\n\n";
}

/** Fonction qui remplace les caract�res particuliers
 * remplace les # par \# par exemple
 * @param   $texte  le texte � stripper
 * @return  le texte modifi�
 */
function tex_strip($texte) {
    $tmp = str_replace("\\", "$\\backslash$", $texte);
    $tmp = str_replace("#", "\\#", $tmp);
    $tmp = str_replace("$", "\\$", $tmp);
    $tmp = str_replace("\\$\\backslash\\$", "$\\backslash$", $texte);
    $tmp = str_replace("%", "\\%", $tmp);
    $tmp = str_replace("&", "\\&", $tmp);
    $tmp = str_replace("_", "\\_", $tmp);
    $tmp = str_replace("^", "\\^{}", $tmp);
    return $tmp;
}

/** G�n�ration d'un nouvel item
 * @return code TeX pour la cr�ation d'un nouveau titre de ligne de tableau
 * @param  $itemname label de la nouvelle ligne
 */
function contact_tbl_item($itemname) {
    return "\t\t\t" . tex_strip($itemname) . "\n";
}

/** G�n�ration d'un contenu
 * @return code TeX pour l'insertion d'une nouvelle ligne de contenu.
 * @param  $text le-dit contenu, chaque '\n' est r�interpr�t�.
 */
function contact_tbl_row($text) {
    $temp = split("\n",tex_strip($text));
    return "\t\t\t\t&"
	.  join("\\\\\n\t\t\t&", $temp)
	.  "\\\\\n";
}

/** G�n�ration d'un item + contenu
 * @return code TeX pour l'insertion d'une nouvelle ligne.
 * @param  $itemname label de la nouvelle ligne
 * @param  $text le-dit contenu, chaque '\n' est r�interpr�t�.
 */
function contact_tbl_entry($itemname, $text) {
    $temp = split("\n",tex_strip($text));
    return "\t\t\t" . tex_strip($itemname) . "\n"
	.  "\t\t\t\t&"
	.  join("\\\\\n\t\t\t&", $temp)
	.  "\\\\\n";
}

?>
