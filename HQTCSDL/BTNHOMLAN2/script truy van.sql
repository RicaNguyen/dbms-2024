--NGUYENBAHOAINHUT
--22810211
--BTAPNHOMLAN2

use QLTV
go
    --1.Liệtkêdanhsáchhọtênvàmãđộcgiảngười lớnđangmượnsáchchưatrảvàsốlượngsáchhọđangmượn
select
    count(*) as dangmuon,
    qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten
from
    QuaTrinhMuon as qtm
    join DocGia as dg on qtm.MaDocGia = dg.MaDocGia
where
    qtm.ngay_tra is NULL
group by
    qtm.MaDocGia,
    qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten;

-- 2.Liệtkêdanhsáchhọtênvàmãđộcgiảngười lớnđangmượnsáchtrểhạn(sovớiquyđịnh)
select
    distinct qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten
from
    QuaTrinhMuon as qtm
    join DocGia as dg on qtm.MaDocGia = dg.MaDocGia
where
    qtm.ngay_hethan <= GETDATE()
    and qtm.ngay_tra is NULL
    and qtm.MaDocGia in (
        select
            MaDocGia
        from
            NguoiLon
    );

-- 3.Liệtkêdanhsáchhọtênđọcgiảtrẻemđangmượnsáchchưatrảvàtênđầusáchmàtrẻemđangmượn
select
    qtm.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten,
    ts.TuaSach as TenSach
from
    QuaTrinhMuon as qtm
    join DocGia as dg on qtm.MaDocGia = dg.MaDocGia
    join DauSach as ds on qtm.isbn = ds.isbn
    join TuaSach as ts on ds.ma_tuasach = ts.ma_tuasach
where
    qtm.ngay_hethan <= GETDATE()
    and qtm.ngay_tra is NULL
    and qtm.MaDocGia in (
        select
            MaDocGia
        from
            TreEm
    );

-- 4.Liệtkêdanhsáchcácđộcgiảngười lớnđangmượnsáchchưatrảđồngthời trẻemmàngườilớnđóđangbảolãnhcũngcómượnsáchchưatrả
-- TODO:
-- 5.Liệtkêdanhsáchđộcgiảđangđăngkýmượnsáchvàtênđầusáchcầnmượn
select
    dg.Ho,
    dg.TenLot,
    dg.Ten,
    ts.TuaSach as TenSachDangKyMuon
from
    DangKy as dk
    join DauSach as ds on dk.isbn = ds.isbn
    join TuaSach as ts on ds.ma_tuasach = ts.ma_tuasach
    join DocGia as dg on dk.MaDocGia = dg.MaDocGia;

--6. Liệtkêdanhsáchđộcgiảđangđăngkýmượnsáchvàsốlượngđầusáchđãđăngký.
select
    dg.Ho,
    dg.TenLot,
    dg.Ten,
    count(*) as SoLuongSachDaDangKyMuon
from
    DangKy as dk
    join DocGia as dg on dk.MaDocGia = dg.MaDocGia
group by
    dk.MaDocGia,
    dg.Ho,
    dg.TenLot,
    dg.Ten;

-- 7. Liệtkêdanhsáchmã isbnvàtênđầusáchđangđượcđộcgiảđăngkýmượnvàđangtrongtrạngtháisẵnsàngchomượn
-- TODO:
-- 8.Vớimỗiđầusách,chobiếtsốlầnđãmượn(vàđãtrả)
-- TODO: