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

-- Câu 1: Nhận vào @ten và in ra dòng ‘Xin chào’ + @ten.
-- Khởi tạo proc
If (object_id('usp_Hello',N'P') is not null)
	drop proc usp_Hello
go
create proc usp_Hello 
@ten nvarchar(10)
as
begin 
	print 'Hello '+@ten
end
go
-- Thực thi
exec usp_Hello N'Tèo'
go
--------------------------------------------

-- Câu 2: Nhận vào @a, @b và in ra tổng hai số @a, @b bằng lệnh print.
-- Khởi tạo proc
If (object_id('usp_TinhTong_Print',N'P') is not null)
	drop proc usp_TinhTong_Print
go
create proc usp_TinhTong_Print
@a int,
@b int
as
begin 
	print @a+@b
end
go
-- Thực thi
exec usp_TinhTong_Print 5,10
go
--------------------------------------------

-- Câu 3: Nhận vào @a, @b và xuất ra tổng hai số @a, @b dưới dạng tham số output.
-- Khởi tạo proc
If (object_id('usp_TinhTong_OutPut',N'P') is not null)
	drop proc usp_TinhTong_OutPut
go
create proc usp_TinhTong_OutPut
@a int,
@b int,
@result int = null output
as
begin 
	set @result = @a+@b
end
go
-- Thực thi
declare @result int
exec usp_TinhTong_OutPut 5,10,@result out
print @result
go
--------------------------------------------

-- Câu 4: Nhận vào @a, @b và xuất ra tổng hai số @a, @b bằng lệnh return.
-- Khởi tạo proc
If (object_id('usp_TinhTong_Return',N'P') is not null)
	drop proc usp_TinhTong_Return
go
create proc usp_TinhTong_Return
@a int,
@b int
as
begin 
	declare @result int
	set @result = @a+@b
	return @result
end
go
-- Thực thi
declare @result int
exec @result= usp_TinhTong_Return 5,10
print @result
go
--------------------------------------------

--Câu 5: Nhận vào @a, @b và tính tổng các số nằm trong đoạn [@a, @b].
-- + Trả về giá trị tổng nếu @a < @b
-- + Trả về 0 nếu @a = @b
-- + Trả về -1 nếu @a > @b
-- Giá trị trả về được lưu trong tham số output.
-- Khởi tạo proc
If (object_id('usp_Tong_Output',N'P') is not null)
	drop proc usp_Tong_Output
go
create proc usp_Tong_Output
@a int,
@b int,
@result int = null output
as
begin 
	if(@a=@b)
		set @result = 0
	else if(@a>@b)
		set @result = -1
	else 
	begin
	set @result = 0
	while(@a<=@b)
		begin
			set @result = @result + @a
			set @a= @a+1
		end
	end
end
go
-- Thực thi
declare @result int
exec usp_Tong_Output 20,10,@result out
print @result
go
--------------------------------------------

--Câu 6: Nhận vào @a, @b và tính tổng các số nằm trong đoạn [@a, @b].
-- + Trả về giá trị tổng nếu @a < @b
-- + Trả về 0 nếu @a = @b
-- + Trả về -1 nếu @a > @b
-- Sử dụng lệnh return để trả về giá trị.
-- Khởi tạo proc
If (object_id('usp_Tong_Return',N'P') is not null)
	drop proc usp_Tong_Return
go
create proc usp_Tong_Return
@a int,
@b int
as
begin
	
	if(@a=@b)
		return 0
	else if(@a>@b)
		return 1
	else 
	begin
	declare @result int = 0
	while(@a<=@b)
		begin
			set @result = @result + @a
			set @a= @a+1
		end
		return @result
	end
end
go
-- Thực thi
declare @result int
exec @result = usp_Tong_Return 10,5
print @result
go
--------------------------------------------

--Câu 7: Nhận vào @n và kiểm tra xem n có phải số nguyên tố không.
-- + Trả về 1 nếu @n là số nguyên tố.
-- + Trả về -1 nếu @n không phải là số nguyên tố.
-- Giá trị trả về được lưu trong tham số output
-- Khởi tạo proc
If (object_id('usp_KiemTraSNT',N'P') is not null)
	drop proc usp_KiemTraSNT
go
create proc usp_KiemTraSNT
@n int,
@result int null output
as
begin
	declare @count int = 0
	declare @i int = 2
	if @n < 2
		set @result = -1
	else 
		begin
	while(@i<=SQRT(@n))
		begin
			if (@n%@i=0)
				set @count = @count + 1
			set @i=@i+1
		end
	if @count = 0
		set @result = 1
	else
		set @result = -1
	end
end
go
-- Thực thi
declare @result int
exec usp_KiemTraSNT 4,@result out
print @result
go
--------------------------------------------

--Câu 8: Nhận vào @a, @b và đếm các số nguyên tố trong đoạn [@a,@b]. Giá trị trả về được lưu trong tham số output.
-- Lưu ý: sử dụng lại strored procedure ở câu 7.
-- Khởi tạo proc
If (object_id('usp_SNT_TrongDoan',N'P') is not null)
	drop proc usp_SNT_TrongDoan
go
create proc usp_SNT_TrongDoan
@a int,
@b int,
@result int null output
as
begin
	set @result = 0
	while(@a<=@b)
	begin
		declare @temp int
		exec usp_KiemTraSNT @a,@temp out
		if (@temp = 1)
			begin
				set @result=@result + 1
				set @a = @a+1
			end
		else
			set @a=@a+1
	end
end
go
-- Thực thi
declare @result int
exec usp_SNT_TrongDoan 2,5,@result out
print @result
go
--------------------------------------------

--Câu 8: Nhận vào @a, @b và đếm các số nguyên tố trong đoạn [@a,@b]. Giá trị trả về được lưu trong tham số output.
-- Lưu ý: sử dụng lại strored procedure ở câu 7.
-- Khởi tạo proc
If (object_id('usp_SNT_TrongDoan',N'P') is not null)
	drop proc usp_SNT_TrongDoan
go
create proc usp_SNT_TrongDoan
@a int,
@b int,
@result int null output
as
begin
	set @result = 0
	while(@a<=@b)
	begin
		declare @temp int
		exec usp_KiemTraSNT @a,@temp out
		if (@temp = 1)
			begin
				set @result=@result + 1
				set @a = @a+1
			end
		else
			set @a=@a+1
	end
end
go
-- Thực thi
declare @result int
exec usp_SNT_TrongDoan 2,5,@result out
print @result
go
--------------------------------------------

--Câu 9.Nhận vào @n và kiểm tra xem n có phải số chẵn không.
-- + Trả về 1 nếu @n là số chẵn.
-- + Trả về -1 nếu @n không phải số chẵn.
-- Giá trị trả về được lưu trong tham số output.
-- Khởi tạo proc
If (object_id('usp_KiemTraChan',N'P') is not null)
	drop proc usp_KiemTraChan
go
create proc usp_KiemTraChan
@n int,
@result int null output
as
begin
	if(@n%2=0)
		set @result = 1
	else
		set @result = -1
end
go
-- Thực thi
declare @result int
exec usp_KiemTraChan 3,@result out
print @result
go
--------------------------------------------

--Câu 10.Nhận vào @a, @b và đếm các số nguyên tố không chẵn trong đoạn [@a, @b]. 
-- Giá trị trả về được lưu trong tham số output. 
-- Lưu ý: sử dụng lại stored procedure ở câu 7 và 9.
-- Khởi tạo proc
If (object_id('usp_SNTKhongChan',N'P') is not null)
	drop proc usp_SNTKhongChan
go
create proc usp_SNTKhongChan
@a int,
@b int,
@result int null output
as
begin
	set @result = 0
	while (@a<=@b)
	begin
	declare @laSNT int 
	exec usp_KiemTraSNT @a,@laSNT out
	declare @laLe int
	exec usp_KiemTraChan @a,@laLe out
	if(@laSNT=1 and @laLe = -1)
		begin
			set @result = @result + 1
			set @a = @a+1
		end
	else
		set @a = @a+1
	end
end
go
-- Thực thi
declare @result int
exec usp_SNTKhongChan 2,10,@result out
print @result
go
--------------------------------------------
--------------------------------------------

--Câu 12. Cho biết danh sách các học viên thuộc về lớp do giáo viên “GV00001” quản lý.
If (object_id('usp_DSHocVien',N'P') is not null)
	drop proc usp_DSHocVien
go
create proc usp_DSHocVien
as
begin
	select HV.*
	from HOCVIEN HV join LOPHOC LH on HV.MaLop = LH.MaLop
	where LH.GVQuanLi = 'GV00001'
end
go
-- Thực thi
exec usp_DSHocVien
go
--------------------------------------------

-- Câu 12. Cho biết danh sách các học viên thuộc về lớp do giáo viên “GV00001” quản lý.
If (object_id('usp_DSHocVien',N'P') is not null)
	drop proc usp_DSHocVien
go
create proc usp_DSHocVien
as
begin
	select HV.*
	from HOCVIEN HV join LOPHOC LH on HV.MaLop = LH.MaLop
	where LH.GVQuanLi = 'GV00001'
end
go
-- Thực thi
exec usp_DSHocVien
go
--------------------------------------------

-- Câu 13.	Nhận vào một mã lớp, cho biết danh sách các học viên thuộc lớp này.
If (object_id('usp_DSHVCuaLop',N'P') is not null)
	drop proc usp_DSHVCuaLop
go
create proc usp_DSHVCuaLop
@malop varchar(8)
as
begin
	select HV.*
	from HOCVIEN HV join LOPHOC LH on HV.MaLop = LH.MaLop
	where LH.MaLop = @malop
end
go
-- Thực thi
exec usp_DSHVCuaLop 'LH000002'
go
--------------------------------------------

-- Câu 14.	Nhận vào một mã lớp, cho biết sỉ số lớp, họ tên giáo viên quản lý lớp và họ tên lớp trưởng. 
-- Xuất kết quả bằng tham số output.
If (object_id('usp_ThongTinCuaLop',N'P') is not null)
	drop proc usp_ThongTinCuaLop
go
create proc usp_ThongTinCuaLop
@malop varchar(8),
@siso int null output,
@tengv nvarchar(50) null output,
@tenloptruong nvarchar(50) null output
as
begin
	select  @siso = COUNT(*),@tengv = GV.TenGV
	from HOCVIEN HV join LOPHOC LH on HV.MaLop = LH.MaLop join GIAOVIEN GV on GV.MaGV = LH.GVQuanLi
	where LH.MaLop = @malop
	group by GV.TenGV
	
	select @tenloptruong = HV.TenHocVien
	from HOCVIEN HV join LOPHOC LH on HV.MaHocVien = LH.LopTruong
	where LH.MaLop = @malop

end
go
-- Thực thi
declare @siso int
declare @tengv nvarchar(50)
declare @tenloptruong nvarchar(50)
declare @malop varchar(8)='LH000001'
exec usp_ThongTinCuaLop @malop,@siso out,@tengv out,@tenloptruong out
print N'Lớp: '+ @malop + N' - GVCN: ' + @tengv +N' - Lớp trưởng: '+ @tenloptruong +N' - Sĩ số: ' + cast(@siso as varchar) 
go
--------------------------------------------

-- Câu 15. Nhận vào một mã lớp, xuất ra họ tên giáo viên quản lý lớp bằng lệnh print.
If (object_id('usp_GiaoVienQuanLy',N'P') is not null)
	drop proc usp_GiaoVienQuanLy
go
create proc usp_GiaoVienQuanLy
@malop varchar(8)
as
begin
	declare @tengv nvarchar(50)
	select @tengv = GV.TenGV
	from GIAOVIEN GV join LOPHOC LH on GV.MaGV = LH.GVQuanLi
	where LH.MaLop = @malop
	print 'GVCN: '+@tengv
end
go
-- Thực thi
exec usp_GiaoVienQuanLy 'LH000002'
go
--------------------------------------------

-- Câu 16. Nhận vào mã lớp, cho biết danh sách (dùng lệnh select) họ tên các học viên lớn tuổi nhất của lớp này
If (object_id('usp_DSHVLonTuoi',N'P') is not null)
	drop proc usp_DSHVLonTuoi
go
create proc usp_DSHVLonTuoi
@malop varchar(8)
as
begin
	select HV.*
	from HOCVIEN HV join LOPHOC LH on HV.MaLop = LH.MaLop
	where LH.MaLop = @malop and Datediff(year,HV.NgaySinh,getdate()) =( select MAX(DATEDIFF(year,HV1.NgaySinh,GETDATE()))
																		from HOCVIEN HV1 join LOPHOC LH1 on HV1.MaLop = LH1.MaLop
																		where LH1.MaLop = @malop )
end
go
-- Thực thi
exec usp_DSHVLonTuoi 'LH000004'
go
--------------------------------------------

-- Câu 17.	Nhận vào giá trị giới tính, xuất ra số lượng giáo viên có giới tính này qua tham số output.
If (object_id('usp_SoLuongGVTheoGioiTinh',N'P') is not null)
	drop proc usp_SoLuongGVTheoGioiTinh
go
create proc usp_SoLuongGVTheoGioiTinh
@gioitinh nvarchar(10),
@result int null output
as
begin
	select @result = count(*) 
	from GIAOVIEN GV
	where GV.GioiTinh = @gioitinh
end
go
-- Thực thi
declare @result int
exec usp_SoLuongGVTheoGioiTinh N'Nam',@result out
print @result
go
--------------------------------------------

-- Câu 18.	Nhận vào một tên môn, cho biết danh sách các giáo viên (dùng lệnh select) đã từng
-- được phân công giảng dạy môn này

If (object_id('usp_GVDuocPCGiangDay',N'P') is not null)
	drop proc usp_GVDuocPCGiangDay
go
create proc usp_GVDuocPCGiangDay
@monhoc nvarchar(50)

as
begin
	select distinct GV.*
	from MONHOC MH join PHANCONG PC on MH.MaMonHoc = PC.MaMH join GIAOVIEN GV on PC.MaGV = GV.MaGV
	where MH.TenMonHoc = @monhoc
end
go
-- Thực thi
declare @result int
exec usp_GVDuocPCGiangDay N'Khai thác dữ liệu'
go
--------------------------------------------