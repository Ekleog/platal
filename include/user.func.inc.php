<?php
/***************************************************************************
 *  Copyright (C) 2003-2008 Polytechnique.org                              *
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

// {{{ function user_clear_all_subs()
/** kills the inscription of a user.
 * we still keep his birthdate, adresses, and personnal stuff
 * kills the entreprises, mentor, emails and lists subscription stuff
 */
function user_clear_all_subs($user_id, $really_del=true)
{
    // keep datas in : aliases, adresses, tels, profile_education, binets_ins, contacts, groupesx_ins, homonymes, identification_ax, photo
    // delete in     : auth_user_md5, auth_user_quick, competences_ins, emails, entreprises, langues_ins, mentor,
    //                 mentor_pays, mentor_secteurs, newsletter_ins, perte_pass, requests, user_changes, virtual_redirect, watch_sub
    // + delete maillists

    global $globals;
    $uid = intval($user_id);
    $user = User::getSilent($uid);
    list($alias) = explode('@', $user->forlifeEmail());

    $tables_to_clear = array('uid' => array('competences_ins', 'profile_job', 'langues_ins', 'profile_mentor_country',
                                            'profile_mentor_sector', 'profile_mentor', 'perte_pass', 'watch_sub'),
                             'user_id' => array('requests', 'user_changes'));

    if ($really_del) {
        array_push($tables_to_clear['uid'], 'emails', 'groupex.membres', 'contacts', 'adresses', 'profile_phones',
                                            'photo', 'perte_pass', 'langues_ins', 'forum_subs', 'forum_profiles');
        array_push($tables_to_clear['user_id'], 'newsletter_ins', 'auth_user_quick', 'binets_ins');
        $tables_to_clear['id'] = array('aliases');
        $tables_to_clear['contact'] = array('contacts');
        XDB::execute("UPDATE auth_user_md5
                         SET date_ins = 0, promo_sortie = 0, nom_usage = '',  password = '', perms = 'pending',
                             nationalite = '', nationalite2 = '', nationalite3 = '', cv = '', section = 0,
                             date = 0, smtppass = '', mail_storage = ''
                       WHERE user_id = {?}", $uid);
        XDB::execute("DELETE virtual.* FROM virtual INNER JOIN virtual_redirect AS r USING(vid) WHERE redirect = {?}",
                     $alias.'@'.$globals->mail->domain);
        XDB::execute("DELETE virtual.* FROM virtual INNER JOIN virtual_redirect AS r USING(vid) WHERE redirect = {?}",
                     $alias.'@'.$globals->mail->domain2);
    } else {
        XDB::execute("UPDATE auth_user_md5   SET password='',smtppass='' WHERE user_id={?}", $uid);
        XDB::execute("UPDATE auth_user_quick SET watch_flags='' WHERE user_id={?}", $uid);
    }

    XDB::execute("DELETE FROM virtual_redirect WHERE redirect = {?}", $alias.'@'.$globals->mail->domain);
    XDB::execute("DELETE FROM virtual_redirect WHERE redirect = {?}", $alias.'@'.$globals->mail->domain2);

    foreach ($tables_to_clear as $key=>&$tables) {
        foreach ($tables as $table) {
            XDB::execute("DELETE FROM $table WHERE $key={?}", $uid);
        }
    }

    $mmlist = new MMList(S::v('uid'), S::v('password'));
    $mmlist->kill($alias, $really_del);

    // Deactivates, when available, the Google Apps account of the user.
    if ($globals->mailstorage->googleapps_domain) {
        require_once 'googleapps.inc.php';
        if (GoogleAppsAccount::account_status($uid)) {
            $account = new GoogleAppsAccount($user);
            $account->suspend();
        }
    }
}

// }}}
// {{{ function has_user_right()
function has_user_right($pub, $view = 'private') {
    if ($pub == $view) return true;
    // all infos available for private
    if ($view == 'private') return true;
    // public infos available for all
    if ($pub == 'public') return true;
    // here we have view = ax or public, and pub = ax or private, and pub != view
    return false;
}
// }}}
// {{{ function get_not_registered_user()

function get_not_registered_user($login, $iterator = false)
{
    global $globals;
    @list($login, $domain) = explode('@', $login);
    if ($domain && $domain != $globals->mail->domain && $domain != $globals->mail->domain2) {
        return null;
    }
    @list($prenom, $nom, $promo) = explode('.', $login);
    $where = 'REPLACE(REPLACE(REPLACE(nom, " ", ""), "-", ""), "\'", "") LIKE CONCAT("%", {?}, "%")
          AND  REPLACE(REPLACE(REPLACE(prenom, " ", ""), "-", ""), "\'", "") LIKE CONCAT("%", {?}, "%")';
    if ($promo) {
        if (preg_match('/^[0-9]{2}$/', $promo)) {
            $where .= 'AND MOD(promo, 100) = {?}';
        } elseif (preg_match('/^[0-9]{4}$/', $promo)) {
            $where .= 'AND promo = {?}';
        }
    }
    $sql = "SELECT  user_id, nom, prenom, promo
              FROM  auth_user_md5
             WHERE  $where AND perms = 'pending'
          ORDER BY  promo, nom, prenom";
    if ($iterator) {
        return XDB::iterator($sql, $nom, $prenom, $promo);
    } else {
        $res = XDB::query($sql, $nom, $prenom, $promo);
        return $res->fetchAllAssoc();
    }
}

// }}}
// {{{ function get_user_details_pro()

function get_user_details_pro($uid, $view = 'private')
{
    $sql  = "SELECT  en.name AS entreprise, s.name as secteur, f.fonction_fr as fonction,
                     j.description AS poste, gp.pays AS countrytxt, gr.name AS region,
                     j.id AS entrid, j.pub, j.email, j.email_pub, j.url AS w_web, en.url AS web,
                     e.adr1, e.adr2, e.adr3, e.postcode, e.city, e.adr_pub
               FROM  profile_job                   AS j
          LEFT JOIN  entreprises                   AS e  ON (e.entrid = j.id AND e.uid = j.uid)
          LEFT JOIN  profile_job_enum              AS en ON (j.jobid = en.id)
          LEFT JOIN  profile_job_subsubsector_enum AS s  ON (j.subsubsectorid = s.id)
          LEFT JOIN  fonctions_def                 AS f  ON (j.functionid = f.id)
          LEFT JOIN  geoloc_pays                   AS gp ON (gp.a2 = e.country)
          LEFT JOIN  geoloc_region                 AS gr ON (gr.a2 = e.country AND gr.region = e.region)
              WHERE  j.uid = {?}
           ORDER BY  j.id";
    $res  = XDB::query($sql, $uid);
    $all_pro = $res->fetchAllAssoc();
    foreach ($all_pro as $i => $pro) {
        if (!has_user_right($pro['pub'], $view))
            unset($all_pro[$i]);
        else {
            if (!has_user_right($pro['adr_pub'], $view)) {
                if ($pro['adr1'] == '' &&
                    $pro['adr2'] == '' &&
                    $pro['adr3'] == '' &&
                    $pro['postcode'] == '' &&
                    $pro['city'] == '' &&
                    $pro['countrytxt'] == '' &&
                    $pro['region'] == '') {
                    $all_pro[$i]['adr_pub'] = $view;
                } else {
                    $all_pro[$i]['adr1'] = '';
                    $all_pro[$i]['adr2'] = '';
                    $all_pro[$i]['adr3'] = '';
                    $all_pro[$i]['postcode'] = '';
                    $all_pro[$i]['city'] = '';
                    $all_pro[$i]['countrytxt'] = '';
                    $all_pro[$i]['region'] = '';
                }
            }
            $sql = "SELECT  pub AS tel_pub, tel_type, display_tel AS tel, comment
                      FROM  profile_phones AS t
                     WHERE  uid = {?} AND link_type = 'pro' AND link_id = {?}
                  ORDER BY  link_id, tel_type DESC, tel_id";
            $restel = XDB::iterator($sql, $uid, $pro['entrid']);
            while ($nexttel = $restel->next()) {
                if (has_user_right($nexttel['tel_pub'], $view)) {
                    if (!isset($all_pro[$i]['tels'])) {
                        $all_pro[$i]['tels'] = array($nexttel);
                    } else {
                        $all_pro[$i]['tels'][] = $nexttel;
                    }
                }
            }
            if (!has_user_right($pro['email_pub'], $view)) {
                if ($pro['email'] == '')
                    $all_pro[$i]['email_pub'] = $view;
                else
                    $all_pro[$i]['email'] = '';
            }
            if ($all_pro[$i]['adr1'] == '' &&
                $all_pro[$i]['adr2'] == '' &&
                $all_pro[$i]['adr3'] == '' &&
                $all_pro[$i]['postcode'] == '' &&
                $all_pro[$i]['city'] == '' &&
                $all_pro[$i]['countrytxt'] == '' &&
                $all_pro[$i]['region'] == '' &&
                $all_pro[$i]['entreprise'] == '' &&
                $all_pro[$i]['fonction'] == '' &&
                $all_pro[$i]['secteur'] == '' &&
                $all_pro[$i]['poste'] == '' &&
                (!isset($all_pro[$i]['tels'])) &&
                $all_pro[$i]['email'] == '')
                unset($all_pro[$i]);
        }
    }
    if (!count($all_pro)) return false;
    return $all_pro;
}

// }}}
// {{{ function get_user_details_adr()

function get_user_details_adr($uid, $view = 'private') {
    $sql  = "SELECT  a.adrid, a.adr1,a.adr2,a.adr3,a.postcode,a.city,
                     gp.pays AS countrytxt,a.region, a.regiontxt,
                     FIND_IN_SET('active', a.statut) AS active, a.adrid,
                     FIND_IN_SET('res-secondaire', a.statut) AS secondaire,
                     FIND_IN_SET('courrier', a.statut) AS courier,
                     a.pub, gp.display, a.comment
               FROM  adresses AS a
          LEFT JOIN  geoloc_pays AS gp ON (gp.a2=a.country)
              WHERE  uid= {?} AND NOT FIND_IN_SET('pro',a.statut)
           ORDER BY  NOT FIND_IN_SET('active',a.statut), FIND_IN_SET('temporaire',a.statut), FIND_IN_SET('res-secondaire',a.statut)";
    $res  = XDB::query($sql, $uid);
    $all_adr = $res->fetchAllAssoc();
    $adrid_index = array();
    foreach ($all_adr as $i => $adr) {
        if (!has_user_right($adr['pub'], $view))
            unset($all_adr[$i]);
        else
            $adrid_index[$adr['adrid']] = $i;
    }

    $sql = "SELECT  link_id AS adrid, pub AS tel_pub, tel_type, display_tel AS tel, tel_id AS telid, comment
              FROM  profile_phones AS t
             WHERE  uid = {?} AND link_type = 'address'
          ORDER BY  link_id, tel_type DESC, tel_id";
    $restel = XDB::iterator($sql, $uid);
    while ($nexttel = $restel->next()) {
        if (has_user_right($nexttel['tel_pub'], $view)) {
            $adrid = $nexttel['adrid'];
            unset($nexttel['adrid']);
            if (isset($adrid_index[$adrid])) {
                if (!isset($all_adr[$adrid_index[$adrid]]['tels']))
                    $all_adr[$adrid_index[$adrid]]['tels'] = array($nexttel);
                else
                    $all_adr[$adrid_index[$adrid]]['tels'][] = $nexttel;
            }
        }
    }
    return $all_adr;
}

// }}}
// {{{ function get_user_details()

function &get_user_details($login, $from_uid = '', $view = 'private')
{
    $reqsql = "SELECT  u.user_id, d.promo_display, u.prenom, u.nom, u.nom_usage, u.date, u.cv,
                       u.perms IN ('admin','user','disabled') AS inscrit,  FIND_IN_SET('femme', u.flags) AS sexe, u.deces != 0 AS dcd, u.deces,
                       q.profile_nick AS nickname, q.profile_from_ax, q.profile_freetext AS freetext,
                       q.profile_freetext_pub AS freetext_pub,
                       q.profile_medals_pub AS medals_pub, co.corps_pub AS corps_pub,
                       IF(gp1.nat='',gp1.pays,gp1.nat) AS nationalite, gp1.a2 AS iso3166_1,
                       IF(gp2.nat='',gp2.pays,gp2.nat) AS nationalite2, gp2.a2 AS iso3166_2,
                       IF(gp3.nat='',gp3.pays,gp3.nat) AS nationalite3, gp3.a2 AS iso3166_3,
                       a.alias AS forlife, a2.alias AS bestalias,
                       c.uid IS NOT NULL AS is_contact,
                       s.text AS section, p.x, p.y, p.pub AS photo_pub,
                       u.matricule_ax,
                       m.expertise != '' AS is_referent,
                       (COUNT(e.email) > 0 OR FIND_IN_SET('googleapps', u.mail_storage) > 0) AS actif,
                       nd.display AS name_display, nd.tooltip AS name_tooltip
                 FROM  auth_user_md5         AS u
           INNER JOIN  auth_user_quick       AS q   USING(user_id)
           INNER JOIN  aliases               AS a   ON (u.user_id = a.id AND a.type = 'a_vie')
           INNER JOIN  aliases               AS a2  ON (u.user_id = a2.id AND FIND_IN_SET('bestalias', a2.flags))
            LEFT JOIN  contacts              AS c   ON (c.uid = {?} and c.contact = u.user_id)
            LEFT JOIN  profile_corps         AS co  ON (co.uid = u.user_id)
            LEFT JOIN  geoloc_pays           AS gp1 ON (gp1.a2 = u.nationalite)
            LEFT JOIN  geoloc_pays           AS gp2 ON (gp2.a2 = u.nationalite2)
            LEFT JOIN  geoloc_pays           AS gp3 ON (gp3.a2 = u.nationalite3)
           INNER JOIN  sections              AS s   ON (s.id  = u.section)
            LEFT JOIN  photo                 AS p   ON (p.uid = u.user_id)
            LEFT JOIN  profile_mentor        AS m   ON (m.uid = u.user_id)
            LEFT JOIN  emails                AS e   ON (e.uid = u.user_id AND e.flags='active')
           INNER JOIN  profile_names_display AS nd  ON (nd.user_id = u.user_id)
           INNER JOIN  profile_display       AS d   ON (d.uid = u.user_id)
                WHERE  a.alias = {?}
             GROUP BY  u.user_id";
    $res  = XDB::query($reqsql, $from_uid, $login);
    $user = $res->fetchOneAssoc();
    $uid  = $user['user_id'];
    // hide orange status, cv, nickname, section
    if (!has_user_right('private', $view)) {
        $user['cv'] = '';
        $user['nickname'] = '';
        $user['section'] = '';
    }

    // hide freetext
    if (!has_user_right($user['freetext_pub'], $view)) {
        if ($user['freetext'] == '')
            $user['freetext_pub'] = $view;
        else
            $user['freetext'] = '';
    }

    $sql = "SELECT  pub AS tel_pub, tel_type, display_tel AS tel, comment
              FROM  profile_phones AS t
             WHERE  uid = {?} AND link_type = 'user'
          ORDER BY  tel_type DESC, tel_id";
    $restel = XDB::iterator($sql, $uid);
    while ($nexttel = $restel->next()) {
        if (has_user_right($nexttel['tel_pub'], $view)) {
            if (!isset($user['tels'])) {
                $user['tels'] = array($nexttel);
            } else {
                $user['tels'][] = $nexttel;
            }
        }
    }

    $user['adr_pro'] = get_user_details_pro($uid, $view);
    $user['adr']     = get_user_details_adr($uid, $view);

    if (has_user_right('private', $view)) {
        $sql  = "SELECT  text
                   FROM  binets_ins
              LEFT JOIN  binets_def ON binets_ins.binet_id = binets_def.id
                  WHERE  user_id = {?}";
        $res  = XDB::query($sql, $uid);
        $user['binets']      = $res->fetchColumn();
        $user['binets_join'] = join(', ', $user['binets']);

        $res  = XDB::iterRow("SELECT  a.diminutif, a.nom, a.site
                                FROM  groupex.asso    AS a
                           LEFT JOIN  groupex.membres AS m ON (m.asso_id = a.id)
                               WHERE  m.uid = {?} AND (a.cat = 'GroupesX' OR a.cat = 'Institutions')
                                      AND pub = 'public'", $uid);
        $user['gpxs'] = Array();
        $user['gpxs_name'] = Array();
        while (list($gxd, $gxt, $gxu) = $res->next()) {
            if (!$gxu) {
                $gxu = 'http://www.polytechnique.net/' . $gxd;
            }
            $user['gpxs'][] = '<span title="' . pl_entities($gxt) . "\"><a href=\"$gxu\">$gxd</a></span>";
            $user['gpxs_name'][] = $gxt;
        }
        $user['gpxs_join'] = join(', ', $user['gpxs']);
    }

    $res = XDB::iterRow("SELECT  en.name AS name, en.url AS url, d.degree AS degree,
                                 ed.grad_year AS grad_year, f.field AS field, ed.program AS program
                           FROM  profile_education AS ed
                      LEFT JOIN  profile_education_enum        AS en ON (en.id = ed.eduid)
                      LEFT JOIN  profile_education_degree_enum AS d  ON (d.id  = ed.degreeid)
                      LEFT JOIN  profile_education_field_enum  AS f  ON (f.id  = ed.fieldid)
                          WHERE  uid = {?} AND NOT FIND_IN_SET('primary', flags)
                       ORDER BY  ed.grad_year", $uid);

    if (list($name, $url, $degree, $grad_year, $field, $program) = $res->next()) {
        require_once('education.func.inc.php');
        $user['education'][] = education_fmt($name, $url, $degree, $grad_year, $field, $program, $user['sexe'], true);
    }
    while (list($name, $url, $degree, $grad_year, $field, $program) = $res->next()) {
        $user['education'][] = education_fmt($name, $url, $degree, $grad_year, $field, $program, $user['sexe'], true);
    }

    if (has_user_right($user['corps_pub'], $view)) {
        $res = XDB::query("SELECT  e1.name AS original, e2.name AS current, r.name AS rank
                             FROM  profile_corps           AS c
                        LEFT JOIN  profile_corps_enum      AS e1 ON (c.original_corpsid = e1.id)
                        LEFT JOIN  profile_corps_enum      AS e2 ON (c.current_corpsid = e2.id)
                        LEFT JOIN  profile_corps_rank_enum AS r  ON (c.rankid = r.id)
                            WHERE  c.uid = {?} AND c.original_corpsid != 1", $uid);
        if ($res = $res->fetchOneRow()) {
            list($original, $current, $rank) = $res;
            $user['corps'] = "Corps d'origine : " . $original . ", corps actuel : " . $current . ", grade : " . $rank;
        }
    }

    if (has_user_right($user['medals_pub'], $view)) {
        $res = XDB::iterator("SELECT  m.id, m.text AS medal, m.type, s.gid, g.text AS grade
                                FROM  profile_medals_sub    AS s
                          INNER JOIN  profile_medals        AS m ON ( s.mid = m.id )
                           LEFT JOIN  profile_medals_grades AS g ON ( s.mid = g.mid AND s.gid = g.gid )
                               WHERE  s.uid = {?}", $uid);
        $user['medals'] = Array();
        while ($tmp = $res->next()) {
            $user['medals'][] = $tmp;
        }
    }

    $user['networking'] = Array();
    $res = XDB::iterator("SELECT  n.address, n.pub, m.network_type AS type, m.name, m.filter, m.link
                            FROM  profile_networking AS n
                      INNER JOIN  profile_networking_enum AS m ON (n.network_type = m.network_type)
                           WHERE  n.uid = {?}", $uid);
    while($network = $res->next())
    {
        if (has_user_right($network['pub'], $view)) {
            $network['link'] = str_replace('%s', $network['address'], $network['link']);
            $user['networking'][] = $network;
        }
    }

    return $user;
}
// }}}
// {{{ function add_user_address()
function add_user_address($uid, $adrid, $adr) {
    XDB::execute(
        "INSERT INTO adresses (`uid`, `adrid`, `adr1`, `adr2`, `adr3`, `postcode`, `city`, `country`, `datemaj`, `pub`) (
        SELECT u.user_id, {?}, {?}, {?}, {?}, {?}, {?}, gp.a2, NOW(), {?}
            FROM auth_user_md5 AS u
            LEFT JOIN geoloc_pays AS gp ON (gp.pays LIKE {?} OR gp.country LIKE {?} OR gp.a2 LIKE {?})
            WHERE u.user_id = {?}
            LIMIT 1)",
        $adrid, $adr['adr1'], $adr['adr2'], $adr['adr3'], $adr['postcode'], $adr['city'], $adr['pub'], $adr['countrytxt'], $adr['countrytxt'], $adr['countrytxt'], $uid);
    if (isset($adr['tels']) && is_array($adr['tels'])) {
        $telid = 0;
        foreach ($adr['tels'] as $tel) if ($tel['tel']) {
            add_user_tel($uid, 'address', $adrid, $telid, $tel);
            $telid ++;
        }
    }
}
// }}}
// {{{ function update_user_address()
function update_user_address($uid, $adrid, $adr) {
    // update address
    XDB::execute(
        "UPDATE adresses AS a LEFT JOIN geoloc_pays AS gp ON (gp.pays = {?})
        SET `adr1` = {?}, `adr2` = {?}, `adr3` = {?},
        `postcode` = {?}, `city` = {?}, a.`country` = gp.a2, `datemaj` = NOW(), `pub` = {?}
        WHERE adrid = {?} AND uid = {?}",
        $adr['country_txt'],
        $adr['adr1'], $adr['adr2'], $adr['adr3'],
        $adr['postcode'], $adr['city'], $adr['pub'], $adrid, $uid);
    if (isset($adr['tels']) && is_array($adr['tels'])) {
        $res = XDB::query("SELECT tel_id FROM profile_phones WHERE uid = {?} AND link_type = 'address' AND link_id = {?} ORDER BY tel_id", $uid, $adrid);
        $telids = $res->fetchColumn();
        foreach ($adr['tels'] as $tel) {
            if (isset($tel['telid']) && isset($tel['remove']) && $tel['remove']) {
                remove_user_tel($uid, 'address', $adrid, $tel['telid']);
                if (isset($telids[$tel['telid']])) unset($telids[$tel['telid']]);
            } else if (isset($tel['telid'])) {
                update_user_tel($uid, 'address', $adrid, $tel['telid'], $tel);
            } else {
                for ($telid = 0; isset($telids[$telid]) && ($telids[$telid] == $telid); $telid++);
                add_user_tel($uid, 'address', $adrid, $telid, $tel);
            }
        }
    }
}
// }}}
// {{{ function remove_user_address()
function remove_user_address($uid, $adrid) {
    XDB::execute("DELETE FROM adresses WHERE adrid = {?} AND uid = {?}", $adrid, $uid);
    XDB::execute("DELETE FROM profile_phones WHERE link_id = {?} AND uid = {?} AND link_type = 'address'", $adrid, $uid);
}
// }}}
// {{{ function add_user_tel()
function add_user_tel($uid, $link_type, $link_id, $telid, $tel) {
    require('profil.func.inc.php');
    $fmt_phone  = format_phone_number($tel['tel']);
    $disp_phone = format_display_number($fmt_phone, $error);
    XDB::execute("INSERT INTO profile_phones (uid, link_type, link_id, tel_id, tel_type, search_tel, display_tel, pub)
                       VALUES ({?}, {?}, {?}, {?}, {?}, {?}, {?}, {?})",
                 $uid, $link_type, $link_id, $telid, $tel['tel_type'], $fmt_phone, $disp_phone, $tel['tel_pub']);
}
// }}}
// {{{ function update_user_tel()
function update_user_tel($uid, $link_type, $link_id, $telid, $tel) {
    require('profil.func.inc.php');
    $fmt_phone  = format_phone_number($tel['tel']);
    $disp_phone = format_display_number($fmt_phone, $error);
    XDB::execute("UPDATE profile_phones SET search_tel = {?}, display_tel = {?}, tel_type = {?}, pub = {?}
                   WHERE link_type = {?} AND tel_id = {?} AND link_id = {?} AND uid = {?}",
                 $fmt_phone, $disp_phone, $tel['tel_type'], $tel['tel_pub'],
                 $link_type, $telid, $link_id, $uid);
}
// }}}
// {{{ function remove_user_tel()
function remove_user_tel($uid, $link_type, $link_id, $telid) {
    XDB::execute("DELETE FROM profile_phones WHERE tel_id = {?} AND link_id = {?} AND uid = {?} AND link_type = {?}",
                 $telid, $link_id, $uid, $link_type);
}
// }}}
// {{{ function add_user_pro()
function add_user_pro($uid, $entrid, $pro) {
    XDB::execute(
        "INSERT INTO entreprises (`uid`, `entrid`, `entreprise`, `poste`, `secteur`, `ss_secteur`, `fonction`,
            `adr1`, `adr2`, `adr3`, `postcode`, `city`, `country`, `region`, `email`, `web`, `pub`, `adr_pub`, `email_pub`)
        SELECT u.user_id, {?}, {?}, {?}, s.id, ss.id, f.id,
        {?}, {?}, {?}, {?}, {?}, gp.a2, gr.region, {?}, {?}, {?}, {?}, {?}, {?}, {?}, {?}, {?}
        FROM auth_user_md5 AS u
            LEFT JOIN  emploi_secteur AS s ON(s.label LIKE {?})
            LEFT JOIN  emploi_ss_secteur AS ss ON(s.id = ss.secteur AND ss.label LIKE {?})
            LEFT JOIN  fonctions_def AS f ON(f.fonction_fr LIKE {?} OR f.fonction_en LIKE {?})
            LEFT JOIN  geoloc_pays AS gp ON (gp.country LIKE {?} OR gp.pays LIKE {?})
            LEFT JOIN  geoloc_region AS gr ON (gr.a2 = gp.a2 AND gr.name LIKE {?})
        WHERE u.user_id = {?}
        LIMIT 1",
        $entrid, $pro['entreprise'], $pro['poste'],
        $pro['adr1'], $pro['adr2'], $pro['adr3'], $pro['postcode'], $pro['city'], $pro['email'], $pro['web'], $pro['pub'], $pro['adr_pub'], $pro['email_pub'],
        $pro['secteur'], $pro['sous_secteur'], $pro['fonction'], $pro['fonction'],
        $pro['countrytxt'], $pro['countrytxt'], $pro['region'],
        $uid);
    if (isset($pro['tels']) && is_array($pro['tels'])) {
        $telid = 0;
        foreach ($pro['tels'] as $tel) {
            if ($pro['tel']) {
                add_user_tel($uid, 'pro', $entrid, $telid, $tel);
                $telid ++;
            }
        }
    }
}
// }}}
// {{{ function update_user_pro()
function update_user_pro($uid, $entrid, $pro) {
    $join = "";
    $set = "";
    $args_join = array();
    $args_set = array();

    $join .= "LEFT JOIN  emploi_secteur AS s ON(s.label LIKE {?})
            LEFT JOIN  emploi_ss_secteur AS ss ON(s.id = ss.secteur AND ss.label LIKE {?})
            LEFT JOIN  fonctions_def AS f ON(f.fonction_fr LIKE {?} OR f.fonction_en LIKE {?})";
    $args_join[] = $pro['secteur'];
    $args_join[] = $pro['sous_secteur'];
    $args_join[] = $pro['fonction'];
    $args_join[] = $pro['fonction'];
    $set .= ", e.`entreprise` = {?}, e.`secteur` = s.id, e.`ss_secteur` = ss.id, e.`fonction` = f.id, e.`poste`= {?}, e.`web` = {?}, e.`pub` = {?}";
    $args_set[] = $pro['entreprise'];
    $args_set[] = $pro['poste'];
    $args_set[] = $pro['web'];
    $args_set[] = $pro['pub'];

    if (isset($pro['adr1'])) {
        $join .= "LEFT JOIN  geoloc_pays AS gp ON (gp.country LIKE {?} OR gp.pays LIKE {?})
                LEFT JOIN  geoloc_region AS gr ON (gr.a2 = gp.a2 AND gr.name LIKE {?})";
        $args_join[] = $pro['countrytxt'];
        $args_join[] = $pro['countrytxt'];
        $args_join[] = $pro['region'];
        $set .= ", e.`adr1` = {?}, e.`adr2` = {?}, e.`adr3` = {?}, e.`postcode` = {?}, e.`city` = {?}, e.`country` = gp.a2, e.`region` = gr.region, e.`adr_pub` = {?}";
        $args_set[] = $pro['adr1'];
        $args_set[] = $pro['adr2'];
        $args_set[] = $pro['adr3'];
        $args_set[] = $pro['postcode'];
        $args_set[] = $pro['city'];
        $args_set[] = $pro['adr_pub'];
    }

    if (isset($pro['email'])) {
        $set .= ", e.`email` = {?}, e.`email_pub` = {?}";
        $args_set[] = $pro['email'];
        $args_set[] = $pro['email_pub'];
    }
    $query = "UPDATE entreprises AS e ".$join." SET ".substr($set,1)." WHERE e.uid = {?} AND e.entrid = {?}";
    $args_where = array($uid, $entrid);
    $args = array_merge(array($query), $args_join, $args_set, $args_where);
    call_user_func_array(array('XDB', 'execute'), $args);


    if (isset($pro['tels']) && is_array($pro['tels'])) {
        $res = XDB::query("SELECT tel_id FROM profile_phones WHERE uid = {?} AND link_type = 'pro' AND link_id = {?} ORDER BY tel_id", $uid, $entrid);
        $telids = $res->fetchColumn();
        foreach ($pro['tels'] as $tel) {
            if (isset($tel['telid']) && isset($tel['remove']) && $tel['remove']) {
                remove_user_tel($uid, 'pro', $entrid, $tel['telid']);
                if (isset($telids[$tel['telid']])) unset($telids[$tel['telid']]);
            } else if (isset($tel['telid'])) {
                update_user_tel($uid, 'pro', $entrid, $tel['telid'], $tel);
            } else {
                for ($telid = 0; isset($telids[$telid]) && ($telids[$telid] == $telid); $telid++);
                add_user_tel($uid, 'pro', $entrid, $telid, $tel);
            }
        }
    }
}
// }}}
// {{{ function remove_user_pro()
function remove_user_pro($uid, $entrid) {
    XDB::execute("DELETE FROM entreprises WHERE entrid = {?} AND uid = {?}", $entrid, $uid);
    XDB::execute("DELETE FROM profile_phones WHERE link_id = {?} AND uid = {?} AND link_type = 'pro'", $entrid, $uid);
}
// }}}
// {{{ function set_user_details_addresses()
function set_user_details_addresses($uid, $adrs) {
    $req = XDB::query('SELECT MAX(adrid) + 1
                         FROM adresses
                        WHERE uid = {?}', $uid);
    $adrid = $req->fetchOneCell();
    if (is_null($adrid)) {
        $adrid = 0;
    }
    foreach ($adrs as $adr) {
        if (!@$adr['remove']) {
            add_user_address($uid, $adrid, $adr);
            ++$adrid;
        }
    }
    require_once 'geoloc.inc.php';
    localize_addresses($uid);
}
// }}}
// {{{ function set_user_details_pro()

function set_user_details_pro($uid, $pros)
{
    $req = XDB::query('SELECT MAX(entrid) + 1
                         FROM entreprises
                        WHERE uid = {?}', $uid);
    $entrid = $req->fetchOneCell();
    if (is_null($entrid)) {
        $entrid = 0;
    }
    foreach ($pros as $pro) {
        if (!@$pro['remove']) {
            add_user_pro($uid, $entrid, $pro);
            ++$entrid;
        }
    }
}

// }}}
// {{{ function set_user_details()
function set_user_details($uid, $details) {
    if (isset($details['nom_usage'])) {
        XDB::execute("UPDATE auth_user_md5 SET nom_usage = {?} WHERE user_id = {?}", strtoupper($details['nom_usage']), $uid);
    }
    if (isset($details['nationalite'])) {
        XDB::execute(
            "UPDATE auth_user_md5 AS u
                INNER JOIN geoloc_pays     AS gp
            SET u.nationalite = gp.a2
            WHERE (gp.a2 = {?} OR gp.nat = {?})
                AND u.user_id = {?}",  $details['nationalite'], $details['nationalite'], $uid);
    }
    if (isset($details['adr']) && is_array($details['adr']))
        set_user_details_addresses($uid, $details['adr']);
    if (isset($details['adr_pro']) && is_array($details['adr_pro']))
        set_user_details_pro($uid, $details['adr_pro']);
    if (isset($details['binets']) && is_array($details['binets'])) {
        XDB::execute("DELETE FROM binets_ins WHERE user_id = {?}", $uid);
        foreach ($details['binets'] as $binet)
            XDB::execute(
            "INSERT INTO binets_ins (`user_id`, `binet_id`)
                SELECT {?}, id FROM binets_def WHERE text = {?} LIMIT 1",
                $uid, $binet);
    }
    if (isset($details['gpxs']) && is_array($details['gpxs'])) {
        XDB::execute("DELETE FROM groupesx_ins WHERE user_id = {?}", $uid);
        foreach ($details['gpxs'] as $groupex) {
            if (preg_match('/<a href="[^"]*">([^<]+)</a>/u', $groupex, $a)) $groupex = $a[1];
            XDB::execute(
            "INSERT INTO groupesx_ins (`user_id`, `binet_id`)
                SELECT {?}, id FROM groupesx_def WHERE text = {?} LIMIT 1",
                $uid, $groupex);
        }
    }
    if (isset($details['tels']) && is_array($details['tels'])) {
        $res = XDB::query("SELECT tel_id FROM profile_phones WHERE uid = {?} AND link_type = 'user' ORDER BY tel_id", $uid);
        $telids = $res->fetchColumn();
        foreach ($details['tels'] as $tel) {
            if (isset($tel['telid']) && isset($tel['remove']) && $tel['remove']) {
                remove_user_tel($uid, 'user', 0, $tel['telid']);
                if (isset($telids[$tel['telid']])) unset($telids[$tel['telid']]);
            } else if (isset($tel['telid'])) {
                update_user_tel($uid, 'user', 0, $tel['telid'], $tel);
            } else {
                for ($telid = 0; isset($telids[$telid]) && ($telids[$telid] == $telid); $telid++);
                add_user_tel($uid, 'user', 0, $telid, $tel);
            }
        }
    }

    // education
    // medals
}
// }}}
// {{{ function _user_reindex

function _user_reindex($uid, $keys, $muls, $pubs)
{
    foreach ($keys as $i => $key) {
        if ($key == '') {
            continue;
        }
        $toks  = preg_split('/[ \'\-]+/', $key);
        $token = "";
        $first = 5;
        while ($toks) {
            $token = strtolower(replace_accent(array_pop($toks) . $token));
            $score = ($toks ? 0 : 10 + $first) * $muls[$i];
            XDB::execute("REPLACE INTO  search_name (token, uid, soundex, score, flags)
                                VALUES  ({?}, {?}, {?}, {?}, {?})",
                         $token, $uid, soundex_fr($token), $score, $pubs[$i] ? 'public' : '');
            $first = 0;
        }
    }
    $res = XDB::query("SELECT  nom_ini, nom, nom_usage, prenom_ini, prenom, promo, matricule
                         FROM  auth_user_md5
                        WHERE  user_id = {?}", $uid);
    if (!$res->numRows()) {
        unset($res);
        return;
    }
    $array = $res->fetchOneRow();
    $promo = intval(array_pop($array));
    $mat   = array_shift($array);
    array_walk($array, 'soundex_fr');
    XDB::execute("REPLACE INTO  recherche_soundex
                           SET  matricule = {?}, nom1_soundex = {?}, nom2_soundex= {?}, nom3_soundex = {?},
                                prenom1_soundex = {?}, prenom2_soundex= {?}, promo = {?}",
                 $mat, $array[0], $array[1], $array[2], $array[3], $array[4], $promo);
    unset($res);
    unset($array);
}

// }}}
// {{{ function user_reindex

function user_reindex($uid) {
    XDB::execute("DELETE FROM search_name WHERE uid={?}", $uid);
    $res = XDB::query("SELECT prenom, nom, nom_usage, profile_nick FROM auth_user_md5 INNER JOIN auth_user_quick USING(user_id) WHERE auth_user_md5.user_id = {?}", $uid);
    if ($res->numRows()) {
      _user_reindex($uid, $res->fetchOneRow(), array(1,1,1,0.2), array(true, true, true, false));
    } else { // not in auth_user_quick => still "pending"
      $res = XDB::query("SELECT prenom, nom, nom_usage FROM auth_user_md5 WHERE auth_user_md5.user_id = {?}", $uid);
      if ($res->numRows()) {
          _user_reindex($uid, $res->fetchOneRow(), array(1,1,1), array(true, true, true));
      }
    }
}

// }}}
// {{{ function set_new_usage()

function set_new_usage($uid, $usage, $alias=false)
{
    XDB::execute("UPDATE auth_user_md5 set nom_usage={?} WHERE user_id={?}",$usage ,$uid);
    XDB::execute("DELETE FROM aliases WHERE FIND_IN_SET('usage',flags) AND id={?}", $uid);
    if ($alias && $usage) {
        XDB::execute("UPDATE aliases SET flags=flags & 255-1 WHERE id={?}", $uid);
        XDB::execute("INSERT INTO aliases VALUES({?}, 'alias', 'usage,bestalias', {?}, null)",
            $alias, $uid);
    }
    $r = XDB::query("SELECT alias FROM aliases WHERE FIND_IN_SET('bestalias', flags) AND id = {?}", $uid);
    if ($r->numRows() == "") {
        XDB::execute("UPDATE aliases SET flags = 1 | flags WHERE id = {?} LIMIT 1", $uid);
        $r = XDB::query("SELECT alias FROM aliases WHERE FIND_IN_SET('bestalias', flags) AND id = {?}", $uid);
    }
    user_reindex($uid);
    return $r->fetchOneCell();
}

// }}}
// {{{ function get_X_mat
function get_X_mat($ourmat)
{
    if (!preg_match('/^[0-9]{8}$/', $ourmat)) {
        // le matricule de notre base doit comporter 8 chiffres
        return 0;
    }

    $year = intval(substr($ourmat, 0, 4));
    $rang = intval(substr($ourmat, 5, 3));
    if ($year < 1996) {
        return;
    } elseif ($year < 2000) {
        $year = intval(substr(1900 - $year, 1, 3));
        return sprintf('%02u0%03u', $year, $rang);
    } else {
        $year = intval(substr(1900 - $year, 1, 3));
        return sprintf('%03u%03u', $year, $rang);
    }
}

// }}}


// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
