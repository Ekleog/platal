DROP TABLE IF EXISTS profile_display;

CREATE TABLE  profile_display (
  pid INT(11) NOT NULL DEFAULT 0,
  yourself VARCHAR(255) NOT NULL,
  public_name VARCHAR(255) NOT NULL,
  private_name VARCHAR(255) NOT NULL,
  directory_name VARCHAR(255) NOT NULL,
  short_name VARCHAR(255) NOT NULL,
  sort_name VARCHAR(255) NOT NULL,
  promo VARCHAR(255) DEFAULT '' NOT NULL,
  PRIMARY KEY(pid)
) CHARSET=utf8;

INSERT INTO  profile_display (pid, yourself, public_name, private_name, directory_name, short_name, sort_name)
     SELECT  u.user_id, u.prenom,
             CONCAT(u.prenom, ' ', IF(u.nom_usage != '', CONCAT(u.nom_usage, ' (', u.nom, ')') , u.nom)),
             CONCAT(u.prenom, ' ', IF(u.nom_usage != '', CONCAT(u.nom_usage, ' (', u.nom, ')') , u.nom),
               IF(q.profile_nick != '', CONCAT(' (alias ', q.profile_nick, ')'), '')),
             CONCAT(IF(u.nom_usage != '', CONCAT(u.nom_usage, ' (', u.nom, ')') , u.nom), ' ', u.prenom),
             CONCAT(u.prenom, ' ', IF(u.nom_usage != '', u.nom_usage, u.nom)),
             CONCAT(IF(u.nom_usage != '', u.nom_usage, u.nom), ' ', u.prenom)
       FROM  auth_user_md5   AS u
  LEFT JOIN  auth_user_quick AS q ON (u.user_id = q.user_id);


DROP TABLE IF EXISTS profile_name_search_enum;

CREATE TABLE IF NOT EXISTS profile_name_search_enum (
  id TINYINT(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  explanations VARCHAR(255) NOT NULL,
  flags SET('has_particle', 'not_displayed', 'always_displayed', 'public') NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (name)
) CHARSET=utf8;

INSERT INTO  profile_name_search_enum (name, flags, explanations)
     VALUES  ('Nom patronymique', 'has_particle,always_displayed,public', 'Le nom de famille avec lequel tu es n�'),
             ('Nom marital', 'has_particle,always_displayed,public',
              'Ton nom d\'�pouse ou d\'�poux'),
             ('Nom usuel', 'has_particle,always_displayed,public',
              'Le nom de famille que tu utilises usuellement s\'il est diff�rent du nom patronymique, ce peut-�tre une  version racourcie de celui-ci, ton nom marital, une combianaison de ces deux noms...'),
             ('Pr�nom', 'always_displayed,public', 'Ton pr�nom'),
             ('Pseudonyme (nom de plume)', 'always_displayed,public',
              'Pseudonyme pour les artistes, gens de lettres'),
             ('Surnom', '', 'Surnom � l\'�cole ou ailleurs'),
             ('Pr�nom usuel', 'public', 'Si tu utilises une version raccourcie, francis�e... de ton pr�nom'),
             ('Autre pr�nom', '', 'Si tu as d\'autres pr�noms et que tu souhaites les faire appara�tre'),
             ('Autre nom', '', 'Si tu as d\'autres noms et que tu souhaites les faire appara�tre'),
             ('Nom initial', 'has_particle,not_displayed,public', ''),
             ('Pr�nom initial', 'has_particle,not_displayed,public', '');


DROP TABLE IF EXISTS profile_name_search;

CREATE TABLE IF NOT EXISTS profile_name_search (
  id TINYINT(2) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id of this name for this user',
  pid INT(11) NOT NULL COMMENT 'id of alumni',
  name VARCHAR(255) NOT NULL COMMENT 'name to search for',
  particle VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'particle of the name to search for',
  typeid TINYINT(2) UNSIGNED NOT NULL COMMENT 'type of name',
  PRIMARY KEY (pid, id)
) CHARSET=utf8 COMMENT = 'Names of alumni (search table)';

INSERT INTO  profile_name_search (pid, name, typeid)
     SELECT  u.user_id, u.nom, e.id
       FROM  auth_user_md5            AS u
 INNER JOIN  profile_name_search_enum AS e ON (e.name = 'Nom patronymique')
      WHERE  nom != '';

INSERT INTO  profile_name_search (pid, name, typeid)
     SELECT  u.user_id, u.nom_ini, e.id
       FROM  auth_user_md5            AS u
 INNER JOIN  profile_name_search_enum AS e ON (e.name = 'Nom initial')
      WHERE  nom_ini != '';

INSERT INTO  profile_name_search (pid, name, typeid)
     SELECT  u.user_id, u.prenom, e.id
       FROM  auth_user_md5            AS u
 INNER JOIN  profile_name_search_enum AS e ON (e.name = 'Pr�nom')
      WHERE  prenom != '';

INSERT INTO  profile_name_search (pid, name, typeid)
     SELECT  u.user_id, u.prenom_ini, e.id
       FROM  auth_user_md5            AS u
 INNER JOIN  profile_name_search_enum AS e ON (e.name = 'Pr�nom initial')
      WHERE  prenom_ini != '';

INSERT INTO  profile_name_search (pid, name, typeid)
     SELECT  u.user_id, u.nom_usage, e.id
       FROM  auth_user_md5            AS u
 INNER JOIN  profile_name_search_enum AS e ON (e.name = 'Nom usuel')
      WHERE  nom_usage != '';

INSERT INTO  profile_name_search (pid, name, typeid)
     SELECT  q.user_id, q.profile_nick, e.id
       FROM  auth_user_quick          AS q
 INNER JOIN  profile_name_search_enum AS e ON (e.name = 'Surnom')
      WHERE  profile_nick != '';

-- vim:set syntax=mysql:
