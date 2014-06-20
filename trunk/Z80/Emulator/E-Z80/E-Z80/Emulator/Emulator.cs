using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Input;
using System.Diagnostics;

namespace E_Z80.Emulator
{
    public class Z80_Emulator
    {
        private Z80 FCpu;
        private MemoryMapper FMemoryMapper;
        private PortMapper FPortMapper;
        private Ram FRam;
        private Graphics FGraphics;
        private TickCounter FTickCounter;
        private DiskController FDiskController;
        private Serial FSerial;
        private Led FLed;
        private Speaker FSpeaker;
        private Keyboard FKeyboard;
        private BootLoader FBootLoader;

        private bool FInterruptIrq;
        private bool FInterruptNmi;
        private Task FMainTask;

        private const int cFrameDurationMs = 25;
        private const int cCyclesPerMs = 20000;

        public Z80_Emulator()
        {
            FMemoryMapper = new MemoryMapper();
            FPortMapper = new PortMapper();
            FCpu = new Z80 { MemProvider = FMemoryMapper, PortProvider = FPortMapper };

            FGraphics = new Graphics();
            FMemoryMapper.Register(0x1000, 0x1fff, FGraphics);
            FPortMapper.Register(5, 7, FGraphics);

            FRam = new Ram();
            FMemoryMapper.Register(0, 0xffff, FRam);
            FPortMapper.Register(0, 0, FRam);

            FTickCounter = new TickCounter();
            FPortMapper.Register(130, 133, FTickCounter);

            FDiskController = new DiskController(FMemoryMapper, () => FCpu.Reset());
            FPortMapper.Register(160, 169, FDiskController);

            FSerial = new Serial(FMemoryMapper);
            FPortMapper.Register(170, 179, FSerial);

            FLed = new Led();
            FPortMapper.Register(3, 3, FLed);

            FSpeaker = new Speaker();
            FPortMapper.Register(4, 4, FSpeaker);

            FKeyboard = new Keyboard();
            FPortMapper.Register(128, 129, FKeyboard);

            FBootLoader = new BootLoader(FMemoryMapper);

            OriginalSpeed = true;
        }

        public string SdDirectory { 
            get
            {
                return FDiskController.DirName;
            }
            set
            {
                FDiskController.DirName = value;
            }
        }

        public bool OriginalSpeed { get; set; }

        public Double LoadFactor { get; private set; }

        public WriteableBitmap Screen
        {
            get
            {
                return FGraphics.Screen;
            }
        }

        private void ExecutionLoop()
        {
            FBootLoader.Load();
            FCpu.Reset();
            FCpu.Exec(cCyclesPerMs * 1000); // 1 second
            FCpu.Reset();

            Thread.Sleep(500);
            FGraphics.RamActive = false;
            FDiskController.LoadProgram(DiskController.BiosFile);
            FCpu.EnableLog = true;

            var hStopwatch = new Stopwatch();

            while (true)
            {
                hStopwatch.Start();
                FCpu.Exec(cFrameDurationMs * cCyclesPerMs);
                hStopwatch.Stop();

                if (OriginalSpeed && hStopwatch.ElapsedMilliseconds < cFrameDurationMs)
                {
                    var hSleepMs = cFrameDurationMs - (int)hStopwatch.ElapsedMilliseconds;
                    LoadFactor = 1.0 - (double)hSleepMs / (double)cFrameDurationMs;
                    Thread.Sleep(hSleepMs);
                }
                else
                    LoadFactor = 1.0;

                hStopwatch.Reset();


                if (FInterruptIrq)
                {
                    FCpu.Interrupt(Z80.INTERRUPT_TYPE_IRQ, true);
                    FInterruptIrq = false;
                }
                if (FInterruptNmi)
                {
                    FCpu.Interrupt(Z80.INTERRUPT_TYPE_NMI, true);
                    FInterruptNmi = false;
                }
            }
        }

        public void AddNewKey(char _Key)
        {
            FKeyboard.AddNewKey(_Key);
        }

        public void AddNewSpecialKey(Key _Key)
        {
            FKeyboard.AddNewSpecialKey(_Key);
        }

        public void KeyDown(Key _Key)
        {
            FKeyboard.KeyDown(_Key);
        }

        public void KeyUp(Key _Key)
        {
            FKeyboard.KeyUp(_Key);
        }

        public void UpdateScreen()
        {
            FGraphics.UpdateScreen();
        }

        public void Start()
        {
            if (FMainTask == null)
            {
                FMainTask = new Task(ExecutionLoop);
                FMainTask.Start();
            }
        }

        public void InterruptIrq()
        {
            FInterruptIrq = true;
        }

        public void InterruptNmi()
        {
            FInterruptNmi = true;
        }

    }
}