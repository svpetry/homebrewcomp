using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace E_Z80
{
    public interface IMemRangeProvider
    {
        bool Peek(int _Addr, out byte _Value);
        bool Poke(int _Addr, byte _Value);
    }

    internal class MemoryMapping
    {
        public int AddrLo { get; set; }
        public int AddrHi { get; set; }
        public IMemRangeProvider Provider { get; set; }
    }

    public class MemoryMapper : IMemoryProvider
    {
        private List<MemoryMapping> FMemoryMappings = new List<MemoryMapping>();
        //private StreamWriter FLogFile = new StreamWriter("memlog.txt");

        private IEnumerable<IMemRangeProvider> EnumMappings(int _Addr)
        {
            foreach (var hMapping in FMemoryMappings)
            {
                if (hMapping.AddrLo <= _Addr && hMapping.AddrHi >= _Addr)
                    yield return hMapping.Provider;
            }
        }

        #region IMemoryProvider

        public int Peek(int _Addr)
        {
            byte hResult = 0;
            foreach (var hMemRange in EnumMappings(_Addr))
            {
                if (hMemRange.Peek(_Addr, out hResult))
                    return hResult;
            }
            return 0;
        }

        public void Poke(int _Addr, int _Value)
        {
            foreach (var hMemRange in EnumMappings(_Addr))
            {
                if (hMemRange.Poke(_Addr, (byte)(_Value & 0xff)))
                {
                    //FLogFile.WriteLine(_Addr.ToString() + " : " + _Value.ToString());
                    //FLogFile.Flush();
                    return;
                }
            }

        }

        #endregion

        public void Register(int _AddrLo, int _AddrHigh, IMemRangeProvider _Provider)
        {
            FMemoryMappings.Add(new MemoryMapping { AddrLo = _AddrLo, AddrHi = _AddrHigh, Provider = _Provider });
        }
    }
}
