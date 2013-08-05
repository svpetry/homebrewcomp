using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace E_Z80
{
    class Serial : IPortProvider
    {
        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            throw new NotImplementedException();
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}
