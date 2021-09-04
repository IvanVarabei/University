namespace SWBoss
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
            this.text1 = new System.Windows.Forms.Label();
            this.text2 = new System.Windows.Forms.Label();
            this.buttonB = new System.Windows.Forms.Button();
            this.boxX = new System.Windows.Forms.TextBox();
            this.text3 = new System.Windows.Forms.Label();
            this.boxY = new System.Windows.Forms.TextBox();
            this.text4 = new System.Windows.Forms.Label();
            this.boxZ = new System.Windows.Forms.TextBox();
            this.text5 = new System.Windows.Forms.Label();
            this.boxR = new System.Windows.Forms.TextBox();
            this.text6 = new System.Windows.Forms.Label();
            this.boxDepth = new System.Windows.Forms.TextBox();
            this.text7 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // text1
            // 
            this.text1.AutoSize = true;
            this.text1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.text1.Location = new System.Drawing.Point(46, 9);
            this.text1.Name = "text1";
            this.text1.Size = new System.Drawing.Size(180, 17);
            this.text1.TabIndex = 0;
            this.text1.Text = "Координаты центра круга";
            // 
            // text2
            // 
            this.text2.AutoSize = true;
            this.text2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.text2.Location = new System.Drawing.Point(12, 34);
            this.text2.Name = "text2";
            this.text2.Size = new System.Drawing.Size(17, 17);
            this.text2.TabIndex = 1;
            this.text2.Text = "X";
            // 
            // buttonB
            // 
            this.buttonB.Font = new System.Drawing.Font("Microsoft Sans Serif", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.buttonB.Location = new System.Drawing.Point(81, 183);
            this.buttonB.Name = "buttonB";
            this.buttonB.Size = new System.Drawing.Size(103, 23);
            this.buttonB.TabIndex = 2;
            this.buttonB.Text = "Построить цилиндр";
            this.buttonB.UseVisualStyleBackColor = true;
            this.buttonB.Click += new System.EventHandler(this.buttonB_Click);
            // 
            // boxX
            // 
            this.boxX.Location = new System.Drawing.Point(35, 31);
            this.boxX.Name = "boxX";
            this.boxX.Size = new System.Drawing.Size(55, 20);
            this.boxX.TabIndex = 3;
            // 
            // text3
            // 
            this.text3.AutoSize = true;
            this.text3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.text3.Location = new System.Drawing.Point(96, 34);
            this.text3.Name = "text3";
            this.text3.Size = new System.Drawing.Size(17, 17);
            this.text3.TabIndex = 4;
            this.text3.Text = "Y";
            // 
            // boxY
            // 
            this.boxY.Location = new System.Drawing.Point(119, 33);
            this.boxY.Name = "boxY";
            this.boxY.Size = new System.Drawing.Size(55, 20);
            this.boxY.TabIndex = 5;
            // 
            // text4
            // 
            this.text4.AutoSize = true;
            this.text4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.text4.Location = new System.Drawing.Point(185, 32);
            this.text4.Name = "text4";
            this.text4.Size = new System.Drawing.Size(17, 17);
            this.text4.TabIndex = 6;
            this.text4.Text = "Z";
            // 
            // boxZ
            // 
            this.boxZ.Location = new System.Drawing.Point(208, 31);
            this.boxZ.Name = "boxZ";
            this.boxZ.Size = new System.Drawing.Size(55, 20);
            this.boxZ.TabIndex = 7;
            // 
            // text5
            // 
            this.text5.AutoSize = true;
            this.text5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.text5.Location = new System.Drawing.Point(47, 60);
            this.text5.Name = "text5";
            this.text5.Size = new System.Drawing.Size(71, 17);
            this.text5.TabIndex = 8;
            this.text5.Text = "Радиус = ";
            // 
            // boxR
            // 
            this.boxR.Location = new System.Drawing.Point(119, 59);
            this.boxR.Name = "boxR";
            this.boxR.Size = new System.Drawing.Size(55, 20);
            this.boxR.TabIndex = 9;
            // 
            // text6
            // 
            this.text6.AutoSize = true;
            this.text6.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.text6.Location = new System.Drawing.Point(42, 106);
            this.text6.Name = "text6";
            this.text6.Size = new System.Drawing.Size(196, 17);
            this.text6.TabIndex = 10;
            this.text6.Text = "Направление выдавливания";
            // 
            // boxDepth
            // 
            this.boxDepth.Location = new System.Drawing.Point(90, 131);
            this.boxDepth.Name = "boxDepth";
            this.boxDepth.Size = new System.Drawing.Size(100, 20);
            this.boxDepth.TabIndex = 11;
            // 
            // text7
            // 
            this.text7.AutoSize = true;
            this.text7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.text7.Location = new System.Drawing.Point(12, 132);
            this.text7.Name = "text7";
            this.text7.Size = new System.Drawing.Size(63, 17);
            this.text7.TabIndex = 12;
            this.text7.Text = "Глубина";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 261);
            this.Controls.Add(this.text7);
            this.Controls.Add(this.boxDepth);
            this.Controls.Add(this.text6);
            this.Controls.Add(this.boxR);
            this.Controls.Add(this.text5);
            this.Controls.Add(this.boxZ);
            this.Controls.Add(this.text4);
            this.Controls.Add(this.boxY);
            this.Controls.Add(this.text3);
            this.Controls.Add(this.boxX);
            this.Controls.Add(this.buttonB);
            this.Controls.Add(this.text2);
            this.Controls.Add(this.text1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label text1;
        private System.Windows.Forms.Label text2;
        private System.Windows.Forms.Button buttonB;
        private System.Windows.Forms.TextBox boxX;
        private System.Windows.Forms.Label text3;
        private System.Windows.Forms.TextBox boxY;
        private System.Windows.Forms.Label text4;
        private System.Windows.Forms.TextBox boxZ;
        private System.Windows.Forms.Label text5;
        private System.Windows.Forms.TextBox boxR;
        private System.Windows.Forms.Label text6;
        private System.Windows.Forms.TextBox boxDepth;
        private System.Windows.Forms.Label text7;
    }
}

