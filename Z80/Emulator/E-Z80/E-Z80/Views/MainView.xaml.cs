using System.Windows;
using System.Windows.Input;
using E_Z80.ViewModels;

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

        private void Window_TextInput(object sender, TextCompositionEventArgs e)
        {
            var hText = e.Text;
            if (hText.Length > 0)
                ((MainViewModel)DataContext).TextInputCommand.Execute(hText[0]);
        }

        private void Window_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.IsRepeat)
                ((MainViewModel)DataContext).KeyRepeatCommand.Execute(e.Key);
            else
                ((MainViewModel)DataContext).KeyDownCommand.Execute(e.Key);
        }

        private void Window_PreviewKeyUp(object sender, KeyEventArgs e)
        {
            if (!e.IsRepeat)
                ((MainViewModel)DataContext).KeyUpCommand.Execute(e.Key);
        }
    }
}
