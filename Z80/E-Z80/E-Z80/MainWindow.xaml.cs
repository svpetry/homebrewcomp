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
using System.Windows.Threading;

namespace E_Z80
{
    /// <summary>
    /// Interaktionslogik für MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private Emulator FEmulator;
        private DispatcherTimer FScreenTimer;
        private WriteableBitmap FScreen;

        public MainWindow()
        {
            InitializeComponent();

            FEmulator = new Emulator();

            FScreen = new WriteableBitmap(640, 480, 96, 96, PixelFormats.Bgr32, null);

            FScreenTimer = new DispatcherTimer();
            FScreenTimer.Interval = new TimeSpan(0, 0, 0, 0, 40);
            FScreenTimer.Tick += UpdateScreen;
            FScreenTimer.Start();

        }

        void UpdateScreen(object sender, EventArgs e)
        {
            ImageScreen.Source = FScreen;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            FEmulator.Start();
        }
    }
}
