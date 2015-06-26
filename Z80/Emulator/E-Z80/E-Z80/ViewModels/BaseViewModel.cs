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
        protected virtual void OnPropertyChanged([CallerMemberName] string _PropertyName = null)
        {
            var hHandler = PropertyChanged;
            if (hHandler != null) hHandler(this, new PropertyChangedEventArgs(_PropertyName));
        }
    }

    public class ActionCommand : ICommand
    {
        private readonly Action<object> FExecuteHandler;
        private readonly Func<object, bool> FCanExecuteHandler;

        public ActionCommand(Action<object> _Execute)
        {
            if (_Execute == null)
                throw new ArgumentNullException("_Execute");
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
