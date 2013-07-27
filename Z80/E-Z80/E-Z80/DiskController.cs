using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E_Z80
{
    internal class MemAccess
    {
        private IMemoryProvider FMemory;

        private const int cAddrBusy = 0x0044;
        private const int cAddrSparam = 0x0060;
        private const int cAddrOutparam = 0x0055;
        private const int cAddrParam1b = 0x0051;
        private const int cAddrParam1w = 0x0051;
        private const int cAddrParam1l = 0x0051;
        private const int cAddrParam2 = 0x0053;
        private const int cAddrProgram = 0x0280;
        private const int cAddBuffer = 0x0080;

        public MemAccess(IMemoryProvider _Memory)
        {
            FMemory = _Memory;
        }

        public string sparam
        {
            get
            {
                string hStr = "";
                for (int hIdx = 0; hIdx < 0x20; hIdx++)
                {
                    byte hChar = (byte)FMemory.Peek(cAddrSparam + hIdx);
                    if (hChar == 0)
                        break;
                    else
                        hStr = hStr + (char)hChar;
                }

                return hStr;
            }

            set
            {
                var hStr = value;
                if (hStr.Length > 0x1f)
                    hStr = hStr.Substring(0, 0x1f);
                int hIdx = 0;
                foreach (char cChar in hStr)
                {
                    FMemory.Poke(cAddrSparam + hIdx, (byte)cChar);
                    hIdx++;
                }
                FMemory.Poke(cAddrSparam + hIdx, 0);
            }
        }

        public byte busy
        {
            set
            {
                FMemory.Poke(cAddrBusy, value);
            }
        }

        public byte param1b
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

        public int param1w
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

        public uint param1l
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

        public int outparam
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
            byte[] hResult = new byte[_Size];
            for (var hIdx = 0; hIdx < _Size; hIdx++)
                hResult[hIdx] = (byte)FMemory.Peek(cAddBuffer + hIdx);
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
        private MemAccess FMemAccess;
        private Action FResetCpu;
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
                byte[] hBytes = File.ReadAllBytes(hFileName);

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
            var hFileName = Path.Combine(FDirName, FMemAccess.sparam);
            if (File.Exists(hFileName))
            {
                FFilePos = 0;
                FFileContent = File.ReadAllBytes(hFileName);
                FMemAccess.param1l = (uint)FFileContent.Length;
                FMemAccess.outparam = 1;
            }
            else
                FMemAccess.outparam = 0;
            
            ResetStatus();
        }

        private void WriteNewFile()
        {
            var hFileName = Path.Combine(FDirName, FMemAccess.sparam);
            if (!File.Exists(hFileName))
            {
                FSaveFileName = hFileName;
                FStatus = 1;
                FWriteMode = WriteMode.CreateNew;
            }
            else
                FStatus = 0;
        }

        private void AppendFile()
        {
            var hFileName = Path.Combine(FDirName, FMemAccess.sparam);
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
                    int hSize = (int)FMemAccess.param1l;
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
            FMemAccess.sparam = _FileName.ToUpper();
            var hFileInfo = new FileInfo(Path.Combine(FDirName, _FileName));
            FMemAccess.param1l = (uint)hFileInfo.Length;
            
            int hAttributes = 0;
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
            FMemAccess.outparam = hAttributes;
        }

        #region IPortProvider

        public int InB(int _Addr, int _Hi)
        {
            FMemAccess.busy = 1;
            switch (_Addr)
            {
                case 161: // disk status (1 = OK)
                    return FDirName != "" ? FStatus : 0;

                case 163:
                    return ReadByteFromFile();
            }
            FMemAccess.busy = 0;
            return 0;
        }

        public void OutB(int _Addr, int _Value, int _State)
        {
            FMemAccess.busy = 1;
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
                            FMemAccess.sparam = "";
                        FDirFileIdx = 1;
                        ResetStatus();
                        break;
                        
                    case 11: // read next dir entry
                        if (FDirFileIdx < FDirFiles.Length)
                            SetDirInfo(FDirFiles[FDirFileIdx++]);
                        else
                            FMemAccess.sparam = "";
                        ResetStatus();
                        break;

                    case 20: // open file for reading (sparam: file name, outparam: 1=ok, paramdword: file size)
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
                            FMemAccess.sparam = hSegments[hSegments.Length - 2].ToUpper();
                        else
                            FMemAccess.sparam = "";
                        ResetStatus();
                        break;

                    case 27: // load program
                        LoadProgram(FMemAccess.sparam);
                        break;

                    case 28: // delete file (outparam: 1=file deleted)
                        var hFileName = Path.Combine(FDirName, FMemAccess.sparam);
                        if (File.Exists(hFileName))
                        {
                            File.Delete(hFileName);
                            FMemAccess.outparam = 1;
                        }
                        else
                            FMemAccess.outparam = 0;
                        ResetStatus();
                        break;

                    case 29: // check if file exists (outparam: 1=yes)
                        FMemAccess.outparam = File.Exists(Path.Combine(FDirName, FMemAccess.sparam)) ? 1 : 0;
                        ResetStatus();
                        break;
                }
            }
            FMemAccess.busy = 0;
        }

        #endregion
    }
}
