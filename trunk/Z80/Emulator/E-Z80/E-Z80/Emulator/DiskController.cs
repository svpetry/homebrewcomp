using System;
using System.IO;
using System.Linq;

namespace E_Z80.Emulator
{
    internal class MemAccess
    {
        private readonly IMemoryProvider FMemory;

        private const int cAddrBusy = 0x0044;
        private const int cAddrParam1b = 0x0051;
        private const int cAddrParam1w = 0x0051;
        private const int cAddrParam1l = 0x0051;
        private const int cAddrParam2 = 0x0053;
        private const int cAddrOutparam = 0x0055;
        private const int cAddrSparam = 0x0060;
        private const int cAddrBuffer = 0x0080; // size of buffer: 512 bytes
        private const int cAddrProgram = 0x0280;

        public MemAccess(IMemoryProvider _Memory)
        {
            FMemory = _Memory;
        }

        public string Sparam
        {
            get
            {
                var hStr = "";
                for (var hIdx = 0; hIdx < 0x20; hIdx++)
                {
                    var hChar = (byte)FMemory.Peek(cAddrSparam + hIdx);
                    if (hChar == 0)
                        break;
                    hStr += (char)hChar;
                }

                return hStr;
            }

            set
            {
                var hStr = value;
                if (hStr.Length > 0x1f)
                    hStr = hStr.Substring(0, 0x1f);
                var hIdx = 0;
                foreach (var hChar in hStr)
                {
                    FMemory.Poke(cAddrSparam + hIdx, (byte)hChar);
                    hIdx++;
                }
                FMemory.Poke(cAddrSparam + hIdx, 0);
            }
        }

        public byte Busy
        {
            set
            {
                FMemory.Poke(cAddrBusy, value);
            }
        }

        public byte Param1B
        {
            get
            {
                return (byte)FMemory.Peek(cAddrParam1b);
            }
            set
            {
                FMemory.Poke(cAddrParam1b, value);
            }
        }

        public int Param1W
        {
            get
            {
                return (FMemory.Peek(cAddrParam1w) << 8) + FMemory.Peek(cAddrParam1w + 1);
            }
            set
            {
                FMemory.Poke(cAddrParam1w, (value & 0xff00) >> 8);
                FMemory.Poke(cAddrParam1w + 1, value & 0xff);
            }
        }

        public uint Param1L
        {
            get
            {
                return ((uint)FMemory.Peek(cAddrParam1l)) + (((uint)FMemory.Peek(cAddrParam1l + 1)) << 8) +
                    (((uint)FMemory.Peek(cAddrParam1l + 2)) << 16) + ((uint)FMemory.Peek(cAddrParam1l + 3) << 24);
            }
            set
            {
                FMemory.Poke(cAddrParam1l, (byte)(value & 0xff));
                FMemory.Poke(cAddrParam1l + 1, (byte)((value & 0xff00) >> 8));
                FMemory.Poke(cAddrParam1l + 2, (byte)((value & 0xff0000) >> 16));
                FMemory.Poke(cAddrParam1l + 3, (byte)((value & 0xff000000) >> 24));
            }
        }

        public int Outparam
        {
            set
            {
                FMemory.Poke(cAddrOutparam, value & 0xff);
                FMemory.Poke(cAddrOutparam + 1, (value & 0xff00) >> 8);
            }
        }

        public void Load(byte[] _Data, int _Addr)
        {
            for (var hIdx = 0; hIdx < _Data.Length; hIdx++)
                FMemory.Poke(_Addr + hIdx, _Data[hIdx]);
        }

        public byte[] ReadBuffer(int _Size)
        {
            var hResult = new byte[_Size];
            for (var hIdx = 0; hIdx < _Size; hIdx++)
                hResult[hIdx] = (byte)FMemory.Peek(cAddrBuffer + hIdx);
            return hResult;
        }
    }

    enum WriteMode
    {
        None,
        CreateNew,
        Append
    }

    class DiskController : IPortProvider
    {
        private string FDirName = "";
        private readonly MemAccess FMemAccess;
        private readonly Action FResetCpu;
        private int FStatus = 1;

        private string[] FDirFiles;
        private int FDirFileIdx;

        private byte[] FFileContent;
        private int FFilePos;
        
        private string FSaveFileName;
        private WriteMode FWriteMode = WriteMode.None;

        public static string BiosFile = "bios.bin";

        public DiskController(IMemoryProvider _Memory, Action _ResetCpu)
        {
            FMemAccess = new MemAccess(_Memory);
            FResetCpu = _ResetCpu;
        }

        public string DirName
        {
            set
            {
                FDirName = value;
            }
            get
            {
                return FDirName;
            }
        }

        public void LoadProgram(string _FileName)
        {
            var hFileName = Path.Combine(FDirName, _FileName);
            if (File.Exists(hFileName))
            {
                var hBytes = File.ReadAllBytes(hFileName);

                if (_FileName == BiosFile)
                    FMemAccess.Load(hBytes, 0x0000);
                else
                    FMemAccess.Load(hBytes, 0x0280);

                FResetCpu();

                ResetStatus();
            }
            else
                FStatus = 0;
        }

        private void ResetStatus()
        {
            FStatus = 1;
            FWriteMode = WriteMode.None;
            FSaveFileName = "";
        }

        private int ReadByteFromFile()
        {
            if (FFilePos < FFileContent.Length)
                return FFileContent[FFilePos++];
            return 0;
        }

        private void LoadFile()
        {
            var hFileName = Path.Combine(FDirName, FMemAccess.Sparam);
            if (File.Exists(hFileName))
            {
                FFilePos = 0;
                FFileContent = File.ReadAllBytes(hFileName);
                FMemAccess.Param1L = (uint)FFileContent.Length;
                FMemAccess.Outparam = 1;
            }
            else
                FMemAccess.Outparam = 0;
            
            ResetStatus();
        }

        private void WriteNewFile()
        {
            var hFileName = Path.Combine(FDirName, FMemAccess.Sparam);

            // overwrite existing file
            if (File.Exists(hFileName))
                File.Delete(hFileName);

            FSaveFileName = hFileName;
            FStatus = 1;
            FWriteMode = WriteMode.CreateNew;
        }

        private void AppendFile()
        {
            var hFileName = Path.Combine(FDirName, FMemAccess.Sparam);
            if (File.Exists(hFileName))
            {
                FSaveFileName = hFileName;
                FStatus = 1;
                FWriteMode = WriteMode.Append;
            }
            else
                FStatus = 0;
        }

        private void WriteBlock()
        {
            try
            {
                if (FSaveFileName != "")
                {
                    int hSize = (int)FMemAccess.Param1L;
                    if (FWriteMode == WriteMode.CreateNew && !File.Exists(FSaveFileName))
                    {
                        File.WriteAllBytes(FSaveFileName, FMemAccess.ReadBuffer(hSize));
                    }
                    else
                    {
                        FileStream hFileStream = File.Open(FSaveFileName, FileMode.Append);
                        hFileStream.Write(FMemAccess.ReadBuffer(hSize), 0, hSize);
                    }
                    FStatus = 1;
                }
                else
                    FStatus = 0;
            }
            catch (Exception)
            {
                FStatus = 0;
            }
        }

        private void SetDirInfo(string _FileName)
        {
            FMemAccess.Sparam = _FileName.ToUpper();
            var hFileInfo = new FileInfo(Path.Combine(FDirName, _FileName));
            FMemAccess.Param1L = (uint)hFileInfo.Length;
            
            var hAttributes = 0;
            if (hFileInfo.Attributes.HasFlag(FileAttributes.ReadOnly))
                hAttributes += 1;
            if (hFileInfo.Attributes.HasFlag(FileAttributes.Hidden))
                hAttributes += 2;
            if (hFileInfo.Attributes.HasFlag(FileAttributes.System))
                hAttributes += 4;
            if (hFileInfo.Attributes.HasFlag(FileAttributes.Directory))
                hAttributes += 16;
            if (hFileInfo.Attributes.HasFlag(FileAttributes.Archive))
                hAttributes += 32;
            FMemAccess.Outparam = hAttributes;
        }

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            FMemAccess.Busy = 1;
            switch (_Addr)
            {
                case 161: // disk status (1 = OK)
                    return FDirName != "" ? FStatus : 0;

                case 163:
                    return ReadByteFromFile();
            }
            FMemAccess.Busy = 0;
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            FMemAccess.Busy = 1;
            if (_Addr == 160)
            {
                switch (_Value)
                {
                    case 0: // init mmc
                        ResetStatus();
                        break;

                    case 1: // read sector
                        break;

                    case 2: // write sector
                        break;

                    case 10: // read first dir entry
                        FDirFiles = Directory.GetFiles(FDirName).Select(_Path => Path.GetFileName(_Path)).ToArray();
                        if (FDirFiles.Length > 0)
                            SetDirInfo(FDirFiles[0]);
                        else
                            FMemAccess.Sparam = "";
                        FDirFileIdx = 1;
                        ResetStatus();
                        break;
                        
                    case 11: // read next dir entry
                        if (FDirFileIdx < FDirFiles.Length)
                            SetDirInfo(FDirFiles[FDirFileIdx++]);
                        else
                            FMemAccess.Sparam = "";
                        ResetStatus();
                        break;

                    case 20: // open file for reading (sparam: file name, outparam: 1=ok, param1l: file size)
                        LoadFile();
                        break;

                    case 21: // open file for writing (create new)
                        WriteNewFile();
                        break;

                    case 22: // open file for writing (append)
                        AppendFile();
                        break;

                    case 23: // read block
                        break;

                    case 24: // write block (param1: size in bytes)
                        WriteBlock();
                        break;

                    case 25: // load complete file into memory
                        break;

                    case 26: // read volume name
                        var hSegments = FDirName.Split(Path.DirectorySeparatorChar);
                        if (hSegments.Length > 1)
                            FMemAccess.Sparam = hSegments[hSegments.Length - 2].ToUpper();
                        else
                            FMemAccess.Sparam = "";
                        ResetStatus();
                        break;

                    case 27: // load program
                        LoadProgram(FMemAccess.Sparam);
                        break;

                    case 28: // delete file (outparam: 1=file deleted)
                        var hFileName = Path.Combine(FDirName, FMemAccess.Sparam);
                        if (File.Exists(hFileName))
                        {
                            File.Delete(hFileName);
                            FMemAccess.Outparam = 1;
                        }
                        else
                            FMemAccess.Outparam = 0;
                        ResetStatus();
                        break;

                    case 29: // check if file exists (outparam: 1=yes)
                        FMemAccess.Outparam = File.Exists(Path.Combine(FDirName, FMemAccess.Sparam)) ? 1 : 0;
                        ResetStatus();
                        break;
                }
            }
            FMemAccess.Busy = 0;
        }

        #endregion
    }
}
