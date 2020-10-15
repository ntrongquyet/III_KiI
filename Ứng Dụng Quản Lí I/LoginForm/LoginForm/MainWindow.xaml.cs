using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
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

namespace LoginForm
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





        private void user_plachoder_GotFocus(object sender, RoutedEventArgs e)
        {
            user_plachoder.Visibility = Visibility.Hidden;
            username.Focus();
        }

        private void username_LostFocus(object sender, RoutedEventArgs e)
        {
            if (username.Text.Trim().Length == 0)
            {
                user_plachoder.Visibility = Visibility.Visible;

            }
            else
            {
                user_plachoder.Visibility = Visibility.Hidden;

            }
        }

        private void password_plachoder_GotFocus(object sender, RoutedEventArgs e)
        {
            password_plachoder.Visibility = Visibility.Hidden;
            password.Focus();
        }

        private void password_LostFocus(object sender, RoutedEventArgs e)
        {
            if (password.Password.Length == 0)
            {
                password_plachoder.Visibility = Visibility.Visible;

            }
            else
            {
                password_plachoder.Visibility = Visibility.Hidden;

            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            Version.Content = "Version "+ Assembly.GetExecutingAssembly().GetName().Version.ToString();
        }
    }
}
