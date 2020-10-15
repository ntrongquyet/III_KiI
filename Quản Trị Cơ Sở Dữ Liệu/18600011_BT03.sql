----- CÂU 1 -----
DECLARE @NUMA INT
DECLARE @NUMB INT
DECLARE @NUMC INT
DECLARE @NUMMIN INT

SET @NUMA = 2
SET @NUMB = - 3
SET @NUMC = 2
SET @NUMMIN = @NUMA

PRINT N'Ba số lần lượt là:  ' + CAST(@NUMA AS NVARCHAR) + ' ' + CAST(@NUMB AS NVARCHAR) + ' ' + CAST(@NUMC AS NVARCHAR)

IF @NUMB < @NUMMIN
	SET @NUMMIN = @NUMB

IF @NUMC < @NUMMIN
	SET @NUMMIN = @NUMC

PRINT N'Số nhỏ nhất là: ' + CAST(@NUMMIN AS NVARCHAR)

----- CÂU 2 -----
DECLARE @diem FLOAT
DECLARE @hoten NVARCHAR(50)
DECLARE @masv VARCHAR(8)

SET @diem = (
		SELECT MAX(DiemTB)
		FROM SinhVien
		) (
		SELECT @masv = MaSV
			,@hoten = Hoten
			,@diem = DiemTB
		FROM SinhVien SV
		WHERE SV.DiemTB = @diem
		)

IF @diem >= 8.0
BEGIN
	PRINT @masv + N' - Điểm trung bình: ' + CAST(@diem AS VARCHAR) + N' - Xếp loại: Giỏi'
END
ELSE IF @diem < 8.0
	AND @diem >= 6.5
BEGIN
	PRINT @masv + N' - Điểm trung bình: ' + CAST(@diem AS VARCHAR) + N' - Xếp loại: Khá'
END
ELSE IF @diem >= 5
BEGIN
	PRINT @masv + N' - Điểm trung bình: ' + CAST(@diem AS VARCHAR) + N' - Xếp loại: Trung bình'
END
ELSE
BEGIN
	PRINT @masv + N' - Điểm trung bình: ' + CAST(@diem AS VARCHAR) + N' - Xếp loại: Yếu'
END

----- CÂU 3 -----
DECLARE @mssv VARCHAR(8)
DECLARE @ht NVARCHAR(50)
DECLARE @ns DATE

SELECT @mssv = MaSV
	,@ht = Hoten
	,@ns = NgaySinh
FROM SinhVien
WHERE MaSV = '0912033'

PRINT N'Mã SV :' + @mssv + CHAR(13) + CHAR(10) + N'Họ tên :' + @ht + CHAR(13) + CHAR(10) + N'Ngày sinh :' + Cast(@ns AS VARCHAR)

----- CÂU 4 -----
SELECT SV.MaSV
	,SV.Hoten
	,AVG(DT.Diem) DiemTB
	,"Kết quả" = CASE 
		WHEN AVG(DT.Diem) > 5
			THEN N'Đậu'
		ELSE N'Rớt'
		END
FROM SinhVien SV
JOIN DiemThi DT ON SV.MaSV = DT.MaSV
GROUP BY SV.MaSV
	,SV.Hoten

SELECT SV.MaSV
	,SV.Hoten
	,DT.Diem AS N'Điểm TB'
	,"Kết quả" = CASE 
		WHEN DT.Diem > 5
			THEN N'Đậu'
		ELSE N'Rớt'
		END
FROM SinhVien SV
JOIN DiemThi DT ON SV.MaSV = DT.MaSV

----- CÂU 5 -----
DECLARE @msg NVARCHAR(100)
DECLARE @msv VARCHAR(8)

SET @msv = '0912033'
SET @msg = @msv + N' chưa tồn tại'

SELECT @msv = SV.MaSV
FROM SinhVien SV
WHERE SV.MaSV = @msv

IF @msv = '0912033'
BEGIN
	SET @msg = @msv + N' sinh viên đã tồn tại'
END

PRINT @msg

----- CÂU 6 -----
DECLARE @mamh VARCHAR(8)

SET @mamh = 'MH05'

IF EXISTS (
		SELECT *
		FROM MonHoc
		WHERE MaMH = @mamh
		)
BEGIN
	PRINT @mamh + N' đã tồn tại'
END
ELSE
	INSERT INTO MonHoc (MaMH)
	VALUES (@mamh)

----- CÂU 7 -----
-- 7.1
-- Tạo thủ tục đếm số sinh viên trong 1 lớp
CREATE PROC usp_DemSoSV @MaLop VARCHAR(8)
	,@SiSo INT OUTPUT
AS
SELECT @SiSo = count(*)
FROM SinhVien
WHERE MaLop = @MaLop

RETURN 0
GO

-- Thực thi thủ tục usp_DemSoSV
DECLARE @test INT

EXEC usp_DemSoSV 'L02'
	,@test OUTPUT

PRINT @test

-- 7.2
-- Thủ tục in sĩ số sinh viên của 1 lớp kèm tên lớp
CREATE PROC usp_InSoSV @MaLop VARCHAR(8)
	,@SiSo INT OUTPUT
AS
SELECT @SiSo = COUNT(*)
FROM SinhVien
WHERE MaLop = @MaLop

PRINT N'Lớp ' + @MaLop + N' có ' + CAST(@SiSo AS VARCHAR) + N' sinh viên'

RETURN 0
GO

-- Thực thi thủ tục usp_InSoSV
DECLARE @SiSo INT

EXEC usp_InSoSV 'L01'
	,@SiSo

-- 7.3
-- Thủ tục lấy điểm của một sinh viên
CREATE PROC usp_DiemMonHoc @MaSV VARCHAR(8)
	,@MaMH VARCHAR(8)
	,@Diem FLOAT OUTPUT
AS
SELECT @Diem = Diem
FROM KetQua
WHERE MaMH = @MaMH
	AND MaSV = @MaSV

RETURN 0
GO

-- Thực thi thủ tục usp_DemSoSV
DECLARE @diem FLOAT

EXEC usp_DiemMonHoc 'SV02'
	,'MH01'
	,@diem OUTPUT

PRINT @diem

-- 7.4
DECLARE cursorSinhVien CURSOR
FOR
SELECT MaLop
FROM SinhVien
GROUP BY MaLop

OPEN cursorSinhVien

DECLARE @MaLop VARCHAR(8)
	,@SiSo INT

FETCH NEXT
FROM cursorSinhVien
INTO @MaLop

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC usp_DemSoSV @MaLop
		,@SiSo OUTPUT

	PRINT N'Sĩ số lớp ' + @MaLop + N' là: ' + Cast(@SiSo AS VARCHAR)

	FETCH NEXT
	FROM cursorSinhVien
	INTO @MaLop
END

CLOSE cursorSinhVien

DEALLOCATE cursorSinhVien

--7.5
-- Thủ tục tìm tên lớp của sinh viên
CREATE PROC usp_LopCuaSV @MaSV VARCHAR(8)
	,@Lop NVARCHAR(50) OUTPUT
AS
SELECT @Lop = L.TenLop
FROM SinhVien SV
JOIN Lop L ON SV.MaLop = L.MaLop
WHERE SV.MaSV = @MaSV

RETURN 0
GO

-- Thực thi thủ tục usp_LopCuaSV
DECLARE @tenlop NVARCHAR(50)

EXEC usp_LopCuaSV 'SV04'
	,@tenlop OUTPUT

PRINT @tenlop