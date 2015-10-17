using System.Collections.Generic;

namespace E_Z80.Emulator
{
    public interface IMemRangeProvider
    {
        bool Peek(int addr, out byte value);
        bool Poke(int addr, byte value);
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
        private readonly List<MemoryMapping> _memoryMappings = new List<MemoryMapping>();
        private readonly List<MemoryMapping> _readMappings = new List<MemoryMapping>(); 
        private readonly List<MemoryMapping> _writeMappings = new List<MemoryMapping>(); 

        #region IMemoryProvider

        public int Peek(int addr)
        {
            for (var hIdx = 0; hIdx < _readMappings.Count; hIdx++)
            {
                var hMapping = _readMappings[hIdx];
                byte hResult;
                if (hMapping.AddrLo <= addr && hMapping.AddrHi >= addr && hMapping.Provider.Peek(addr, out hResult))
                    return hResult;
            }
            return 0;
        }

        public void Poke(int addr, int value)
        {
            for (var hIdx = 0; hIdx < _writeMappings.Count; hIdx++)
            {
                var hMapping = _writeMappings[hIdx];
                if (hMapping.AddrLo <= addr && hMapping.AddrHi >= addr &&
                    hMapping.Provider.Poke(addr, (byte) (value & 0xff)))
                    return;
            }
        }

        #endregion

        public void Register(int addrLo, int addrHigh, IMemRangeProvider provider, bool supportWrite, bool supportRead)
        {
            _memoryMappings.Add(
                new MemoryMapping
                {
                    AddrLo = addrLo,
                    AddrHi = addrHigh,
                    Provider = provider,
                    SupportRead = supportRead,
                    SupportWrite = supportWrite
                });
        }

        public void FinishRegistration()
        {
            foreach (var hMapping in _memoryMappings)
            {
                if (hMapping.SupportRead)
                    _readMappings.Add(hMapping);
                if (hMapping.SupportWrite)
                    _writeMappings.Add(hMapping);
            } 
        }
    }
}
