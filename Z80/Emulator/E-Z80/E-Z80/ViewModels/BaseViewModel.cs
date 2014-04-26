using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace E_Z80.ViewModels
{
    class BaseViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        
        protected void OnPropertyChanged([CallerMemberName] string _PropertyName = "")
        {
            var hEventArgs = new PropertyChangedEventArgs(_PropertyName);
            var hChanged = PropertyChanged;
            if (hChanged != null) hChanged(this, hEventArgs);
        }
    }

    public class ActionCommand : ICommand
    {
        private readonly Action<object> FExecuteHandler;
        private readonly Func<object, bool> FCanExecuteHandler;

        public ActionCommand(Action<object> _Execute)
        {
            if (_Execute == null)
                throw new ArgumentNullException("Execute cannot be null");
            FExecuteHandler = _Execute;
        }

        public ActionCommand(Action<object> _Execute, Func<object, bool> _CanExecute)
            : this(_Execute)
        {
            FCanExecuteHandler = _CanExecute;
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        public void Execute(object _Parameter)
        {
            FExecuteHandler(_Parameter);
        }

        public bool CanExecute(object _Parameter)
        {
            if (FCanExecuteHandler == null)
                return true;
            return FCanExecuteHandler(_Parameter);
        }
    }  
}
