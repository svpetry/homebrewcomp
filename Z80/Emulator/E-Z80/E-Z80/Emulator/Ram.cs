﻿namespace E_Z80.Emulator
{
    class Ram : IMemRangeProvider, IPortProvider
    {
        // the memory system consists of 5 banks of ram, each has a size of 32 kbytes.
        private readonly byte[] FMemoryLow = new byte[0x8000];
        private readonly byte[][] FMemoryHigh = { new byte[0x8000], new byte[0x8000], new byte[0x8000], new byte[0x8000] };
        private int FSelectedHighBank;

        #region IMemRangeProvider

        public bool Peek(int _Addr, out byte _Value)
        {
            _Value = _Addr < 0x8000 ? FMemoryLow[_Addr] : FMemoryHigh[FSelectedHighBank][_Addr - 0x8000];
            return true;
        }

        public bool Poke(int _Addr, byte _Value)
        {
            if (_Addr < 0x8000)
                FMemoryLow[_Addr] = _Value;
            else
                FMemoryHigh[FSelectedHighBank][_Addr - 0x8000] = _Value;
            return true;
        }

        #endregion

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            if (_Addr != 0) return;

            switch (_Value)
            {
                case 1:
                    FSelectedHighBank = 0;
                    break;
                case 2:
                    FSelectedHighBank = 1;
                    break;
                case 4:
                    FSelectedHighBank = 2;
                    break;
                case 8:
                    FSelectedHighBank = 3;
                    break;
            }
        }

        #endregion
    }
}
