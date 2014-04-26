using E_Z80.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
            return string.Format("Load factor: {0} %", (int)_Value);
        }

        public object ConvertBack(object _Value, Type _TargetType, object _Parameter, System.Globalization.CultureInfo _Culture)
        {
            return null;
        }
    }

    public class ViewIOService : IOService
    {
        public bool OpenSelectFolderDialog(string _InitialDir)
        {
            var hDialog = new FolderBrowserDialog { SelectedPath = _InitialDir };
            System.Windows.Forms.DialogResult hResult = hDialog.ShowDialog();
            if (hResult == DialogResult.OK)
            {
                SelectedDirectory = hDialog.SelectedPath;
                return true;
            }
            return false;
        }

        public string SelectedDirectory { get; set; }
    }

    public static class FocusExtension
    {
        public static bool GetIsFocused(DependencyObject obj)
        {
            return (bool)obj.GetValue(IsFocusedProperty);
        }

        public static void SetIsFocused(DependencyObject obj, bool value)
        {
            obj.SetValue(IsFocusedProperty, value);
        }

        public static readonly DependencyProperty IsFocusedProperty =
            DependencyProperty.RegisterAttached(
             "IsFocused", typeof(bool), typeof(FocusExtension),
             new UIPropertyMetadata(false, OnIsFocusedPropertyChanged));

        private static void OnIsFocusedPropertyChanged(DependencyObject d,
            DependencyPropertyChangedEventArgs e)
        {
            var uie = (UIElement)d;
            if ((bool)e.NewValue)
            {
                uie.Focus(); // Don't care about false values.
            }
        }
    }
}
