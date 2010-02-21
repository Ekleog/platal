CREATE TABLE IF NOT EXISTS profile_education_field_enum (
  id INT(2) NOT NULL AUTO_INCREMENT,
  field VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY(id),
  UNIQUE KEY(field)
) ENGINE=InnoDB, CHARSET=utf8;

CREATE TABLE IF NOT EXISTS profile_education_degree_enum (
  id INT(2) NOT NULL AUTO_INCREMENT,
  degree VARCHAR(255) DEFAULT NULL,
  abbreviation VARCHAR(255) DEFAULT '' NOT NULL,
  level TINYINT (1) UNSIGNED DEFAULT 0 NOT NULL,
  PRIMARY KEY(id),
  UNIQUE KEY(degree)
) ENGINE=InnoDB, CHARSET=utf8;

CREATE TABLE IF NOT EXISTS profile_education_degree (
  eduid INT(4) NOT NULL DEFAULT 0,
  degreeid INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY(eduid, degreeid)
) ENGINE=InnoDB, CHARSET=utf8;

CREATE TABLE IF NOT EXISTS profile_education_enum (
  id INT(4) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) DEFAULT NULL,
  abbreviation VARCHAR(255) DEFAULT '' NOT NULL,
  url VARCHAR(255) DEFAULT NULL,
  country CHAR(2) NOT NULL DEFAULT 'FR',
  PRIMARY KEY(id),
  UNIQUE KEY(name)
) ENGINE=InnoDB, CHARSET=utf8;

CREATE TABLE IF NOT EXISTS profile_education (
  id TINYINT(2) UNSIGNED NOT NULL DEFAULT 0,
  uid INT(11) NOT NULL DEFAULT 0,
  eduid INT(4) NOT NULL DEFAULT 0,
  degreeid INT(4) NOT NULL DEFAULT 0,
  fieldid INT(2) NOT NULL DEFAULT 0,
  entry_year INT(4) DEFAULT NULL,
  grad_year INT(4) DEFAULT NULL,
  program VARCHAR(255) DEFAULT NULL,
  flags SET('primary') DEFAULT '' NOT NULL,
  PRIMARY KEY(id, uid),
  INDEX uid (uid)
) ENGINE=InnoDB, CHARSET=utf8;

INSERT INTO  profile_education_field_enum (field)
     VALUES  ('Aéronautique'), ('Agronomie'), ('Assurance'), ('Biologie'),
             ('Chimie'), ('Droit'), ('Économie'), ('Électronique/électricité'),
             ('Environnement/développement durable'), ('Finance'), ('Géographie'),
             ('Histoire'), ('Informatique'), ('Langues'), ('Mathématiques'),
             ('Mathématiques appliquées'), ('Mécanique'), ('Médecine'),
             ('Philosophie'), ('Physique'), ('Sciences politiques');

INSERT INTO  profile_education_degree_enum (degree)
     VALUES  ('Diplôme'), ('Ingénieur'), ('Corps'), ('MS'), ('PhD'),
             ('DEA'), ('ME'), ('MBA'), ('MiF'), ('MPA'), ('Licence');

INSERT INTO  profile_education_degree (eduid, degreeid)
     SELECT  a.id, d.id
       FROM  #x4dat#.applis_def AS a
 INNER JOIN  profile_education_degree_enum AS d ON (FIND_IN_SET(d.degree, a.type));

INSERT INTO  profile_education_enum (id, name, url)
     SELECT  id, text, url
       FROM  #x4dat#.applis_def;

INSERT INTO  profile_education (id, uid, eduid, degreeid)
     SELECT  a.ordre, a.uid, a.aid, d.id
       FROM  #x4dat#.applis_ins AS a
 INNER JOIN  profile_education_degree_enum AS d ON (a.type = d.degree);

     UPDATE  watch_profile AS w1
 INNER JOIN  watch_profile AS w2 ON (w1.uid = w2.uid AND w1.field = 'appli1' AND w2.field = 'appli2')
        SET  w1.ts = IF(w1.ts > w2.ts, w1.ts, w2.ts), w2.ts = IF(w1.ts > w2.ts, w1.ts, w2.ts);

INSERT IGNORE INTO  watch_profile (uid, ts, field)
            SELECT  uid, ts, 'appli1'
              FROM  watch_profile
             WHERE  field = 'appli2';

ALTER TABLE watch_profile MODIFY field enum('nom', 'freetext', 'mobile', 'nationalite', 'nationalite2',
                                            'nationalite3', 'nick', 'web', 'networking', 'appli1', 'appli2',
                                            'edus', 'addresses', 'section', 'binets', 'medals', 'cv', 'jobs',
                                            'photo');

UPDATE watch_profile SET field = 'edus' WHERE field = 'appli1';


DELETE FROM watch_profile WHERE field = 'appli2';

ALTER TABLE watch_profile MODIFY field enum('nom', 'freetext', 'mobile', 'nationalite', 'nationalite2',
                                            'nationalite3', 'nick', 'web', 'networking', 'edus', 'addresses',
                                            'section', 'binets', 'medals', 'cv', 'jobs', 'photo');

# vim:set syntax=mysql:

