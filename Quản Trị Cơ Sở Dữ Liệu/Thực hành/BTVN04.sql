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
-- Author:		Nguyễn Trọng Quyết
-- Create date: 09-11-2020
-- Description:	BTVN-04
-- =============================================
-- Stored procedure đã cài đặt ở câu 3, bài tập về nhà 3.( Cho máy chưa có )
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
declare @DiemTB float
exec usp_TinhDiemTBHocVien 'HV000006  ',@DiemTB out
print @diemtb
select * from HOCVIEN

-- =============================================
IF OBJECT_ID('usp_ThongTinLop') IS NOT NULL
DROP proc usp_ThongTinLop
GO
CREATE PROC usp_ThongTinLop
@MaLop nchar(10)
AS
BEGIN
DECLARE @siso int
DECLARE @GVQL nvarchar(50)
SELECT @siso = COUNT (HV.MaLop),@GVQL = GV.TenGV 
FROM HOCVIEN HV JOIN LOPHOC LH ON HV.MaLop = LH.MaLop JOIN GIAOVIEN GV on LH.GVQuanLi = GV.MaGV
WHERE LH.MaLop = @MaLop
GROUP BY GV.TenGV 
PRINT N'**Lớp: ' + @MaLop
PRINT N'**Sĩ só: ' + TRIM(CAST (@siso as nchar(5))) +N' học viên'
PRINT N'**Giáo viên quản lí:' + @GVQL
PRINT N'**Danh sác học viên:'
DECLARE cur_TTLopX CURSOR FOR
SELECT TenHocVien,DATEDIFF(year,NgaySinh,GETDATE()) 
FROM HOCVIEN
WHERE MaLop = @MaLop 
OPEN cur_TTLopX
DECLARE @TenHV nvarchar(50)
DECLARE @Tuoi int
DECLARE @index int = 1
FETCH NEXT FROM cur_TTLopX INTO @TenHV, @Tuoi
WHILE @@FETCH_STATUS = 0
BEGIN
PRINT '****' + CAST(@index AS nchar(1)) + '. ' + @TenHV + ': '+ CAST(@Tuoi as nchar(2))+N' tuổi'
SET @index = @index + 1
FETCH NEXT FROM cur_TTLopX INTO @TenHV,@Tuoi
END
CLOSE cur_TTLopX
DEALLOCATE cur_TTLopX
END
GO
exec usp_ThongTinLop 'LH000004'

IF OBJECT_ID('usp_ThongTinLopX') IS NOT NULL
DROP proc usp_ThongTinLopX
GO
CREATE PROC usp_ThongTinLopX
@MaLop nchar(10)
AS
BEGIN
	DECLARE @LopTruong nvarchar(50)
	SELECT  distinct @LopTruong = HV1.TenHocVien 
	FROM HOCVIEN HV JOIN LOPHOC LH ON HV.MaLop = LH.MaLop JOIN HOCVIEN HV1 on LH.LopTruong = HV1.MaHocVien
	WHERE LH.MaLop = @MaLop
	
	PRINT N'**Lớp: ' + @MaLop
	PRINT N'**Lớp trưởng:' + @LopTruong
	PRINT N'**Danh sác học viên:'
	
	DECLARE cur_TTLopY CURSOR FOR
	SELECT MaHocVien ,TenHocVien FROM HOCVIEN
	WHERE MaLop = @MaLop	

	OPEN cur_TTLopY

	DECLARE @TenHV nvarchar(50)
	DECLARE @MaHV nchar(10)
	DECLARE @index int = 1

	FETCH NEXT FROM cur_TTLopY INTO @MaHV, @TenHV
	WHILE @@FETCH_STATUS = 0
	BEGIN
	DECLARE @DiemTB float
		exec usp_TinhDiemTBHocVien @MaHV, @DiemTB out
		IF(@DiemTB<0)
		SET @DiemTB = null
		PRINT '****' + CAST(@index AS varchar) + '. ' + @TenHV + ': '+ ISNULL(CAST(@DiemTB as varchar),'NULL')
		SET @index = @index + 1
		FETCH NEXT FROM cur_TTLopY INTO @MaHV, @TenHV
		END
	CLOSE cur_TTLopY
	DEALLOCATE cur_TTLopY
END
GO
exec usp_ThongTinLopX N'LH000004'
go


select * from HOCVIEN