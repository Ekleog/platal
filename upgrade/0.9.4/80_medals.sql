-- http://www.medailles-decorations.com/
-- http://perso.wanadoo.fr/tnr.g/

drop table if exists profile_medals;
create table profile_medals (
        id      int not null auto_increment,
        type    enum('ordre', 'croix', 'militaire', 'honneur', 'resistance', 'prix') not null,
        text    varchar(255),
        img     varchar(255),
        primary key (id)
);

drop table if exists profile_medals_grades;
create table profile_medals_grades (
        mid     int not null,
        gid     int not null,
        text    varchar(255),
        pos     int not null,
        index (pos),
        primary key (mid, gid)
);

drop table if exists profile_medals_sub;
create table profile_medals_sub (
        uid int not null,
        mid int not null,
        gid int not null,
        primary key (uid,mid)
);

insert into profile_medals (type, text, img)
     values ('ordre',     'Ordre National de la Legion d\'Honneur',     'ordre_onlh.jpg'),
            ('ordre',     'Ordre de la lib�ration',                     'ordre_lib.jpg'),
            ('ordre',     'Ordre National du M�rite',                   'ordre_nm.jpg'),
            ('ordre',     'Ordre des Palmes Acad�miques',               'ordre_pa.jpg'),
            ('ordre',     'Ordre du M�rite Agricole',                   'ordre_ma.jpg'),
            ('ordre',     'Ordre du M�rite Maritime',                   'ordre_mm.jpg'),
            ('ordre',     'Ordre des Arts et des Lettres',              'ordre_al.jpg'),
            ('croix',     'Croix de Guerre 1914 - 1918',                'croix_1418.jpg'),
            ('croix',     'Croix de Guerre 1939 - 1945',                'croix_3945.jpg'),
            ('croix',     'Croix des T. O. E.',                         'croix_toe.jpg'),
            ('croix',     'Croix de la Valeur Militaire',               'croix_vm.jpg'),
            ('croix',     'Croix du Combattant Volontaire 1914 - 1918', 'croix_cv1418.jpg'),
            ('croix',     'Croix du Combattant Volontaire',             'croix_cv.jpg'),
            ('croix',     'Croix du Combattant',                        'croix_cc.jpg'),

            ('militaire', 'M�daille Militaire',                             'mili_mili.jpg'),
            ('militaire', 'M�daille des �vad�s',                            'mili_eva.jpg'),
            ('militaire', 'M�daille de la Gendarmerie Nationale',           'mili_gn.jpg'),
            ('militaire', 'M�daille de l\'A�ronautique',                    'mili_aero.jpg'),
            ('militaire', 'M�daille du Service de Sant� des Arm�es',        'mili_ssa.jpg'),
            ('militaire', 'M�daille de la D�fense Nationale',               'mili_defnat.jpg'),
            ('militaire', 'M�daille des Services Militaires Volontaires',   'mili_smv.jpg'),
            ('militaire', 'M�daille d\'Outre-Mer',                          'mili_om.jpg'),
            ('militaire', 'Insignes des Bl�ss�s Militaires',                'mili_ib.jpg'),
            ('militaire', 'M�daille d\'Afrique du Nord',                    'mili_an.jpg'),
            ('militaire', 'Titre de la Reconnaissance de la Nation',        'mili_trn.jpg'),
            ('militaire', 'M�daille des Engag�s Volontaires',               'mili_ev.jpg'),

            ('honneur',   'Actes de D�vouement et Faits de Sauvetage',      'honn_adfs.jpg'),
            ('honneur',   'Actes de Courage et de D�vouement',              'honn_acd.jpg'),
            ('honneur',   'M�daille des Secours Mutuels',                   'honn_sm.jpg'),
            ('honneur',   'M�daille d\'Honneur des Eaux et For�ts',         'honn_ef.jpg'),
            ('honneur',   'Enseignement du Premier Degr�',                  'honn_pd.jpg'),
            ('honneur',   'Minist�re du Commerce et de l\'Industrie',       'honn_mci.jpg'),
            ('honneur',   'M�daille d\'Honneur des Affaires Etrang�res',    'honn_ae.jpg'),
            ('honneur',   'M�daille d\'Honneur Agricole',                   'honn_agr.jpg'),
            ('honneur',   'M�daille d\'Honneur de l\'Assistance Publique',  'honn_ap.jpg'),
            ('honneur',   'M�daille d\'Honneur des Epid�mies',              'honn_epi.jpg'),
            ('honneur',   'M�daille d\'Honneur des Douanes',                'honn_dou.jpg'),
            ('honneur',   'M�daille d\'Honneur P�nitentiaire',              'honn_pen.jpg'),

            ('resistance','M�daille de la R�sistance Fran�aise',            'resi_rf.jpg'),
            ('resistance','Croix du Volontaire de la R�sistance',           'resi_cvr.jpg'),
            ('resistance','M�daille de la D�portation - R�sistance',        'resi_dr.jpg'),

            ('prix',      'M�daille Fields',                                'prix_fields.gif'),
            ('prix',      'Prix Nobel d\'�conomie',                         'prix_nb_eco.jpg'),
            ('prix',      'Prix Nobel de Litt�rature',                      'prix_nb_lit.jpg'),
            ('prix',      'Prix Nobel de M�decine',                         'prix_nb_med.jpg'),
            ('prix',      'Prix Nobel de la Paix',                          'prix_nb_paix.jpg'),
            ('prix',      'Prix Nobel de Physique/Chimie',                  'prix_nb_pc.jpg');

insert into admin_a values (5, 'D�corations', 'admin/gerer_decos.php', 40);

