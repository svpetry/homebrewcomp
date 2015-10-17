using System.Collections.Generic;
using System.IO.Ports;

namespace E_Z80.Emulator
{
    class Serial : IPortProvider
    {
        private readonly IMemoryProvider _memory;
        private SerialPort _serialPort;

        private const int AddrBuffer = 0x0080; // size of buffer: 512 bytes

        public Serial(IMemoryProvider memory)
        {
            _memory = memory;
        }

        #region IPortProvider

        public int InB(int addr, int hi)
        {
            // read byte from RS232
            if (addr == 173)
            {
                if (_serialPort == null) return 0;

                return _serialPort.BytesToRead > 0 ? _serialPort.ReadByte() : 0;
            }
            // read RS232 status (1 = data ready, 0 = no data)
            if (addr == 174)
            {
                if (_serialPort == null) return 0;

                return _serialPort.BytesToRead > 0 ? 1 : 0;
            }
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
            // init RS232
            if (addr == 170)
            {
                _serialPort?.Dispose();

                int hBaudRate = 0;
                switch (value)
                {
                    case 1:
                        hBaudRate = 1200;
                        break;
                    case 2:
                        hBaudRate = 2400;
                        break;
                    case 3:
                        hBaudRate = 4800;
                        break;
                    case 4:
                        hBaudRate = 9600;
                        break;
                    case 5:
                        hBaudRate = 19200;
                        break;
                    case 6:
                        hBaudRate = 38400;
                        break;
                    case 7:
                        hBaudRate = 57600;
                        break;
                    case 8:
                        hBaudRate = 115200;
                        break;
                }
                var hPortNames = SerialPort.GetPortNames();
                if (hBaudRate != 0 && hPortNames.Length > 0)
                {
                    _serialPort = new SerialPort(hPortNames[0], hBaudRate);
                    _serialPort.Open();
                }
            }
            // write byte to RS232
            else if (addr == 171)
            {
                _serialPort?.Write(new[] { ((byte)value) }, 0, 1);
            }
            // write text to RS232
            else if (addr == 172)
            {
                if (_serialPort == null) return;

                byte hValue;
                var hData = new List<byte>();
                var hIdx = 0;
                do
                {
                    hValue = (byte)_memory.Peek(AddrBuffer + hIdx++);
                    hData.Add(hValue);
                } while (hValue != 10 && hIdx < 512);

                _serialPort.Write(hData.ToArray(), 0, hData.Count);
            }
        }

        #endregion
    }
}
