using System.ComponentModel;
using E_Z80.ViewModels;
using System.Windows;
using System.Windows.Input;

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

            DataContext = new MainViewModel(new ViewIoService()) { MainView = this };
        }

        private void Window_TextInput(object _Sender, TextCompositionEventArgs _E)
        {
            var hText = _E.Text;
            if (hText.Length > 0)
                ((MainViewModel)DataContext).TextInputCommand.Execute(hText[0]);
        }

        private void Window_PreviewKeyDown(object _Sender, KeyEventArgs _E)
        {
            if (_E.IsRepeat)
                ((MainViewModel)DataContext).KeyRepeatCommand.Execute(_E.Key);
            else
                ((MainViewModel)DataContext).KeyDownCommand.Execute(_E.Key);
        }

        private void Window_PreviewKeyUp(object _Sender, KeyEventArgs _E)
        {
            if (!_E.IsRepeat)
                ((MainViewModel)DataContext).KeyUpCommand.Execute(_E.Key);
        }
    }
}
