<?php
/***************************************************************************
 *  Copyright (C) 2003-2009 Polytechnique.org                              *
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

class ReminderGapps extends Reminder
{
    public function HandleAction($action)
    {
        switch ($action) {
          case 'yes':
            $this->UpdateOnYes();
            pl_redirect('googleapps');
            break;

          case 'dismiss':
            $this->UpdateOnDismiss();
            break;

          case 'no':
            $this->UpdateOnNo();
            break;
        }
    }

    public function text()
    {
        return "Polytechnique.org te fournit un compte Google Apps qui te permet
            de disposer des applications web de Google (GMail, Google Calendar,
            Google Docs, et bien d'autres) sur ton adresse Polytechnique.org
            habituelle (en savoir plus).";
    }
    public function title()
    {
        return "Création d'un compte Google Apps";
    }

    public static function IsCandidate(User &$user, $candidate)
    {
        require_once 'googleapps.inc.php';
        $isSubscribed = GoogleAppsAccount::account_status($user->id());
        if ($isSubscribed) {
            Reminder::MarkCandidateAsAccepted($user->id(), $candidate);
        }
        return !$isSubscribed;
    }
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>