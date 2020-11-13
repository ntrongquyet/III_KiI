using System;

namespace OOP_ChiTietMay
{
    class Program
    {
        static void Main(string[] args)
        {
            May may = new May();
            may.Nhap();
            Console.WriteLine("-------------------------");
            may.Xuat();
            Console.WriteLine($"Tong tien chi tiet cua may la: {may.TongTien()}");
            Console.WriteLine("-------------------------");
            Console.WriteLine($"Chi tiet co ma la X2-1:");
            may.TimKiem("X2-1").Xuat();
        }
    }
}
