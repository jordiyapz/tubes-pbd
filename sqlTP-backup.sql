drop sequence seq_idpembicara;
drop sequence seq_idkontak;
drop sequence seq_idjadwal;
drop sequence seq_idplot;

drop table plot;
drop table jadwalajar;
drop table kurikulum;
drop table kontak;
drop table pembicara;

create table kurikulum (
    -- FORMAT K[T|K|A|S]0-9|A-D][00-99][0-9|A-D][01-99]
    idKur varchar2(8) primary key,
    parentId varchar2(8) references kurikulum(idKur),
    isi varchar2(200),
    constraint validate_idkur
    check(regexp_like(idkur, 'K[T|K|A|S][0-9|A-D]\d\d[0-9|A-D]\d[1-9]', 'c')),
    constraint validate_parentid
    check(regexp_like(parentid, 'K[T|K|A|S][0-9|A-D]\d\d[0-9|A-D]\d[1-9]', 'c'))
);

insert into kurikulum
values ('KT000001', null, 'Berlindung');

insert into kurikulum
values ('KK001A01', 'KT000001', 'Mengenal figur Buddha');

insert into kurikulum
values ('KAA01001', 'KK001A01', 'Mewarnai gambar Buddha sederhana');

insert into kurikulum
values ('KS001001', 'KAA01001', 'Kertas bergambar Buddha sederhana');
insert into kurikulum
values ('KS001002', 'KAA01001', 'Pensil warna');
insert into kurikulum
values ('KS001003', 'KAA01001', 'Meja lipat kecil');

insert into kurikulum
values ('KAA01002', 'KK001A01', 'Mencocokkan gambar siluet Buddha');

insert into kurikulum
values ('KS002001', 'KAA01002', 'Kertas bergambar siluet Buddha');
insert into kurikulum
values ('KS002002', 'KAA01002', 'Lem kertas');

create table Pembicara (
    idPembicara number primary key,
    nama varchar2(20) default '-',
    panggilan varchar2(20) default '-',
    tgl_lahir date,
    alamat varchar2(50) default '-'
);

alter session set nls_date_format ='DD-MM-YYYY';

create sequence seq_idpembicara
start with 1 increment by 1;

create or replace trigger on_insertpembicara
before insert
on pembicara
referencing new as new
for each row
begin
    select seq_idpembicara.nextval
    into :new.idpembicara from dual;
end;
/

insert into pembicara (nama)
values ('Marlina');
insert into pembicara (panggilan)
values ('Mama Darrell');
insert into pembicara (nama)
values ('Ferlina');
insert into pembicara (nama)
values ('Samsul');
insert into pembicara (nama, panggilan, tgl_lahir, alamat)
values ('Jordi Yaputra', 'Jordi', '14-07-1999', 'Jl. Telekomunikasi, Gg. PGA');

create table kontak (
    idKontak number primary key,
    idpembicara number references pembicara(idpembicara),
    tipe varchar2(6) not null,
    data varchar2(30) not null
);

create sequence seq_idkontak
start with 1 increment by 1;

create or replace trigger on_insertkontak
before insert
on kontak
referencing new as new
for each row
begin
    select seq_idkontak.nextval
    into :new.idkontak from dual;
end;
/

insert into kontak (idpembicara, tipe, data)
values (2, 'wa', '081388341598');
insert into kontak (idpembicara, tipe, data)
values (5, 'wa', '082196510849');

create table jadwalajar (
    idjadwal varchar2(8) primary key,
    tgl date not null,
    status varchar2(10) not null,
    keterangan varchar2(200) default '-'
);

create sequence seq_idjadwal
start with 1 increment by 1;

create or replace trigger on_insertjadwal
before insert
on jadwalajar
referencing new as new
for each row
begin
    select seq_idjadwal.nextval
    into :new.idjadwal from dual;
end;
/

create table plot (
    idplot number primary key,
    idjadwal varchar2(8) references jadwalajar(idjadwal) not null,
    kelas varchar2(4) not null,
    idkur varchar2(8) references kurikulum(idkur),
    idpembicara number references pembicara(idpembicara)
);


create sequence seq_idplot
start with 1 increment by 1;

create or replace trigger on_insertplot
before insert
on plot
referencing new as new
for each row
begin
    select seq_idplot.nextval
    into :new.idplot from dual;
end;
/
