using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Timers;

namespace E_Z80
{
    class TickCounter : IPortProvider
    {
        private uint FTempTicks;

        public uint Ticks { get; private set; }

        public TickCounter()
        {
            var hTask = new Task(
                () =>
                {
                    while (true)
                    {
                        Ticks++;
                        Thread.Sleep(100);
                    }
                });
            hTask.Start();
        }

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            switch (_Addr)
            {
                case 130:
                    FTempTicks = Ticks;
                    return (byte)(FTempTicks & 0x000000ff);

                case 131:
                    return (byte)((FTempTicks & 0x0000ff00) >> 8);
                
                case 132:
                    return (byte)((FTempTicks & 0x00ff0000) >> 16);
                
                case 133:
                    return (byte)((FTempTicks & 0xff000000) >> 24);
            }
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
        }

        #endregion
    }
}
