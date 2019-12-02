drop sequence seq_idtopik;
drop sequence seq_idkompetensi_a;
drop sequence seq_idkompetensi_b;
drop sequence seq_idkompetensi_c;
drop sequence seq_idkompetensi_d;
drop sequence seq_idaktifitas;
drop sequence seq_idsarpras;

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
    idKur varchar2(6) primary key,
    parentId varchar2(6) references kurikulum(idKur),
    isi varchar2(200),
    constraint validate_idkur check 
        (regexp_like(idkur, '[T|K|A|S][A-D|0-9]\d\d\d\d','c')),
    constraint validate_parentid check 
        (regexp_like(parentid, '[T|K|A|S][A-D|0-9]\d\d\d\d','c'))
);

create sequence seq_idtopik
start with 1 increment by 1;
create sequence seq_idkompetensi_a
start with 1 increment by 1;
create sequence seq_idkompetensi_b
start with 1 increment by 1;
create sequence seq_idkompetensi_c
start with 1 increment by 1;
create sequence seq_idkompetensi_d
start with 1 increment by 1;
create sequence seq_idaktifitas
start with 1 increment by 1;
create sequence seq_idsarpras
start with 1 increment by 1;

create or replace trigger on_insert_kurikulum
before insert
on kurikulum
for each row
declare
    newid varchar2(6);
begin
    case substr(:new.idkur, 1, 1)
    when 'T' then
        newid:= 'T' || lpad(seq_idtopik.nextval, 5, '0');   
    when 'A' then
        newid:= 'A' || lpad(seq_idaktifitas.nextval, 5, '0');
    when 'S' then
        newid:= 'S' || lpad(seq_idsarpras.nextval, 5, '0');
    else case substr(:new.idkur, 2, 1)
        when 'A' then
            newid:= 'KA' || lpad(seq_idkompetensi_a.nextval, 4, '0');
        when 'B' then
            newid:= 'KB' || lpad(seq_idkompetensi_b.nextval, 4, '0');
        when 'C' then
            newid:= 'KC' || lpad(seq_idkompetensi_c.nextval, 4, '0');
        else
            newid:= 'KD' || lpad(seq_idkompetensi_d.nextval, 4, '0');
        end case;
    end case;
    select newid into :new.idkur from dual;
end;
/

insert into kurikulum values ('T', null, 'Berlindung')    ;
insert into kurikulum values ('KA', 'T00001', 'Mengenal figur Buddha');
insert into kurikulum values ('A', 'KA0001', 'Mewarnai gambar Buddha sederhana');
insert into kurikulum values ('S', 'A00001', 'Kertas bergambar Buddha sederhana');
insert into kurikulum values ('S', 'A00001', 'Pensil warna');
insert into kurikulum values ('S', 'A00001', 'Meja lipat kecil');
insert into kurikulum values ('A', 'KA0001', 'Mencocokkan gambar siluet Buddha');
insert into kurikulum values ('S', 'A00002', 'Kertas bergambar siluet Buddha');
insert into kurikulum values ('S', 'A00002', 'Lem kertas');
insert into kurikulum values ('A', 'KA0001', 'Nyanyi lagu "Aku sayang Buddha"');
insert into kurikulum values ('S', 'A00003', 'Teks lagu "Aku sayang Buddha"');
insert into kurikulum values ('KA', 'T00001', 'Mengenal figur Buddha, Dhamma, dan Sangha');
insert into kurikulum values ('A', 'KA0002', 'Penjelasan secara lisan dan visual');
insert into kurikulum values ('S', 'A00004', 'Foto/gambar/rupa yang menggambarkan Buddha, Dhamma, dan Sangha');
insert into kurikulum values ('A', 'KA0002', 'Vihara gita');
insert into kurikulum values ('S', 'A00005', 'Musik dan lirik');
insert into kurikulum values ('S', 'A00005', 'Lagu "Aku berlindung"');
insert into kurikulum values ('KA', 'T00001', 'Penjelasan Namaskara');
insert into kurikulum values ('A', 'KA0003', 'Mengenalkan jenis-jenis namaskara');
insert into kurikulum values ('S', 'A00006', 'Video namaskara berbagai aliran');
insert into kurikulum values ('S', 'A00006', 'Praktik namaskara');
insert into kurikulum values ('KB', 'T00001', 'Mengenal kata "BUDDHA"');
insert into kurikulum values ('KC', 'T00001', 'Definisi dan sifat-sifat Tiratana');
insert into kurikulum values ('A', 'KC0001', 'Mempelajari arti Sugato, Lokavidu, Anuttaro, dst');
insert into kurikulum values ('A', 'KC0001', 'Mempelajari arti Sanditthiko, Akaliko, Ehipassiko, dst');
insert into kurikulum values ('A', 'KC0001', 'Mempelajari arti Supatipanno, Ujupatipanno, dst');
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

insert into pembicara (nama) values ('Marlina');
insert into pembicara (panggilan) values ('Mama Darrell');
insert into pembicara (nama) values ('Ferlina');
insert into pembicara (nama) values ('Samsul');
insert into pembicara (nama, panggilan, tgl_lahir, alamat) values ('Jordi Yaputra', 'Jordi', '14-07-1999', 'Jl. Telekomunikasi, Gg. PGA');
insert into pembicara (nama) values ('Robert');
insert into pembicara (nama, panggilan, tgl_lahir, alamat) values ('Hendry Filcozwei Jan', 'Papa Dhika n Revata', '11-5-1970', 'Kompleks Permata Kopo Blok EA No. 343, Bandung');

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
    if (:new.status is null) then
        select case
            when :new.tgl < sysdate then 'selesai'
            else 'belum'
        end case into :new.status from dual;
    end if;
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

select *  from kurikulum
where parentid in (
    select idkur from kurikulum
    where parentid in (
        select idkur from kurikulum
        where isi='Berlindung'
    )
)
order by parentid;

insert into jadwalajar (tgl) values ('25-08-2019');
insert into jadwalajar (tgl) values ('1-9-2019');
insert into jadwalajar (tgl) values ('8-9-2019');
insert into jadwalajar (tgl) values ('15-9-2019');
insert into jadwalajar (tgl) values ('22-09-2019');
insert into jadwalajar (tgl) values ('29-9-2019');

insert into plot
select null, 1, 'A', idkur, 1 from kurikulum where isi = 'Mengenal kata "BUDDHA"';
insert into plot
select null, 1, 'B', idkur, 2 from kurikulum where isi = 'Mengenal figur Buddha, Dhamma, dan Sangha';
insert into plot select 1, 1, 'C', idkur, 
(select idpembicara from pembicara where panggilan='Papa Dhika n Revata') as idpembicara
from kurikulum where isi = 'Definisi dan sifat-sifat Tiratana';

select * from plot;