using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace WindowsFormsApplication1
{
    public partial class FormMain : Form
    {
        public FormMain()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            TextWriter tw = new StreamWriter("sintable.txt");

            int i;
            for (i = 0; i < 256; i++)
            {
                tw.Write((int)(127 * Math.Sin(i * 2 * Math.PI / 256)));
                if (i < 255)
                    tw.Write(", ");
                if (i % 10 == 0)
                    tw.WriteLine();
            }

            tw.Close();
        }
    }
}
