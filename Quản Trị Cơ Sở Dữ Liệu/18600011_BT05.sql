-- Câu 1: Sinh viên chỉ được học các môn của khoa mình mở.

-- Bối cảnh: SinhVien, LopHoc, Khoa, MonHoc

--				Thêm		Xoá			Sửa
-- SinhVien		+			-			+(MaLop)
-- LopHoc		+			-			+(MaKhoa)
-- Khoa			-			+			+(MaKhoa)
-- MonHoc		+			-			+(MaKhoa)
--------------------------------------------------------------------------------------------------
-- Câu 2: Sinh viên chỉ được thi lại nếu điểm của lần thi sau cùng < 5 và số lần thi < 3.

-- Bối cảnh: SinhVien,KetQua

--				Thêm		Xoá			Sửa
-- SinhVien		-			+			+(MaSV)
-- KetQua		+			-			+(LanThi,Diem)
--------------------------------------------------------------------------------------------------
-- Câu 3: Số lượng sinh viên (nếu có) bằng số sinh viên của lớp đó.

-- Bối cảnh: SinhVien,Lop

--				Thêm		Xoá			Sửa
-- SinhVien		+			+			-
-- Lop			-			+			+(MaLop)
--------------------------------------------------------------------------------------------------
-- Câu 4: Xóa một sinh viên phải xóa tất cả các tham chiếu đến sinh viên đó.

-- Bối cảnh: SinhVien,KetQua

--				Thêm		Xoá			Sửa
-- SinhVien		-			+			+(MaSV)
-- KetQua		-			+			+(MaSV)
--------------------------------------------------------------------------------------------------
-- Câu 5: Điểm trung bình (nếu có) phải bằng tổng điểm / tổng tín chỉ.

-- Bối cảnh: SinhVien,KetQua,MonHoc

--				Thêm		Xoá			Sửa
-- SinhVien		-			+			+(MaSV,DiemTB)
-- KetQua		+			+			-(MaSV,Diem)
-- MonHoc		-			+			+(MaMH,SoChi)
--------------------------------------------------------------------------------------------------
-- Câu 6: Sinh viên chỉ được nhập học từ 18 đến 22 tuổi.

-- Bối cảnh: SinhVien

--				Thêm		Xoá			Sửa
-- SinhVien		+			-			+(NamSinh,NamBD,NamKT)
--------------------------------------------------------------------------------------------------
-- Câu 7: Năm bắt đầu học của sinh viên phải nhỏ hơn năm kết thúc và lớn hơn năm thành lập của khoa đó.

-- Bối cảnh: SinhVien,Khoa

--				Thêm		Xoá			Sửa
-- SinhVien		+			-			+(NamBD,NamKT)
-- Khoa			-			+			+(NamThanhLap)
--------------------------------------------------------------------------------------------------
-- Câu 8: Tình trạng của sinh viên là ‘Đã tốt nghiệp’ nếu điểm trung bình >=5.0 và năm kết thúc < năm hiện hành.
-- Tình trạng là ‘Đang học’ nếu năm kết thúc >= năm hiện hành.
-- Tình trạng là ‘Bị thôi học’ nếu điểm trung bình < 5.0 và năm kết thúc > năm hiện hành.

-- Bối cảnh: SinhVien

--				Thêm		Xoá			Sửa
-- SinhVien		+			-			+(NamBD,NamKT,DiemTB)

