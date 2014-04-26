using E_Z80.ViewModels;
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
using System.Windows.Shapes;

namespace E_Z80.Views
{
    /// <summary>
    /// Interaktionslogik für MainView.xaml
    /// </summary>
    public partial class MainView : Window
    {
        public MainView()
        {
            InitializeComponent();

            DataContext = new MainViewModel(new ViewIOService());
        }

        private void Window_TextInput(object _Sender, TextCompositionEventArgs _E)
        {
            var hText = _E.Text;
            if (hText.Length > 0)
                ((MainViewModel)DataContext).TextInputCommand.Execute(hText[0]);
        }

        private void Window_PreviewKeyDown(object _Sender, KeyEventArgs _E)
        {
            if (!_E.IsRepeat)
                ((MainViewModel)DataContext).KeyDownCommand.Execute(_E.Key);
        }

        private void Window_PreviewKeyUp(object _Sender, KeyEventArgs _E)
        {
            if (!_E.IsRepeat)
                ((MainViewModel)DataContext).KeyUpCommand.Execute(_E.Key);
        }
    }
}
