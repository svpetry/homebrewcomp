namespace CreateZ80Font
{
    partial class FormMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.bnOpenFontBmp = new System.Windows.Forms.Button();
            this.tbFontFile = new System.Windows.Forms.TextBox();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.bnCreateFontPpas = new System.Windows.Forms.Button();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.bnCreateBinPpas = new System.Windows.Forms.Button();
            this.tbBinFile = new System.Windows.Forms.TextBox();
            this.bnOpenBinFile = new System.Windows.Forms.Button();
            this.bnCreateBitmap = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // bnOpenFontBmp
            // 
            this.bnOpenFontBmp.Location = new System.Drawing.Point(333, 10);
            this.bnOpenFontBmp.Name = "bnOpenFontBmp";
            this.bnOpenFontBmp.Size = new System.Drawing.Size(21, 23);
            this.bnOpenFontBmp.TabIndex = 0;
            this.bnOpenFontBmp.Text = "..";
            this.bnOpenFontBmp.UseVisualStyleBackColor = true;
            this.bnOpenFontBmp.Click += new System.EventHandler(this.bnOpenFile_Click);
            // 
            // tbFontFile
            // 
            this.tbFontFile.Location = new System.Drawing.Point(12, 12);
            this.tbFontFile.Name = "tbFontFile";
            this.tbFontFile.Size = new System.Drawing.Size(315, 20);
            this.tbFontFile.TabIndex = 1;
            // 
            // openFileDialog
            // 
            this.openFileDialog.Filter = "Bitmap files|*.bmp;*.png";
            this.openFileDialog.Title = "Select bitmap file";
            // 
            // bnCreateFontPpas
            // 
            this.bnCreateFontPpas.Location = new System.Drawing.Point(213, 38);
            this.bnCreateFontPpas.Name = "bnCreateFontPpas";
            this.bnCreateFontPpas.Size = new System.Drawing.Size(114, 23);
            this.bnCreateFontPpas.TabIndex = 2;
            this.bnCreateFontPpas.Text = "Create font.ppas";
            this.bnCreateFontPpas.UseVisualStyleBackColor = true;
            this.bnCreateFontPpas.Click += new System.EventHandler(this.bnStart_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.Filter = "Binary files|*.bin";
            this.openFileDialog1.Title = "Select binary file";
            // 
            // bnCreateBinPpas
            // 
            this.bnCreateBinPpas.Location = new System.Drawing.Point(213, 110);
            this.bnCreateBinPpas.Name = "bnCreateBinPpas";
            this.bnCreateBinPpas.Size = new System.Drawing.Size(114, 23);
            this.bnCreateBinPpas.TabIndex = 5;
            this.bnCreateBinPpas.Text = "Create rom.ppas";
            this.bnCreateBinPpas.UseVisualStyleBackColor = true;
            this.bnCreateBinPpas.Click += new System.EventHandler(this.bnCreateBinPpas_Click);
            // 
            // tbBinFile
            // 
            this.tbBinFile.Location = new System.Drawing.Point(12, 84);
            this.tbBinFile.Name = "tbBinFile";
            this.tbBinFile.Size = new System.Drawing.Size(315, 20);
            this.tbBinFile.TabIndex = 4;
            // 
            // bnOpenBinFile
            // 
            this.bnOpenBinFile.Location = new System.Drawing.Point(333, 82);
            this.bnOpenBinFile.Name = "bnOpenBinFile";
            this.bnOpenBinFile.Size = new System.Drawing.Size(21, 23);
            this.bnOpenBinFile.TabIndex = 3;
            this.bnOpenBinFile.Text = "..";
            this.bnOpenBinFile.UseVisualStyleBackColor = true;
            this.bnOpenBinFile.Click += new System.EventHandler(this.bnOpenBinFile_Click);
            // 
            // bnCreateBitmap
            // 
            this.bnCreateBitmap.Location = new System.Drawing.Point(93, 38);
            this.bnCreateBitmap.Name = "bnCreateBitmap";
            this.bnCreateBitmap.Size = new System.Drawing.Size(114, 23);
            this.bnCreateBitmap.TabIndex = 6;
            this.bnCreateBitmap.Text = "Convert Bitmap";
            this.bnCreateBitmap.UseVisualStyleBackColor = true;
            this.bnCreateBitmap.Click += new System.EventHandler(this.bnCreateBitmap_Click);
            // 
            // FormMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(366, 146);
            this.Controls.Add(this.bnCreateBitmap);
            this.Controls.Add(this.bnCreateBinPpas);
            this.Controls.Add(this.tbBinFile);
            this.Controls.Add(this.bnOpenBinFile);
            this.Controls.Add(this.bnCreateFontPpas);
            this.Controls.Add(this.tbFontFile);
            this.Controls.Add(this.bnOpenFontBmp);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "FormMain";
            this.Text = "CreateZ80Font";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button bnOpenFontBmp;
        private System.Windows.Forms.TextBox tbFontFile;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.Button bnCreateFontPpas;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Button bnCreateBinPpas;
        private System.Windows.Forms.TextBox tbBinFile;
        private System.Windows.Forms.Button bnOpenBinFile;
        private System.Windows.Forms.Button bnCreateBitmap;
    }
}

