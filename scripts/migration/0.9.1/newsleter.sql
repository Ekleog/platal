-- MySQL dump 9.11
--
-- Host: localhost    Database: x4dat
-- ------------------------------------------------------
-- Server version	4.0.21-log

--
-- Table structure for table `newsletter`
--

DROP TABLE IF EXISTS `newsletter`;
CREATE TABLE `newsletter` (
  `id` int(11) NOT NULL auto_increment,
  `date` date NOT NULL default '0000-00-00',
  `titre` varchar(255) NOT NULL default '',
  `bits` enum('sent','new') NOT NULL default 'new',
  `head` mediumtext NOT NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM COMMENT='liste des NL envoyes';

--
-- Dumping data for table `newsletter`
--

INSERT INTO `newsletter` VALUES (3,'2001-11-04','Lettre n�3 de Polytechnique.org : novembre 2001','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 3�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (4,'2001-12-22','Lettre n�4 de Polytechnique.org : d�cembre 2001','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 4�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (5,'2002-03-01','Lettre n�5 de Polytechnique.org : mars 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 5�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (6,'2002-04-01','Lettre n�6 de Polytechnique.org : avril 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 6�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (7,'2002-05-02','Lettre n�7 de Polytechnique.org : mai 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 7�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (9,'2002-07-01','Lettre n�9 de Polytechnique.org : juillet 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 9�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (8,'2002-06-02','Lettre n�8 de Polytechnique.org : juin 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 8�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (13,'2002-11-01','Lettre n�13 de Polytechnique.org : novembre 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 13�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (14,'2002-12-02','Lettre n�14 de Polytechnique.org : d�cembre 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 14�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (15,'2003-01-02','Lettre n�15 de Polytechnique.org : janvier 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 15�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (21,'2003-07-10','Lettre n�21 de Polytechnique.org : juillet 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 21�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (20,'2003-06-01','Lettre n�20 de Polytechnique.org : juin 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 20�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (19,'2003-04-27','Lettre n�19 de Polytechnique.org : mai 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 19�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (18,'2003-04-01','Lettre n�18 de Polytechnique.org : avril 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 18�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (35,'2004-09-01','Lettre n�34 de Polytechnique.org : septembre 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 34�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (29,'2004-03-01','Lettre n�29 de Polytechnique.org : mars 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 29�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (36,'2004-10-01','Lettre n�35 de Polytechnique.org : octobre 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 35�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (26,'2003-12-30','Lettre n�26 de Polytechnique.org : d�cembre 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 26�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (27,'2004-01-01','Lettre n�27 de Polytechnique.org : janvier 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 27�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (25,'2003-10-25','Lettre n�25 de Polytechnique.org : novembre 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 25�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (22,'2003-09-01','Lettre n�22 de Polytechnique.org : septembre 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 22�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (24,'2003-10-01','Lettre n�24 de Polytechnique.org : octobre 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 24�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (30,'2004-03-08','Lettre exceptionnelle \"speciale virus\"','','');
INSERT INTO `newsletter` VALUES (31,'2004-04-01','Lettre n�30 de Polytechnique.org : avril 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 30�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (32,'2004-05-01','Lettre n�31 de Polytechnique.org : mai 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 31�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (33,'2004-06-01','Lettre n�32 de Polytechnique.org : juin 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 32�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (34,'2004-07-01','Lettre n�33 de Polytechnique.org : juillet 2004','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 33�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (28,'2004-02-01','Lettre n�28 de Polytechnique.org : f�vrier 2004','','<cher> <prenom>,\r\n \r\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 28�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (23,'2003-09-24','R�seaux polytechniciens, r�seau Internet : m�me combat ?','','<cher> <prenom>,\r\n\r\nVoici une lettre d\'information exceptionnelle du site Polytechnique.org.\r\n');
INSERT INTO `newsletter` VALUES (1,'2001-04-24','Lettre n�1 de Polytechnique.org : avril 2001','','<cher> <prenom>,\r\n \r\n L\'�quipe de Polytechnique.org est fi�re de te pr�senter la 1�re lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (2,'2001-09-28','Lettre n�2 de Polytechnique.org : octobre 2001','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 2�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (12,'2002-10-01','Lettre n�12 de Polytechnique.org : octobre 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 12�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (16,'2003-02-01','Lettre n�16 de Polytechnique.org : f�vrier 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 16�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (10,'2002-08-01','Lettre n�10 de Polytechnique.org : ao�t 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 10�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (11,'2002-09-02','Lettre n�11 de Polytechnique.org : septembre 2002','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 11�me lettre d\'information des polytechniciens sur le net.');
INSERT INTO `newsletter` VALUES (17,'2003-03-01','Lettre n�17 de Polytechnique.org : mars 2003','','<cher> <prenom>,\n\nL\'�quipe de Polytechnique.org est fi�re de te pr�senter la 17�me lettre d\'information des polytechniciens sur le net.');

