using E_Z80.ViewModels;

namespace E_Z80.Emulator
{
    public class Led : BaseViewModel, IPortProvider
    {
        private bool _ledOn;

        public bool LedOn
        {
            get
            {
                return _ledOn;
            }
            set
            {
                if (_ledOn == value) return;
                _ledOn = value;
                OnPropertyChanged();
            }
        }

        #region IPortProvider

        public int InB(int addr, int hi)
        {
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
            if (addr == 3)
                LedOn = (value & 1) == 1;
        }

        #endregion
    }
}
