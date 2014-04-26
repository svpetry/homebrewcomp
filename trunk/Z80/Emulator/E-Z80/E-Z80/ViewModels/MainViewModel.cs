using E_Z80.Common;
using E_Z80.Emulator;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Threading;
using System.Windows.Media;
using System.Windows.Input;

namespace E_Z80.ViewModels
{
    class MainViewModel : BaseViewModel
    {
        private IOService FIOService;

        private Z80_Emulator FEmulator;
        private DispatcherTimer FScreenTimer;
        private int FUpdateCountdown;

        private const string cSettingsFile = "settings.ini";

        private bool FOriginalSpeed;
        private int FLoadFactor;
        private string FDirectory;
        private ImageSource FScreenSource;

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

        public string Directory
        {
            get
            {
                return FDirectory;
            }
            set
            {
                if (FDirectory == value) return;
                FDirectory = value;
                FEmulator.SdDirectory = value;
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

        public bool ImageFocused
        {
            get
            {
                return true;
            }
            set
            {
                OnPropertyChanged();
            }
        }

        public ActionCommand SelectDirectoryCommand { get; set; }

        public ActionCommand KeyDownCommand { get; set; }

        public ActionCommand KeyUpCommand { get; set; }

        public ActionCommand TextInputCommand { get; set; }
        
        public MainViewModel(IOService _IOService)
        {
            FIOService = _IOService;

            InitCommands();

            FEmulator = new Z80_Emulator();

            if (File.Exists(cSettingsFile))
            {
                var hDirectory = File.ReadAllText(cSettingsFile);
                Directory = hDirectory;
            }
            OriginalSpeed = true;

            FScreenTimer = new DispatcherTimer();
            FScreenTimer.Interval = new TimeSpan(0, 0, 0, 0, 25);
            FScreenTimer.Tick += UpdateScreen;
            FScreenTimer.Start();

            FEmulator.Start();
        }

        private void InitCommands()
        {
            SelectDirectoryCommand = new ActionCommand((_Obj) =>
            {
                if (FIOService.OpenSelectFolderDialog(Directory))
                {
                    Directory = FIOService.SelectedDirectory;
                    File.WriteAllText(cSettingsFile, Directory);
                }
                ImageFocused = true;
            });

            KeyDownCommand = new ActionCommand((_Obj) =>
            {
                FEmulator.KeyDown((Key)_Obj);
                FEmulator.AddNewSpecialKey((Key)_Obj);
            });

            KeyUpCommand = new ActionCommand((_Obj) =>
            {
                FEmulator.KeyUp((Key)_Obj);
            });

            TextInputCommand = new ActionCommand((_Obj) =>
            {
                FEmulator.AddNewKey((char)_Obj);
            });
        }

        private void UpdateScreen(object _Sender, EventArgs _E)
        {
            FEmulator.UpdateScreen();
            ScreenSource = FEmulator.Screen;

            if (FUpdateCountdown-- == 0)
            {
                LoadFactor = (int)(FEmulator.LoadFactor * 100);
                FUpdateCountdown = 10;
            }

        }

    }
}
