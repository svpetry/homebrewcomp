using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace E_Z80
{
    enum GraMode { Text, Graphics };

    class Graphics : IMemRangeProvider, IPortProvider
    {
        public static int RowCount = 25;
        public static int ColCount = 80;

        private const int cVRamStart = 0x1000;
        private const int cVRamSize = 0x1000;
        private const int cRowSize = 128;
        private const int cInvalidLimit = 200;

        private byte[] FVideoRam = new byte[cVRamSize];
        private WriteableBitmap FScreen;
        private Color FFgColor = Color.FromRgb(0xff, 0xff, 0xff);
        private Color FBgColor = Color.FromRgb(0, 0, 0);
        private Stack<int> FInvalidChars = new Stack<int>();
        private bool FAllInvalid;
        private GraMode FMode = GraMode.Text;

        public Graphics(WriteableBitmap _Screen)
        {
            FScreen = _Screen;
        }

        private Color ValueToColor(int _Value)
        {
            byte hRed, hGreen, hBlue;

            switch (_Value & 3)
            {
                case 2:
                    hRed = 85;
                    break;
                case 1:
                    hRed = 170;
                    break;
                case 3:
                    hRed = 255;
                    break;
                default:
                    hRed = 0;
                    break;
            }

            switch (_Value & 12)
            {
                case 8:
                    hGreen = 85;
                    break;
                case 4:
                    hGreen = 170;
                    break;
                case 12:
                    hGreen = 255;
                    break;
                default:
                    hGreen = 0;
                    break;
            }

            switch (_Value & 48)
            {
                case 32:
                    hBlue = 85;
                    break;
                case 16:
                    hBlue = 170;
                    break;
                case 48:
                    hBlue = 255;
                    break;
                default:
                    hBlue = 0;
                    break;
            }

            return Color.FromRgb(hRed, hGreen, hBlue);
        }

        public bool RamActive { get; set; }

        public GraMode Mode {
            get
            {
                return FMode;
            }
            set
            {
                if (value != FMode)
                {
                    FAllInvalid = true;
                    FMode = value;
                }
            }
        }

        public Color FgColor
        {
            set
            {
                FFgColor = value;
                lock (FInvalidChars)
                {
                    FAllInvalid = true;
                    FInvalidChars.Clear();
                }
            }
        }

        public Color BgColor
        {
            set
            {
                FBgColor = value;
                lock (FInvalidChars)
                {
                    FAllInvalid = true;
                    FInvalidChars.Clear();
                }
            }
        }

        public void PutChar(int _Col, int _Row, byte _Char)
        {
            int hCharIdx = _Row * cRowSize + _Col;
            FVideoRam[hCharIdx] = _Char;

            if (!FAllInvalid)
            {
                lock (FInvalidChars)
                {
                    if (FInvalidChars.Count >= cInvalidLimit)
                    {
                        FAllInvalid = true;
                        FInvalidChars.Clear();
                    }
                    else
                        FInvalidChars.Push(hCharIdx);
                }
            }
        }

        private void DrawChar(int _Col, int _Row)
        {
            if (_Col < ColCount && _Row < RowCount)
            {
                var hRect = new Int32Rect(_Col * 8, _Row * 16, 8, 16);
                var hBytesPerPixel = FScreen.Format.BitsPerPixel / 8;
                var hStride = hRect.Width * hBytesPerPixel;

                byte[] hPixels;

                if (FMode == GraMode.Text)
                {
                    hPixels = Characters.GetChar(FVideoRam[_Row * cRowSize + _Col], FFgColor, FBgColor);
                }
                else
                {
                    byte hChar = FVideoRam[_Row * cRowSize + _Col];
                    hPixels = new byte[hStride * 16];
                    for (var hIdx = 0; hIdx < 8 * 16; hIdx++)
                    {
                        int hPixelIdx = hIdx * hBytesPerPixel;
                        int hRow = hIdx / 32;
                        int hCol = (hIdx % 8) / 4;
                        int hBitPos = hRow * 2 + hCol;
                        if ((hChar & (1 << hBitPos)) > 0)
                        {
                            hPixels[hPixelIdx] = FFgColor.B;
                            hPixels[hPixelIdx + 1] = FFgColor.G;
                            hPixels[hPixelIdx + 2] = FFgColor.R;
                        }
                        else
                        {
                            hPixels[hPixelIdx] = FBgColor.B;
                            hPixels[hPixelIdx + 1] = FBgColor.G;
                            hPixels[hPixelIdx + 2] = FBgColor.R;
                        }
                    }
                }
                FScreen.WritePixels(hRect, hPixels, hStride, 0);
            }
        }

        public void UpdateScreen()
        {
            if (FAllInvalid)
            {
                lock (FInvalidChars)
                {
                    FAllInvalid = false;
                    FInvalidChars.Clear();
                }

                for (var hRow = 0; hRow < RowCount; hRow++)
                {
                    for (var hCol = 0; hCol < ColCount; hCol++)
                        DrawChar(hCol, hRow);
                }

            }
            else
            {
                lock (FInvalidChars)
                {
                    while (FInvalidChars.Count > 0)
                    {
                        var hCharIdx = FInvalidChars.Pop();
                        DrawChar(hCharIdx % cRowSize, hCharIdx / cRowSize);
                    }
                }
            }
        }

        #region IMemRangeProvider

        public bool Peek(int _Addr, out byte _Value)
        {
            _Value = 0;
            return false;
        }

        public bool Poke(int _Addr, byte _Value)
        {
            if (RamActive)
            {
                int hCharIdx = _Addr - cVRamStart;
                if (FVideoRam[hCharIdx] != _Value)
                {
                    FVideoRam[hCharIdx] = _Value;
                    if (!FAllInvalid)
                    {
                        lock (FInvalidChars)
                        {
                            if (FInvalidChars.Count >= cInvalidLimit)
                            {
                                FAllInvalid = true;
                                FInvalidChars.Clear();
                            }
                            else
                                FInvalidChars.Push(hCharIdx);
                        }
                    }
                }

                return true;
            }
            return false;
        }

        #endregion

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            switch (_Addr)
            {
                case 5:
                    BgColor = ValueToColor(_Value);
                    break;

                case 6:
                    FgColor = ValueToColor(_Value);
                    break;

                case 7:
                    RamActive = (_Value & 1) > 0;
                    if ((_Value & 2) > 0)
                        Mode = GraMode.Graphics;
                    else
                        Mode = GraMode.Text;
                    break;
            }
        }

        #endregion

    }
}