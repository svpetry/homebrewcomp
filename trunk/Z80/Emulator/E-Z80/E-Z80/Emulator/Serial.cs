using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Ports;

namespace E_Z80.Emulator
{
    class Serial : IPortProvider
    {
        private IMemoryProvider FMemory;
        private SerialPort FSerialPort;

        private const int cAddrBuffer = 0x0080; // size of buffer: 512 bytes

        public Serial(IMemoryProvider _Memory)
        {
            FMemory = _Memory;
        }

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            // read byte from RS232
            if (_Addr == 173)
            {
                if (FSerialPort == null) return 0;

                return FSerialPort.BytesToRead > 0 ? FSerialPort.ReadByte() : 0;
            }
            // read RS232 status (1 = data ready, 0 = no data)
            else if (_Addr == 174)
            {
                if (FSerialPort == null) return 0;

                return FSerialPort.BytesToRead > 0 ? 1 : 0;
            }
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            // init RS232
            if (_Addr == 170)
            {
                if (FSerialPort != null)
                    FSerialPort.Dispose();

                int hBaudRate = 0;
                switch (_Value)
                {
                    case 1:
                        hBaudRate = 4800;
                        break;
                    case 2:
                        hBaudRate = 9600;
                        break;
                    case 3:
                        hBaudRate = 19200;
                        break;
                    case 4:
                        hBaudRate = 38400;
                        break;
                    case 5:
                        hBaudRate = 57600;
                        break;
                    case 6:
                        hBaudRate = 115200;
                        break;
                }
                var hPortNames = SerialPort.GetPortNames();
                if (hBaudRate != 0 && hPortNames.Length > 0)
                {
                    FSerialPort = new SerialPort(hPortNames[0], hBaudRate);
                    FSerialPort.Open();
                }
            }
            // write byte to RS232
            else if (_Addr == 171)
            {
                if (FSerialPort == null) return;
                
                FSerialPort.Write(new byte[] { ((byte)_Value) }, 0, 1);
            }
            // write text to RS232
            else if (_Addr == 172)
            {
                if (FSerialPort == null) return;

                byte hValue;
                var hData = new List<byte>();
                var hIdx = 0;
                do
                {
                    hValue = (byte)FMemory.Peek(cAddrBuffer + hIdx);
                    hData.Add(hValue);
                } while (hValue != 10 && hIdx < 512);

                FSerialPort.Write(hData.ToArray(), 0, hData.Count);
            }
        }

        #endregion
    }
}
