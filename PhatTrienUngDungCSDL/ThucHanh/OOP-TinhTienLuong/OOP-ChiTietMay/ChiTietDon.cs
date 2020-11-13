using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_ChiTietMay
{
    class ChiTietDon : ChiTiet
    {

        public override void Nhap()
        {
            Console.Write("Nhap ten ma chi tiet don: ");
            MaSo = Console.ReadLine();
            Console.Write("Nhap gia tien: ");
            GiaTien = float.Parse(Console.ReadLine());
        }
        public override void Xuat()
        {
            Console.WriteLine("Ma so: " + MaSo);
            Console.WriteLine("Gia tien: " + GiaTien);
        }
        public override float TinhTien()
        {
            return GiaTien;
        }
        public override ChiTiet TimKiem(string _maso)
        {
            if (MaSo.Equals(_maso))
            {
                return this;
            }
            return null; 
        }
    }
}
