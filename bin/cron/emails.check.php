#!/usr/bin/php5 -q
<?php
/***************************************************************************
 *  Copyright (C) 2003-2010 Polytechnique.org                              *
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

/* Number of consecutive month of bounce before deactivating a redirection
 */
$panne_level = 3;

require('./connect.db.inc.php');
require("Console/Getopt.php");

/*
 * Parse the command-line options.
 */
$opts = Console_GetOpt::getopt($argv, 'v');
$opt_verbose = false;

if (PEAR::isError($opts)) {
    echo $opts->getMessage();
} else {
    $opts = $opts[0];
    foreach ($opts as $opt) {
        if ($opt[0] == 'v') {
            $opt_verbose = true;
        }
    }
}

/*
 * Check duplicated addresses
 */
$sql = "SELECT  a1.alias, a2.alias, e1.email
          FROM  emails        AS e1
    INNER JOIN  emails        AS e2 ON (e1.email = e2.email AND e1.uid != e2.uid
                                       AND (e1.uid < e2.uid OR NOT FIND_IN_SET('active', e2.flags)))
     LEFT JOIN  emails_watch  AS w  ON (e1.email = w.email)
    INNER JOIN  aliases       AS a1 ON (a1.id = e1.uid AND a1.type = 'a_vie')
    INNER JOIN  aliases       AS a2 ON (a2.id = e2.uid AND a2.type = 'a_vie')
    INNER JOIN  auth_user_md5 AS u1 ON (a1.id = u1.user_id)
    INNER JOIN  auth_user_md5 AS u2 ON (a2.id = u2.user_id)
         WHERE  FIND_IN_SET('active', e1.flags) AND u1.nom != u2.nom_usage AND u2.nom != u1.nom_usage AND w.email IS NULL
      ORDER BY  a1.alias";

$it = Xdb::iterRow($sql);

$insert   = array();
$conflits = array();
while (list($alias1, $alias2, $mail) = $it->next()) {
    $insert[]   = "('$mail', 'pending', CURDATE(), NOW())";
    $conflits[] = "* $mail sur $alias1 et $alias2";
}

if (count($conflits) > 0) {
    echo "Nouvelles adresses en doublon détectées :\n" . join("\n", $conflits)
        . "\n\nVous pouvez entrer les informations collectées à ce sujet sur la page :\n"
        . "https://www.polytechnique.org/admin/emails/duplicated";

    echo "\n\n";
    $sql = "INSERT IGNORE INTO  emails_watch (email, state, detection, last)
                        VALUES  " . join(", ", $insert);
    XDB::execute($sql);
    if (XDB::errno() != 0) {
        echo 'Error : ' . XDB::error() . "\n$sql";
    }
}

/*
 * Check dead emails
 */
if ($panne_level > 0) {
    $sql = "SELECT  e.email, u.hruid
              FROM  emails        AS e
        INNER JOIN  auth_user_md5 AS u ON u.user_id = e.uid
             WHERE  e.panne_level = $panne_level AND e.flags = 'active'
          ORDER BY  u.hruid";
    $res = Xdb::query($sql);

    if ($res->numRows()) {
        $result = $res->fetchAllAssoc();
        echo "Nouvelles adresses en panne detectees :\n";
        foreach ($result as $assoc) {
            echo '* ' . $assoc['email'] . ' pour ' . $assoc['hruid'] . "\n";
        }
        echo "\n\n";

        Xdb::execute("UPDATE  emails
                         SET  flags = 'panne'
                       WHERE  panne_level = 3 AND flags = 'active'");
    }

    Xdb::execute("UPDATE  emails
                     SET  panne_level = $panne_level
                   WHERE  panne_level > $panne_level");
}

/*
 * Retrieve the users with no active redirection, but still one working
 * inactive redirection.
 */
if ($opt_verbose) {
    $res = XDB::query("SELECT  u.hruid, ei.email
                         FROM  auth_user_md5   AS u
                    LEFT JOIN  emails          AS ea ON (ea.uid = u.user_id AND ea.flags='active')
                   INNER JOIN  emails          AS ei ON (ei.uid = u.user_id AND ei.flags='')
                        WHERE  FIND_IN_SET('googleapps', u.mail_storage) = 0 AND ea.email IS NULL
                     GROUP BY  u.user_id");

    if ($res->numRows()) {
        $result = $res->fetchAllAssoc();
        echo "Camarades n'ayant plus d'adresses actives, mais ayant une adresse inactive :\n";
        foreach ($result as $user) {
            echo '* ' . $user['email'] . ' pour ' . $user['hruid'] . "\n";
        }
    }
    echo "\n";
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
