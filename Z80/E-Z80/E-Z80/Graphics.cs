using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace E_Z80
{
    class Graphics : IMemRangeProvider
    {
        private byte[] FVideoRam = new byte[0x1000];
        private WriteableBitmap FScreen;

        public Graphics(WriteableBitmap _Screen)
        {
            FScreen = _Screen;
        }

        public bool RamActive { get; set; }

        public bool Peek(int _Addr, out byte _Value)
        {
            _Value = 0;
            return false;
        }

        public bool Poke(int _Addr, byte _Value)
        {
            if (RamActive)
            {
                FVideoRam[_Addr - 0x0800] = _Value;
                return true;
            }
            return false;
        }
    }
}
