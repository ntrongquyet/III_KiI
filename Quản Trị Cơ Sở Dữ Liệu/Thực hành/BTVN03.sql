-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nguyễn Trọng Quyết - 18600011
-- =============================================
USE QLHocVien
GO
--1. Nhập vào mã một học viên, đếm số môn mà học viên này đã thi đậu. Điều kiện thi đậu: Điểm lần thi sau cùng của môn này >= 5.
--Xuất kết quả bằng tham số output.
IF OBJECT_ID('usp_DeSoMonDau') IS NOT NULL
	DROP PROC usp_DeSoMonDau
GO
CREATE PROC usp_DeSoMonDau
@MaHV NCHAR(10), @KetQua INT OUT
AS
BEGIN 
	SELECT @KetQua = COUNT(*)  
	FROM KETQUA KQ	
		JOIN (SELECT KQ1.MaHV, KQ1.MaMonHoc, MAX(KQ1.LanThi) AS MAX_LANTHI
			  FROM KETQUA KQ1
			  GROUP BY KQ1.MaHV, KQ1.MaMonHoc) AS MAX_LT 
			  ON MAX_LT.MaHV = KQ.MaHV AND MAX_LT.MAX_LANTHI = KQ.LanThi AND KQ.MaMonHoc = MAX_LT.MaMonHoc
	WHERE KQ.MaHV = @MaHV AND KQ.Diem >= 5
END

GO

--Thực thi bài 1
DECLARE @MaHV NCHAR(10), @KetQua INT
SET @MaHV = 'HV000002'
EXEC usp_DeSoMonDau @MaHV, @KetQua OUT
PRINT N'Số môn học viên ' + TRIM(@MaHV) + N' đã thi đậu là: ' + CAST(@KetQua AS VARCHAR)
GO

--2. Xuất ra danh sách họ tên các giáo viên, ứng với mỗi giáo viên cho biết số môn mà các giáo viên này đã được phân công giảng dạy.
--Xuất kết quả bằng lệnh select.
IF OBJECT_ID('usp_XuatGiaoVien') IS NOT NULL
	DROP PROC usp_XuatGiaoVien
GO

CREATE PROC usp_XuatGiaoVien 
AS
BEGIN
	SELECT GV.MaGV, GV.TenGV, COUNT(*) AS N'Số lượng môn'
	FROM GIAOVIEN GV JOIN PHANCONG PC ON PC.MaGV = GV.MaGV
	GROUP BY GV.MaGV, GV.TenGV
END
GO

--Thực thi bài 2
EXEC usp_XuatGiaoVien
GO

--3. Nhận vào mã một học viên, cho biết điểm trung bình của học viên đó. Điểm trung bình được tính trên điểm thi lần thi sau cùng của học viên theo công thức:
--Điểm trung bình = ∑(Điểm * Số tín chỉ) / ∑Số tín chỉ
--Xuất ra kết quả bằng tham số output. Lưu ý: ĐTB làm tròn 2 chữ số.
IF OBJECT_ID('usp_TinhDiemTBHocVien') IS NOT NULL
	DROP PROC usp_TinhDiemTBHocVien
GO
CREATE PROC usp_TinhDiemTBHocVien
@MaHV NCHAR(10), @KetQua FLOAT OUT
AS
BEGIN
	SELECT @KetQua = ROUND(SUM(KQ.Diem * MH.SoChi)/SUM(MH.SoChi),2,0)
	FROM KETQUA KQ	
		JOIN (SELECT KQ1.MaHV, KQ1.MaMonHoc, MAX(KQ1.LanThi) AS MAX_LANTHI
			  FROM KETQUA KQ1
			  GROUP BY KQ1.MaHV, KQ1.MaMonHoc) AS MAX_LT 
			  ON MAX_LT.MaHV = KQ.MaHV AND MAX_LT.MAX_LANTHI = KQ.LanThi AND KQ.MaMonHoc = MAX_LT.MaMonHoc
		JOIN MONHOC MH ON MH.MaMonHoc = KQ.MaMonHoc
	WHERE KQ.MaHV = @MaHV
END
GO
--Thực thi bài 3
DECLARE @MaHV NCHAR(10), @KetQua FLOAT
SET @MaHV = 'HV000010'
EXEC usp_TinhDiemTBHocVien @MaHV, @KetQua OUT
PRINT N'Điểm trung bình của học viên: ' + TRIM(@MaHV) + N' là: ' + CAST(@KetQua AS VARCHAR)
GO

--4. Nhận vào mã một học viên, cho biết xếp loại của học viên đó. Xếp loại của một học viên được đánh giá dựa vào điểm trung bình theo quy tắc bên dưới:
--§ ĐTB < 5 à loại “Yếu”
--§ ĐTB = 5 à loại “Trung bình”
--§ 5 < ĐTB < 6.5 à loại “Trung bình khá”
--§ 6.5 <= ĐTB < 8 à loại “Khá”
--§ 8 < ĐTB < 9 à loại “Giỏi”
--§ ĐTB >= 9 à loại “Xuất sắc”
--Xuất kết quả bằng tham số output. Lưu ý: sử dụng lại stored procedure ở câu 3.
IF OBJECT_ID('usp_XepLoaiHocVien') IS NOT NULL
	DROP PROC usp_XepLoaiHocVien
GO
CREATE PROC usp_XepLoaiHocVien
@MaHV NCHAR(10), @XepLoai NVARCHAR(MAX) OUT
AS
BEGIN
	DECLARE @DiemTB FLOAT
	EXEC usp_TinhDiemTBHocVien @MaHV, @DiemTB OUT
	IF @DiemTB >= 9
		SET @XepLoai = N'Xuất sắc'
	IF @DiemTB >= 8
		SET @XepLoai = N'Giỏi'
	IF @DiemTB >= 6.5
		SET @XepLoai = N'Khá'
	IF @DiemTB >= 5
		SET @XepLoai = N'Trung bình khá'
	IF @DiemTB = 5
		SET @XepLoai = N'Trung bình'
	IF @DiemTB < 5
		SET @XepLoai = N'Yếu'
END
GO

--Thực thi bài 4
DECLARE @MaHV NCHAR(10),  @XepLoai NVARCHAR(100)
SET @MaHV = 'HV000006'
EXEC usp_XepLoaiHocVien @MaHV, @XepLoai OUT
PRINT  N'Học viên ' + TRIM(@MaHV) + N' xếp loại: ' + @XepLoai
GO

--5. Nhận vào một mã lớp, cho biết họ tên học viên có điểm trung bình cao nhất của lớp đó.
--Điều kiện và công thức tính điểm trung bình tương tự câu 3.
--Xuất kết quả bằng lệnh select.
IF OBJECT_ID('usp_DiemTBCaoNhatLop') IS NOT NULL
	DROP PROC usp_DiemTBCaoNhatLop
GO
CREATE PROC usp_DiemTBCaoNhatLop
@MaLH NCHAR(10)
AS
BEGIN
SELECT HV1.TenHocVien, ROUND(DIEM_TB,2,0) AS N'Điểm trung bình'
FROM HOCVIEN HV1 
	JOIN
	(SELECT KQ.MaHV, SUM(KQ.Diem * MH.SoChi) / SUM(MH.SoChi) AS DIEM_TB
	FROM KETQUA KQ JOIN MONHOC MH ON MH.MaMonHoc = KQ.MaMonHoc
	WHERE KQ.LanThi >= ALL (SELECT KQ1.LanThi FROM KETQUA KQ1 WHERE KQ1.MaHV = KQ.MaHV)
							GROUP BY KQ.MaHV) DIEM_TB_HV ON HV1.MaHocVien = DIEM_TB_HV.MaHV
							WHERE DIEM_TB_HV.DIEM_TB >= ALL (SELECT SUM(KQ.Diem * MH.SoChi) / SUM(MH.SoChi) AS DIEM_TB
															FROM KETQUA KQ JOIN MONHOC MH ON MH.MaMonHoc = KQ.MaMonHoc JOIN HOCVIEN HV2 ON HV2.MaHocVien = KQ.MaHV
															WHERE KQ.LanThi >= ALL (SELECT KQ1.LanThi FROM KETQUA KQ1 WHERE KQ1.MaHV = KQ.MaHV)
															GROUP BY KQ.MaHV, HV2.MaLop
															HAVING HV2.MaLop = HV1.MaLop) AND HV1.MaLop = @MaLH
END
GO

--Thực thi bài 5
EXEC usp_DiemTBCaoNhatLop 'LH000002'
GO

--6. Viết stored procedure nhận vào thông tin một học viên mới và đưa học viên vào CSDL theo quy trình sau:
--§ B1: Kiểm tra nếu mã học viên đã có à thông báo lỗi mã học viên đã tồn tại & kết thúc.
--§ B2: Kiểm tra nếu học viên được xếp vào lớp chưa tồn tại thì thông báo lỗi lớp học không hợp lệ & kết thúc.
--§ B3: Kiểm tra nếu học viên được xếp vào lớp có nhiều hơn 20 học viên thì thông báo lớp đã quá đông và không thể nhận thêm học viên & kết thúc.
--§ B4: Kiểm tra nếu tình trạng không phải là một trong ba tình trạng ‘đang học’, ‘đã tốt nghiệp’ hoặc ‘bị thôi học’ thì thông báo lỗi tình trạng không hợp lệ & kết thúc.
--§ B5: Nếu các điều kiện đã thoả mãn, thêm học viên vào.
--§ B6: Cập nhật lại sĩ số trong bảng lớp học tương ứng.
--§ B7: Thông báo thêm học viên thành công.
IF OBJECT_ID('usp_KiemTraHV') IS NOT NULL
DROP PROC usp_KiemTraHV
GO

CREATE PROC usp_KiemTraHV
@MaMH NCHAR(10), @MaHV NCHAR(10), @Diem FLOAT
AS
BEGIN 
	DECLARE @CountMH INT = 0
	DECLARE @CountHV INT = 0
	--Kiểm tra môn học tồn tại
	SELECT @CountMH = COUNT(*)
	FROM MONHOC MH WHERE @MaMH = MH.MaMonHoc

	--Kiểm tra học viên tồn tại
	SELECT @CountHV = COUNT(*)
	FROM HOCVIEN HV WHERE @MaHV = HV.MaHocVien

	IF(@CountMH > 0)
		PRINT N'CSDL có tồn tại Môn học: ' + @MaMH
	ELSE
	BEGIN
		PRINT N'CSDL không tồn tại Môn học: ' + @MaMH
		PRINT N'Kết thúc chương trình'
		RETURN 0
	END

	IF(@CountHV > 0)
		PRINT N'CSDL có tồn tại Học Viên: ' + @MaHV
	ELSE
	BEGIN
		PRINT N'CSDL không tồn tại Học Viên: ' + @MaHV
		PRINT N'Kết thúc chương trình'
		RETURN 0
	END
	--Kiểm tra điểm
	IF((@Diem < 0) OR (@Diem > 10 ))
	BEGIN
		PRINT N'Điểm không hợp lệ!'
		PRINT N'Kết thúc chương trình'
		RETURN 0
	END
	ELSE
		PRINT N'Điểm hợp lệ!'

	DECLARE @LanThi INT = 0
	SELECT @LanThi = MAX(KQ1.LanThi)
	FROM KETQUA KQ1
	WHERE @MaMH = KQ1.MaMonHoc AND @MaHV = KQ1.MaHV
	GROUP BY KQ1.MaHV,KQ1.MaMonHoc
	
	SET @LanThi += 1

	INSERT INTO dbo.KETQUA(MaHV, MaMonHoc, LanThi, Diem) VALUES (@MaHV, @MaMH, @LanThi, @Diem)
	PRINT N'Thêm vào CSDL thành công!'
END
GO

--Thực thi bài 6
EXEC usp_KiemTraHV  'MH00003', 'HV000002', 5.6
GO
--7. Viết stored procedure nhận vào một mã học viên và tiến hành xoá học viên này theo quy trình sau:
--§ B1: Kiểm tra nếu mã học viên không có à thông báo lỗi mã học viên không tồn tại kết thúc.
--§ B2: Kiểm tra nếu tình trạng học viên là “đang học” à thông báo lỗi không được xoá học viên đang học & kết thúc.
--§ B3: Nếu các điều kiện đã thoả mãn, xoá học viên.
--§ B4: Cập nhật lại sĩ số trong bảng lớp học tương ứng.
--§ B5: Thông báo xoá học viên thành công.
IF OBJECT_ID('usp_XoaHocVien') IS NOT NULL
DROP PROC usp_XoaHocVien
GO
CREATE PROC usp_XoaHocVien
@MaHV NCHAR(10)
AS
BEGIN
	--Kiểm tra học viên tồn tại
	DECLARE @CountHV INT = 0
	SELECT @CountHV = COUNT(*) 
	FROM HOCVIEN HV
	WHERE @MaHV = HV.MaHocVien
	IF @CountHV < 1
	BEGIN
		PRINT N'Không tồn tại học viên ' + TRIM(@MaHV)
		RETURN 0
	END

	--Kiểm tra tinh trạng học tập của học viên
	SET @CountHV = 0
	SELECT @CountHV = COUNT(*) 
	FROM HOCVIEN HV
	WHERE (@MaHV = HV.MaHocVien) AND (HV.TinhTrang = N'đang học')
	IF @CountHV > 0
	BEGIN
		PRINT N'Học viên ' + TRIM(@MaHV) + N' vẫn còn đang học, không thể xóa!'
		RETURN 0
	END

	DECLARE @LopCuaHocVien NCHAR(10)
	SELECT @LopCuaHocVien = HV.MaLop FROM HOCVIEN HV
	WHERE HV.MaHocVien = @MaHV

	DELETE HOCVIEN WHERE MaHocVien = @MaHV
	UPDATE LOPHOC SET SiSo = SiSo - 1 WHERE MaLop = @LopCuaHocVien

	PRINT N'Xóa học viên ' + TRIM(@MaHV) + ' thành công!'
END
GO
--Thực thi bài 7
DECLARE @MaHV NCHAR(10)
SET @MaHV = 'HV000011'
EXEC usp_XoaHocVien @MaHV
GO

--8. Viết stored procedure nhận vào một mã học viên và một mã lớp, tiến hành chuyển học sang lớp này theo quy trình sau:
--§ B1: Kiểm tra nếu mã học viên không có và thông báo lỗi mã học viên không tồn tại kết thúc.
--§ B2: Kiểm tra nếu không tồn tại mã lớp sẽ chuyển học viên sang và thông báo lớp không hợp lệ & kết thúc.
--§ B2: Cập nhật mã lớp mới cho học viên.
--§ B3: Cập nhật lại sĩ số trong bảng lớp học mà học viên mới chuyển sang (tăng 1).
--§ B4: Cập nhật lại sĩ số trong bảng lớp học mà học viên vừa chuyển đi (giảm 1). Lưu ý: nếu sĩ số lớp cũ sau khi học viên chuyển đi là 0 thì tiến hành huỷ lớp này.
--§ B5: Thông báo chuyển lớp thành công.
IF OBJECT_ID('usp_ChuyenLopHocVien') IS NOT NULL
DROP PROC usp_ChuyenLopHocVien
GO
CREATE PROC usp_ChuyenLopHocVien	
@MaHV NCHAR(10), @MaLopChuyen NCHAR(10)
AS
BEGIN
	DECLARE @CountSV INT
	DECLARE @CountLH INT

	--Kiểm tra học viên có tồn tại
	SELECT @CountSV = COUNT(*)
	FROM dbo.HOCVIEN HV
	WHERE HV.MaHocVien = @MaHV
	IF @CountSV < 1
	BEGIN
		PRINT N'Học viên ' + TRIM(@MaHV) + N' không tồn tại!'
		RETURN 0
	END

	--Kiểm tra lớp học có hợp lệ
	SELECT @CountLH = COUNT(*)
	FROM dbo.LOPHOC LH
	WHERE LH.MaLop = @MaLopChuyen
	IF @CountLH < 1
	BEGIN
		PRINT N'Lớp học ' + TRIM(@MaLopChuyen) + N' không lợp lệ!'
		RETURN 0
	END
	SET @CountLH = 0
	SELECT @CountLH = COUNT(*)
	FROM dbo.HOCVIEN HV
	WHERE (HV.MaLop = @MaLopChuyen) AND (HV.MaHocVien = @MaHV)
	IF @CountLH > 1
	BEGIN
		PRINT N'[LỖI]Học viên ' + TRIM(@MaHV) + N' đang học ở lớp ' + TRIM(@MaLopChuyen)
		RETURN 0
	END

	--Lấy lớp mà học viên đang học
	DECLARE @MaLopDangHoc NCHAR(10)
	SELECT @MaLopDangHoc = MaLop
	FROM dbo.HOCVIEN HV 
	WHERE MaHocVien = @MaHV 

	--Cập nhật lại các thông số liên quan
	UPDATE dbo.HOCVIEN SET MaLop = @MaLopChuyen WHERE MaHocVien = @MaHV
	UPDATE dbo.LOPHOC SET SiSo += 1 WHERE MaLop = @MaLopChuyen
	UPDATE dbo.LOPHOC SET  SiSo = SiSo - 1 WHERE MaLop = @MaLopDangHoc
	
	DECLARE @SiSoLopDangHoc INT
	SELECT @SiSoLopDangHoc = LH.SiSo
	FROM dbo.LOPHOC LH
	WHERE LH.MaLop = @MaLopDangHoc

	IF @SiSoLopDangHoc < 1
	DELETE dbo.LOPHOC WHERE MaLop = @MaLopDangHoc

	PRINT N'Chuyển học viên ' + TRIM(@MaHV) + N' sang lớp '+ TRIM(@MaLopChuyen) + N' thành công!'
END
GO

--Thực thi bài 8
DECLARE @MaHV NCHAR(10)
DECLARE @MaLH NCHAR(10)
SET @MaHV = 'HV000012'
SET @MaLH = 'LH000008'
EXEC usp_ChuyenLopHocVien @MaHV, @MaLH
GO