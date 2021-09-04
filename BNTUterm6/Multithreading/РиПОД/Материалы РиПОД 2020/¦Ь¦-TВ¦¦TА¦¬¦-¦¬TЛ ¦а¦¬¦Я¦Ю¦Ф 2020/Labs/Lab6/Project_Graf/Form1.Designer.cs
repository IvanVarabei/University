namespace Project_Graf
{
    partial class Form1
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
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.buttonOper = new System.Windows.Forms.Button();
            this.buttonCreateList = new System.Windows.Forms.Button();
            this.dataGridViewType = new System.Windows.Forms.DataGridView();
            this.Column3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.numericUpDownPor = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this.dataGridViewGraf = new System.Windows.Forms.DataGridView();
            this.Column1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Column2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.tabPage4 = new System.Windows.Forms.TabPage();
            this.pictureBoxGrafSl = new System.Windows.Forms.PictureBox();
            this.button1 = new System.Windows.Forms.Button();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewType)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownPor)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewGraf)).BeginInit();
            this.tabPage3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.tabPage4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxGrafSl)).BeginInit();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Controls.Add(this.tabPage4);
            this.tabControl1.Location = new System.Drawing.Point(12, 12);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(822, 480);
            this.tabControl1.TabIndex = 0;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.buttonOper);
            this.tabPage1.Controls.Add(this.buttonCreateList);
            this.tabPage1.Controls.Add(this.dataGridViewType);
            this.tabPage1.Controls.Add(this.numericUpDownPor);
            this.tabPage1.Controls.Add(this.label1);
            this.tabPage1.Controls.Add(this.dataGridViewGraf);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(814, 454);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Создание графа";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // buttonOper
            // 
            this.buttonOper.Location = new System.Drawing.Point(359, 13);
            this.buttonOper.Name = "buttonOper";
            this.buttonOper.Size = new System.Drawing.Size(159, 23);
            this.buttonOper.TabIndex = 5;
            this.buttonOper.Text = "Пошаговое планирование";
            this.buttonOper.UseVisualStyleBackColor = true;
            this.buttonOper.Click += new System.EventHandler(this.buttonOper_Click);
            // 
            // buttonCreateList
            // 
            this.buttonCreateList.Location = new System.Drawing.Point(173, 13);
            this.buttonCreateList.Name = "buttonCreateList";
            this.buttonCreateList.Size = new System.Drawing.Size(159, 23);
            this.buttonCreateList.TabIndex = 4;
            this.buttonCreateList.Text = "Организовать список";
            this.buttonCreateList.UseVisualStyleBackColor = true;
            this.buttonCreateList.Click += new System.EventHandler(this.buttonCreateList_Click);
            // 
            // dataGridViewType
            // 
            this.dataGridViewType.AllowUserToAddRows = false;
            this.dataGridViewType.AllowUserToDeleteRows = false;
            this.dataGridViewType.AllowUserToResizeColumns = false;
            this.dataGridViewType.AllowUserToResizeRows = false;
            this.dataGridViewType.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewType.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Column3});
            this.dataGridViewType.Location = new System.Drawing.Point(625, 42);
            this.dataGridViewType.Name = "dataGridViewType";
            this.dataGridViewType.Size = new System.Drawing.Size(130, 400);
            this.dataGridViewType.TabIndex = 3;
            // 
            // Column3
            // 
            this.Column3.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Column3.HeaderText = "Type";
            this.Column3.Name = "Column3";
            // 
            // numericUpDownPor
            // 
            this.numericUpDownPor.Location = new System.Drawing.Point(105, 16);
            this.numericUpDownPor.Maximum = new decimal(new int[] {
            15,
            0,
            0,
            0});
            this.numericUpDownPor.Name = "numericUpDownPor";
            this.numericUpDownPor.Size = new System.Drawing.Size(37, 20);
            this.numericUpDownPor.TabIndex = 2;
            this.numericUpDownPor.Value = new decimal(new int[] {
            3,
            0,
            0,
            0});
            this.numericUpDownPor.Click += new System.EventHandler(this.numericUpDownPor_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 18);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(85, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Порядок графа";
            // 
            // dataGridViewGraf
            // 
            this.dataGridViewGraf.AllowUserToAddRows = false;
            this.dataGridViewGraf.AllowUserToDeleteRows = false;
            this.dataGridViewGraf.AllowUserToResizeColumns = false;
            this.dataGridViewGraf.AllowUserToResizeRows = false;
            this.dataGridViewGraf.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewGraf.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Column1,
            this.Column2});
            this.dataGridViewGraf.Location = new System.Drawing.Point(34, 42);
            this.dataGridViewGraf.Name = "dataGridViewGraf";
            this.dataGridViewGraf.Size = new System.Drawing.Size(524, 400);
            this.dataGridViewGraf.TabIndex = 0;
            // 
            // Column1
            // 
            this.Column1.HeaderText = "1";
            this.Column1.Name = "Column1";
            this.Column1.Width = 60;
            // 
            // Column2
            // 
            this.Column2.HeaderText = "2";
            this.Column2.Name = "Column2";
            // 
            // tabPage3
            // 
            this.tabPage3.Controls.Add(this.pictureBox1);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage3.Size = new System.Drawing.Size(814, 454);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Графическое представление графа";
            this.tabPage3.UseVisualStyleBackColor = true;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new System.Drawing.Point(6, 9);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(802, 442);
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            this.pictureBox1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pictureBox1_MouseDown);
            this.pictureBox1.MouseMove += new System.Windows.Forms.MouseEventHandler(this.pictureBox1_MouseMove);
            this.pictureBox1.MouseUp += new System.Windows.Forms.MouseEventHandler(this.pictureBox1_MouseUp);
            // 
            // tabPage4
            // 
            this.tabPage4.Controls.Add(this.pictureBoxGrafSl);
            this.tabPage4.Location = new System.Drawing.Point(4, 22);
            this.tabPage4.Name = "tabPage4";
            this.tabPage4.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage4.Size = new System.Drawing.Size(814, 454);
            this.tabPage4.TabIndex = 3;
            this.tabPage4.Text = "Планирование пошаговое";
            this.tabPage4.UseVisualStyleBackColor = true;
            // 
            // pictureBoxGrafSl
            // 
            this.pictureBoxGrafSl.Location = new System.Drawing.Point(6, 3);
            this.pictureBoxGrafSl.Name = "pictureBoxGrafSl";
            this.pictureBoxGrafSl.Size = new System.Drawing.Size(805, 448);
            this.pictureBoxGrafSl.TabIndex = 0;
            this.pictureBoxGrafSl.TabStop = false;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(850, 220);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(115, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "Планировать";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(977, 504);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tabControl1);
            this.Name = "Form1";
            this.Text = "Планирование";
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewType)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownPor)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewGraf)).EndInit();
            this.tabPage3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.tabPage4.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxGrafSl)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.DataGridView dataGridViewGraf;
        private System.Windows.Forms.NumericUpDown numericUpDownPor;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dataGridViewType;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column3;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column1;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column2;
        private System.Windows.Forms.Button buttonCreateList;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.TabPage tabPage4;
        private System.Windows.Forms.PictureBox pictureBoxGrafSl;
        private System.Windows.Forms.Button buttonOper;
        private System.Windows.Forms.Button button1;
    }
}

