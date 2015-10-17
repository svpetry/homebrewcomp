using System.Media;

namespace E_Z80.Emulator
{
    class Speaker : IPortProvider
    {
        #region IPortProvider

        public int InB(int addr, int hi)
        {
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
            if (addr == 4 && (value & 1) == 1)
                SystemSounds.Beep.Play();
        }

        #endregion
    }
}
