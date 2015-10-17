using System;
using System.Globalization;
using System.IO;

namespace E_Z80.Common
{
    static class Settings
    {
        private static int _updateRate;
        private const int MinUpdateRate = 2;
        private const int MaxUpdateRate = 100;

        public static string SdDirectory { get; set; }

        public static int UpdateRate
        {
            get
            {
                return _updateRate;
            }
            set
            {
                _updateRate = value;
                if (_updateRate < MinUpdateRate)
                    _updateRate = MinUpdateRate;
                else if (_updateRate > MaxUpdateRate)
                    _updateRate = MaxUpdateRate;
            }
        }

        public static void Save()
        {
            var hLines = new[] { SdDirectory, UpdateRate.ToString(CultureInfo.InvariantCulture) };
            File.WriteAllLines(Defs.SettingsFile, hLines);
        }

        public static void Load()
        {
            try
            {
                var hLines = File.ReadAllLines(Defs.SettingsFile);
                SdDirectory = hLines[0];
                UpdateRate = int.Parse(hLines[1]);
            }
            catch (Exception)
            {
                SetDefaults();
            } 
        }

        private static void SetDefaults()
        {
            UpdateRate = 40;
        }
    }
}
