<?
/*** Validation des offres d'emploi ***/

function from_mail_valid_emploi() {
    global $globals ;
    return "Equipe Polytechnique.org <".$globals->addr_mail_valid_emploi.">" ; 
}

function subject_mail_valid_emploi ($nomEntreprise) {
    global $globals ;
    return "[Polytechnique.org/EMPLOI] Annonce emploi : ".$nomEntreprise ;
}

function cc_mail_valid_emploi() {
    global $globals ;
    return $globals->addr_mail_valid_emploi ;
}

function msg_valid_emploi_OK ($titre) {
    $msg =  "Bonjour,\n".
            "\n".
            "L'annonce << {$titre} >> ".
            "a �t� accept�e par les mod�rateurs. Elle appara�tra ".
            "dans le forum emploi du site\n\n".
            "Nous vous remercions d'avoir propos� cette annonce.\n";
            "\n".
            "Cordialement,\n".
            "L'�quipe X.org" ;
    return $msg ;
}

function msg_valid_emploi_NON ($titre) {
    $msg =  "Bonjour,\n".
            "\n".
            "L'annonce << {$titre} >> ".
            "a �t� refus�e par les mod�rateurs.\n".
            "\n".
            "Cordialement,\n".
            "L'�quipe X.org" ;
    return $msg ;
}

function from_post_emploi() {
    global $globals ;
    return "Annonce recrutement <".$globals->addr_mail_recrutement.">" ;
}

function to_post_emploi() {
    return "xorg.pa.emploi" ;
}

function subject_post_emploi( $annonceEmploi ) {
    return "[OFFRE PUBLIQUE] ".$annonceEmploi->entreprise." : ".$annonceEmploi->titre ;
}

function msg_post_emploi( $annonceEmploi ) {
    return  $annonceEmploi->text.
            "\n\n\n".
            "#############################################################################\n".
            " Ce forum n'est pas accessible � l'entreprise qui a propos�  cette  annonce.\n".
            " Pour  y  r�pondre,  utilise  les  coordonn�es  mentionn�es  dans  l'annonce\n".
            " elle-m�me.\n".
            "#############################################################################\n" ;
}

function from_post_emploi_test() {
    global $globals ;
    return "Tests annonces recrutement <".$globals->addr_mail_supprt.">" ;
}

function to_post_emploi_test() {
    return "xorg.test" ;
}

function subject_post_emploi_test( $annonceEmploi) {
    return "[TEST PUBLIC] ".$annonceEmploi->entreprise." : ".$annonceEmploi->titre ;
}


?>
