using E_Z80.ViewModels;

namespace E_Z80.Emulator
{
    public class Led : BaseViewModel, IPortProvider
    {
        private bool FLedOn;

        public bool LedOn
        {
            get
            {
                return FLedOn;
            }
            set
            {
                if (FLedOn == value) return;
                FLedOn = value;
                OnPropertyChanged();
            }
        }

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
