using System.Collections.Generic;

namespace E_Z80.Emulator
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
        public bool SupportRead { get; set; }
        public bool SupportWrite { get; set; }
    }

    public class MemoryMapper : IMemoryProvider
    {
        private readonly List<MemoryMapping> FMemoryMappings = new List<MemoryMapping>();
        private readonly List<MemoryMapping> FReadMappings = new List<MemoryMapping>(); 
        private readonly List<MemoryMapping> FWriteMappings = new List<MemoryMapping>(); 

        #region IMemoryProvider

        public int Peek(int _Addr)
        {
            foreach (var hMapping in FReadMappings)
            {
                byte hResult;
                if (hMapping.AddrLo <= _Addr && hMapping.AddrHi >= _Addr && hMapping.Provider.Peek(_Addr, out hResult))
                    return hResult;
            }
            return 0;
        }

        public void Poke(int _Addr, int _Value)
        {
            foreach (var hMapping in FWriteMappings)
            {
                if (hMapping.AddrLo <= _Addr && hMapping.AddrHi >= _Addr && hMapping.Provider.Poke(_Addr, (byte)(_Value & 0xff)))
                    return;
            }
        }

        #endregion

        public void Register(int _AddrLo, int _AddrHigh, IMemRangeProvider _Provider, bool _SupportWrite, bool _SupportRead)
        {
            FMemoryMappings.Add(
                new MemoryMapping
                {
                    AddrLo = _AddrLo,
                    AddrHi = _AddrHigh,
                    Provider = _Provider,
                    SupportRead = _SupportRead,
                    SupportWrite = _SupportWrite
                });
        }

        public void FinishRegistration()
        {
            foreach (var hMapping in FMemoryMappings)
            {
                if (hMapping.SupportRead)
                    FReadMappings.Add(hMapping);
                if (hMapping.SupportWrite)
                    FWriteMappings.Add(hMapping);
            } 
        }
    }
}
