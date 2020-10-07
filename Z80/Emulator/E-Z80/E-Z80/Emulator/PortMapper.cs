using System.Collections.Generic;
using System.Linq;

namespace E_Z80.Emulator
{
    internal class PortMapping
    {
        public IPortProvider Provider { get; set; }
        public int PortLo { get; set; }
        public int PortHi { get; set; }
    }

    public class PortMapper : IPortProvider
    {
        private readonly List<PortMapping> _portMappings = new List<PortMapping>();

        private IEnumerable<IPortProvider> EnumMappings(int port)
        {
            return _portMappings.Where(mapping => mapping.PortLo <= port && mapping.PortHi >= port).Select(mapping => mapping.Provider);
        }

        public int InB(int addr, int hi)
        {
            var provider = EnumMappings(addr).FirstOrDefault();
            return provider?.InB(addr, hi) ?? 0;
        }

        public void OutB(int addr, int value, int state)
        {
            foreach (var provider in EnumMappings(addr))
                provider.OutB(addr, value, state);
        }

        public void Register(int portLo, int portHi, IPortProvider provider)
        {
            _portMappings.Add(new PortMapping { Provider = provider, PortLo = portLo, PortHi = portHi });
        }

   }
}
