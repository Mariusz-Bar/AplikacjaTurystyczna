using GMap.NET;
using GMap.NET.MapProviders;
using GMap.NET.WindowsPresentation;
using MySql.Data.MySqlClient;
using Projekt1.Controls;
using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Projekt1
{
    /// <summary>
    /// Logika interakcji dla klasy MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private PointLatLng Point { get; set; }
        private GMapMarker Marker { get; set; }
        private Page1 strona1; 
        public MainWindow()
        {
            InitializeComponent();
            strona1 = null;

            string mysqlCon = "server=127.0.0.1; user=root; database=aplikacjaturystyczna; password=";
            string mysqlCon2 = "server=127.0.0.1; user=root; database=aplikacjaturystyczna; password=";
            
            string sql = "SELECT DISTINCT Kategoria from filtr where filtr.Kategoria <> 'Custom'";
            
            MySqlConnection mySqlConnection = new MySqlConnection(mysqlCon);
            MySqlConnection mySqlConnection2 = new MySqlConnection(mysqlCon2);

            MySqlCommand cmd = new MySqlCommand(sql, mySqlConnection);
            try
            {
                mySqlConnection.Open();

                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    KategoriaControl kategoriaControl = new KategoriaControl();
                    kategoriaControl.KategoriaMenuButton.Content = reader.GetString("Kategoria");
                                        
                    string sql2 = "SELECT Rodzaj from filtr WHERE Kategoria= '" + reader.GetString("Kategoria") +" '"; 
                    MySqlCommand cmd2 = new MySqlCommand(sql2,mySqlConnection2);
                    try
                    {
                        mySqlConnection2.Open();
                        MySqlDataReader reader2 = cmd2.ExecuteReader();
                        while (reader2.Read())
                        {
                            RodzajControl rodzajControl = new RodzajControl();
                            rodzajControl.RodzajControlName.Content= reader2.GetString("Rodzaj");
                            kategoriaControl.KategoriaMenu.Children.Add(rodzajControl);
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    finally
                    {
                        mySqlConnection2.Close();
                    }
                    KategoriaMenuPanel.Children.Add(kategoriaControl);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                mySqlConnection.Close();
            }
        }

        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            if(mapView.Markers.Count==0)
            {
                MessageBox.Show("Nie zaznaczyłeś miejsca startowego");
            }
            else
            {
                List<String> filtersList = new List<String>();
                for (int i=0;i<KategoriaMenuPanel.Children.Count;i++)
                {
                    UIElement kategoriaElement = KategoriaMenuPanel.Children[i];
                    var kategoriaControl = kategoriaElement as KategoriaControl;
                    
                    for(int j=0;j<kategoriaControl.KategoriaMenu.Children.Count;j++)
                    {
                        UIElement rodzajElement = kategoriaControl.KategoriaMenu.Children[j];
                        var rodzajControl = rodzajElement as RodzajControl;
                        if(rodzajControl.RodzajControlName.IsChecked==true)
                        {
                            filtersList.Add((String)rodzajControl.RodzajControlName.Content);                           
                        }
                    }
                }

                if(filtersList.Count>0)
                {
                    strona1 = new Page1(Point,filtersList,Int32.Parse(odlegloscSliderWartosc.Text));
                    PageFrame.Content = strona1;
                }
                else
                {
                    MessageBox.Show("Zaznacz jakies filtry");
                }
                
            }
            
        }

        private void mapView_Loaded(object sender, RoutedEventArgs e)
        {
            mapView.DragButton = MouseButton.Left;
            mapView.MapProvider = GMapProviders.OpenStreetMap;
            mapView.SetPositionByKeywords("Opole, Polska");
            mapView.MouseWheelZoomType = GMap.NET.MouseWheelZoomType.MousePositionAndCenter;
            mapView.CanDragMap = true;
            mapView.MinZoom = 6;
            mapView.MaxZoom = 17;
            mapView.Zoom = 14;
            mapView.Visibility = Visibility.Hidden;
            
        }

        private void MapButtonSet_Click(object sender, RoutedEventArgs e)
        {
            if (PageFrame.Content != null)
            {
                PageFrame.Content = null;
            }
            
            if(SearchBar.Text != "Podaj miasto")
            {
                if (mapView.Visibility == Visibility.Hidden)
                {
                    mapView.Visibility = Visibility.Visible;
                }
                if (PinButton.Visibility == Visibility.Hidden)
                {
                    PinButton.Visibility = Visibility.Visible;
                }

                if (SearchBar.Text != String.Empty)
                {
                    mapView.SetPositionByKeywords(SearchBar.Text);
                    mapView.Zoom = 14;
                    UstawMarker();
                }
            }
                      
        }

        private void PinButton_Click(object sender, RoutedEventArgs e)
        {
            UstawMarker();
        }

        private void UstawMarker()
        {
            

            if (mapView.Markers.Count > 0)
            {
                mapView.Markers.RemoveAt(0);
            }
            Point = mapView.Position;
            Marker = new GMapMarker(Point);

            Image pinImage = new Image();
            pinImage.Width = 30;
            pinImage.Height = 30;
            pinImage.Source = new BitmapImage(new System.Uri("pack://application:,,,/Resources/pin3.png"));            
            pinImage.Name = "pinImage";
            
            Marker.Shape= pinImage;
            Marker.Offset = new Point(-pinImage.Width/2, -pinImage.Height);
            mapView.Markers.Add(Marker);

        }

        private void MapButtonShow_Click(object sender, RoutedEventArgs e)
        {
            if(PageFrame.Content != null)
            {
                PageFrame.Content = null;
                if (mapView.Visibility == Visibility.Hidden)
                {
                    mapView.Visibility = Visibility.Visible;
                }
                

                if (PinButton.Visibility == Visibility.Hidden)
                {
                    PinButton.Visibility = Visibility.Visible;
                }
                
            }
            else
            {
                PageFrame.Content = strona1;
                if (mapView.Visibility == Visibility.Hidden)
                {
                    mapView.Visibility = Visibility.Visible;
                }
                else
                {
                    mapView.Visibility = Visibility.Hidden;
                }

                if (PinButton.Visibility == Visibility.Hidden)
                {
                    PinButton.Visibility = Visibility.Visible;
                }
                else
                {
                    PinButton.Visibility = Visibility.Hidden;
                }
            }           
        }

        private void SearchBar_GotFocus(object sender, RoutedEventArgs e)
        {
            TextBox textBox = (TextBox)sender;
            if(textBox.Text == "Podaj miasto")
            {
                textBox.Text = "";
            }
        }

    }
}
