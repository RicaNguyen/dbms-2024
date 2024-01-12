--- Ho ten: Nguyen Ba Hoai Nhut
--- Mssv: 22810211
--- khoa 2022-2
--- Quan ly thu vien

USE master
DROP DATABASE
IF EXISTS QLTHUVIEN

CREATE DATABASE QLTHUVIEN
GO 
USE QLTHUVIEN
GO

CREATE TABLE DOCGIA (
ma_DocGia int,
ho nvarchar(50),
tenlot nvarchar(50),
ten nvarchar(50),
ngaysinh date,
primary key (ma_DocGia)
)

CREATE TABLE nguoilon(
ma_DocGia int,
sonha int,
duong nvarchar(50),
quan nvarchar(50),
dienthoai nvarchar(50),
han_sd date,
primary key (ma_DocGia)
)

CREATE TABLE treem(
ma_DocGia int,
ma_DocGia_nguoilon int,
primary key (ma_DocGia)
)

CREATE TABLE tuasach(
ma_tuasach int,
tuasach nvarchar(50),
tacgia nvarchar(50),
tomtat ntext,
primary key(ma_tuasach)
)

CREATE TABLE dausach (
isbn int,
ma_tuasach int,
ngonngu nvarchar(50),
bia nvarchar(50),
trang_thai char(1),
primary key(isbn)
)
CREATE TABLE cuonsach (
	isbn int,
	ma_cuonsach int,
	tinhtrang char(1),
	primary key (isbn, ma_cuonsach),
)

CREATE TABLE DangKy (
	isbn int,
	ma_DocGia int,
	ngay_dk datetime,
	ghichu ntext,
	primary key (isbn, ma_docgia),
)

CREATE TABLE muon (
	isbn int,
	ma_cuonsach int,
	ma_DocGia int,
	ngay_muon datetime,
	ngay_hethan datetime,
	primary key (isbn, ma_cuonsach),
)

CREATE TABLE quatrinhmuon (
	isbn int,
	ma_cuonsach int,
	ngay_muon datetime,
	ma_DocGia int,
	ngay_hethan datetime,
	ngay_tra datetime,
	tien_muon money,
	tien_datra money,                       
	tien_datcoc money,                                                       
	ghichu ntext,
	primary key (isbn, ma_cuonsach, ngay_muon),
)
GO
ALTER TABLE treem ADD 
	CONSTRAINT treem_nguoilon_lk
	FOREIGN KEY (ma_DocGia_nguoilon) REFERENCES nguoilon(ma_DocGia),
	CONSTRAINT treem_docgia_lk
	FOREIGN KEY (ma_DocGia) REFERENCES DOCGIA(ma_DocGia)
ALTER TABLE DOCGIA ADD
	CONSTRAINT nguoilon_docgia_lk
	FOREIGN KEY (ma_DocGia) REFERENCES DOCGIA(ma_DocGia)
ALTER TABLE dausach ADD  
	CONSTRAINT dausach_tuasach_lk
	FOREIGN KEY (ma_tuasach) REFERENCES tuasach(ma_tuasach)
ALTER TABLE dangky ADD  
	CONSTRAINT dangky_dausach_lk
	FOREIGN KEY (isbn) REFERENCES dausach(isbn),
	CONSTRAINT dangky_docgia_lk
	FOREIGN KEY (ma_DocGia) REFERENCES DOCGIA(ma_DocGia)
ALTER TABLE muon ADD  
	CONSTRAINT muon_cuonsach_lk
	FOREIGN KEY (isbn, ma_cuonsach) REFERENCES cuonsach(isbn, ma_cuonsach),
	CONSTRAINT muon_docgia_lk
	FOREIGN KEY (ma_DocGia) REFERENCES docgia(ma_DocGia)

ALTER TABLE cuonsach ADD  
	CONSTRAINT cuonsach_cuonsach_lk
	FOREIGN KEY (isbn) REFERENCES dausach(isbn)

ALTER TABLE quatrinhmuon ADD  
	CONSTRAINT quatrinhmuon_cuonsach_lk
	FOREIGN KEY (isbn, ma_cuonsach) REFERENCES cuonsach(isbn, ma_cuonsach)
GO