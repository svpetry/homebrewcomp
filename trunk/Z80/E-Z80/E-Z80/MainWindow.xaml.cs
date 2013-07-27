using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
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

        private const string cSettingsFile = "settings.ini";

        public MainWindow()
        {
            InitializeComponent();

            FScreen = new WriteableBitmap(640, 480, 96, 96, PixelFormats.Bgr32, null);
            FEmulator = new Emulator(FScreen);

            if (File.Exists(cSettingsFile))
            {
                var hDirectory = File.ReadAllText(cSettingsFile);
                FEmulator.SdDirectory = hDirectory;
                TextBoxDirectory.Text = hDirectory;
            }

            FScreenTimer = new DispatcherTimer();
            FScreenTimer.Interval = new TimeSpan(0, 0, 0, 0, 60);
            FScreenTimer.Tick += UpdateScreen;
            FScreenTimer.Start();

            FEmulator.Start();
        }

        void UpdateScreen(object sender, EventArgs e)
        {
            FEmulator.UpdateScreen();
            ImageScreen.Source = FScreen;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
        }

        private void Window_TextInput(object sender, TextCompositionEventArgs e)
        {
            var hText = e.Text;
            if (hText.Length > 0)
                FEmulator.AddNewKey(hText[0]);
        }

        private void Window_KeyDown(object sender, KeyEventArgs e)
        {
        }

        private void Window_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.System)
                FEmulator.AddNewSpecialKey(Key.F10);
            else
                FEmulator.AddNewSpecialKey(e.Key);
        }

        private void SelectDirectory(object sender, RoutedEventArgs e)
        {
            var hDialog = new System.Windows.Forms.FolderBrowserDialog();
            hDialog.SelectedPath = FEmulator.SdDirectory;
            System.Windows.Forms.DialogResult hDlgResult = hDialog.ShowDialog();
            if (hDlgResult == System.Windows.Forms.DialogResult.OK)
            {
                var hDirectory = hDialog.SelectedPath;
                FEmulator.SdDirectory = hDirectory;
                TextBoxDirectory.Text = hDirectory;
                File.WriteAllText(cSettingsFile, hDirectory);
            }
        }

        private void ImageScreen_MouseDown(object sender, MouseButtonEventArgs e)
        {
            ImageScreen.Focus();
        }

    }

}
