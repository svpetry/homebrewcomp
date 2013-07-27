using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E_Z80
{
    class Led : IPortProvider
    {
        public bool LedOn { get; set; }

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            if (_Addr == 3)
                LedOn = (_Value & 1) == 1;
        }

        #endregion
    }
}
