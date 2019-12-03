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

insert into kurikulum values ('T', null, 'Berlindung');
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
insert into kurikulum values ('KA', 'T00001', 'Belajar Paritta dan artinya');
insert into kurikulum values ('A', 'KA0004', 'Membaca paritta Buddhanussati lengkap');
insert into kurikulum values ('S', 'A00007', 'Teks paritta Buddhanussati lengkap');
insert into kurikulum values ('A', 'KA0004', 'Membaca paritta Dhammanussati lengkap');
insert into kurikulum values ('S', 'A00008', 'Teks paritta Dhammanussati lengkap');
insert into kurikulum values ('A', 'KA0004', 'Membaca paritta Sanghanussati lengkap');
insert into kurikulum values ('S', 'A00009', 'Teks paritta Sanghanussati lengkap');
insert into kurikulum values ('T', null, 'Pancasila');
insert into kurikulum values ('KA', 'T00002', 'Menyayangi makhluk hidup');
insert into kurikulum values ('A', 'KA0005', 'Mengajak murid memberi makan ikan');
insert into kurikulum values ('S', 'A00010', 'Sayur untuk makanan ikan Koi di kolam koi VVD');
insert into kurikulum values ('A', 'KA0005', 'Menonton film "Titi Tata" tentang menyelamatkan kodok');
insert into kurikulum values ('S', 'A00011', 'Kartun "Titi Tata menyelamatkan kodok"');
insert into kurikulum values ('KA', 'T00002', 'Penerapan Pancasila');
insert into kurikulum values ('A', 'KA0006', 'Melatih sila ke 2 (mengambil permen sesuka hati dengan syarat semua anak harus mendapat permen) ');
insert into kurikulum values ('S', 'A00012', 'Permen');
insert into kurikulum values ('KA', 'T00002', 'Manfaat menjalankan Sila');
insert into kurikulum values ('A', 'KA0007', 'Penjabaran manfaat menjalankan sila 1 s/d 5');
insert into kurikulum values ('S', 'A00013', 'Teks');
insert into kurikulum values ('KA', 'T00002', 'Kaitan Pancasila dengan Hukum Kamma');
insert into kurikulum values ('A', 'KA0008', 'Penjelasan singkat tentang Pancasila dan Hukum Kamma');
insert into kurikulum values ('A', 'KA0008', 'Menceritakan kisah pelanggaran Sila pada masa lampau dan akibatnya');
insert into kurikulum values ('T', null, 'Riwayat Sang Buddha');
insert into kurikulum values ('KA', 'T00003', 'Mengetahui kejadian kelahiran Pangeran Siddharta');
insert into kurikulum values ('A', 'KA0009', 'Cerita kelahiran Pangeran Sidharta');
insert into kurikulum values ('A', 'KA0009', 'Video riwayat singkat Buddha');
insert into kurikulum values ('S', 'A00017', 'Laptop, infocus, dan layar');
insert into kurikulum values ('KA', 'T00003', 'Kelahiran Boddhisatta');
insert into kurikulum values ('A', 'KA0010', 'Menceritakan kelahiran Pangeran Siddharta');
insert into kurikulum values ('KA', 'T00003', 'Pelepasan keduniawian Pangeran Siddharta');
insert into kurikulum values ('KA', 'T00003', 'Pemutaran Roda Dhamma');
insert into kurikulum values ('T', null, 'Berbuat Baik');
insert into kurikulum values ('KA', 'T00004', 'Bisa membedakan perbuatan baik dan buruk melalui ucapan dan badan jasmani');
insert into kurikulum values ('A', 'KA0011', 'Ilustrasi foto/video kegiatan sehari - hari secara sederhana');
insert into kurikulum values ('S', 'A00019', 'Foto/video perbuatan baik');
insert into kurikulum values ('S', 'A00019', 'Foto/video perbuatan buruk');
insert into kurikulum values ('A', 'KA0012', 'Game board "Jalan Kebaikan"');
insert into kurikulum values ('S', 'A00020', 'Game-board, dadu, pion');

insert into kurikulum values ('KA', 'T00001', 'Mengenal kata "BUDDHA"');
insert into kurikulum values ('KC', 'T00001', 'Definisi dan sifat-sifat Tiratana');
insert into kurikulum values ('A', 'KC0001', 'Mempelajari arti Sugato, Lokavidu, Anuttaro, dst');
insert into kurikulum values ('A', 'KC0001', 'Mempelajari arti Sanditthiko, Akaliko, Ehipassiko, dst');
insert into kurikulum values ('A', 'KC0001', 'Mempelajari arti Supatipanno, Ujupatipanno, dst');
insert into kurikulum values ('KD', 'T00001', 'Perenungan sifat-sifat Tiratana (Meditasi)');
insert into kurikulum values ('A', 'KD0001', 'Perenungan Buddhanussati');
insert into kurikulum values ('A', 'KD0001', 'Perenungan Dhammanussati');
insert into kurikulum values ('A', 'KD0001', 'Perenungan Sanghanussati');
insert into kurikulum values ('KB', 'T00001', 'Mengenal figur Buddha, Dhamma, dan Sangha');
insert into kurikulum values ('KB', 'T00001', 'Definisi Tiratana');
insert into kurikulum values ('KB', 'T00001', 'Belajar paritta dan artinya');
insert into kurikulum values ('KB', 'T00001', 'Cara menghormat Tiratana');
insert into kurikulum values ('KB', 'T00001', 'Penjelasan Namaskara');
insert into kurikulum values ('A', 'KB0001', 'Penjelasan secara lisan dan visual');
insert into kurikulum values ('A', 'KB0001', 'Vihara gita');
insert into kurikulum values ('A', 'KB0002', 'Penjelasan secara lisan dan visual (teori)');
insert into kurikulum values ('A', 'KB0002', 'Acak kata');
insert into kurikulum values ('A', 'KB0002', 'Mencocokkan gambar dan kata');
insert into kurikulum values ('A', 'KB0003', 'Membaca paritta Tisarana');
insert into kurikulum values ('A', 'KB0003', 'Simulasi tidur');
insert into kurikulum values ('A', 'KB0004', 'Membersihkan altar dan rupang');
insert into kurikulum values ('A', 'KB0004', 'Membuat persembahan altar sederhana');
insert into kurikulum values ('A', 'KB0004', 'Menghargai produk Dhamma (tidak menaruh buku Dhamma sembarangan / tidak hormat)');
insert into kurikulum values ('A', 'KB0005', 'Arti Namaskara');
insert into kurikulum values ('A', 'KB0005', 'Mengajarkan 5 titik sentuk');
insert into kurikulum values ('A', 'KB0005', 'Menunjukkan namaskara versi Theravada');

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
insert into pembicara (nama, panggilan, tgl_lahir, alamat) values ('Tushita Fariyani', 'Icha', '14-08-1999', 'Jl. Wijaya Kusuma, Margaasih');
insert into pembicara (nama) values ('Robert');
insert into pembicara (nama, panggilan, tgl_lahir, alamat) values ('Hendry Filcozwei Jan', 'Papa Dhika n Revata', '11-5-1970', 'Kompleks Permata Kopo Blok EA No. 343, Bandung');
insert into pembicara (nama) values ('Dimas');
insert into pembicara (nama) values ('Agus');
insert into pembicara (nama) values ('Asep');
insert into pembicara (nama) values ('Felix');
insert into pembicara (nama) values ('Kevin');
insert into pembicara (nama) values ('Deni');
insert into pembicara (nama) values ('Abas');
insert into pembicara (nama) values ('Owen');
insert into pembicara (nama) values ('Gagan');
insert into pembicara (nama) values ('Ruben');
insert into pembicara (nama) values ('Alex');
insert into pembicara (nama) values ('Edward');
insert into pembicara (nama) values ('Lisa');
insert into pembicara (nama) values ('Ayu');
insert into pembicara (nama) values ('Putri');

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
values (1, 'WA', '082250057777');
insert into kontak (idpembicara, tipe, data)
values (1, 'IG', 'Marlin');
insert into kontak (idpembicara, tipe, data)
values (1, 'WA', '081245678912');
insert into kontak (idpembicara, tipe, data)
values (2, 'WA', '081388341598');
insert into kontak (idpembicara, tipe, data)
values (2, 'WA', '0852345678912');
insert into kontak (idpembicara, tipe, data)
values (3, 'WA', '085222278912');
insert into kontak (idpembicara, tipe, data)
values (4, 'line', 'sam');
insert into kontak (idpembicara, tipe, data)
values (4, 'WA', '085244578912');
insert into kontak (idpembicara, tipe, data)
values (5, 'WA', '082196510849');
insert into kontak (idpembicara, tipe, data)
values (5, 'line', 'jordiyapz');
insert into kontak (idpembicara, tipe, data)
values (5, 'IG', 'jordiyaputra');
insert into kontak (idpembicara, tipe, data)
values (6, 'WA', '081234567891');
insert into kontak (idpembicara, tipe, data)
values (6, 'line', 'roro');
insert into kontak (idpembicara, tipe, data)
values (7, 'WA', '082133510841');
insert into kontak (idpembicara, tipe, data)
values (7, 'IG', 'hendryfil');
insert into kontak (idpembicara, tipe, data)
values (8, 'WA', '082216771231');
insert into kontak (idpembicara, tipe, data)
values (8, 'IG', 'Dimasr');
insert into kontak (idpembicara, tipe, data)
values (8, 'line', 'dimdim');
insert into kontak (idpembicara, tipe, data)
values (9, 'WA', '0852345678912');
insert into kontak (idpembicara, tipe, data)
values (9, 'line', 'gusgus');
insert into kontak (idpembicara, tipe, data)
values (10, 'IG', 'asepaja');
insert into kontak (idpembicara, tipe, data)
values (10, 'WA', '0852345677712');
insert into kontak (idpembicara, tipe, data)
values (11, 'WA', '081234444555');
insert into kontak (idpembicara, tipe, data)
values (12, 'WA', '0852345678812');
insert into kontak (idpembicara, tipe, data)
values (13, 'WA', '085234278812');
insert into kontak (idpembicara, tipe, data)
values (13, 'line', 'deden');
insert into kontak (idpembicara, tipe, data)
values (14, 'WA', '08523178812');
insert into kontak (idpembicara, tipe, data)
values (14, 'IG', 'abas2');
insert into kontak (idpembicara, tipe, data)
values (15, 'WA', '085234567802');
insert into kontak (idpembicara, tipe, data)
values (15, 'line', 'ah234');
insert into kontak (idpembicara, tipe, data)
values (15, 'IG', 'owens');
insert into kontak (idpembicara, tipe, data)
values (16, 'WA', '085298678812');
insert into kontak (idpembicara, tipe, data)
values (16, 'IG', 'Gans11');
insert into kontak (idpembicara, tipe, data)
values (17, 'WA', '085566677882');
insert into kontak (idpembicara, tipe, data)
values (17, 'WA', '085234567812');
insert into kontak (idpembicara, tipe, data)
values (18, 'WA', '085234467812');
insert into kontak (idpembicara, tipe, data)
values (18, 'line', 'Al');
insert into kontak (idpembicara, tipe, data)
values (19, 'WA', '085233378812');
insert into kontak (idpembicara, tipe, data)
values (20, 'IG', 'Liz');
insert into kontak (idpembicara, tipe, data)
values (20, 'WA', '081225678812');
insert into kontak (idpembicara, tipe, data)
values (21, 'line', 'ayuning');
insert into kontak (idpembicara, tipe, data)
values (22, 'line', 'puput');


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

insert into jadwalajar (tgl) values ('25-08-2019');
insert into jadwalajar (tgl) values ('1-9-2019');
insert into jadwalajar (tgl) values ('8-9-2019');
insert into jadwalajar (tgl) values ('15-9-2019');
insert into jadwalajar (tgl) values ('22-09-2019');
insert into jadwalajar (tgl) values ('29-9-2019');
insert into jadwalajar (tgl) values ('6-10-2019');
insert into jadwalajar (tgl) values ('13-10-2019');
insert into jadwalajar (tgl) values ('20-10-2019');
insert into jadwalajar (tgl) values ('27-10-2019');
insert into jadwalajar (tgl) values ('3-11-2019');
insert into jadwalajar (tgl) values ('10-11-2019');
insert into jadwalajar (tgl) values ('17-11-2019');
insert into jadwalajar (tgl) values ('24-11-2019');
insert into jadwalajar (tgl) values ('12-1-2020');
insert into jadwalajar (tgl) values ('19-1-2020');
insert into jadwalajar (tgl) values ('26-1-2020');
insert into jadwalajar (tgl) values ('2-2-2020');
insert into jadwalajar (tgl) values ('9-2-2020');
insert into jadwalajar (tgl) values ('16-2-2020');

insert into plot select 0, 1, 'A', 'KA0014', 7 from dual;
insert into plot select 0, 1, 'B', 'KA0002', 2 from dual;
insert into plot select 0, 1, 'C', 'A00021', 8 from dual;
insert into plot select 0, 1, 'C', 'A00022', 8 from dual;
insert into plot select 0, 1, 'D', 'A00024', 3 from dual;
insert into plot select 0, 2, 'A', 'KA0001', null from dual;
insert into plot select 0, 2, 'B', 'KB0002', null from dual;
insert into plot select 0, 2, 'C', 'A00023', null from dual;
insert into plot select 0, 2, 'D', 'A00025', null from dual;

insert into plot select 0, 3, 'A', 'KA0003', 4 from dual;
insert into plot select 0, 3, 'B', 'A00001', 3 from dual;
insert into plot values (0, 3, 'C', 'A00002', 10);
insert into plot values (0, 3, 'D', 'A00004', 14);
insert into plot values (0, 4, 'ABCD', 'A00017', 5);
insert into plot values (0, 5, 'A', 'A00006', 16);
insert into plot values (0, 5, 'BC', 'KA0004', 13);
insert into plot values (0, 5, 'D', 'A00012', 5);
insert into plot values (0, 6, 'A', 'A00011', 19);
insert into plot values (0, 6, 'B', 'A00003', 18);
insert into plot values (0, 6, 'C', 'A00005', 21);
insert into plot values (0, 6, 'D', 'A00026', 16);
insert into plot values (0, 7, 'AB', 'A00020', 13);
insert into plot values (0, 7, 'CD', 'A00018', 6);
insert into plot values (0, 8, 'C', 'A00014', 5);
insert into plot values (0, 8, 'AB', 'A00010', 6);
insert into plot values (0, 8, 'D', 'A00013', 18);
insert into plot values (0, 9, 'A', 'A00019', 14);
insert into plot values (0, 9, 'B', 'A00015', 17);
insert into plot values (0, 9, 'C', 'A00016', 11);
insert into plot values (0, 9, 'D', 'A00013', 14);
insert into plot values (0, 10, 'A', 'A00027', 11);
insert into plot values (0, 10, 'B', 'A00037', 12);
insert into plot values (0, 10, 'C', 'A00036', 19);
insert into plot values (0, 10, 'D', 'A00034', 12);
insert into plot values (0, 11, 'A', 'A00028', 6);
insert into plot values (0, 11, 'B', 'A00038', 3);
insert into plot values (0, 11, 'C', 'A00032', 1);
insert into plot values (0, 11, 'D', 'A00035', 5);
insert into plot values (0, 12, 'AB', 'A00033', 3);
insert into plot values (0, 12, 'CD', 'A00039', 8);

select idplot, tgl, kelas, idkur, isi, nama, panggilan
from plot 
left outer join kurikulum using (idkur)
left outer join jadwalajar using (idjadwal)
left outer join pembicara using (idpembicara)
order by idplot;

select * from kurikulum 
where 
(substr(parentid,1,1)='K' 
 or substr(idkur,1,1)='A') 
and idkur not in (select idkur from plot)
and parentid not in (
    select idkur from plot
    where substr(idkur,1,1)='K'
);