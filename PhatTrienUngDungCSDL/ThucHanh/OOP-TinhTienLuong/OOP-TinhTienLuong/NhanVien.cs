using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_TinhTienLuong
{
    class NhanVien
    {
        string _hoTen;
        string _ngaySinh;
        float _luongCoBan;
        public string HoTen { get => _hoTen; set => _hoTen = value; }
        public string NgaySinh { get => _ngaySinh; set => _ngaySinh = value; }
        public float LuongCoBan { get => _luongCoBan; set => _luongCoBan = value; }

        public virtual void Nhap()
        {

        }
        public virtual void Xuat()
        {

        }
        public virtual float Luong()
        {
            return 0;
        }
    }
}
