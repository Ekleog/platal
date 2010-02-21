DROP TABLE IF EXISTS profile_networking_enum;
DROP TABLE IF EXISTS profile_networking;

CREATE TABLE `profile_networking_enum` (
    `network_type` tinyint unsigned NOT NULL,
    `name` varchar(30) NOT NULL,
    `icon` varchar(50) NOT NULL COMMENT 'icon filename',
    `filter` enum('email','web','number','none') NOT NULL DEFAULT 'none' COMMENT 'filter type for addresses',
    `link` varchar(255) NOT NULL COMMENT 'string used to forge an URL linking to the the profile page',
    PRIMARY KEY (`network_type`)
) ENGINE=InnoDB, CHARSET=utf8, COMMENT='types of networking addresses';


CREATE TABLE `profile_networking` (
    `pid` int NOT NULL COMMENT 'profile id',
    `nwid` tinyint unsigned NOT NULL COMMENT 'number of the address for the user',
    `network_type` tinyint unsigned NOT NULL,
    `address` varchar(255) NOT NULL,
    `pub` enum('private','public') NOT NULL DEFAULT 'private',
    PRIMARY KEY (`pid`, `nwid`),
    INDEX uid (pid)
) ENGINE=InnoDB, CHARSET=utf8, COMMENT='networking addresses';

-- Insert a first address type for old URLs
INSERT INTO `profile_networking_enum` (`network_type`, `name`, `icon`, `filter`)
     VALUES (0, 'Page web', 'web.gif', 'web');

INSERT INTO `profile_networking` (`pid`, `nwid`, `network_type`, `address`, `pub`)
     SELECT `user_id`, 0, 0, `profile_web`, `profile_web_pub`
       FROM #x4dat#.`auth_user_quick`
      WHERE `profile_web` <> "";

-- Modify watch_profile to update 'field' from web to networking
ALTER TABLE `watch_profile`
     MODIFY `field` enum('nom', 'freetext', 'mobile', 'nationalite', 'nick',
                         'web', 'networking', 'appli1', 'appli2', 'addresses',
                         'section', 'binets', 'medals', 'cv', 'jobs', 'photo');

UPDATE `watch_profile` SET `field` = 'networking' WHERE `field` = 'web';

ALTER TABLE `watch_profile`
     MODIFY `field` enum('nom', 'freetext', 'mobile', 'nationalite', 'nick',
                         'networking', 'appli1', 'appli2', 'addresses',
                         'section', 'binets', 'medals', 'cv', 'jobs', 'photo');

# vim:set syntax=mysql:
