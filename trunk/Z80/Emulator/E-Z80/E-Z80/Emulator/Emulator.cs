using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;
using System.Windows.Input;
using System.Diagnostics;

namespace E_Z80.Emulator
{
    public class MainEmulator
    {
        private readonly Z80 FCpu;
        private readonly MemoryMapper FMemoryMapper;
        private readonly PortMapper FPortMapper;
        private readonly Ram FRam;
        private readonly Graphics FGraphics;
        private readonly TickCounter FTickCounter;
        private readonly DiskController FDiskController;
        private readonly Serial FSerial;
        private readonly Led FLed;
        private readonly Speaker FSpeaker;
        private readonly Keyboard FKeyboard;
        private readonly BootLoader FBootLoader;

        private bool FInterruptIrq;
        private bool FInterruptNmi;
        private bool FDoReset;
        private Task FMainTask;

        private const int cFrameDurationMs = 25;
        private const int cLoadMeasureFrameCount = 20;
        private const int cCyclesPerMs = 20000;

        public MainEmulator()
        {
            FMemoryMapper = new MemoryMapper();
            FPortMapper = new PortMapper();
            FCpu = new Z80 { MemProvider = FMemoryMapper, PortProvider = FPortMapper };

            FGraphics = new Graphics();
            FMemoryMapper.Register(0x1000, 0x1fff, FGraphics, true, false);
            FPortMapper.Register(5, 7, FGraphics);

            FRam = new Ram();
            FMemoryMapper.Register(0, 0xffff, FRam, true, true);
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

            FMemoryMapper.FinishRegistration();

            OriginalSpeed = true;
        }

        public string SdDirectory
        { 
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

        public Led Led
        {
            get
            {
                return FLed;
            }
        }

        private void ExecutionLoop()
        {
            while (true)
            {
                FBootLoader.Load();
                FCpu.Reset();
                FCpu.Exec(cCyclesPerMs * 1000); // 1 second
                FCpu.Reset();
                Thread.Sleep(500);

                FDiskController.LoadProgram(DiskController.BiosFile);
                FCpu.EnableLog = true;

                var hFrameCount = 0;
                var hTotalSleep = 0;
                var hStopwatch = new Stopwatch();

                while (!FDoReset)
                {
                    hStopwatch.Start();
                    FCpu.Exec(cFrameDurationMs * cCyclesPerMs);
                    hStopwatch.Stop();

                    var hSleepMs = 0;
                    if (OriginalSpeed && hStopwatch.ElapsedMilliseconds < cFrameDurationMs)
                    {
                        hSleepMs = cFrameDurationMs - (int)hStopwatch.ElapsedMilliseconds;
                        Thread.Sleep(hSleepMs);
                    }

                    hTotalSleep += hSleepMs;
                    if (++hFrameCount == cLoadMeasureFrameCount)
                    {
                        LoadFactor = 1.0 - (double)hTotalSleep / (hFrameCount * cFrameDurationMs);
                        hTotalSleep = 0;
                        hFrameCount = 0;
                    }

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
                FDoReset = false;
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

        public void Reset()
        {
            FDoReset = true;
        }
    }
}