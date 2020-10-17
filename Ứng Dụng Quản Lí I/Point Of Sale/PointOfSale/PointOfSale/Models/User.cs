using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
namespace PointOfSale.Models
{
    public class User : INotifyPropertyChanged
    {
        private int userID;
        private string account;
        private string password;

        public int UserID { get => userID; set => userID = value; }
        public string Account { get => account; set => account = value; }
        public string Password { get => password; set => password = value; }

        #region INotifyPropertyChanged Members  

        public event PropertyChangedEventHandler PropertyChanged;
        private void OnPropertyChanged(string propertyName)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
        #endregion
    }
}
