-- Câu 1: Cho biết danh sách các học viên thuộc về lớp do giáo viên “GV00001” quản lý.
SELECT HV.*
FROM LOPHOC LH
JOIN HOCVIEN HV ON LH.MaLop = HV.MaLop
WHERE LH.GVQuanLi = 'GV00001'

-- Câu 2: Cho biết danh sách các giáo viên được phân công giảng dạy môn “Khai thác dữ liệu”.
SELECT GV.*
FROM GIAOVIEN_DAY_MONHOC DMH
JOIN MONHOC MH ON DMH.MaMH = MH.MaMonHoc
JOIN GIAOVIEN GV ON DMH.MaGV = GV.MaGV
WHERE MH.TenMonHoc = N'Khai thác dữ liệu'

-- Câu 3: Cho biết họ tên các học viên “đã tốt nghiệp”.
SELECT TenHocVien
FROM HOCVIEN
WHERE TinhTrang = N'đã tốt nghiệp'

-- Câu 4: Cho biết tên các môn học mà giáo viên có tên “Như Lan” đã được phân công giảng dạy.
SELECT MH.TenMonHoc
FROM GIAOVIEN_DAY_MONHOC DMH
JOIN MONHOC MH ON DMH.MaMH = MH.MaMonHoc
JOIN GIAOVIEN GV ON DMH.MaGV = GV.MaGV
WHERE GV.TenGV LIKE N'%Như Lan%'

-- Câu 5: Đếm số môn mà mỗi giáo viên “nam” có khả năng giảng dạy. Xuất ra mã giáo viên, học tên và tổng số môn mà giáo viên này có thể dạy.
SELECT GV.MaGV
	,GV.TenGV
	,COUNT(*) AS N'Tổng số môn dạy'
FROM GIAOVIEN_DAY_MONHOC DMH
JOIN GIAOVIEN GV ON DMH.MaGV = GV.MaGV
WHERE GV.GioiTinh = N'Nam'
GROUP BY GV.MaGV
	,GV.TenGV

-- Câu 6: Cho biết điểm trung bình của học viên “Nguyễn Thuỳ Linh”. Điểm trung bình được tính trên điểm thi lần thi sau cùng của học viên theo công thức:
-- Điểm trung bình = ∑(Điểm * Số tín chỉ) / ∑Số tín chỉ
SELECT ROUND(SUM(Diem) / SUM(SoChi), 2) N'Điểm TB'
FROM (
	SELECT MH.MaMonHoc
		,KQ.Diem * MH.SoChi AS 'Diem'
	FROM HOCVIEN HV
	JOIN KETQUA KQ ON HV.MaHocVien = KQ.MaHV
	JOIN MONHOC MH ON KQ.MaMonHoc = MH.MaMonHoc
	WHERE HV.TenHocVien = N'Nguyễn Thị Kiều Trang' AND KQ.LanThi = (
			SELECT MAX(LanThi)
			FROM KETQUA
			WHERE HV.MaHocVien = MaHV
			)
	) T1
INNER JOIN (
	SELECT *
	FROM MONHOC
	) T2 ON T1.MaMonHoc = T2.MaMonHoc

-- Câu 7: Cho biết có bao nhiêu học viên đã từng thi đậu môn “Tin học cơ sở”.
SELECT Count(DISTINCT HV.MaHocVien)
FROM MONHOC MH
JOIN KETQUA KQ ON MH.MaMonHoc = KQ.MaMonHoc
JOIN HOCVIEN HV ON HV.MaHocVien = KQ.MaHV
WHERE MH.TenMonHoc = N'Phân tích thiết kế hệ thống thông tin' AND KQ.Diem >= 5

--AND KQ.LanThi = (Select MAX(LanThi)
--		   from KETQUA
--              where HV.MaHocVien = MaHV)
-- Đã từng đậu thì nghĩ không có lần cuối thi
-- Câu 8: Cho biết họ tên các học viên lớn tuổi nhất của từng lớp.
SELECT HV.TenHocVien
	,Max(DATEDIFF(YEAR, HV.NgaySinh, GETDATE())) AS Tuoi
	,HV.MaLop
FROM HOCVIEN HV
WHERE DATEDIFF(YEAR, HV.NgaySinh, GEtDate()) = (
		SELECT Max(DATEDIFF(YEAR, NgaySinh, GETDATE()))
		FROM HOCVIEN
		WHERE MaLop = HV.MaLop
		)
GROUP BY HV.TenHocVien
	,HV.MaLop

-- Câu 9: Xuất ra danh sách tên các môn học, ứng với mỗi môn cho biết số học viên vẫn chưa thi đậu môn đó. Học viên chưa thi đậu khi điểm lần thi cuối cùng môn đó <5.
SELECT MH.TenMonHoc
	,MH.MaMonHoc
	,COUNT(MH.MaMonHoc) N'Số SV còn lại'
FROM MONHOC MH
LEFT JOIN KETQUA KQ ON MH.MaMonHoc = KQ.MaMonHoc
WHERE KQ.Diem < 5 AND KQ.LanThi = (
		SELECT MAX(LanThi)
		FROM KETQUA
		WHERE KQ.MaHV = MaHV
		)
GROUP BY MH.TenMonHoc
	,MH.MaMonHoc

-- Câu 10: Cho biết họ tên học viên có điểm trung bình cao nhất của từng lớp. Điều kiện và công thức tính điểm trung bình tương tự câu 6. Xuất ra mã lớp và họ tên học viên.
--SELECT T.TenHocVien, MAX(T.DIEMTB)
--FROM (
--	SELECT TenHocVien
--		,MaLop
--		,ROUND(SUM(Diem) / SUM(SoChi), 2) DIEMTB
--	FROM (
--		SELECT HV.TenHocVien
--			,HV.MaHocVien
--			,HV.MaLop
--			,MH.MaMonHoc
--			,KQ.Diem * MH.SoChi AS 'Diem'
--		FROM HOCVIEN HV
--		JOIN KETQUA KQ ON HV.MaHocVien = KQ.MaHV
--		JOIN MONHOC MH ON KQ.MaMonHoc = MH.MaMonHoc
--		WHERE KQ.LanThi = (
--				SELECT MAX(LanThi)
--				FROM KETQUA
--				WHERE HV.MaHocVien = MaHV
--				)
--		) T1
--	INNER JOIN (
--		SELECT *
--		FROM MONHOC
--		) T2 ON T1.MaMonHoc = T2.MaMonHoc
--	GROUP BY MaLop
--		,MaHocVien
--		,TenHocVien
--	) T
-- Câu 11: Cho biết mã số và họ tên giáo viên được phân công giảng dạy môn “Toán cao cấp” nhiều lần nhất.
SELECT GV.MaGV
	,GV.TenGV
	,COUNT(GV.MaGV) SOLAN
FROM PHANCONG PC
JOIN GIAOVIEN GV ON PC.MaGV = GV.MaGV
JOIN MONHOC MH ON MH.MaMonHoc = PC.MaMH
WHERE MH.TenMonHoc = N'Hệ thống thông minh'
GROUP BY GV.MaGV
	,GV.TenGV
HAVING COUNT(GV.MaGV) = (
		SELECT MAX(T.SOLAN)
		FROM (
			SELECT GV.MaGV
				,GV.TenGV
				,COUNT(GV.MaGV) SOLAN
			FROM PHANCONG PC
			JOIN GIAOVIEN GV ON PC.MaGV = GV.MaGV
			JOIN MONHOC MH ON MH.MaMonHoc = PC.MaMH
			WHERE MH.TenMonHoc = N'Hệ thống thông minh'
			GROUP BY GV.MaGV
				,GV.TenGV
			) T
		)