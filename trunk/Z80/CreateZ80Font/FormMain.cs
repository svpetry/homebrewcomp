using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace CreateZ80Font
{
    public partial class FormMain : Form
    {
        public FormMain()
        {
            InitializeComponent();
        }

        private void bnOpenFile_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                tbFontFile.Text = openFileDialog.FileName;
            }
        }

        private void bnStart_Click(object sender, EventArgs e)
        {
            string file_name = tbFontFile.Text;
            if (File.Exists(file_name))
            {
                TextWriter tw = new StreamWriter(Path.ChangeExtension(file_name, ".ppas"));
                Bitmap bmp = new Bitmap(file_name);

                tw.WriteLine("unit Characters;");
                tw.WriteLine("");
                tw.WriteLine("const");
                tw.WriteLine("  char_data: array[0..127] of array[0..15] of byte =");

                int char_no;
                for (char_no = 0; char_no < 128; char_no++)
                {
                    int char_x, char_y;

                    if (char_no == 0)
                        tw.WriteLine("  ((");
                    else
                        tw.WriteLine("  ), (");

                    char_x = (char_no % 32) * 16;
                    char_y = (char_no / 32) * 16;

                    for (int y = 0; y < 16; y++)
                    {
                        tw.Write("    %");
                        for (int x = 0; x < 8; x++)
                        {
                            if (bmp.GetPixel(char_x + x, char_y + y).G == 0)
                                tw.Write("1");
                            else
                                tw.Write("0");
                        }
                        if (y == 15)
                            tw.WriteLine("");
                        else
                            tw.WriteLine(",");
                    }

                }
                tw.WriteLine("  ));");
                tw.WriteLine("");
                tw.WriteLine("end.");

                tw.Close();
            }
        }

        private void bnOpenBinFile_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                tbBinFile.Text = openFileDialog1.FileName;
            }
        }

        private void bnCreateBinPpas_Click(object sender, EventArgs e)
        {
            string file_name = tbBinFile.Text;
            if (File.Exists(file_name))
            {
                TextWriter tw = new StreamWriter("rom.ppas");
                byte d;

                System.IO.FileStream binstr = new FileStream(file_name, FileMode.Open);

                tw.WriteLine("unit rom;");
                tw.WriteLine("");
                tw.WriteLine("const");
                tw.WriteLine("  rom: array[0.."+(binstr.Length - 1)+"] of byte =");
                tw.WriteLine("  (");
                for (int i = 0; i < binstr.Length; i++)
                {
                    if (i % 16 == 0)
                        tw.Write("  ");
                    d = (byte) binstr.ReadByte();
                    tw.Write(d);
                    if (i < binstr.Length - 1)
                        tw.Write(", ");
                    if ((i % 16 == 15) || (i == binstr.Length - 1))
                        tw.WriteLine("");
                }
                tw.WriteLine("  );");
                tw.WriteLine("");
                tw.WriteLine("  rom_size = "+binstr.Length+";");
                tw.WriteLine("");
                tw.WriteLine("end.");

                tw.Close();
                binstr.Close();
            }
        }

        private void bnCreateBitmap_Click(object sender, EventArgs e)
        {
            string file_name = tbFontFile.Text;
            if (File.Exists(file_name))
            {
                Bitmap bmp = new Bitmap(file_name);
                byte[,] chars = new byte[80, 25];

                for (byte y = 0; y < 100; y++)
                {
                    for (byte x = 0; x < 160; x++)
                    {
                        if (bmp.GetPixel(x, y).G == 0)
                            chars[x / 2, y / 4] |= (byte)(((x & 1) + 1) << ((y & 3) << 1));
                    }
                }

                TextWriter tw = new StreamWriter(Path.ChangeExtension(file_name, ".c"));
                tw.WriteLine("const char picture[25][80] = {");
                for (int row = 0; row < 25; row++)
                {
                    if (row == 0)
                        tw.WriteLine("\t{");
                    else
                        tw.WriteLine("\t}, {");
                    tw.Write("\t\t");
                    for (int col = 0; col < 80; col++)
                    {
                        tw.Write(chars[col, row]);
                        if (col < 79)
                        {
                            tw.Write(",");
                            if (col % 10 == 9)
                                tw.Write("\n\t\t");
                            else
                                tw.Write(" ");
                        }
                    }
                    tw.WriteLine();
                    if (row == 24)
                        tw.WriteLine("\t}");
                }
                tw.WriteLine("};");
                tw.Close();
            }
        }
    }
}
