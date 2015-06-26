using System.IO;
using System.Linq;
using E_Z80.Common;

namespace E_Z80.Emulator
{
    class BootLoader
    {
        private byte[] FData;

        private readonly IMemoryProvider FMemory;

        private void LoadBootloader()
        {
            if (File.Exists(Defs.BootloaderFile))
                FData = File.ReadAllText(Defs.BootloaderFile).Split(',').Select(_Str => (byte)int.Parse(_Str.Trim())).ToArray();
        }

        public BootLoader(IMemoryProvider _Memory)
        {
            FMemory = _Memory;
        }

        public void Load()
        {
            LoadBootloader();
            for (var hIdx = 0; hIdx < FData.Length; hIdx++)
                FMemory.Poke(hIdx, FData[hIdx]);
        }

    }
}
