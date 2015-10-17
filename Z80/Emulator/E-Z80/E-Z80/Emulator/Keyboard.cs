using System.Collections.Generic;
using System.Windows.Input;

namespace E_Z80.Emulator
{
    class Keyboard : IPortProvider
    {
        private static readonly Queue<byte> KeyQueue = new Queue<byte>();
        private static readonly Queue<byte> ScanCodeQueue = new Queue<byte>();
        private readonly object _lockObj = new object();

        #region IPortProvider

        public int InB(int addr, int hi)
        {
            if (addr == 128)
            {
                lock (_lockObj)
                {
                    ScanCodeQueue.Clear();
                    if (KeyQueue.Count > 0)
                    {
                        var hKey = KeyQueue.Dequeue();
                        return hKey;
                    }
                    return 255;
                }
            }
            if (addr == 129)
            {
                lock (_lockObj)
                {
                    KeyQueue.Clear();
                    if (ScanCodeQueue.Count > 0)
                    {
                        var hKey = ScanCodeQueue.Dequeue();
                        return hKey;
                    }
                    return 0;
                }
            }
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
        }

        #endregion

        public void AddNewKey(char key)
        {
            AddNewKey((byte)key);
        }

        public void AddScanCodes(byte [] code)
        {
            lock (_lockObj)
            {
                foreach (var hCode in code)
                    ScanCodeQueue.Enqueue(hCode);
            }
        }

        private void AddNewKey(byte key)
        {
            if (key < 128)
            {
                lock (_lockObj)
                {
                    var hKey = key;
                    if (hKey == 13)
                        hKey = 10;
                    KeyQueue.Enqueue(hKey);
                }
            }
        }

        public void AddNewSpecialKey(Key key)
        {
            switch (key)
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
                case Key.System:
                    AddNewKey(0);
                    AddNewKey(68);
                    break;
            }
        }

        public void KeyDown(Key key)
        {
            switch (key)
            {
                case Key.Up:
                    AddScanCodes(new byte[] { 0xe0, 0x75 });
                    break;

                case Key.Down:
                    AddScanCodes(new byte[] { 0xe0, 0x72 });
                    break;

                case Key.Left:
                    AddScanCodes(new byte[] { 0xe0, 0x6b });
                    break;

                case Key.Right:
                    AddScanCodes(new byte[] { 0xe0, 0x74 });
                    break;

                case Key.Space:
                    AddScanCodes(new byte[] { 0x29 });
                    break;

                case Key.Escape:
                    AddScanCodes(new byte[] { 0x76 });
                    break;

            }
        }

        public void KeyUp(Key key)
        {
            switch (key)
            {
                case Key.Up:
                    AddScanCodes(new byte[] { 0xe0, 0x75 + 0x80 });
                    break;

                case Key.Down:
                    AddScanCodes(new byte[] { 0xe0, 0x72 + 0x80 });
                    break;

                case Key.Left:
                    AddScanCodes(new byte[] { 0xe0, 0x6b + 0x80 });
                    break;

                case Key.Right:
                    AddScanCodes(new byte[] { 0xe0, 0x74 + 0x80 });
                    break;

                case Key.Space:
                    AddScanCodes(new byte[] { 0x29 + 0x80 });
                    break;

                case Key.Escape:
                    AddScanCodes(new byte[] { 0x29 + 0x76 });
                    break;
            }
        }

    }
}   
