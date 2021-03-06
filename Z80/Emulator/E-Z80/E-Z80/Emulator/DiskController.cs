﻿using System;
using System.IO;
using System.Linq;

namespace E_Z80.Emulator
{
    internal class MemAccess
    {
        private readonly IMemoryProvider _memory;

        private const int AddrBusy = 0x0044;
        private const int AddrParam1B = 0x0051;
        private const int AddrParam1W = 0x0051;
        private const int AddrParam1L = 0x0051;
        private const int AddrParam2 = 0x0053;
        private const int AddrOutparam = 0x0055;
        private const int AddrSparam = 0x0080;
        private const int AddrBuffer = 0x0080; // size of buffer: 512 bytes
        private const int AddrProgram = 0x0280;

        public MemAccess(IMemoryProvider memory)
        {
            _memory = memory;
        }

        public string Sparam
        {
            get
            {
                var str = "";
                for (var idx = 0; idx < 0x20; idx++)
                {
                    var chr = (byte)_memory.Peek(AddrSparam + idx);
                    if (chr == 0)
                        break;
                    str += (char)chr;
                }

                return str;
            }

            set
            {
                var str = value;
                if (str.Length > 0x1f)
                    str = str.Substring(0, 0x1f);
                var idx = 0;
                foreach (var chr in str)
                {
                    _memory.Poke(AddrSparam + idx, chr);
                    idx++;
                }
                _memory.Poke(AddrSparam + idx, 0);
            }
        }

        public byte Busy
        {
            set
            {
                _memory.Poke(AddrBusy, value);
            }
        }

        public byte Param1B
        {
            get
            {
                return (byte)_memory.Peek(AddrParam1B);
            }
            set
            {
                _memory.Poke(AddrParam1B, value);
            }
        }

        public ushort Param1W
        {
            get
            {
                return (ushort)(_memory.Peek(AddrParam1W) + (_memory.Peek(AddrParam1W + 1) << 8));
            }
            set
            {
                _memory.Poke(AddrParam1W, value & 0xff);
                _memory.Poke(AddrParam1W + 1, (value & 0xff00) >> 8);
            }
        }

        public uint Param1L
        {
            get
            {
                return ((uint)_memory.Peek(AddrParam1L)) + (((uint)_memory.Peek(AddrParam1L + 1)) << 8) +
                    (((uint)_memory.Peek(AddrParam1L + 2)) << 16) + ((uint)_memory.Peek(AddrParam1L + 3) << 24);
            }
            set
            {
                _memory.Poke(AddrParam1L, (byte)(value & 0xff));
                _memory.Poke(AddrParam1L + 1, (byte)((value & 0xff00) >> 8));
                _memory.Poke(AddrParam1L + 2, (byte)((value & 0xff0000) >> 16));
                _memory.Poke(AddrParam1L + 3, (byte)((value & 0xff000000) >> 24));
            }
        }

        public int Outparam
        {
            set
            {
                _memory.Poke(AddrOutparam, value & 0xff);
                _memory.Poke(AddrOutparam + 1, (value & 0xff00) >> 8);
            }
        }

        public void Load(byte[] data, int addr)
        {
            for (var idx = 0; idx < data.Length; idx++)
                _memory.Poke(addr++, data[idx]);
        }

        public byte[] ReadBuffer(int size)
        {
            var result = new byte[size];
            for (var idx = 0; idx < size; idx++)
                result[idx] = (byte)_memory.Peek(AddrBuffer + idx);
            return result;
        }

        public void WriteByteToBuffer(int offset, byte data)
        {
            _memory.Poke(AddrBuffer + offset, data);
        }
    }

    enum AccessMode
    {
        None,
        Read,
        CreateNew,
        Append
    }

    class DiskController : IPortProvider
    {
        private string _dirName = "";
        private readonly MemAccess _memAccess;
        private readonly Action _resetCpu;
        private int _status = 1;

        private string[] _dirFiles;
        private int _dirFileIdx;

        private byte[] _fileContent;
        private int _filePos;
        
        private string _saveFileName;
        private AccessMode _accessMode = AccessMode.None;

        public static string BiosFile = "bios.bin";

        public DiskController(IMemoryProvider memory, Action resetCpu)
        {
            _memAccess = new MemAccess(memory);
            _resetCpu = resetCpu;
        }

        public string DirName
        {
            set
            {
                _dirName = value;
            }
            get
            {
                return _dirName;
            }
        }

        public void LoadFileIntoMemory(string fileName, int address)
        {
            var filePath = Path.Combine(_dirName, fileName);
            if (File.Exists(filePath))
            {
                var bytes = File.ReadAllBytes(filePath);
                _memAccess.Load(bytes, address);

                ResetStatus();
            }
            else
                _status = 0;
        }

        private void ResetStatus()
        {
            _status = 1;
            _accessMode = AccessMode.None;
            _saveFileName = "";
        }

        private void ReadFile()
        {
            var filePath = Path.Combine(_dirName, _memAccess.Sparam);
            if (File.Exists(filePath))
            {
                _filePos = 0;
                _fileContent = File.ReadAllBytes(filePath);
                _memAccess.Param1L = (uint)_fileContent.Length;
                _memAccess.Outparam = 1;
                _status = 1;
                _accessMode = AccessMode.Read;
            }
            else
            {
                _accessMode = AccessMode.None;
                _memAccess.Outparam = 0;
                _status = 0;
            }
        }

        private void WriteNewFile()
        {
            var filePath = Path.Combine(_dirName, _memAccess.Sparam);

            // overwrite existing file
            if (File.Exists(filePath))
                File.Delete(filePath);

            _saveFileName = filePath;
            _status = 1;
            _accessMode = AccessMode.CreateNew;
        }

        private void AppendFile()
        {
            var filePath = Path.Combine(_dirName, _memAccess.Sparam);
            if (File.Exists(filePath))
            {
                _saveFileName = filePath;
                _status = 1;
                _accessMode = AccessMode.Append;
            }
            else
            {
                _status = 0;
                _accessMode = AccessMode.None;
            }
        }

        private byte ReadByteFromFile()
        {
            if (_filePos < _fileContent.Length)
                return _fileContent[_filePos++];
            return 0;
        }

        private void ReadBlock()
        {
            try
            {
                if (_accessMode == AccessMode.Read)
                {
                    for (var idx = 0; idx < 512 && _filePos < _fileContent.Length; idx++)
                        _memAccess.WriteByteToBuffer(idx, _fileContent[_filePos++]);
                    _status = 1;
                }
                else
                    _status = 0;
            }
            catch (Exception)
            {
                _status = 0;
            }
        }

        private void WriteBlock()
        {
            try
            {
                if (_saveFileName != "" && (_accessMode == AccessMode.Append || _accessMode == AccessMode.CreateNew))
                {
                    int size = (int)_memAccess.Param1L;
                    if (_accessMode == AccessMode.CreateNew)
                        File.WriteAllBytes(_saveFileName, _memAccess.ReadBuffer(size));
                    else
                    {
                        FileStream hFileStream = File.Open(_saveFileName, FileMode.Append);
                        hFileStream.Write(_memAccess.ReadBuffer(size), 0, size);
                    }
                    _status = 1;
                }
                else
                    _status = 0;
            }
            catch (Exception)
            {
                _status = 0;
            }
        }

        private void SetDirInfo(string fileName)
        {
            _memAccess.Sparam = fileName.ToUpper();
            var fileInfo = new FileInfo(Path.Combine(_dirName, fileName));
            _memAccess.Param1L = (uint)fileInfo.Length;
            
            var attributes = 0;
            if (fileInfo.Attributes.HasFlag(FileAttributes.ReadOnly))
                attributes += 1;
            if (fileInfo.Attributes.HasFlag(FileAttributes.Hidden))
                attributes += 2;
            if (fileInfo.Attributes.HasFlag(FileAttributes.System))
                attributes += 4;
            if (fileInfo.Attributes.HasFlag(FileAttributes.Directory))
                attributes += 16;
            if (fileInfo.Attributes.HasFlag(FileAttributes.Archive))
                attributes += 32;
            _memAccess.Outparam = attributes;
        }

        #region IPortProvider

        public int InB(int addr, int hi)
        {
            _memAccess.Busy = 1;
            switch (addr)
            {
                case 161: // disk status (1 = OK)
                    return _dirName != "" ? _status : 0;

                case 163:
                    return ReadByteFromFile();
            }
            _memAccess.Busy = 0;
            return 0;
        }

        public void OutB(int addr, int value, int state)
        {
            _memAccess.Busy = 1;
            if (addr == 160)
            {
                switch (value)
                {
                    case 0: // init mmc
                        ResetStatus();
                        break;

                    case 1: // read sector
                        break;

                    case 2: // write sector
                        break;

                    case 10: // read first dir entry
                        _dirFiles = Directory.GetFiles(_dirName).Select(Path.GetFileName).ToArray();
                        if (_dirFiles.Length > 0)
                            SetDirInfo(_dirFiles[0]);
                        else
                            _memAccess.Sparam = "";
                        _dirFileIdx = 1;
                        ResetStatus();
                        break;
                        
                    case 11: // read next dir entry
                        if (_dirFileIdx < _dirFiles.Length)
                            SetDirInfo(_dirFiles[_dirFileIdx++]);
                        else
                            _memAccess.Sparam = "";
                        ResetStatus();
                        break;

                    case 20: // open file for reading (sparam: file name, outparam: 1=ok, param1l: file size)
                        ReadFile();
                        break;

                    case 21: // open file for writing (create new)
                        WriteNewFile();
                        break;

                    case 22: // open file for writing (append)
                        AppendFile();
                        break;

                    case 23: // read block
                        ReadBlock();
                        break;

                    case 24: // write block (param1: size in bytes)
                        WriteBlock();
                        break;

                    case 25: // load complete file into memory
                        LoadFileIntoMemory(_memAccess.Sparam, _memAccess.Param1W);
                        break;

                    case 26: // read volume name
                        var segments = _dirName.Split(Path.DirectorySeparatorChar);
                        if (segments.Length > 1)
                            _memAccess.Sparam = segments[segments.Length - 2].ToUpper();
                        else
                            _memAccess.Sparam = "";
                        ResetStatus();
                        break;

                    //case 27: // load program
                    //    LoadProgram(_memAccess.Sparam);
                    //    break;

                    case 28: // delete file (outparam: 1=file deleted)
                        var fileName = Path.Combine(_dirName, _memAccess.Sparam);
                        if (File.Exists(fileName))
                        {
                            File.Delete(fileName);
                            _memAccess.Outparam = 1;
                        }
                        else
                            _memAccess.Outparam = 0;
                        ResetStatus();
                        break;

                    case 29: // check if file exists (outparam: 1=yes)
                        _memAccess.Outparam = File.Exists(Path.Combine(_dirName, _memAccess.Sparam)) ? 1 : 0;
                        ResetStatus();
                        break;
                }
            }
            _memAccess.Busy = 0;
        }

        #endregion
    }
}
