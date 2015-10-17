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
            for (i = 0; i < 1024; i++)
            {
                tw.Write((int)(32767 * Math.Sin(i * 2 * Math.PI / 1024)));
                if (i < 1023)
                    tw.Write(", ");
                if (i % 10 == 0)
                    tw.WriteLine();
            }

            tw.Close();
        }
    }
}
