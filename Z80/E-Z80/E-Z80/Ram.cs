using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E_Z80
{
    class Ram : IMemRangeProvider
    {
        // the memory system consists of 4 banks of ram, each has a size of 32 kbytes.
        private byte[] FMemoryLow = new byte[0x8000];
        private byte[][] FMemoryHigh = { new byte[0x8000], new byte[0x8000], new byte[0x8000] };
        private int FSelectedHighBank;

        public bool Peek(int _Addr, out byte _Value)
        {
            _Value = _Addr < 0x8000 ? FMemoryLow[_Addr] : FMemoryHigh[FSelectedHighBank][_Addr - 0x8000];
            return true;
        }

        public bool Poke(int _Addr, byte _Value)
        {
            if (_Addr < 0x8000)
                FMemoryLow[_Addr] = (byte)_Value;
            else
                FMemoryHigh[FSelectedHighBank][_Addr - 0x8000] = (byte)_Value;
            return true;
        }

        public void SetHighBank(int _BankNo)
        {
            FSelectedHighBank = _BankNo;
        }

    }
}
