using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_TinhTienLuong
{
    class QuanLy : NhanVien
    {
        int _heSoChucVu;
        float _thuong;

        public override void Nhap()
        {
            Console.WriteLine("Nhap thong tin cua nhan vien quan li: ");
            Console.Write("Ho ten cua nhan vien: ");
            HoTen = Console.ReadLine();
            Console.Write("Ngay sinh cua nhan vien: ");
            NgaySinh = Console.ReadLine();
            Console.Write("Luong co ban: ");
            LuongCoBan = float.Parse(Console.ReadLine());
            Console.Write("He so chuc vu: ");
            _heSoChucVu = Int32.Parse(Console.ReadLine());
            Console.Write("Thuong: ");
            _thuong = float.Parse(Console.ReadLine());
        }
        public override void Xuat()
        {
            Console.WriteLine("Ho ten: " + HoTen);
            Console.WriteLine("Chuc vu: NV-QuanLy");
            Console.WriteLine("Ngay sinh: " + NgaySinh);
            Console.WriteLine("Luong co ban: " + LuongCoBan);
            Console.WriteLine("He so chuc vu: " + _heSoChucVu);
            Console.WriteLine("Thuong: " + _thuong);
            Console.WriteLine("-------------------------------------");
        }
        public override float Luong()
        {
            float tinhLuong = 0;
            tinhLuong = LuongCoBan * _heSoChucVu + _thuong;
            return tinhLuong;
        }
    }
}
