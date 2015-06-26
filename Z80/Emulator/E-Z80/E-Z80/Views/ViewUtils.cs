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
        public object Convert(object _Value, Type _TargetType, object _Parameter, System.Globalization.CultureInfo _Culture)
        {
            return string.Format("CPU load: {0} %", (int)_Value);
        }

        public object ConvertBack(object _Value, Type _TargetType, object _Parameter, System.Globalization.CultureInfo _Culture)
        {
            return null;
        }
    }

    [ValueConversion(typeof(int), typeof(string))]
    public class UpdateRateConverter : IValueConverter
    {
        public object Convert(object _Value, Type _TargetType, object _Parameter, System.Globalization.CultureInfo _Culture)
        {
            return string.Format("{0} Hz", (int)_Value);
        }

        public object ConvertBack(object _Value, Type _TargetType, object _Parameter, System.Globalization.CultureInfo _Culture)
        {
            var hStr = (string)_Value;
            return int.Parse(hStr);
        }
    }

    [ValueConversion(typeof(bool), typeof(Brush))]
    public class LedColorConverter : IValueConverter
    {
        public object Convert(object _Value, Type _TargetType, object _Parameter, System.Globalization.CultureInfo _Culture)
        {
            return (bool)_Value ? Brushes.Red : Brushes.LightGray;
        }

        public object ConvertBack(object _Value, Type _TargetType, object _Parameter, System.Globalization.CultureInfo _Culture)
        {
            return null;
        }
    }

    public class ViewIoService : IOService
    {
        public bool OpenSelectFolderDialog(string _InitialDir)
        {
            var hDialog = new FolderBrowserDialog { SelectedPath = _InitialDir };
            var hResult = hDialog.ShowDialog();
            if (hResult == DialogResult.OK)
            {
                SelectedDirectory = hDialog.SelectedPath;
                return true;
            }
            return false;
        }

        public string SelectedDirectory { get; set; }

        public void ShowError(string _ErrorMsg)
        {
            System.Windows.MessageBox.Show(_ErrorMsg, "Error!", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}
