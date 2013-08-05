using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Input;

namespace E_Z80
{
    class Keyboard : IPortProvider
    {
        private static Queue<byte> FKeyQueue = new Queue<byte>();
        private object FLockObj = new object();

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            if (_Addr == 128)
            {
                lock (FLockObj)
                {
                    if (FKeyQueue.Count > 0)
                    {
                        var hKey = FKeyQueue.Dequeue();
                        return hKey;
                    }
                    else
                        return 255;
                }
            }
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
        }

        public void AddNewKey(char _Key)
        {
            AddNewKey((byte)_Key);
        }

        private void AddNewKey(byte _Key)
        {
            if (_Key < 128)
            {
                lock (FLockObj)
                {
                    var hKey = _Key;
                    if (hKey == 13)
                        hKey = 10;
                    FKeyQueue.Enqueue(hKey);
                }
            }
        }

        public void AddNewSpecialKey(Key _Key)
        {
            switch (_Key)
            {
                case Key.Up:
                    AddNewKey(0);
                    AddNewKey(72);
                    break;

                case Key.Down:
                    AddNewKey(0);
                    AddNewKey(80);
                    break;

                case Key.Left:
                    AddNewKey(0);
                    AddNewKey(75);
                    break;

                case Key.Right:
                    AddNewKey(0);
                    AddNewKey(77);
                    break;

                case Key.PageUp:
                    AddNewKey(0);
                    AddNewKey(73);
                    break;

                case Key.PageDown:
                    AddNewKey(0);
                    AddNewKey(81);
                    break;

                case Key.Home:
                    AddNewKey(0);
                    AddNewKey(71);
                    break;

                case Key.End:
                    AddNewKey(0);
                    AddNewKey(79);
                    break;
                
                case Key.F1:
                    AddNewKey(0);
                    AddNewKey(59);
                    break;

                case Key.F2:
                    AddNewKey(0);
                    AddNewKey(60);
                    break;

                case Key.F3:
                    AddNewKey(0);
                    AddNewKey(61);
                    break;

                case Key.F4:
                    AddNewKey(0);
                    AddNewKey(62);
                    break;

                case Key.F5:
                    AddNewKey(0);
                    AddNewKey(63);
                    break;

                case Key.F6:
                    AddNewKey(0);
                    AddNewKey(64);
                    break;

                case Key.F7:
                    AddNewKey(0);
                    AddNewKey(65);
                    break;

                case Key.F8:
                    AddNewKey(0);
                    AddNewKey(66);
                    break;

                case Key.F9:
                    AddNewKey(0);
                    AddNewKey(67);
                    break;

                case Key.F10:
                    AddNewKey(0);
                    AddNewKey(68);
                    break;
            }
        }

        #endregion
    }
}   
