using System;
using System.Collections.Generic;
using System.Text;

namespace OOP_ChiTietMay
{
    abstract class ChiTiet
    {
        private string _maSo;
        private float _giaTien;

        public string MaSo { get => _maSo; set => _maSo = value; }
        public float GiaTien { get => _giaTien; set => _giaTien = value; }

        public abstract void Nhap();
        public abstract void Xuat();
        public abstract float TinhTien();
        public abstract ChiTiet TimKiem(string _maso);

    }
}
