<?
/*** Validation des offres d'emploi ***/

function msg_valid_emploi_NON ($titre) {
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
