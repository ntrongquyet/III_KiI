using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_TinhTienLuong
{
    class CongTy
    {
        private NhanVien[] _list;
        private int _n;

        public int N { get => _n; set => _n = value; }

        public void Nhap()
        {
            Console.Write("Nhap so luong nhan vien: ");
            N = Int16.Parse(Console.ReadLine());
            _list = new NhanVien[N];
            for(int i = 0; i < N; i++)
            {
                _list[i] = new NhanVien();
                int luachon;
                Console.WriteLine("Chon kieu nhan vien:\n1.NV-VP\n2.NV-QL\n3.NV-SX");
                luachon = Int16.Parse(Console.ReadLine());
                if (luachon == 1)
                {
                    _list[i] = new VanPhong();
                }
                if(luachon == 2)
                {
                    _list[i] = new QuanLy();
                }
                if (luachon == 3)
                {
                    _list[i] = new SanXuat();
                }
                if(luachon<1 && luachon > 3)
                {
                    return;
                }
                _list[i].Nhap();
            }
        }
        public void Xuat()
        {
            for(int i = 0; i < _list.Length; i++)
            {
                _list[i].Xuat();
            }
        }
        public float Luong()
        {
            float tongLuong = 0; 
            for(int i = 0; i < _list.Length; i++)
            {
                tongLuong += _list[i].Luong();
            }
            return tongLuong;
        }
        public NhanVien TimKiem(string name)
        {
            for(int i = 0; i < _list.Length; i++)
            {
                if (_list[i].HoTen.Contains(name))
                {
                    return _list[i];
                }
            }
            return null;
        }
    }
   
}
