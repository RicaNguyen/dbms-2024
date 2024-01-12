USE QLDA_22810211_BT5;
--1. Tim nhung nhan vien lam viec o phong so 4
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên làm việc ở phòng 4'
FROM NHANVIEN AS NV
WHERE NV.PHG = 4;

--2. Tim nhung nhan vien co muc luong tren 30000
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên có mức lương trên 30000'
FROM NHANVIEN AS NV 
WHERE NV.Luong>30000;

--3. Tim cac nhan vien co muc luong tren 25 000 o phong 4 hoac cac nhan vien co muc luong tren 30 000 o phong 5
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên có mức lương trên 25 000 ở phòng 4 hoặc trên 30000 ở phòng 5'
FROM NHANVIEN AS NV
WHERE (NV.Luong>25000 AND NV.PHG = 4 ) OR(NV.Luong>30000 AND NV.PHG = 5);

--4. Cho biet ho ten day du cua cac nhan vien co ho bat dau bang ki tu 'N'
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên có họ bắt đầu bằng kí tự N'
FROM NHANVIEN AS NV
WHERE NV.HoNV LIKE 'N%';

--5. Tim nhung nhan vien lam viec o phong so 4 
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên làm việc ở phòng 4'
FROM NHANVIEN AS NV
WHERE NV.PHG = 4;

--6. Tim cac nhan vien co muc luong tren 25 000 o phong 4 hoac cac nhan vien co muc luong tren 30 000 o phong 5 
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên có mức lương trên 25 000 ở phòng 4 hoặc trên 30000 ở phòng 5'
FROM NHANVIEN AS NV
WHERE (NV.Luong>25000 AND NV.PHG = 4 ) OR(NV.Luong>30000 AND NV.PHG = 5);

--7. Cho biet ho ten day du cua cac nhan vien co ho ba dau bang ki tu 'N'
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên có họ bắt đầu bằng kí tự N'
FROM NHANVIEN AS NV
WHERE NV.HoNV LIKE 'N%';

--8. Cho biet cac nhan vien sinh truoc ngay 30/4/1975 hoac o TP HCM hoac lam viec tai phong so 4
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên sinh trước ngày 30/4/1975 hoặc ở TP HCM hoặc làm việc tại phòng số 4'
FROM NHANVIEN AS NV
WHERE (NV.NgSinh < '1967-04-30' ) OR(NV.DChi LIKE '%TP HCM') OR(NV.PHG=4);

--9. Cho biet cac nhan vien sinh truoc nam 1975 
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên sinh trước năm 1975'
FROM NHANVIEN AS NV
WHERE YEAR(NV.NgSinh) < 1975 ;

--10. Cho biet cac nhan vien sinh truoc ngay 30/4/1975 hoac o TP HCM hoac lam viec tai phong so 4
SELECT NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV AS N'Những nhân viên sinh trước ngày 30/4/1975 hoặc ở TP HCM hoặc làm việc tại phòng số 4'
FROM NHANVIEN AS NV
WHERE (NV.NgSinh < '1967-04-30' ) OR(NV.DChi LIKE N'%TP HCM') OR(NV.PHG=4);

--11. Voi moi phong ban, cho biet ten phong ban va dia diem phong 
SELECT PB.MaPHG, PB.TenPHG, DDP.DiaDiem
FROM PHONGBAN AS PB, DIADIEM_PHG AS DDP
WHERE PB.MaPHG = DDP.MaPHG;
 
--12. Tim ten nhung nguoi truong phong cua tung phong ban 
SELECT PB.TenPHG AS N'Tên phòng' ,(NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV) AS N'Tên trưởng phòng'
FROM PHONGBAN AS PB, NHANVIEN AS NV
WHERE  NV.MaNV =PB.TrPHG;

--13. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu".
SELECT (NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV) AS N'Tên nhân viên phòng nghiên cứu', NV.DChi AS N'Địa chỉ'
FROM PHONGBAN AS PB, NHANVIEN AS NV
WHERE  NV.PHG=PB.MaPHG AND PB.TenPHG =N'Nghiên cứu'; 

--14. Với mọi đề án ở "Ha Noi", liệt kê các mã số đề án (MADA),
-- mã số phòng ban chủ trì đề án (PHONG), họ tên trưởng phòng (HONV, TENLOT, TENNV)
-- cũng như địa chỉ (DCHI) và ngày sinh (NGSINH) của người ấy.
SELECT DA.TenDA as N'Tên đề án', PB.TenPHG AS N'Tên phòng ban', 
       (NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV) AS N'Tên trưởng phòng',
        NV.NgSinh AS N'Ngày sinh'
FROM DEAN AS DA, NHANVIEN AS NV,  PHONGBAN AS PB
WHERE NV.MaNV=PB.TrPHG AND PB.MaPHG = DA.Phong AND DA.Ddiem_DA = N'Hà Nội';

--15. Với mọi đề án ở "Ha Noi", liệt kê các mã số đề án (MADA), mã số phòng ban chủ trì đề án (PHONG), họ tên trưởng phòng (HONV, TENLOT, TENNV) cũng như địa chỉ (DCHI) và ngày sinh (NGSINH) của người ấy.
SELECT DA.TenDA as N'Tên đề án', PB.TenPHG AS N'Tên phòng ban', 
       (NV.HoNV +' '+ NV.TenLot +' '+  NV.TenNV) AS N'Tên trưởng phòng',
        NV.NgSinh AS N'Ngày sinh'
FROM DEAN AS DA, NHANVIEN AS NV,  PHONGBAN AS PB
WHERE NV.MaNV=PB.TrPHG AND PB.MaPHG = DA.Phong AND DA.Ddiem_DA = N'Hà Nội';

--16. Với mỗi phòng ban, liệt kê tên phòng ban (TENPHG) và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT  PB.TenPHG AS N'Tên phòng', AVG(NV.Luong) AS N'Lương trung bình'
FROM PHONGBAN AS PB, NHANVIEN AS NV
WHERE NV.PHG=PB.MaPHG
GROUP BY PB.MaPHG, PB.TenPHG;

--17. Lương trung bình của tất cả các nữ nhân viên
SELECT   AVG(NV.Luong) AS N'Lương trung bình của tất cả nữ nhân viên'
FROM NHANVIEN AS NV
WHERE NV.Phai=N'Nữ';

--18. Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản lý trực tiếp.
SELECT QL.MaNV as 'Mã nhân viên quản lý ', COUNT(NV.MaNV) AS 'Số lượng nhân viên'
FROM NHANVIEN AS NV, NHANVIEN AS QL
WHERE QL.MaNV=NV.Ma_NQL
GROUP BY QL.MaNV;

--19. Với mỗi phòng ban, liệt kê tên phòng ban (TENPHG) và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT QL.MaNV as 'Mã nhân viên quản lý ', COUNT(NV.MaNV) AS 'Số lượng nhân viên'
FROM NHANVIEN AS NV, NHANVIEN AS QL
WHERE QL.MaNV=NV.Ma_NQL
GROUP BY QL.MaNV;

--20. Lương trung bình của tất cả các nữ nhân viên
SELECT   AVG(NV.Luong) AS N'Lương trung bình của tất cả nữ nhân viên'
FROM NHANVIEN AS NV
WHERE NV.Phai=N'Nữ';