using System;

namespace OOP_TinhTienLuong
{
    class Program
    {
        static void Main(string[] args)
        {
            CongTy ct = new CongTy();
            ct.Nhap();
            Console.Clear();
            ct.Xuat();
            Console.WriteLine("Tong luong cua toan cong ty la: " + ct.Luong());
            Console.WriteLine($"Nhan vien Nguyen Van A:");
            ct.TimKiem("Van A").Xuat();
        }
    }
}
