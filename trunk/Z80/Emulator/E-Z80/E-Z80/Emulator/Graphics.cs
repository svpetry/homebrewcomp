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
        private const int cVRamStart = 0x1000;
        private const int cVRamSize = 0x1000;
        private const int cRowSize = 128;
        private const int cInvalidLimit = 200;

        private const int cScreenWidth = 640;
        private const int cScreenHeight = 400;
        public static int RowCount = 25;
        public static int ColCount = 80;

        private readonly byte[] FVideoRam = new byte[cVRamSize];
        private readonly WriteableBitmap FScreen;
        private readonly int FBytesPerPixel;
        private Color FFgColor = Color.FromRgb(0xff, 0xff, 0xff);
        private Color FBgColor = Color.FromRgb(0, 0, 0);
        private readonly HashSet<int> FInvalidCharPositions = new HashSet<int>();
        private bool FAllInvalid;
        private GraMode FMode = GraMode.Text;

        public Graphics()
        {
            FScreen = new WriteableBitmap(cScreenWidth, cScreenHeight, 96, 96, PixelFormats.Bgr32, null);
            FBytesPerPixel = FScreen.Format.BitsPerPixel /  8;
        }

        public bool RamActive { get; private set; }

        public GraMode Mode
        {
            get
            {
                return FMode;
            }
            set
            {
                if (value == FMode) return;
                SetAllInvalid();
                FMode = value;
            }
        }

        public Color FgColor
        {
            set
            {
                FFgColor = value;
                SetAllInvalid();
            }
        }

        public Color BgColor
        {
            set
            {
                FBgColor = value;
                SetAllInvalid();
            }
        }

        public WriteableBitmap Screen
        {
            get
            {
                return FScreen;
            }
        }

        private void SetAllInvalid()
        {
            lock (FInvalidCharPositions)
            {
                FAllInvalid = true;
                FInvalidCharPositions.Clear();
            }
        }

        private static Color ValueToColor(int _Value)
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

        private WritePixelsInfo PrepareDrawChar(int _Col, int _Row)
        {
            if (_Col >= ColCount || _Row >= RowCount) return null;

            var hRect = new Int32Rect(_Col * Characters.CharWidth, _Row * Characters.CharHeight, Characters.CharWidth, Characters.CharHeight);
            var hStride = hRect.Width * FBytesPerPixel;

            byte[] hPixels;

            var hChar = FVideoRam[_Row * cRowSize + _Col];
            if (FMode == GraMode.Text)
                hPixels = Characters.GetChar(hChar, FFgColor, FBgColor);
            else
            {
                hPixels = new byte[hStride * Characters.CharHeight];
                for (var hIdx = 0; hIdx < Characters.CharWidth * Characters.CharHeight; hIdx++)
                {
                    var hPixelIdx = hIdx * FBytesPerPixel;
                    var hRow = hIdx / (4 * Characters.CharWidth);
                    var hCol = (hIdx % Characters.CharWidth) / 4;
                    var hBitPos = hRow * 2 + hCol;
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
            return new WritePixelsInfo { Pixels = hPixels, Rect = hRect, Stride = hStride };
        }

        //public void PutChar(int _Col, int _Row, byte _Char)
        //{
        //    var hCharIdx = _Row * cRowSize + _Col;
        //    FVideoRam[hCharIdx] = _Char;

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

            Monitor.Enter(FInvalidCharPositions);
            if (FAllInvalid)
            {
                FAllInvalid = false;
                FInvalidCharPositions.Clear();
                Monitor.Exit(FInvalidCharPositions);

                hWritePixelsInfos = new WritePixelsInfo[RowCount * ColCount];
                Parallel.For(
                    0,
                    RowCount,
                    _Row =>
                    {
                        for (var hCol = 0; hCol < ColCount; hCol++)
                        {
                            var hWritePixelsInfo = PrepareDrawChar(hCol, _Row);
                            if (hWritePixelsInfo != null)
                                hWritePixelsInfos[_Row * ColCount + hCol] = hWritePixelsInfo;
                        }
                    });
            }
            else
            {
                var hCharIndices = FInvalidCharPositions.ToArray();
                FInvalidCharPositions.Clear();
                Monitor.Exit(FInvalidCharPositions);

                hWritePixelsInfos = new WritePixelsInfo[hCharIndices.Length];

                Parallel.For(
                    0,
                    hCharIndices.Length,
                    _Idx =>
                    {
                        var hCharIdx = hCharIndices[_Idx];
                        var hWritePixelsInfo = PrepareDrawChar(hCharIdx % cRowSize, hCharIdx / cRowSize);
                        if (hWritePixelsInfo != null)
                            hWritePixelsInfos[_Idx] = hWritePixelsInfo;
                    });

            }

            foreach (var hWritePixelsInfo in hWritePixelsInfos.Where(_PixelInfo => _PixelInfo != null))
                FScreen.WritePixels(hWritePixelsInfo.Rect, hWritePixelsInfo.Pixels, hWritePixelsInfo.Stride, 0);
        }

        #region IMemRangeProvider

        public bool Peek(int _Addr, out byte _Value)
        {
            _Value = 0;
            return false;
        }

        public bool Poke(int _Addr, byte _Value)
        {
            if (!RamActive) return false;

            var hCharIdx = _Addr - cVRamStart;
            if (FVideoRam[hCharIdx] != _Value)
            {
                FVideoRam[hCharIdx] = _Value;

                if (FAllInvalid) return true;

                lock (FInvalidCharPositions)
                {
                    if (!FAllInvalid)
                    {
                        if (FInvalidCharPositions.Count >= cInvalidLimit)
                        {
                            FAllInvalid = true;
                            FInvalidCharPositions.Clear();
                        }
                        else
                            FInvalidCharPositions.Add(hCharIdx);
                    }
                }
            }

            return true;
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
                    Mode = (_Value & 2) > 0 ? GraMode.Graphics : GraMode.Text;
                    break;
            }
        }

        #endregion
    }
}