--22810211
--Nguyễn Ba Hoài Nhựt
--22810211@student.hcmus.edu.vn

--20810009
--Võ Văn Quang Huy 
--20810009@student.hcmus.edu.vn

--BTAPNHOMLAN2

USE QLTV;
GO

--1.Liệt kê danh sách họ tên và mã độc giả người lớn đang mượn sách chưa trả và số lượng sách họ đang mượn
--22810211 - Nguyễn Ba Hoài Nhựt
SELECT
    count(*) AS dangmuon,
    qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten
FROM
    QuaTrinhMuon AS qtm
    JOIN DocGia AS dg ON qtm.MaDocGia = dg.MaDocGia
WHERE
    qtm.ngay_tra IS NULL
    AND qtm.MaDocGia IN (
        SELECT
            MaDocGia
        FROM
            NguoiLon
    )
GROUP BY
    qtm.MaDocGia,
    qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten;

-- 2.Liệt kê danh sách họ tên và mã độc giả người lớn đan gmượn sách trể hạn(so với quy định)
-- 22810211 - Nguyễn Ba Hoài Nhựt
SELECT DISTINCT
    qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten
FROM
    QuaTrinhMuon AS qtm
    JOIN DocGia AS dg ON qtm.MaDocGia = dg.MaDocGia
WHERE
    qtm.ngay_hethan <= GETDATE ()
    AND qtm.ngay_tra IS NULL
    AND qtm.MaDocGia IN (
        SELECT
            MaDocGia
        FROM
            NguoiLon
    );

-- 3.Liệt kê danh sách họ tên đọc giả trẻ em đang mượn sách chưa trả và tên đầu sách mà trẻ em đang mượn
-- 22810211 - Nguyễn Ba Hoài Nhựt
SELECT
    qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten,
    ts.TuaSach AS TenSach
FROM
    QuaTrinhMuon AS qtm
    JOIN DocGia AS dg ON qtm.MaDocGia = dg.MaDocGia
    JOIN DauSach AS ds ON qtm.isbn = ds.isbn
    JOIN TuaSach AS ts ON ds.ma_tuasach = ts.ma_tuasach
WHERE
    qtm.ngay_hethan <= GETDATE ()
    AND qtm.ngay_tra IS NULL
    AND qtm.MaDocGia IN (
        SELECT
            MaDocGia
        FROM
            TreEm
    );

-- 4.Liệt kê danh sách các độc giả người lớn đang mượn sách chưa trả đồng thời trẻ em mà người lớn đó đang bảo lãnh cũng có mượn sách chưa trả
-- 22810211 - Nguyễn Ba Hoài Nhựt
SELECT
    DocGia.MaDocGia,
    DocGia.Ho,
    DocGia.TenLot,
    DocGia.Ten
FROM
    TreEm
    JOIN DocGia ON TreEm.MaDocGia_nguoilon = DocGia.MaDocGia
WHERE
    TreEm.MaDocGia IN (
        SELECT
            QuaTrinhMuon.MaDocGia
        FROM
            QuaTrinhMuon
        WHERE
            QuaTrinhMuon.ngay_tra IS NULL
    )
    AND TreEm.MaDocGia_nguoilon IN (
        SELECT
            QuaTrinhMuon.MaDocGia
        FROM
            QuaTrinhMuon
        WHERE
            QuaTrinhMuon.ngay_tra IS NULL
    );

-- 5.Liệt kê danh sác độc giả đang đăng ký mượn sách và tên đầu sách cầ nmượn
-- 22810211 - Nguyễn Ba Hoài Nhựt
SELECT
    dg.Ho,
    dg.TenLot,
    dg.Ten,
    ts.TuaSach AS TenSachDangKyMuon
FROM
    DangKy AS dk
    JOIN DauSach AS ds ON dk.isbn = ds.isbn
    JOIN TuaSach AS ts ON ds.ma_tuasach = ts.ma_tuasach
    JOIN DocGia AS dg ON dk.MaDocGia = dg.MaDocGia;

-- 6. Liệt kê danh sách độc giả đang đăng ký mượn sách và số lượng đầu sách đã đăng ký.
-- 22810211 - Nguyễn Ba Hoài Nhựt
SELECT
    dg.Ho,
    dg.TenLot,
    dg.Ten,
    count(*) AS SoLuongSachDaDangKyMuon
FROM
    DangKy AS dk
    JOIN DocGia AS dg ON dk.MaDocGia = dg.MaDocGia
GROUP BY
    dk.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten;

-- 7. Liệt kê danh sách mã isbn và tên đầu sách đang được độc giả đăng ký mượn và đang trong trạng thái sẵn sàng cho mượn
-- 20810009 - Võ Văn Quang Huy 
SELECT
    DangKy.isbn,
    DauSach.ngonngu
FROM
    DangKy
    INNER JOIN DauSach ON DangKy.isbn = DauSach.isbn
    INNER JOIN CuonSach ON DauSach.isbn = CuonSach.isbn
WHERE
    DangKy.ngay_dk IS NOT NULL
    AND cuonsach.tinhtrang = 'Y';

-- 8.Với mỗi đầu sách, cho biết số lần đã mượn(và đã trả)
-- 20810009 - Võ Văn Quang Huy 
SELECT
    QuaTrinhMuon.isbn,
    tuasach.tuasach,
    count(*) AS 'Số lần đã mượn',
    count(QuaTrinhMuon.ngay_tra) AS 'Số lần đã trả'
FROM
    QuaTrinhMuon
    JOIN DauSach ON QuaTrinhMuon.isbn = DauSach.isbn
    JOIN TuaSach ON DauSach.ma_tuasach = TuaSach.ma_tuasach
GROUP BY
    QuaTrinhMuon.isbn,
    tuasach.tuasach
ORDER BY
    QuaTrinhMuon.isbn;