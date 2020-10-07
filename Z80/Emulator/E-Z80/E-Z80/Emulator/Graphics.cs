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

            var rect = new Int32Rect(col * Characters.CharWidth, row * Characters.CharHeight, Characters.CharWidth, Characters.CharHeight);
            var stride = rect.Width * _bytesPerPixel;

            byte[] pixels;

            var chr = _videoRam[row * RowSize + col];
            if (_mode == GraMode.Text)
                pixels = Characters.GetChar(chr, _fgColor, _bgColor);
            else
            {
                pixels = new byte[stride * Characters.CharHeight];
                for (var idx = 0; idx < Characters.CharWidth * Characters.CharHeight; idx++)
                {
                    var pixelIdx = idx * _bytesPerPixel;
                    var localRow = idx / (4 * Characters.CharWidth);
                    var localCol = (idx % Characters.CharWidth) / 4;
                    var bitPos = localRow * 2 + localCol;
                    if ((chr & (1 << bitPos)) > 0)
                    {
                        pixels[pixelIdx] = _fgColor.B;
                        pixels[pixelIdx + 1] = _fgColor.G;
                        pixels[pixelIdx + 2] = _fgColor.R;
                    }
                    else
                    {
                        pixels[pixelIdx] = _bgColor.B;
                        pixels[pixelIdx + 1] = _bgColor.G;
                        pixels[pixelIdx + 2] = _bgColor.R;
                    }
                }
            }
            return new WritePixelsInfo { Pixels = pixels, Rect = rect, Stride = stride };
        }

        //public void PutChar(int _Col, int _Row, byte _Char)
        //{
        //    var charIdx = _Row * cRowSize + _Col;
        //    _videoRam[charIdx] = _Char;

        //    if (_allInvalid) return;

        //    lock (_invalidCharPositions)
        //    {
        //        if (!_allInvalid)
        //        {
        //            if (_invalidCharPositions.Count >= cInvalidLimit)
        //            {
        //                _allInvalid = true;
        //                _invalidCharPositions.Clear();
        //            }
        //            else
        //                _invalidCharPositions.Add(hCharIdx);
        //        }
        //    }
        //}

        public void UpdateScreen()
        {
            WritePixelsInfo[] writePixelsInfos;

            Monitor.Enter(_invalidCharPositions);
            if (_allInvalid)
            {
                _allInvalid = false;
                _invalidCharPositions.Clear();
                Monitor.Exit(_invalidCharPositions);

                writePixelsInfos = new WritePixelsInfo[RowCount * ColCount];
                Parallel.For(
                    0,
                    RowCount,
                    row =>
                    {
                        for (var col = 0; col < ColCount; col++)
                        {
                            var info = PrepareDrawChar(col, row);
                            if (info != null)
                                writePixelsInfos[row * ColCount + col] = info;
                        }
                    });
            }
            else
            {
                var charIndices = _invalidCharPositions.ToArray();
                _invalidCharPositions.Clear();
                Monitor.Exit(_invalidCharPositions);

                writePixelsInfos = new WritePixelsInfo[charIndices.Length];

                Parallel.For(
                    0,
                    charIndices.Length,
                    idx =>
                    {
                        var charIdx = charIndices[idx];
                        var info = PrepareDrawChar(charIdx % RowSize, charIdx / RowSize);
                        if (info != null)
                            writePixelsInfos[idx] = info;
                    });

            }

            foreach (var info in writePixelsInfos.Where(pixelInfo => pixelInfo != null))
                _screen.WritePixels(info.Rect, info.Pixels, info.Stride, 0);
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

            var charIdx = addr - VRamStart;
            if (_videoRam[charIdx] != value)
            {
                _videoRam[charIdx] = value;

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
                            _invalidCharPositions.Add(charIdx);
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