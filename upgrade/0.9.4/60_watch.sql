alter table watch_cat add column type enum('basic', 'near', 'often') not null default 'basic';
update watch_cat set type='often' where frequent=1;
alter table watch_cat drop column frequent;
insert into watch_cat (id, short, mail, type) values(4, 'Anniversaires', 'Ces camarades ont fet� leur anniversaire cette semaine', 'near');
