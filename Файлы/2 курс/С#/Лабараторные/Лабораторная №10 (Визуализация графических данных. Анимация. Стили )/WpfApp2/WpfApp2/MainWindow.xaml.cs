using System;
using System.Windows;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Threading;
using System.Windows.Media.Animation;
using System.Windows.Controls;

namespace WpfApp2
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            grid1.Children.Add(DrawLine(X1: 262, Y1: 10, X2: 262, Y2: 257));
            grid1.Children.Add(DrawLine(X1: 10, Y1: 134, X2: 514, Y2: 134));

            for (double i = 10; i < 34 * 30; i += Math.PI / 3 * 30)
            {
                Line a = new Line();
                a.X1 = i;
                a.Y1 = 139;
                a.X2 = i;
                a.Y2 = 129;
                a.Stroke = Brushes.Black;
                grid1.Children.Add(a);
            }

            for (int i = 30; i < 17 * 30; i += 30)
            {
                Line a = new Line();
                a.X1 = 257;
                a.Y1 = i;
                a.X2 = 267;
                a.Y2 = i;
                a.Stroke = Brushes.Black;
                grid1.Children.Add(a);
            }

            grid1.Children.Add(DrawPolyLine(257, 15, 262, 10, 267, 15));
            grid1.Children.Add(DrawPolyLine(509, 129, 514, 134, 509, 139));
            grid1.Children.Add(DrawPolyLine(15, 129, 10, 134, 15, 139));
            grid1.Children.Add(DrawPolyLine(257, 252, 262, 257, 267, 252));
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            Polyline polyline = new Polyline();
            polyline.Points = new PointCollection();

            for (double x = -3.1415 * 3; x < 3.1415 * 3; x += 0.001)
            {
                double y = Math.Cos(x) * -1;

                polyline.Points.Add(new Point(x * 30 + 262, y * 105 + 134));
            }
            polyline.Stroke = Brushes.Green;
            grid1.Children.Add(polyline);
        }
        Line DrawLine(int X1, int Y1, int X2, int Y2)
        {
            Line line = new Line();
            line.X1 = X1;
            line.Y1 = Y1;
            line.X2 = X2;
            line.Y2 = Y2;
            line.Stroke = Brushes.Black;
            return line;

        }
        Polyline DrawPolyLine(int X1, int Y1, int X2, int Y2, int X3, int Y3)
        {
            Polyline polyline = new Polyline();
            polyline.Points = new PointCollection();
            polyline.Points.Add(new Point(X1, Y1));
            polyline.Points.Add(new Point(X2, Y2));
            polyline.Points.Add(new Point(X3, Y3));
            polyline.Stroke = Brushes.Red;
            return polyline;


        }
    }
}

