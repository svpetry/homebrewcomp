namespace E_Z80.Emulator
{
    class Ram : IMemRangeProvider, IPortProvider
    {
        // the memory system consists of 5 banks of ram, each has a size of 32 kbytes.
        private readonly byte[] _memoryLow = new byte[0x8000];
        private readonly byte[][] _memoryHigh = { new byte[0x8000], new byte[0x8000], new byte[0x8000], new byte[0x8000] };
        private int _selectedHighBank;

        #region IMemRangeProvider

        public bool Peek(int addr, out byte value)
        {
            value = addr < 0x8000 ? _memoryLow[addr] : _memoryHigh[_selectedHighBank][addr - 0x8000];
            return true;
        }

        public bool Poke(int addr, byte value)
        {
            if (addr < 0x8000)
                _memoryLow[addr] = value;
            else
                _memoryHigh[_selectedHighBank][addr - 0x8000] = value;
            return true;
        }

        #endregion

        #region IPortProvider

        public int InB(int addr, int hi)
        {
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
            if (addr != 0) return;

            switch (value)
            {
                case 1:
                    _selectedHighBank = 0;
                    break;
                case 2:
                    _selectedHighBank = 1;
                    break;
                case 4:
                    _selectedHighBank = 2;
                    break;
                case 8:
                    _selectedHighBank = 3;
                    break;
            }
        }

        #endregion
    }
}
