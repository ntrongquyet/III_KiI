using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OOP_ChiTietMay
{
    class ChiTietPhuc:ChiTiet
    {
        int _soLuongCT;
        ChiTiet[] list;

        public override void Nhap()
        {
            Console.Write("Nhap ten ma chi tiet phuc: ");
            MaSo = Console.ReadLine();
            Console.Write("Nhap so luong chi tiet con: ");
            _soLuongCT = Int16.Parse(Console.ReadLine());
            list = new ChiTiet[_soLuongCT];
            int loai;
            for(int i = 0; i < _soLuongCT; i++)
            {
                Console.WriteLine($"Nhap chi tiet {i+1}");
                Console.Write("0.Chi tiet don\n1.Chi tiet phuc\nChon loai chi tiet:");
                loai = Int16.Parse(Console.ReadLine());
                if (loai == 0)
                    list[i] = new ChiTietDon();
                else if (loai == 1)
                    list[i] = new ChiTietPhuc();
                list[i].Nhap();
            }
        }
        public override void Xuat()
        {
            Console.WriteLine("Ma so: " + MaSo);
            //Console.WriteLine("Gia tien: " + GiaTien);
            Console.WriteLine($"Chi tiet phuc co {_soLuongCT} con: ");
            for (int i = 0; i < _soLuongCT; i++)
                list[i].Xuat();
        }
        public override float TinhTien()
        {
            float tien = 0;
            for(int i = 0; i < _soLuongCT; i++)
            {
                tien += list[i].TinhTien();
            }
            return tien;
        }
        public override ChiTiet TimKiem(string _maso)
        {
            if (MaSo.Equals(_maso))
            {
                return this;
            }
            for(int i = 0; i < _soLuongCT; i++)
            {
                return list[i].TimKiem(_maso);
            }
            return null;
        }
    }
}
