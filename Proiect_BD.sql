drop table platforma_joc;
drop table platforma;
drop table gen_joc;
drop table gen;
drop table mod_joc;
drop table mod;
drop table status;
drop table utilizator;
drop table joc;
drop table dezvoltator;
drop table editura;

create table editura
(id_editura number(3) constraint pk_editura primary key,
 nume_editura varchar2(30) constraint nume_editura_not_null not null constraint nume_editura_unique unique);
 
create table dezvoltator
(id_dezvoltator number(3) constraint pk_dezvoltator primary key,
 nume_dezvoltator varchar2(35) constraint nume_dezvoltator_not_null not null constraint nume_dezvoltator_unique unique,
 tip_dezvoltator varchar2(3) constraint tip_dezvoltator_not_null not null constraint tip_dezvoltator_corect check (tip_dezvoltator in ('A', 'AA', 'AAA')),
 id_editura number(3) constraint fk_editura_dez references editura(id_editura) on delete set null);
 
create table joc
(id_joc number(3) constraint pk_joc primary key,
 nume_joc varchar2(35) constraint nume_joc_not_null not null constraint nume_joc_unique unique,
 data_lansare date constraint data_lansare_not_null not null,
 rating number(20) constraint rating_numer_0_10 check (rating >= 0 and rating <= 10),
 id_dezvoltator number(3) constraint fk_dezvoltator_joc references dezvoltator(id_dezvoltator) on delete set null);
 
create table utilizator
(id_utilizator number(3) constraint pk_utilizator primary key,
 nume_utilizator varchar2(25) constraint nume_utilizator_not_null not null constraint nume_utilizator_unique unique,
 nume varchar2(30),
 prenume varchar2(30),
 adresa_email varchar2(35));
 
create table status
(id_utilizator number(3) constraint fk_utilizator_sts references utilizator(id_utilizator) on delete cascade constraint vf_id_utilizator_sts not null,
 id_joc number(3) constraint fk_joc_sts references joc(id_joc) on delete cascade constraint vf_id_joc_sts not null,
 status varchar2(15) constraint status_not_null not null,
 primary key(id_utilizator, id_joc));
 
create table mod
(id_mod number(3) constraint pk_mod primary key,
 nume_mod varchar2(20) constraint nume_mod_not_null not null constraint nume_mod_unique unique);
 
create table mod_joc
(id_mod number(3) constraint fk_mod_jm references mod(id_mod) on delete cascade constraint vf_id_mod_jm not null,
 id_joc number(3) constraint fk_joc_jm references joc(id_joc) on delete cascade constraint vf_id_joc_jm not null,
 primary key(id_mod, id_joc));
 
create table gen
(id_gen number(3) constraint pk_gen primary key,
 nume_gen varchar2(15) constraint nume_gen_not_null not null constraint nume_gen_unique unique);
 
create table gen_joc
(id_gen number(3) constraint fk_gen_jg references gen(id_gen) on delete cascade constraint vf_id_gen_jg not null,
 id_joc number(3) constraint fk_joc_jg references joc(id_joc) on delete cascade constraint vf_id_joc_jg not null,
 primary key(id_gen, id_joc));
 
create table platforma
(id_platforma number(3) constraint pk_platforma primary key,
 nume_platforma varchar2(35) constraint nume_platforma_not_null not null constraint nume_platforma_unique unique,
 nume_fabricant varchar2(35) constraint nume_fabricant_not_null not null);
 
create table platforma_joc
(id_platforma number(3) constraint fk_platforma_jp references platforma(id_platforma) on delete cascade constraint vf_id_platforma_jp not null,
 id_joc number(3) constraint fk_joc_jp references joc(id_joc) on delete cascade constraint vf_id_joc_jp not null,
 primary key(id_platforma, id_joc));

insert into editura values(1, 'Sony');
insert into editura values(2, 'Nintendo');
insert into editura values(3, 'Ubisoft');

insert into dezvoltator values(1, 'Naughty Dog', 'A', 1);
insert into dezvoltator values(2, 'Intelligent Systems', 'AA', 2);
insert into dezvoltator values(3, 'Ubisoft Montreal', 'AAA', 3);

insert into joc values(1, 'Uncharted', to_date('16-11-2007','dd-mm-yyyy'), '8.8 ', 1);
insert into joc values(2, 'Duck Hunt', to_date('21-05-1984','dd-mm-yyyy'), '8.8', 2);
insert into joc values(3, 'Rainbow Six Siege', to_date('27-05-2014','dd-mm-yyyy'), '7.2', 3);

insert into utilizator values(1, 'kov23', 'Kovaci', 'Adrian', 'a.kov@mail.com');
insert into utilizator values(2, 'T_Cod', 'Tama', 'Codin ', 't_codin@gmail.com');
insert into utilizator values(3, 'Nora_1101', 'Fina ', 'Nora', 'FNora41@yahoo.com');

insert into status values(2, 2, 'Terminat');
insert into status values(2, 1, 'In progres');
insert into status values(3, 1, 'Terminat');
insert into status values(1, 3, 'In progres');

insert into mod values(1, 'Single player');
insert into mod values(2, 'Cooperativ');
insert into mod values(3, 'Multiplayer');

insert into mod_joc values(1, 2);
insert into mod_joc values(2, 2);
insert into mod_joc values(3, 3);
insert into mod_joc values(1, 1);

insert into gen values(1, 'Actiune');
insert into gen values(2, 'Aventura');
insert into gen values(3, 'Impuscaturi');

insert into gen_joc values(2, 1);
insert into gen_joc values(3, 2);
insert into gen_joc values(1, 3);

insert into platforma values(1, 'NES', 'Nintendo');
insert into platforma values(2, 'PlayStation', 'Sony');
insert into platforma values(3, 'Windows', 'Microsoft');

insert into platforma_joc values(2, 1);
insert into platforma_joc values(3, 3);
insert into platforma_joc values(3, 2);
insert into platforma_joc values(1, 2);

commit;