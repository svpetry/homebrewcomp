using System.IO;
using System.Linq;
using E_Z80.Common;

namespace E_Z80.Emulator
{
    class BootLoader
    {
        private byte[] _data;

        private readonly IMemoryProvider _memory;

        private void LoadBootloader()
        {
            if (File.Exists(Defs.BootloaderFile))
                _data = File.ReadAllText(Defs.BootloaderFile).Split(',').Select(_ => (byte)int.Parse(_.Trim())).ToArray();
        }

        public BootLoader(IMemoryProvider memory)
        {
            _memory = memory;
        }

        public void Load()
        {
            LoadBootloader();
            for (var hIdx = 0; hIdx < _data.Length; hIdx++)
                _memory.Poke(hIdx, _data[hIdx]);
        }

    }
}
