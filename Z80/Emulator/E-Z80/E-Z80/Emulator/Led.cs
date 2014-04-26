﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace E_Z80.Emulator
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