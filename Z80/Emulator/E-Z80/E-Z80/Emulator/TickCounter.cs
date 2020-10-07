using System.Threading;
using System.Threading.Tasks;

namespace E_Z80.Emulator
{
    class TickCounter : IPortProvider
    {
        private uint _tempTicks;

        public uint Ticks { get; private set; }

        public TickCounter(CancellationToken token)
        {
            var task = new Task(
                () =>
                {
                    while (!token.IsCancellationRequested)
                    {
                        Ticks++;
                        Thread.Sleep(100);
                    }
                });
            task.Start();
        }

        #region IPortProvider

        public int InB(int addr, int hi)
        {
            switch (addr)
            {
                case 130:
                    _tempTicks = Ticks;
                    return (byte)(_tempTicks & 0x000000ff);

                case 131:
                    return (byte)((_tempTicks & 0x0000ff00) >> 8);
                
                case 132:
                    return (byte)((_tempTicks & 0x00ff0000) >> 16);
                
                case 133:
                    return (byte)((_tempTicks & 0xff000000) >> 24);
            }
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
        }

        #endregion
    }
}
