using System;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Threading;
using E_Z80.Common;
using E_Z80.Emulator;
using E_Z80.Views;

namespace E_Z80.ViewModels
{
    internal class MainViewModel : BaseViewModel
    {
        private readonly IOService _ioService;

        private readonly MainEmulator _emulator;

        private DispatcherTimer _screenTimer;

        private int _updateCountdown;

        private bool _originalSpeed;
        private int _loadFactor;

        private ImageSource _screenSource;

        public MainViewModel(IOService ioService)
        {
            _ioService = ioService;
            Settings.Load();

            InitCommands();

            _emulator = new MainEmulator();

            OriginalSpeed = true;

            InitScreenTimer();

            var hInterruptTimer = new DispatcherTimer { Interval = new TimeSpan(0, 0, 0, 0, 100) };
            hInterruptTimer.Tick += (sender, eventArgs) => _emulator.InterruptIrq();
            hInterruptTimer.Start();

            _emulator.SdDirectory = Settings.SdDirectory;
            _emulator.Start();
        }

        private void InitScreenTimer()
        {
            _screenTimer?.Stop();

            _screenTimer = new DispatcherTimer { Interval = new TimeSpan(0, 0, 0, 0, 1000 / Settings.UpdateRate) };
            _screenTimer.Tick += UpdateScreen;
            _screenTimer.Start();
        }

        public bool OriginalSpeed
        {
            get
            {
                return _originalSpeed;
            }
            set
            {
                if (_originalSpeed == value) return;
                _originalSpeed = value;
                _emulator.OriginalSpeed = value;
                OnPropertyChanged();
            }
        }

        public int LoadFactor
        {
            get
            {
                return _loadFactor;
            }
            set
            {
                if (_loadFactor == value) return;
                _loadFactor = value;
                OnPropertyChanged();
            }
        }

        public ImageSource ScreenSource
        {
            get
            {
                return _screenSource;
            }
            set
            {
                _screenSource = value;
                OnPropertyChanged();
            }
        }

        public Led Led => _emulator.Led;

        public ActionCommand KeyDownCommand { get; private set; }

        public ActionCommand KeyUpCommand { get; private set; }

        public ActionCommand TextInputCommand { get; private set; }

        public ActionCommand KeyRepeatCommand { get; private set; }

        public ActionCommand SettingsCommand { get; private set; }

        public ActionCommand ResetCommand { get; private set; }

        public Window MainView { get; set; }

        private void InitCommands()
        {
            KeyDownCommand = new ActionCommand(
                obj =>
                {
                    _emulator.KeyDown((Key)obj);
                    _emulator.AddNewSpecialKey((Key)obj);
                });

            KeyUpCommand = new ActionCommand(obj => _emulator.KeyUp((Key)obj));

            TextInputCommand = new ActionCommand(obj => _emulator.AddNewKey((char)obj));

            KeyRepeatCommand = new ActionCommand(obj => _emulator.AddNewSpecialKey((Key)obj));

            SettingsCommand = new ActionCommand(ShowSettings);

            ResetCommand = new ActionCommand(Reset);
        }

        private void Reset(object obj)
        {
            _emulator.Reset();
        }

        private void ShowSettings(object obj)
        {
            if (OpenDialog(new SettingsView(), new SettingsViewModel(_ioService)) == true)
            {
                _emulator.SdDirectory = Settings.SdDirectory;
                InitScreenTimer();
            }
        }

        private bool? OpenDialog(Window dialogView, BaseViewModel dialogViewModel)
        {
            try
            {
                dialogView.Owner = MainView;
                dialogView.DataContext = dialogViewModel;
                var hResult = dialogView.ShowDialog();
                return hResult;
            }
            catch (Exception hEx)
            {
                _ioService.ShowError(hEx.Message);
            }
            return null;
        }

        private void UpdateScreen(object sender, EventArgs e)
        {
            _emulator.UpdateScreen();
            ScreenSource = _emulator.Screen;

            if (_updateCountdown-- == 0)
            {
                LoadFactor = (int)(_emulator.LoadFactor * 100);
                _updateCountdown = 20;
            }
        }
    }
}