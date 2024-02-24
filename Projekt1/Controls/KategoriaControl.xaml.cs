using Google.Protobuf.WellKnownTypes;
using System;
using System.Collections.Generic;
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

namespace Projekt1.Controls
{
    /// <summary>
    /// Logika interakcji dla klasy KategoriaControl.xaml
    /// </summary>
    public partial class KategoriaControl : UserControl
    {
        public KategoriaControl()
        {
            InitializeComponent();
        }

        private void KategoriaMenuButton_Click(object sender, RoutedEventArgs e)
        {
            if(KategoriaMenu.Visibility==Visibility.Collapsed)
            {
                KategoriaMenu.Visibility=Visibility.Visible;
            }
            else
            {
                KategoriaMenu.Visibility=Visibility.Collapsed;
            }
        }

    }
}
