using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_TinhTienLuong
{
    class SanXuat:NhanVien
    {
        int _soSanPham;

        public override void Nhap()
        {
            Console.WriteLine("Nhap thong tin cua nhan vien san xuat: ");
            Console.Write("Ho ten cua nhan vien: ");
            HoTen = Console.ReadLine();
            Console.Write("Ngay sinh cua nhan vien: ");
            NgaySinh = Console.ReadLine();
            Console.Write("Luong co ban: ");
            LuongCoBan = float.Parse(Console.ReadLine());
            Console.Write("So san pham: ");
            _soSanPham = Int32.Parse(Console.ReadLine());
        }
        public override void Xuat()
        {
            Console.WriteLine("Ho ten: " + HoTen);
            Console.WriteLine("Chuc vu: NV-SanXuat");
            Console.WriteLine("Ngay sinh: " + NgaySinh);
            Console.WriteLine("Luong co ban: " + LuongCoBan);
            Console.WriteLine("So san pham: " + _soSanPham);
            Console.WriteLine("-------------------------------------");
        }
        public override float Luong()
        {
            float tinhLuong = LuongCoBan + _soSanPham * 2000;
            return tinhLuong;
        }
    }
}
