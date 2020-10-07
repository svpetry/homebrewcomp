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
        private readonly CancellationTokenSource _cancellationTokenSource = new CancellationTokenSource();
        private readonly Z80 _cpu;
        private readonly MemoryMapper _memoryMapper;
        private readonly PortMapper _portMapper;
        private readonly Ram _ram;
        private readonly Graphics _graphics;
        private readonly TickCounter _tickCounter;
        private readonly DiskController _diskController;
        private readonly Serial _serial;
        private readonly Led _led;
        private readonly Speaker _speaker;
        private readonly Keyboard _keyboard;
        //private readonly BootLoader FBootLoader;

        private bool _interruptIrq;
        private bool _interruptNmi;
        private bool _doReset;
        private Task _mainTask;

        private const int FrameDurationMs = 25;
        private const int LoadMeasureFrameCount = 20;
        private const int CyclesPerMs = 20000;

        public MainEmulator()
        {
            _memoryMapper = new MemoryMapper();
            _portMapper = new PortMapper();
            _cpu = new Z80 { MemProvider = _memoryMapper, PortProvider = _portMapper };

            _graphics = new Graphics();
            _memoryMapper.Register(0x1000, 0x1fff, _graphics, true, false);
            _portMapper.Register(5, 7, _graphics);

            _ram = new Ram();
            _memoryMapper.Register(0, 0xffff, _ram, true, true);
            _portMapper.Register(0, 0, _ram);

            _tickCounter = new TickCounter(_cancellationTokenSource.Token);
            _portMapper.Register(130, 133, _tickCounter);

            _diskController = new DiskController(_memoryMapper, () => _cpu.Reset());
            _portMapper.Register(160, 169, _diskController);

            _serial = new Serial(_memoryMapper);
            _portMapper.Register(170, 179, _serial);

            _led = new Led();
            _portMapper.Register(3, 3, _led);

            _speaker = new Speaker();
            _portMapper.Register(4, 4, _speaker);

            _keyboard = new Keyboard();
            _portMapper.Register(128, 129, _keyboard);

            //FBootLoader = new BootLoader(FMemoryMapper);

            _memoryMapper.FinishRegistration();

            OriginalSpeed = true;
        }

        public string SdDirectory
        { 
            get
            {
                return _diskController.DirName;
            }
            set
            {
                _diskController.DirName = value;
            }
        }

        public bool OriginalSpeed { get; set; }

        public Double LoadFactor { get; private set; }

        public WriteableBitmap Screen => _graphics.Screen;

        public Led Led => _led;

        private void ExecutionLoop(CancellationToken token)
        {
            Task.Run(() =>
            {
                while (!token.IsCancellationRequested)
                {
                    Thread.Sleep(100);
                    InterruptNmi();
                }
            }, token);

            while (!token.IsCancellationRequested)
            {
                _cpu.Reset();

                _diskController.LoadFileIntoMemory(DiskController.BiosFile, 0);

                var frameCount = 0;
                var totalSleep = 0;
                var stopWatch = new Stopwatch();

                while (!_doReset)
                {
                    stopWatch.Start();
                    _cpu.Exec(FrameDurationMs * CyclesPerMs);
                    stopWatch.Stop();

                    var sleepMs = 0;
                    if (OriginalSpeed && stopWatch.ElapsedMilliseconds < FrameDurationMs)
                    {
                        sleepMs = FrameDurationMs - (int)stopWatch.ElapsedMilliseconds;
                        Thread.Sleep(sleepMs);
                    }

                    totalSleep += sleepMs;
                    if (++frameCount == LoadMeasureFrameCount)
                    {
                        LoadFactor = 1.0 - (double)totalSleep / (frameCount * FrameDurationMs);
                        totalSleep = 0;
                        frameCount = 0;
                    }

                    stopWatch.Reset();


                    if (_interruptIrq)
                    {
                        _cpu.Interrupt(Z80.INTERRUPT_TYPE_IRQ, true);
                        _interruptIrq = false;
                    }
                    if (_interruptNmi)
                    {
                        _cpu.Interrupt(Z80.INTERRUPT_TYPE_NMI, true);
                        _interruptNmi = false;
                    }
                }
                _doReset = false;
            }
        }

        public void AddNewKey(char key)
        {
            _keyboard.AddNewKey(key);
        }

        public void AddNewSpecialKey(Key key)
        {
            _keyboard.AddNewSpecialKey(key);
        }

        public void KeyDown(Key key)
        {
            _keyboard.KeyDown(key);
        }

        public void KeyUp(Key key)
        {
            _keyboard.KeyUp(key);
        }

        public void UpdateScreen()
        {
            _graphics.UpdateScreen();
        }

        public void Start()
        {
            if (_mainTask == null)
                _mainTask = Task.Run(() => ExecutionLoop(_cancellationTokenSource.Token));
        }

        public void InterruptIrq()
        {
            _interruptIrq = true;
        }

        public void InterruptNmi()
        {
            _interruptNmi = true;
        }

        public void Reset()
        {
            _doReset = true;
        }
    }
}