-------------------------------------------------------------------
-- 8.1 Viết hàm tính điểm trung bình của sinh viên.
-------------------------------------------------------------------
CREATE FUNCTION uf_DiemTrungBinh ()
RETURNS @BangDiem TABLE (
	MaSV VARCHAR(8)
	,TenSV NVARCHAR(50)
	,DiemTB FLOAT
	)
AS
BEGIN
	DECLARE cur_SV CURSOR
	FOR
	SELECT MaSV
	FROM SinhVien

	DECLARE @Ma VARCHAR(8)

	OPEN cur_SV

	FETCH NEXT
	FROM cur_SV
	INTO @Ma

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @BangDiem
		VALUES (
			@Ma
			,(
				SELECT Hoten
				FROM SinhVien
				WHERE MaSV = @Ma
				)
			,(
				SELECT AVG(Diem)
				FROM KetQua
				WHERE MaSV = @Ma
				)
			)

		FETCH NEXT
		FROM cur_SV
		INTO @Ma
	END

	CLOSE cur_SV

	DEALLOCATE cur_SV

	RETURN
END

-- Thực thi hàm 
SELECT *
FROM uf_DiemTrungBinh()

-------------------------------------------------------------------
-- 8.2 Viết hàm tìm mã sinh viên có điểm trung bình cao nhất.
-------------------------------------------------------------------
SELECT *
FROM uf_DiemTrungBinh()

CREATE FUNCTION uf_DiemCaoNhat ()
RETURNS VARCHAR(8)
AS
BEGIN
	-- Khai báo biến trả về 
	DECLARE @MaSV VARCHAR(8);

	SELECT @MaSV = MAX(DiemTB)
	FROM uf_DiemTrungBinh()

	RETURN @MaSV
END

PRINT dbo.uf_DiemCaoNhat()

-------------------------------------------------------------------
-- 8.3 Viết hàm xuất danh sách các sinh viên có điểm < 5
-------------------------------------------------------------------
CREATE FUNCTION uf_DSSV ()
RETURNS TABLE
AS
RETURN

SELECT SV.MaSV
	,SV.Hoten
	,MH.TenMH
	,KQ.Diem
FROM SinhVien SV
JOIN KetQua KQ ON SV.MaSV = KQ.MaSV
JOIN MonHoc MH ON KQ.MaMH = MH.MaMH
WHERE KQ.Diem > 5
GO

SELECT *
FROM uf_DSSV()

-------------------------------------------------------------------
-- 8.4 Viết thủ tục xếp loại cho sinh viên (gọi hàm câu 1).
-------------------------------------------------------------------
CREATE PROC usp_XepLoai @MaSV VARCHAR(8)
AS
SELECT *
	,N'Xếp loại' = CASE 
		WHEN DiemTB >= 8
			THEN N'Giỏi'
		WHEN DiemTB < 8
			AND DiemTB >= 6.5
			THEN N'Khá'
		WHEN DiemTB < 6.5
			AND DiemTB > 5
			THEN N'Trung bình'
		ELSE N'Yếu'
		END
FROM uf_DiemTrungBinh()
WHERE MaSV = @MaSV

RETURN 0
GO

EXEC usp_XepLoai 'SV02'