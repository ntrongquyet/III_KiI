-- Câu  1 : Cho biết danh sách các học viên đã từng thi đậu môn “Mạng máy tính”.
select HV.* from HOCVIEN HV join KETQUA KQ on HV.MaHocVien = KQ.MaHV join MONHOC MH on KQ.MaMonHoc = MH.MaMonHoc
where MH.TenMonHoc = N'Mạng máy tính' and KQ.Diem > 5
-- Câu 2 : Cho biết danh sách các giáo viên nam đã từng được phân công quản lý lớp.
select distinct GV.* from GIAOVIEN_DAY_MONHOC DMH join GIAOVIEN GV on DMH.MaGV = GV.MaGV
where GV.GioiTinh = 'Nam'
-- Câu 3 : Cho biết họ tên lớp trưởng các lớp học kết thúc trước năm 2015
select HV.TenHocVien from LOPHOC LH join HOCVIEN HV on LH.LopTruong = HV.MaHocVien
where LH.NamKetThuc<2015
-- Câu 4: Đếm số lần giáo viên “Nguyễn Văn An” được phân công dạy lớp “LH000004”.
select COUNT(*) from GIAOVIEN GV join PHANCONG PC on GV.MaGV = PC.MaGV
where PC.MaLop = 'LH000004' and GV.TenGV = N'Nguyễn Văn An'
-- Câu 5: Đếm số lượng lớp mà mỗi giáo viên từng quản lý. Xuất ra mã giáo viên, họ tên và số lượng lớp họ quản lý.
select GV.MaGV, GV.TenGV, Count(GV.MaGV) as N'Số lớp quản lý' from LOPHOC LH join GIAOVIEN GV on LH.GVQuanLi = GV.MaGV
group by GV.TenGV, GV.MaGV
-- Câu 6: Cho biết thông tin lớp học (mã lớp, tên giáo viên quản lý) có sĩ số đông nhất.
select GV.MaGV, GV.TenGV, LH.SiSo as SiSo from LOPHOC LH join GIAOVIEN GV on LH.GVQuanLi = GV.MaGV
where LH.SiSo = (select MAX(SiSo) from LOPHOC)
group by GV.MaGV, GV.TenGV,LH.SiSo
-- Câu 7: Cho biết mã và họ tên học viên còn rớt môn “Công nghệ phần mềm”.
select distinct HV.MaHocVien, HV.TenHocVien from HOCVIEN HV join KETQUA KQ on HV.MaHocVien = KQ.MaHV join MONHOC MH on KQ.MaMonHoc = MH.MaMonHoc
where KQ.Diem < 5 and MH.TenMonHoc = N'Công nghệ phần mềm'