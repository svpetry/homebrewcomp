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
            for (var idx = 0; idx < _readMappings.Count; idx++)
            {
                var mapping = _readMappings[idx];
                byte result;
                if (mapping.AddrLo <= addr && mapping.AddrHi >= addr && mapping.Provider.Peek(addr, out result))
                    return result;
            }
            return 0;
        }

        public void Poke(int addr, int value)
        {
            for (var idx = 0; idx < _writeMappings.Count; idx++)
            {
                var mapping = _writeMappings[idx];
                if (mapping.AddrLo <= addr && mapping.AddrHi >= addr &&
                    mapping.Provider.Poke(addr, (byte) (value & 0xff)))
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
            foreach (var mapping in _memoryMappings)
            {
                if (mapping.SupportRead)
                    _readMappings.Add(mapping);
                if (mapping.SupportWrite)
                    _writeMappings.Add(mapping);
            } 
        }
    }
}
