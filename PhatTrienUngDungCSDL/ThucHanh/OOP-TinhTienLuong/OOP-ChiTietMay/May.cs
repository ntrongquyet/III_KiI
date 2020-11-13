using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_ChiTietMay
{
    class May
    {
        int N;
        ChiTiet[] ds;
        public void Nhap()
        {
            Console.Write("Nhap so luong chi tiet con cua may: ");
            N = int.Parse(Console.ReadLine());
            int loai;
            ds = new ChiTiet[N];
            for (int i = 0; i < N; i++)
            {
                Console.WriteLine($"Nhap chi tiet {i + 1}: ");
                Console.Write("0.Chi tiet don\n1.Chi tiet phuc\nChon loai chi tiet:");
                loai = Int16.Parse(Console.ReadLine());
                if (loai == 0)
                    ds[i] = new ChiTietDon();
                else if (loai == 1)
                    ds[i] = new ChiTietPhuc();
                ds[i].Nhap();
            }
        }
        public void Xuat()
        {
            Console.WriteLine("Thong tin chi tiet may la: ");
            for (int i = 0; i < N; i++)
            {
                ds[i].Xuat();
                Console.WriteLine("---------------------------------");
            }

        }
        public float TongTien()
        {
            float tongtien = 0;
            for(int i = 0; i < N; i++)
            {
                tongtien += ds[i].TinhTien();
            }
            return tongtien;
        }
        public ChiTiet TimKiem(string _maso)
        {
            
            for(int i = 0; i < N; i++)
            {
                ChiTiet temp = null;
                
                temp = ds[i].TimKiem(_maso);
                if (temp != null)
                    return temp;
            }
            return null;
        }
    }
   
}
