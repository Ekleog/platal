-- MySQL dump 9.11
--
-- Host: localhost    Database: x4dat
-- ------------------------------------------------------
-- Server version	4.0.21-log

--
-- Table structure for table `nationalites`
--

DROP TABLE IF EXISTS `nationalites`;
CREATE TABLE `nationalites` (
  `id` tinyint(3) unsigned NOT NULL default '0',
  `text` varchar(50) NOT NULL default '',
  `iso3166` char(2) NOT NULL default '',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM PACK_KEYS=1 COMMENT='liste des nationalits';

--
-- Dumping data for table `nationalites`
--

INSERT INTO `nationalites` VALUES (0,'','');
INSERT INTO `nationalites` VALUES (1,'Albanais','AL');
INSERT INTO `nationalites` VALUES (2,'Alg�rien','DZ');
INSERT INTO `nationalites` VALUES (3,'Allemand','DE');
INSERT INTO `nationalites` VALUES (4,'Am�ricain','US');
INSERT INTO `nationalites` VALUES (5,'Argentin','AR');
INSERT INTO `nationalites` VALUES (6,'Australien','AU');
INSERT INTO `nationalites` VALUES (7,'Autrichien','AT');
INSERT INTO `nationalites` VALUES (8,'Belge','BE');
INSERT INTO `nationalites` VALUES (9,'Benin','BJ');
INSERT INTO `nationalites` VALUES (10,'Botswanais','BW');
INSERT INTO `nationalites` VALUES (11,'Bouthan','BT');
INSERT INTO `nationalites` VALUES (12,'Br�silien','BR');
INSERT INTO `nationalites` VALUES (13,'Britannique','GB');
INSERT INTO `nationalites` VALUES (14,'Bulgare','BG');
INSERT INTO `nationalites` VALUES (15,'Burkina Faso','BF');
INSERT INTO `nationalites` VALUES (16,'Cambodgien','KH');
INSERT INTO `nationalites` VALUES (17,'Camerounais','');
INSERT INTO `nationalites` VALUES (18,'Canadien','');
INSERT INTO `nationalites` VALUES (19,'Chilien','');
INSERT INTO `nationalites` VALUES (20,'Chinois','');
INSERT INTO `nationalites` VALUES (21,'Colombien','');
INSERT INTO `nationalites` VALUES (22,'Cor�en','');
INSERT INTO `nationalites` VALUES (80,'Croate','');
INSERT INTO `nationalites` VALUES (23,'Cubain','');
INSERT INTO `nationalites` VALUES (24,'Danois','');
INSERT INTO `nationalites` VALUES (25,'Ecossais','');
INSERT INTO `nationalites` VALUES (26,'Egyptien','');
INSERT INTO `nationalites` VALUES (81,'Equatorien','');
INSERT INTO `nationalites` VALUES (27,'Espagnol','');
INSERT INTO `nationalites` VALUES (28,'Estonien','');
INSERT INTO `nationalites` VALUES (29,'Finlandais','');
INSERT INTO `nationalites` VALUES (30,'Fran�ais','FR');
INSERT INTO `nationalites` VALUES (31,'Gabonais','');
INSERT INTO `nationalites` VALUES (32,'Georgien','');
INSERT INTO `nationalites` VALUES (33,'Grec','');
INSERT INTO `nationalites` VALUES (34,'Ha�tien','');
INSERT INTO `nationalites` VALUES (36,'Hong-Kong','');
INSERT INTO `nationalites` VALUES (37,'Hongrois','');
INSERT INTO `nationalites` VALUES (38,'Indien','');
INSERT INTO `nationalites` VALUES (39,'Iranien','');
INSERT INTO `nationalites` VALUES (40,'Irlandais','');
INSERT INTO `nationalites` VALUES (41,'Islandais','');
INSERT INTO `nationalites` VALUES (42,'Isra�lien','');
INSERT INTO `nationalites` VALUES (43,'Italien','');
INSERT INTO `nationalites` VALUES (44,'Ivoirien','');
INSERT INTO `nationalites` VALUES (45,'Jama�cain','');
INSERT INTO `nationalites` VALUES (46,'Japonais','');
INSERT INTO `nationalites` VALUES (47,'Kazakh','');
INSERT INTO `nationalites` VALUES (48,'Kurde','');
INSERT INTO `nationalites` VALUES (49,'Lettonien','');
INSERT INTO `nationalites` VALUES (50,'Libanais','');
INSERT INTO `nationalites` VALUES (51,'Lituanien','');
INSERT INTO `nationalites` VALUES (52,'Luxembourgeois','');
INSERT INTO `nationalites` VALUES (53,'Mac�donien','');
INSERT INTO `nationalites` VALUES (82,'Malgache','');
INSERT INTO `nationalites` VALUES (54,'Malien','');
INSERT INTO `nationalites` VALUES (55,'Marocain','');
INSERT INTO `nationalites` VALUES (56,'Mexicain','');
INSERT INTO `nationalites` VALUES (35,'N�erlandais','');
INSERT INTO `nationalites` VALUES (57,'N�o-Z�landais','');
INSERT INTO `nationalites` VALUES (58,'Norv�gien','');
INSERT INTO `nationalites` VALUES (59,'Palestinien','');
INSERT INTO `nationalites` VALUES (60,'P�ruvien','');
INSERT INTO `nationalites` VALUES (61,'Polonais','');
INSERT INTO `nationalites` VALUES (62,'Portugais','');
INSERT INTO `nationalites` VALUES (63,'Roumain','');
INSERT INTO `nationalites` VALUES (64,'Russe','');
INSERT INTO `nationalites` VALUES (65,'S�n�galais','');
INSERT INTO `nationalites` VALUES (66,'Serbe','');
INSERT INTO `nationalites` VALUES (84,'Singapourien','');
INSERT INTO `nationalites` VALUES (67,'Slovaque','');
INSERT INTO `nationalites` VALUES (69,'Sud-Africain','');
INSERT INTO `nationalites` VALUES (70,'Su�dois','');
INSERT INTO `nationalites` VALUES (71,'Suisse','');
INSERT INTO `nationalites` VALUES (72,'Tadjik','');
INSERT INTO `nationalites` VALUES (73,'Ta�wanais','');
INSERT INTO `nationalites` VALUES (74,'Tch�que','');
INSERT INTO `nationalites` VALUES (75,'Tunisien','');
INSERT INTO `nationalites` VALUES (76,'Turc','');
INSERT INTO `nationalites` VALUES (83,'Ukrainien','');
INSERT INTO `nationalites` VALUES (85,'Uruguayen','');
INSERT INTO `nationalites` VALUES (77,'V�n�zu�lien','');
INSERT INTO `nationalites` VALUES (78,'Vietnamien','');
INSERT INTO `nationalites` VALUES (79,'Yougoslave','');

