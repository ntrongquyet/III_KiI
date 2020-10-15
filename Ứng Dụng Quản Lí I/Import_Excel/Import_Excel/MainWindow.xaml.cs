using Aspose.Cells;
using Microsoft.Win32;
using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Import_Excel
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }




        private void importBtnClick_Click(object sender, RoutedEventArgs e)
        {
            var ofd = new OpenFileDialog();
            if(ofd.ShowDialog() == true)
            {
                var filename = ofd.FileName;
                var info = new FileInfo(filename);
                var wb = new Workbook(filename);
                var sheets = wb.Worksheets;
                var db = new MyStoreEntities();
                foreach(var sheet in sheets)
                {
                    var caterogy = new Category()
                    {
                        Name = sheet.Name
                    };
                    Debug.WriteLine(caterogy.Name);
                    db.Categories.Add(caterogy);
                    db.SaveChanges();
                    //var baseFolder = AppDomain.CurrentDomain.BaseDirectory;
                    //// Kiểm tra sự tồn tại của thư mục hình ảnh
                    //if (!Directory.Exists(baseFolder + "Images\\"))
                    //{
                    //    Directory.CreateDirectory(baseFolder + "Images\\");
                    //}
                    var cell = sheet.Cells[$"B3"];
                    var row = 3;
                    while (cell.Value != null)
                    {
                        var product = new Product()
                        {
                            CatId = caterogy.Id,
                            SKU = sheet.Cells[$"C{row}"].StringValue,
                            Name = sheet.Cells[$"D{row}"].StringValue,
                            Price = sheet.Cells[$"E{row}"].IntValue,
                            Quantity = sheet.Cells[$"F{row}"].IntValue,
                            Description = sheet.Cells[$"C{row}"].StringValue,
                            Image = sheet.Cells[$"C{row}"].StringValue
                        };
                        db.Products.Add(product);
                        db.SaveChanges();
                        row++;
                        cell = sheet.Cells[$"B{row}"];
                    }
                }

            }
        }
    }
}
