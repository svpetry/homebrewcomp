using System.Collections.ObjectModel;
using System.Windows;
using E_Z80.Common;

namespace E_Z80.ViewModels
{
    class SettingsViewModel : BaseViewModel
    {
        private readonly IOService _ioService;

        private string _sdDirectory;
        private int _updateRate;
        private ObservableCollection<int> _updateRates;

        public SettingsViewModel(IOService ioService)
        {
            _ioService = ioService;
            UpdateRates = new ObservableCollection<int>(new[] {2, 5, 10, 25, 40, 60, 80, 120});

            SdDirectory = Settings.SdDirectory;
            UpdateRate = Settings.UpdateRate;
            InitCommands();
        }

        private void InitCommands()
        {
            CancelCommand = new ActionCommand(Cancel);
            OkCommand = new ActionCommand(Ok);
            SelectDirectoryCommand = new ActionCommand(SelectDirectory);
        }

        private void Ok(object obj)
        {
            Settings.SdDirectory = _sdDirectory;
            Settings.UpdateRate = _updateRate;
            Settings.Save();
            ((Window)obj).DialogResult = true;
            ((Window)obj).Close();
        }

        private void Cancel(object obj)
        {
            ((Window)obj).DialogResult = false;
            ((Window)obj).Close();
        }

        private void SelectDirectory(object obj)
        {
            if (_ioService.OpenSelectFolderDialog(SdDirectory))
                SdDirectory = _ioService.SelectedDirectory;
        }

        public string SdDirectory
        {
            get
            {
                return _sdDirectory;
            }
            set
            {
                if (value == _sdDirectory) return;
                _sdDirectory = value;
                OnPropertyChanged();
            }
        }

        public int UpdateRate
        {
            get
            {
                return _updateRate;
            }
            set
            {
                if (value == _updateRate) return;
                _updateRate = value;
                OnPropertyChanged();
            }
        }

        public ObservableCollection<int> UpdateRates
        {
            get
            {
                return _updateRates;
            }
            private set
            {
                _updateRates = value;
                OnPropertyChanged();
            }
        }

        public ActionCommand CancelCommand { get; private set; }

        public ActionCommand OkCommand { get; private set; }

        public ActionCommand SelectDirectoryCommand { get; private set; }
    }
}
