using System;
using System.IO;
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
        private readonly IOService FIoService;

        private readonly MainEmulator FEmulator;

        private DispatcherTimer FScreenTimer;

        private int FUpdateCountdown;

        private bool FOriginalSpeed;
        private int FLoadFactor;

        private ImageSource FScreenSource;

        public MainViewModel(IOService _IoService)
        {
            FIoService = _IoService;
            Settings.Load();

            InitCommands();

            FEmulator = new MainEmulator();

            OriginalSpeed = true;

            InitScreenTimer();

            var hInterruptTimer = new DispatcherTimer { Interval = new TimeSpan(0, 0, 0, 0, 100) };
            hInterruptTimer.Tick += (_Sender, _EventArgs) => FEmulator.InterruptIrq();
            hInterruptTimer.Start();

            FEmulator.SdDirectory = Settings.SdDirectory;
            FEmulator.Start();
        }

        private void InitScreenTimer()
        {
            if (FScreenTimer != null)
                FScreenTimer.Stop();

            FScreenTimer = new DispatcherTimer { Interval = new TimeSpan(0, 0, 0, 0, 1000 / Settings.UpdateRate) };
            FScreenTimer.Tick += UpdateScreen;
            FScreenTimer.Start();
        }

        public bool OriginalSpeed
        {
            get
            {
                return FOriginalSpeed;
            }
            set
            {
                if (FOriginalSpeed == value) return;
                FOriginalSpeed = value;
                FEmulator.OriginalSpeed = value;
                OnPropertyChanged();
            }
        }

        public int LoadFactor
        {
            get
            {
                return FLoadFactor;
            }
            set
            {
                if (FLoadFactor == value) return;
                FLoadFactor = value;
                OnPropertyChanged();
            }
        }

        public ImageSource ScreenSource
        {
            get
            {
                return FScreenSource;
            }
            set
            {
                FScreenSource = value;
                OnPropertyChanged();
            }
        }

        public Led Led
        {
            get
            {
                return FEmulator.Led;
            }
        }

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
                _Obj =>
                {
                    FEmulator.KeyDown((Key)_Obj);
                    FEmulator.AddNewSpecialKey((Key)_Obj);
                });

            KeyUpCommand = new ActionCommand(_Obj => FEmulator.KeyUp((Key)_Obj));

            TextInputCommand = new ActionCommand(_Obj => FEmulator.AddNewKey((char)_Obj));

            KeyRepeatCommand = new ActionCommand(_Obj => FEmulator.AddNewSpecialKey((Key)_Obj));

            SettingsCommand = new ActionCommand(ShowSettings);

            ResetCommand = new ActionCommand(Reset);
        }

        private void Reset(object _Obj)
        {
            FEmulator.Reset();
        }

        private void ShowSettings(object _Obj)
        {
            if (OpenDialog(new SettingsView(), new SettingsViewModel(FIoService)) == true)
            {
                FEmulator.SdDirectory = Settings.SdDirectory;
                InitScreenTimer();
            }
        }

        private bool? OpenDialog(Window _DialogView, BaseViewModel _DialogViewModel)
        {
            try
            {
                _DialogView.Owner = MainView;
                _DialogView.DataContext = _DialogViewModel;
                var hResult = _DialogView.ShowDialog();
                return hResult;
            }
            catch (Exception hEx)
            {
                FIoService.ShowError(hEx.Message);
            }
            return null;
        }

        private void UpdateScreen(object _Sender, EventArgs _E)
        {
            FEmulator.UpdateScreen();
            ScreenSource = FEmulator.Screen;

            if (FUpdateCountdown-- == 0)
            {
                LoadFactor = (int)(FEmulator.LoadFactor * 100);
                FUpdateCountdown = 20;
            }
        }
    }
}