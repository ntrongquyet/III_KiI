using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace PointOfSale.ViewModels
{
    public class LoginViewModel : BaseViewModel
    {
        // Test Account
        string account = "admin";
        string password = "admin";
        private string _Username
        public bool IsLogin { get; set; }
        public ICommand LoginCommand { get; set; }
        public string Username { get => _Username; se _Username = value; }

        public LoginViewModel ()
        {
            IsLogin = false; 
            LoginCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>{ Login(p); });
        }
        void Login(Window p)
        {
            if (p == null)
                return;
            
            IsLogin = true;
            p.Close();
        }
    }
}
