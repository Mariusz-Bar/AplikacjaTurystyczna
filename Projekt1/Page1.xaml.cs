using GMap.NET;
using GMap.NET.MapProviders;
using GMap.NET.WindowsPresentation;
using Projekt1.Controls;
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
using MySql.Data.MySqlClient;
using System.Runtime.Remoting.Messaging;

namespace Projekt1
{
    /// <summary>
    /// Logika interakcji dla klasy Page1.xaml
    /// </summary>
    /// 
    public partial class Page1 : Page
    {
        List<String> filtersList;
        int Licznik { get; set; }
        private Page2 strona2;
        public Page1(PointLatLng startPoint, List<String> filtersList, int odleglosc)
        {
            InitializeComponent();
            Licznik = 0;
            this.filtersList = filtersList;
            UstawZnacznikPoczatkowyMapa2(startPoint);

            string sql = "SELECT * FROM miejsce JOIN filtr ON miejsce.FK_id_filtru=filtr.Id_filtru WHERE filtr.Rodzaj = '" + filtersList[0] + "'";
            for (int i=1; i < filtersList.Count; i++)
            {
                sql += "OR filtr.Rodzaj='" + filtersList[i] + "'";
            }

            PointLatLng punkt = new PointLatLng();
            string mysqlCon = "server=127.0.0.1; user=root; database=aplikacjaturystyczna; password=";
            //string sql = "SELECT * FROM miejsce JOIN filtr ON miejsce.FK_id_filtru=filtr.Id_filtru";
            MySqlConnection mySqlConnection = new MySqlConnection(mysqlCon);
            MySqlCommand cmd = new MySqlCommand(sql, mySqlConnection);
            try
            {
                mySqlConnection.Open();
                
                MySqlDataReader reader = cmd.ExecuteReader();
                while(reader.Read())
                {
                    punkt.Lat = reader.GetDouble("Koordynaty_x");
                    punkt.Lng = reader.GetDouble("Koordynaty_y");
                    if (GetDistance(startPoint.Lat, startPoint.Lng, punkt.Lat, punkt.Lng)/1000<odleglosc)
                    {
                        MiejsceControl miejsceControl = new MiejsceControl();
                        miejsceControl.Height = 300;
                        miejsceControl.MiejsceTitle.Text = reader.GetString("Nazwa");
                        miejsceControl.MiejsceOpis.Text = reader.GetString("Opis");
                        miejsceControl.MiejsceAdres.Text = reader.GetString("Miasto") + " " + reader.GetString("Adres");
                        miejsceControl.AdresText.Text = "ADRES";
                        miejsceControl.MiejsceZdjecie.Source = new BitmapImage(new System.Uri("pack://application:,,,/Resources/Miejsca/" + reader.GetString("Zdjecie")));

                        PozycjaKontrolek.Children.Add(miejsceControl);


                        UstawZnacznikMapa2(punkt, Licznik);
                        Licznik++;
                    }
                    
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                mySqlConnection.Close();
            }
        }

        private void mapView2_Loaded(object sender, RoutedEventArgs e)
        {
            mapView2.DragButton = MouseButton.Left;
            mapView2.MapProvider = GMapProviders.OpenStreetMap;
            mapView2.SetPositionByKeywords("Opole, Polska");
            mapView2.MouseWheelZoomType = GMap.NET.MouseWheelZoomType.MousePositionAndCenter;
            mapView2.CanDragMap = true;
            mapView2.MinZoom = 6;
            mapView2.MaxZoom = 17;
            mapView2.Zoom = 14;
            GridMapPage2.Visibility = Visibility.Hidden;
        }

        private void Map2Button_Click(object sender, RoutedEventArgs e)
        {
            if(GridMapPage2.Visibility==Visibility.Hidden)
            {
                GridMapPage2.Visibility=Visibility.Visible;
                Map2Button.Content = "LISTA";
            }
            else
            {
                GridMapPage2.Visibility=Visibility.Hidden;
                Map2Button.Content = "MAPA";
            }
            
        }
        private void UstawZnacznikMapa2(PointLatLng punkt, int id)
        {

            Image pinImage2 = new Image();
            pinImage2.Width = 30;
            pinImage2.Height = 30;
            pinImage2.Source = new BitmapImage(new System.Uri("pack://application:,,,/Resources/pin.png"));
            pinImage2.MouseEnter += new MouseEventHandler(pinImage2_MouseEnter);
            pinImage2.MouseLeave += new MouseEventHandler(pinImage2_MouseLeave);
            pinImage2.MouseDown += new MouseButtonEventHandler(pinImage2_MouseDown);
            pinImage2.Tag = id;


            GMapMarker Marker2 = new GMapMarker(punkt);
            Marker2.Shape = pinImage2;
            Marker2.Offset = new Point(-pinImage2.Width / 2, -pinImage2.Height);
            mapView2.Markers.Add(Marker2);
            
        }

        private void UstawZnacznikPoczatkowyMapa2(PointLatLng punkt)
        {
            Image pinImage2 = new Image();
            pinImage2.Width = 30;
            pinImage2.Height = 30;
            pinImage2.Source = new BitmapImage(new System.Uri("pack://application:,,,/Resources/pin3.png"));

            GMapMarker Marker2 = new GMapMarker(punkt);
            Marker2.Shape = pinImage2;
            Marker2.Offset = new Point(-pinImage2.Width / 2, -pinImage2.Height);
            mapView2.Markers.Add(Marker2);
        }

        private void pinImage2_MouseEnter(object sender, RoutedEventArgs e)
        {
            Image imageThatWasClicked = (Image)sender;
            imageThatWasClicked.Source = new BitmapImage(new System.Uri("pack://application:,,,/Resources/pin2.png"));
        }
        private void pinImage2_MouseLeave(object sender, RoutedEventArgs e)
        {
            Image imageThatWasClicked = (Image)sender;
            imageThatWasClicked.Source = new BitmapImage(new System.Uri("pack://application:,,,/Resources/pin.png"));
        }
        private void pinImage2_MouseDown(object sender, RoutedEventArgs e)
        {
            Image imageThatWasClicked = (Image)sender;

            UIElement elementThatWasClicked = PozycjaKontrolek.Children[Convert.ToInt32(imageThatWasClicked.Tag)+1];
            var controlThatWasClicked = elementThatWasClicked as MiejsceControl;
            MiejscePodMapa.MiejsceTitle.Text = controlThatWasClicked.MiejsceTitle.Text;
            MiejscePodMapa.MiejsceOpis.Text = controlThatWasClicked.MiejsceOpis.Text;
            MiejscePodMapa.MiejsceAdres.Text = controlThatWasClicked.MiejsceAdres.Text;
            MiejscePodMapa.AdresText.Text = controlThatWasClicked.AdresText.Text;
            MiejscePodMapa.MiejsceOpis.FontSize = 18;
            MiejscePodMapa.MiejsceZdjecie.Source = controlThatWasClicked.MiejsceZdjecie.Source;
        }

        private double GetDistance(double latitude, double longitude, double otherLatitude, double otherLongitude)
        {
            var d1 = latitude * (Math.PI / 180.0);
            var num1 = longitude * (Math.PI / 180.0);
            var d2 = otherLatitude * (Math.PI / 180.0);
            var num2 = otherLongitude * (Math.PI / 180.0) - num1;

            var d3 = Math.Pow(Math.Sin((d2 - d1) / 2.0), 2.0) + Math.Cos(d1) * Math.Cos(d2) * Math.Pow(Math.Sin(num2 / 2.0), 2.0);

            return 6376500.0 * (2.0 * Math.Atan2(Math.Sqrt(d3), Math.Sqrt(1.0 - d3)));
        }

        private void DodajMiejsceButton_Click(object sender, RoutedEventArgs e)
        {
            strona2 = new Page2();
            Page2Frame.Content = strona2;
            
        }
    }
}
