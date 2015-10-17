using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace E_Z80.Emulator
{
    internal enum GraMode
    {
        Text,
        Graphics
    };

    internal class WritePixelsInfo
    {
        public Int32Rect Rect { get; set; }
        public byte[] Pixels { get; set; }
        public int Stride { get; set; }
    }

    internal class Graphics : IMemRangeProvider, IPortProvider
    {
        private const int VRamStart = 0x1000;
        private const int VRamSize = 0x1000;
        private const int RowSize = 128;
        private const int InvalidLimit = 200;

        private const int ScreenWidth = 640;
        private const int ScreenHeight = 400;
        public static int RowCount = 25;
        public static int ColCount = 80;

        private readonly byte[] _videoRam = new byte[VRamSize];
        private readonly WriteableBitmap _screen;
        private readonly int _bytesPerPixel;
        private Color _fgColor = Color.FromRgb(0xff, 0xff, 0xff);
        private Color _bgColor = Color.FromRgb(0, 0, 0);
        private readonly HashSet<int> _invalidCharPositions = new HashSet<int>();
        private bool _allInvalid;
        private GraMode _mode = GraMode.Text;

        public Graphics()
        {
            _screen = new WriteableBitmap(ScreenWidth, ScreenHeight, 96, 96, PixelFormats.Bgr32, null);
            _bytesPerPixel = _screen.Format.BitsPerPixel /  8;
        }

        public bool RamActive { get; private set; }

        public GraMode Mode
        {
            get
            {
                return _mode;
            }
            set
            {
                if (value == _mode) return;
                SetAllInvalid();
                _mode = value;
            }
        }

        public Color FgColor
        {
            set
            {
                _fgColor = value;
                SetAllInvalid();
            }
        }

        public Color BgColor
        {
            set
            {
                _bgColor = value;
                SetAllInvalid();
            }
        }

        public WriteableBitmap Screen => _screen;

        private void SetAllInvalid()
        {
            lock (_invalidCharPositions)
            {
                _allInvalid = true;
                _invalidCharPositions.Clear();
            }
        }

        private static Color ValueToColor(int value)
        {
            byte hRed, hGreen, hBlue;

            switch (value & 3)
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

            switch (value & 12)
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

            switch (value & 48)
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

        private WritePixelsInfo PrepareDrawChar(int col, int row)
        {
            if (col >= ColCount || row >= RowCount) return null;

            var hRect = new Int32Rect(col * Characters.CharWidth, row * Characters.CharHeight, Characters.CharWidth, Characters.CharHeight);
            var hStride = hRect.Width * _bytesPerPixel;

            byte[] hPixels;

            var hChar = _videoRam[row * RowSize + col];
            if (_mode == GraMode.Text)
                hPixels = Characters.GetChar(hChar, _fgColor, _bgColor);
            else
            {
                hPixels = new byte[hStride * Characters.CharHeight];
                for (var hIdx = 0; hIdx < Characters.CharWidth * Characters.CharHeight; hIdx++)
                {
                    var hPixelIdx = hIdx * _bytesPerPixel;
                    var hRow = hIdx / (4 * Characters.CharWidth);
                    var hCol = (hIdx % Characters.CharWidth) / 4;
                    var hBitPos = hRow * 2 + hCol;
                    if ((hChar & (1 << hBitPos)) > 0)
                    {
                        hPixels[hPixelIdx] = _fgColor.B;
                        hPixels[hPixelIdx + 1] = _fgColor.G;
                        hPixels[hPixelIdx + 2] = _fgColor.R;
                    }
                    else
                    {
                        hPixels[hPixelIdx] = _bgColor.B;
                        hPixels[hPixelIdx + 1] = _bgColor.G;
                        hPixels[hPixelIdx + 2] = _bgColor.R;
                    }
                }
            }
            return new WritePixelsInfo { Pixels = hPixels, Rect = hRect, Stride = hStride };
        }

        //public void PutChar(int _Col, int _Row, byte _Char)
        //{
        //    var hCharIdx = _Row * cRowSize + _Col;
        //    _videoRam[hCharIdx] = _Char;

        //    if (FAllInvalid) return;

        //    lock (FInvalidCharPositions)
        //    {
        //        if (!FAllInvalid)
        //        {
        //            if (FInvalidCharPositions.Count >= cInvalidLimit)
        //            {
        //                FAllInvalid = true;
        //                FInvalidCharPositions.Clear();
        //            }
        //            else
        //                FInvalidCharPositions.Add(hCharIdx);
        //        }
        //    }
        //}

        public void UpdateScreen()
        {
            WritePixelsInfo[] hWritePixelsInfos;

            Monitor.Enter(_invalidCharPositions);
            if (_allInvalid)
            {
                _allInvalid = false;
                _invalidCharPositions.Clear();
                Monitor.Exit(_invalidCharPositions);

                hWritePixelsInfos = new WritePixelsInfo[RowCount * ColCount];
                Parallel.For(
                    0,
                    RowCount,
                    row =>
                    {
                        for (var hCol = 0; hCol < ColCount; hCol++)
                        {
                            var hWritePixelsInfo = PrepareDrawChar(hCol, row);
                            if (hWritePixelsInfo != null)
                                hWritePixelsInfos[row * ColCount + hCol] = hWritePixelsInfo;
                        }
                    });
            }
            else
            {
                var hCharIndices = _invalidCharPositions.ToArray();
                _invalidCharPositions.Clear();
                Monitor.Exit(_invalidCharPositions);

                hWritePixelsInfos = new WritePixelsInfo[hCharIndices.Length];

                Parallel.For(
                    0,
                    hCharIndices.Length,
                    idx =>
                    {
                        var hCharIdx = hCharIndices[idx];
                        var hWritePixelsInfo = PrepareDrawChar(hCharIdx % RowSize, hCharIdx / RowSize);
                        if (hWritePixelsInfo != null)
                            hWritePixelsInfos[idx] = hWritePixelsInfo;
                    });

            }

            foreach (var hWritePixelsInfo in hWritePixelsInfos.Where(pixelInfo => pixelInfo != null))
                _screen.WritePixels(hWritePixelsInfo.Rect, hWritePixelsInfo.Pixels, hWritePixelsInfo.Stride, 0);
        }

        #region IMemRangeProvider

        public bool Peek(int addr, out byte value)
        {
            value = 0;
            return false;
        }

        public bool Poke(int addr, byte value)
        {
            if (!RamActive) return false;

            var hCharIdx = addr - VRamStart;
            if (_videoRam[hCharIdx] != value)
            {
                _videoRam[hCharIdx] = value;

                if (_allInvalid) return true;

                lock (_invalidCharPositions)
                {
                    if (!_allInvalid)
                    {
                        if (_invalidCharPositions.Count >= InvalidLimit)
                        {
                            _allInvalid = true;
                            _invalidCharPositions.Clear();
                        }
                        else
                            _invalidCharPositions.Add(hCharIdx);
                    }
                }
            }

            return true;
        }

        #endregion

        #region IPortProvider

        public int InB(int addr, int hi)
        {
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
            switch (addr)
            {
                case 5:
                    BgColor = ValueToColor(value);
                    break;

                case 6:
                    FgColor = ValueToColor(value);
                    break;

                case 7:
                    RamActive = (value & 1) > 0;
                    Mode = (value & 2) > 0 ? GraMode.Graphics : GraMode.Text;
                    break;
            }
        }

        #endregion
    }
}