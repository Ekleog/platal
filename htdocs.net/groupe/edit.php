<?php

    require 'xnet.inc.php';
    new_groupadmin_page('xnet/groupe/edit.tpl');

    if (Post::has('submit')) {
        if (has_perms()) {
            $globals->xdb->execute(
                "UPDATE  groupex.asso
                    SET  nom={?}, diminutif={?}, cat={?}, dom={?}, descr={?}, site={?}, mail={?}, resp={?}, forum={?}, mail_domain={?}, ax={?}
                  WHERE  id={?}",
                  Post::get('nom'), Post::get('diminutif'), Post::get('cat'), Post::getInt('dom'),
                  Post::get('descr'), Post::get('site'), Post::get('mail'), Post::get('resp'),
                  Post::get('forum'), Post::get('mail_domain'), Post::has('ax'), $globals->asso('id'));
        } else {
            $globals->xdb->execute(
                "UPDATE  groupex.asso
                    SET  descr={?}, site={?}, mail={?}, resp={?}, forum={?}, ax={?}
                  WHERE  id={?}",
                  Post::get('descr'), Post::get('site'), Post::get('mail'), Post::get('resp'),
                  Post::get('forum'), Post::has('ax'), $globals->asso('id'));
        }

        if ($_FILES['logo']['name']) {
            $logo = file_get_contents($_FILES['logo']['tmp_name']);
            $mime = $_FILES['logo']['type'];
            $globals->xdb->execute('UPDATE groupex.asso SET logo={?}, logo_mime={?} WHERE id={?}', $logo, $mime, $globals->asso('id'));
        }

        header('Location: ../'.Post::get('diminutif', $globals->asso('diminutif')).'/edit.php');
    }

    if (has_perms()) {
        $dom = $globals->xdb->iterator('SELECT * FROM groupex.dom ORDER BY nom');
        $page->assign('dom', $dom);
    }
    $page->run();

?>