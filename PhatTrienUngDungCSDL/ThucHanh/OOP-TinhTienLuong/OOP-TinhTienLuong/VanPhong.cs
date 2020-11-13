using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_TinhTienLuong
{
    class VanPhong:NhanVien
    {
        int _soNgayLam;
        float _troCap;

        public override void Nhap()
        {
            Console.WriteLine("Nhap thong tin cua nhan vien van phong: ");
            Console.Write("Ho ten cua nhan vien: ");
            HoTen = Console.ReadLine();
            Console.Write("Ngay sinh cua nhan vien: ");
            NgaySinh = Console.ReadLine();
            Console.Write("Luong co ban: ");
            LuongCoBan = float.Parse(Console.ReadLine());
            Console.Write("So ngay lam: ");
            _soNgayLam = Int32.Parse(Console.ReadLine());
            Console.Write("Tro cap: ");
            _troCap = float.Parse(Console.ReadLine());
        }
        public override void Xuat()
        {
            Console.WriteLine("Ho ten: " + HoTen);
            Console.WriteLine("Chuc vu: NV-VanPhong");
            Console.WriteLine("Ngay sinh: " + NgaySinh);
            Console.WriteLine("Luong co ban: " + LuongCoBan);
            Console.WriteLine("So ngay lam: " + _soNgayLam);
            Console.WriteLine("Tro cap: " + _troCap);
            Console.WriteLine("-------------------------------------");
        }
        public override float Luong()
        {
            float tinhLuong = LuongCoBan + _soNgayLam * 100000 + _troCap;
            return tinhLuong;
        }
    }
}
