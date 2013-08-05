using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace E_Z80
{
    internal class PortMapping
    {
        public IPortProvider Provider { get; set; }
        public int PortLo { get; set; }
        public int PortHi { get; set; }
    }

    public class PortMapper : IPortProvider
    {
        private List<PortMapping> FPortMappings = new List<PortMapping>();

        private IEnumerable<IPortProvider> EnumMappings(int _Port)
        {
            foreach (var hMapping in FPortMappings)
            {
                if (hMapping.PortLo <= _Port && hMapping.PortHi >= _Port)
                    yield return hMapping.Provider;
            }
        }

        public int InB(int _Port, int _Hi)
        {
            foreach (var hProvider in EnumMappings(_Port))
                return hProvider.InB(_Port, _Hi);
            return 0;
        }

        public void OutB(int _Port, int _Value, int _State)
        {
            foreach (var hProvider in EnumMappings(_Port))
                hProvider.OutB(_Port, _Value, _State);
        }

        public void Register(int _PortLo, int _PortHi, IPortProvider _Provider)
        {
            FPortMappings.Add(new PortMapping { Provider = _Provider, PortLo = _PortLo, PortHi = _PortHi });
        }

   }
}
