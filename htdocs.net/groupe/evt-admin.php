<?php
require 'xnet.inc.php';

define('NB_PER_PAGE', 25);

// check this event is from this asso
if (Env::get('eid')) {
	$res = $globals->xdb->query("SELECT eid FROM groupex.evenements WHERE eid = {?} AND asso_id = {?}", Env::get('eid'), $globals->asso('id'));
	$eid = $res->fetchOneCell();
}

$res = $globals->xdb->iterator(
	"SELECT eid, item_id, titre, montant
	   FROM groupex.evenements_items
	  WHERE eid = {?}",
	$eid);
$moments = array();
while ($m = $res->next()) $moments[$m['item_id']] = $m;

if (may_update() && Env::get('adm') && Env::get('mail') && $eid) {
	if (strpos(Env::get('mail'), '@') === false)
	$res = $globals->xdb->query(
		"SELECT m.uid
		   FROM groupex.membres AS m
	     INNER JOIN aliases AS a ON (a.id = m.uid)
		  WHERE a.alias = {?}",
		Env::get('mail'));
	else
	$res = $globals->xdb->query(
		"SELECT m.uid
		   FROM groupex.membres AS m
		  WHERE m.email = {?} AND m.asso_id = {?}",
		Env::get('mail'), $globals->asso('id'));
	$member = $res->fetchOneCell();
}

if (may_update() && Env::get('adm') == 'prix' && $member && $eid) {
	$globals->xdb->execute("UPDATE groupex.evenements_participants SET paid = IF(paid + {?} > 0, paid + {?}, 0) WHERE uid = {?} AND eid = {?}",
		strtr(Env::get('montant'), ',', '.'),
		strtr(Env::get('montant'), ',', '.'),
		$member, $eid);
}

if (may_update() && Env::get('adm') == 'nbs' && $member && $eid) {
	$res = $globals->xdb->query("SELECT paid FROM groupex.evenements_participants WHERE uid = {?} AND eid = {?}", $member, $eid);
	$paid = $res->fetchOneCell();
	foreach ($moments as $m) if (Env::has('nb'.$m['item_id'])) {
		print_r($m);
		$nb = Env::getInt('nb'.$m['item_id'], 0);
		if ($nb < 0) $nb = 0;
		if ($nb) {
			if (!$paid) $paid = 0;
			$globals->xdb->execute("REPLACE INTO groupex.evenements_participants VALUES ({?}, {?}, {?}, {?}, {?})",
			$eid, $member, $m['item_id'], $nb, $paid);
		}
		else
		$globals->xdb->execute("DELETE FROM groupex.evenements_participants WHERE uid = {?} AND eid = {?} AND item_id = {?}", $member, $eid, $m['item_id']);
	}
}

$res = $globals->xdb->query(
	"SELECT	SUM(nb) AS nb_tot, e.intitule, ei.titre, e.show_participants, e.paiement_id
	   FROM	groupex.evenements AS e
     INNER JOIN	groupex.evenements_items AS ei ON (e.eid = ei.eid)
      LEFT JOIN	groupex.evenements_participants AS ep ON(e.eid = ep.eid AND ei.item_id = ep.item_id)
          WHERE	e.eid = {?} AND ei.item_id = {?}
       GROUP BY ei.item_id",
       $eid, Env::getInt('item_id', 1));

$evt = $res->fetchOneAssoc();

if (!Env::has('item_id')) {
	$res = $globals->xdb->query("SELECT MAX(nb)
		  FROM groupex.evenements AS e
	    INNER JOIN groupex.evenements_items AS ei ON (e.eid = ei.eid)
	     LEFT JOIN groupex.evenements_participants AS ep ON(e.eid = ep.eid AND ei.item_id = ep.item_id)
		 WHERE e.eid = {?}
	      GROUP BY ep.uid",
	$eid);
	$evt['nb_tot'] = array_sum($res->fetchColumn());
	$evt['titre'] = '';
	$evt['item_id'] = 0;
}

if (!$evt['intitule'])
	header("Location: evenements.php");

if ($evt['show_participants'])
	new_group_page('xnet/groupe/evt-admin.tpl');
else
	new_groupadmin_page('xnet/groupe/evt-admin.tpl');

$page->assign('admin', may_update());
$page->assign('evt', $evt);
$page->assign('url_page', Env::get('PHP_SELF')."?eid=".$eid.(Env::has('item_id')?("&item_id=".Env::getInt('item_id')):''));
$page->assign('tout', !Env::has('item_id'));
 
if (count($moments) > 1) $page->assign('moments', $moments);
foreach ($moments as $m) if ($m['montant'] > 0) $money = true;
if ($money) $page->assign('money', true);

$tri = (Env::get('order') == 'alpha' ? 'promo, nom, prenom' : 'nom, prenom, promo');
$whereitemid = Env::has('item_id')?('AND ep.item_id = '.Env::getInt('item_id', 1)):'';
$res = $globals->xdb->iterRow(
            'SELECT  UPPER(SUBSTRING(IF(m.origine="X",IF(u.nom_usage<>"", u.nom_usage, u.nom),m.nom), 1, 1)), COUNT(IF(m.origine="X",u.nom,m.nom))
               FROM  groupex.evenements_participants AS ep
	 INNER JOIN  groupex.evenements AS e ON (ep.eid = e.eid)
	 INNER JOIN  groupex.membres AS m ON ( ep.uid = m.uid AND e.asso_id = m.asso_id)
          LEFT JOIN  auth_user_md5   AS u ON ( u.user_id = m.uid )
              WHERE  ep.eid = {?} '.$whereitemid.'
           GROUP BY  UPPER(SUBSTRING(IF(m.origine="X",u.nom,m.nom), 1, 1))', $eid);

$alphabet = array();
$nb_tot = 0;
while (list($char, $nb) = $res->next()) {
    $alphabet[ord($char)] = $char;
    $nb_tot += $nb;
    if (Env::has('initiale') && $char == strtoupper(Env::get('initiale'))) {
        $tot = $nb;
    }
}
$page->assign('alphabet', $alphabet);

$ofs   = Env::getInt('offset');
$tot   = Env::get('initiale') ? $tot-1 : $nb_tot-1;
$nbp   = intval(($tot-1)/NB_PER_PAGE);
$links = array();
if ($ofs) {
    $links['pr�c�dent'] = $ofs-1;
}
for ($i = 0; $i <= $nbp; $i++) {
    $links[(string)($i+1)] = $i;
}
if ($ofs < $nbp) {
    $links['suivant'] = $ofs+1;
}
if (count($links)>1) {
    $page->assign('links', $links);
}

$ini = Env::has('initiale') ? 'AND IF(m.origine="X",IF(u.nom_usage<>"", u.nom_usage, u.nom),m.nom) LIKE "'.addslashes(Env::get('initiale')).'%"' : '';
$ann = $globals->xdb->iterator(
          "SELECT  IF(m.origine='X',IF(u.nom_usage<>'', u.nom_usage, u.nom) ,m.nom) AS nom,
                   IF(m.origine='X',u.prenom,m.prenom) AS prenom,
                   IF(m.origine='X',u.promo,'ext�rieur') AS promo,
                   IF(m.origine='X',a.alias,m.email) AS email,
                   IF(m.origine='X',FIND_IN_SET('femme', u.flags),0) AS femme,
                   m.perms='admin' AS admin,
                   m.origine='X' AS x,
		   m.uid, 
		   ep.nb, ep.item_id, ep.paid
               FROM  groupex.evenements_participants AS ep
	 INNER JOIN  groupex.evenements AS e ON (ep.eid = e.eid)
	 INNER JOIN  groupex.membres AS m ON ( ep.uid = m.uid AND e.asso_id = m.asso_id)
          LEFT JOIN  auth_user_md5   AS u ON ( u.user_id = m.uid )
          LEFT JOIN  aliases         AS a ON ( a.id = m.uid AND a.type='a_vie' )
              WHERE  ep.eid = {?} $whereitemid $ini
	   ORDER BY  $tri
	      LIMIT {?}, {?}",
	   $eid,
           $ofs*NB_PER_PAGE, NB_PER_PAGE);

$tab = array();
$user = 0;
while ($a = $ann->next()) {
	if ($user != $a['uid']) {
		if ($user) $tab[] = $u;
		$u = $a;
		$user = $a['uid'];
		$u['montant'] = 0;
		if ($money && $evt['paiement_id'] && may_update() && !Env::has('item_id')) {
			$res = $globals->xdb->query(
		"SELECT montant
		   FROM {$globals->money->mpay_tprefix}transactions AS t
		  WHERE ref = {?} AND uid = {?}",
		  	$evt['paiement_id'], $user);
			$montants = $res->fetchColumn();
			foreach ($montants as $m) {
				$p = strtr(substr($m, 0, strpos($m, "EUR")), ",", ".");
				$u['paid'] += trim($p);
			}
		}
	}
	$u[$a['item_id']] = $a['nb'];
	$u['montant'] += $moments[$a['item_id']]['montant']*$a['nb'];
}
if ($user) $tab[] = $u;

$page->assign('ann', $tab);

$page->run();

?>
