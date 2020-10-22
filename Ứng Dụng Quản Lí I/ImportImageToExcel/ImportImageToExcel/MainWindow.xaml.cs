using Microsoft.Win32;
using System;
using System.Collections.Generic;
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
using Aspose.Cells;
namespace ImportImageToExcel
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



        private void importButton_Click(object sender, RoutedEventArgs e)
        {
            var ofd = new OpenFileDialog();
            if (ofd.ShowDialog() == true)
            {
                var filename = ofd.FileName;
                var info = new FileInfo(filename);
                var wb = new Workbook(filename);
                var sheets = wb.Worksheets;
                var db = new MyStoreEntities();
                foreach (var sheet in sheets)
                {
                    var caterogy = new Category()
                    {
                        Name = sheet.Name
                    };
                    db.Categories.Add(caterogy);
                    db.SaveChanges();
                    var baseFolder = AppDomain.CurrentDomain.BaseDirectory;
                    // Kiểm tra sự tồn tại của thư mục hình ảnh
                    if (!Directory.Exists(baseFolder + "Images\\"))
                    {
                        Directory.CreateDirectory(baseFolder + "Images\\");
                    }
                    var cell = sheet.Cells[$"B3"];
                    var row = 3;
                    while (cell.Value != null)
                    {
                        var rowImage = sheet.Cells[$"H{row}"].StringValue;
                        var fileImage = filename.Replace((info.Name), "images");
                        fileImage = $"{fileImage}\\{rowImage}";

                        byte[] name = ConvertBinaryString(fileImage);
                        var product = new Product()
                        {
                            CatId = caterogy.Id,
                            SKU = sheet.Cells[$"C{row}"].StringValue,
                            Name = sheet.Cells[$"D{row}"].StringValue,
                            Price = sheet.Cells[$"E{row}"].IntValue,
                            Quantity = sheet.Cells[$"F{row}"].IntValue,
                            Description = sheet.Cells[$"G{row}"].StringValue,
                            Image = sheet.Cells[$"H{row}"].StringValue,
                            ImageBinary = name,
                        };
                        db.Products.Add(product);
                        db.SaveChanges();
                        row++;
                        cell = sheet.Cells[$"B{row}"];
                    }
                }

            }
            MessageBox.Show("Đã thêm thành công");
        }
        byte[] ConvertBinaryString(string fileName)
        {

            var image = new BitmapImage(new Uri(fileName, UriKind.Absolute));
            var encoder = new JpegBitmapEncoder();
            encoder.Frames.Add(BitmapFrame.Create(image));
            byte[] b2;
            using (var stream = new MemoryStream())
            {
                encoder.Save(stream);

                var db = new MyStoreEntities();
                var photo = new Photo() { Data = stream.ToArray() };
                b2 = photo.Data;
            }
            return b2;

        }

        private void loadImageButton_Click(object sender, RoutedEventArgs e)
        {
            var db = new MyStoreEntities();
            var products = db.Products.ToArray();
            listImageProducts.ItemsSource = products;
        }
    }
}   

 