using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using PointOfSale.Views;
namespace PointOfSale.ViewModels
{
    public class MainViewModel : BaseViewModel
    {
        bool IsLoaded = false;
        public ICommand LoadedWindowCommand { get; set; }
        public MainViewModel()
        {
            LoadedWindowCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                
                IsLoaded = true;
                if (p == null)
                    return;
                p.Hide();
                LoginView login = new LoginView();
                login.ShowDialog();
                var loginVM = login.DataContext as LoginViewModel;
                if (login.DataContext == null)
                    return;
                if (loginVM.IsLogin)
                {
                    p.Show();
                }
                else
                {
                    p.Close();
                }
            });

            
        }
    }
}
