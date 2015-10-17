using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using E_Z80.Annotations;

namespace E_Z80.ViewModels
{
    public class BaseViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            var hHandler = PropertyChanged;
            hHandler?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class ActionCommand : ICommand
    {
        private readonly Action<object> _executeHandler;
        private readonly Func<object, bool> _canExecuteHandler;

        public ActionCommand(Action<object> execute)
        {
            if (execute == null)
                throw new ArgumentNullException(nameof(execute));
            _executeHandler = execute;
        }

        public ActionCommand(Action<object> execute, Func<object, bool> canExecute)
            : this(execute)
        {
            _canExecuteHandler = canExecute;
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        public void Execute(object parameter)
        {
            _executeHandler(parameter);
        }

        public bool CanExecute(object parameter)
        {
            if (_canExecuteHandler == null)
                return true;
            return _canExecuteHandler(parameter);
        }
    }  
}
