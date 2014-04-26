using System;
using System.Collections.Generic;
using System.Linq;
using System.Media;
using System.Text;

namespace E_Z80.Emulator
{
    class Speaker : IPortProvider
    {
        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            if (_Addr == 4 && (_Value & 1) == 1)
                SystemSounds.Beep.Play();
        }

        #endregion
    }
}
