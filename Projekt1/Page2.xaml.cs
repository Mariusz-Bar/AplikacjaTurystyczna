using GMap.NET;
using GMap.NET.MapProviders;
using GMap.NET.WindowsPresentation;
using Microsoft.Win32;
using MySql.Data.MySqlClient;
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

namespace Projekt1
{
    /// <summary>
    /// Logika interakcji dla klasy Page2.xaml
    /// </summary>
    public partial class Page2 : Page
    {
        private PointLatLng punkt3;
        public Page2()
        {
            InitializeComponent();
        }

        private void mapView3_Loaded(object sender, RoutedEventArgs e)
        {
            mapView3.DragButton = MouseButton.Left;
            mapView3.MapProvider = GMapProviders.OpenStreetMap;
            mapView3.SetPositionByKeywords("Opole, Polska");
            mapView3.MouseWheelZoomType = GMap.NET.MouseWheelZoomType.MousePositionAndCenter;
            mapView3.CanDragMap = true;
            mapView3.MinZoom = 6;
            mapView3.MaxZoom = 17;
            mapView3.Zoom = 14;
            
        }

        private void UstawZnacznikMapa3_Click(object sender, RoutedEventArgs e)
        {
            if (mapView3.Markers.Count > 0)
            {
                mapView3.Markers.RemoveAt(0);
            }
            punkt3 = mapView3.Position;
            GMapMarker marker3 = new GMapMarker(punkt3);

            Image pinImage3 = new Image();
            pinImage3.Width = 30;
            pinImage3.Height = 30;
            pinImage3.Source = new BitmapImage(new System.Uri("pack://application:,,,/Resources/pin.png"));
            pinImage3.Name = "testImage";

            marker3.Shape = pinImage3;
            marker3.Offset = new Point(-pinImage3.Width / 2, -pinImage3.Height);
            mapView3.Markers.Add(marker3);
        }

        private void DodajMiejsceButton_Click(object sender, RoutedEventArgs e)
        {
            if(DodajNazweTextBox.Text == "")
            {
                MessageBox.Show("Podaj nazwe");
            }
            else
            {
                if (mapView3.Markers.Count == 0)
                {
                    MessageBox.Show("Ustaw znacznik");
                }
                else
                {
                    string mysqlCon = "server=127.0.0.1; user=root; database=aplikacjaturystyczna; password=";
                    MySqlConnection mySqlConnection = new MySqlConnection(mysqlCon);
                    
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand cmd = mySqlConnection.CreateCommand();
                        cmd.CommandText = "INSERT INTO miejsce(Nazwa,Koordynaty_x, Koordynaty_y,FK_id_kraju,FK_id_filtru) VALUES (@Nazwa,@Koordynaty_x,@Koordynaty_y,1,20)";
                        cmd.Parameters.AddWithValue("@Nazwa",DodajNazweTextBox.Text);
                        cmd.Parameters.AddWithValue("@Koordynaty_x",punkt3.Lat);
                        cmd.Parameters.AddWithValue("@Koordynaty_y",punkt3.Lng);
                        cmd.ExecuteNonQuery();
                        MessageBox.Show("Dziękujemy za dodanie miejsca, po sprawdzeniu jego istnienia zostanie ono dodane do bazy danych");
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
            }
            
        }

        private void CloseImage_MouseDown(object sender, MouseButtonEventArgs e)
        {
            Page3Content.Visibility = Visibility.Hidden;
        }
    }
}
