using System.Windows.Media;
using E_Z80.Common;
using System;
using System.Windows;
using System.Windows.Data;
using System.Windows.Forms;

namespace E_Z80.Views
{
    [ValueConversion(typeof(int), typeof(string))]
    public class LoadFactorToStringConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return $"CPU load: {(int) value} %";
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return null;
        }
    }

    [ValueConversion(typeof(int), typeof(string))]
    public class UpdateRateConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return $"{ value} Hz";
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            var hStr = (string)value;
            return int.Parse(hStr);
        }
    }

    [ValueConversion(typeof(bool), typeof(Brush))]
    public class LedColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return (bool)value ? Brushes.Red : Brushes.LightGray;
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return null;
        }
    }

    public class ViewIoService : IOService
    {
        public bool OpenSelectFolderDialog(string initialDir)
        {
            var hDialog = new FolderBrowserDialog { SelectedPath = initialDir };
            var hResult = hDialog.ShowDialog();
            if (hResult == DialogResult.OK)
            {
                SelectedDirectory = hDialog.SelectedPath;
                return true;
            }
            return false;
        }

        public string SelectedDirectory { get; set; }

        public void ShowError(string errorMsg)
        {
            System.Windows.MessageBox.Show(errorMsg, "Error!", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}
