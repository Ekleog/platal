<?
/* Bandeau de publicit� sur la page de login */
$pub_nbLig = 2 ;
$pub_nbCol = 2 ;

// Liens apparaissant toujours
$pub_tjs = array(
    'password'   => 'Changer mon mot de passe' ,
    'Docs/Dons'  => 'Faire un don � l\'association Polytechnique.org'
    ) ;

// Liens apparaissant de fa�on al�atoire
$pub_rnd = array(
    'newsletter/show.php?nid=last'		    => 'Afficher la derni�re newsletter' ,
    'http://www.polytechnique.net'		    => 'Vers les autres sites polytechniciens' ,
    "trombipromo.php?xpromo={$_SESSION["promo"]}"   => "Voir le trombi de ma promo" ,
    'banana/'                                       => 'Un petit tour du c�t� des forums !!'
    ) ;
?>
