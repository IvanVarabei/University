namespace Lab4
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
            this.tbP = new System.Windows.Forms.TextBox();
            this.tbQ = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.tbFi = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.tbKs = new System.Windows.Forms.TextBox();
            this.tbTextToCrypt = new System.Windows.Forms.TextBox();
            this.tbCryptText = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.tbKo = new System.Windows.Forms.TextBox();
            this.btnCrypt = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.tbKo1 = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.tbN2 = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.tbTextToEncrypt = new System.Windows.Forms.TextBox();
            this.btnCancel1 = new System.Windows.Forms.Button();
            this.tbN = new System.Windows.Forms.TextBox();
            this.btnEncryptText = new System.Windows.Forms.Button();
            this.label6 = new System.Windows.Forms.Label();
            this.tbEncryptText = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.tbKsEC = new System.Windows.Forms.TextBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.label10 = new System.Windows.Forms.Label();
            this.tbN1 = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.SuspendLayout();
            // 
            // tbP
            // 
            this.tbP.Location = new System.Drawing.Point(40, 22);
            this.tbP.Name = "tbP";
            this.tbP.Size = new System.Drawing.Size(52, 23);
            this.tbP.TabIndex = 0;
            this.tbP.TextChanged += new System.EventHandler(this.tbP_TextChanged);
            this.tbP.Leave += new System.EventHandler(this.tbP_Leave);
            // 
            // tbQ
            // 
            this.tbQ.Location = new System.Drawing.Point(40, 49);
            this.tbQ.Name = "tbQ";
            this.tbQ.Size = new System.Drawing.Size(52, 23);
            this.tbQ.TabIndex = 1;
            this.tbQ.Leave += new System.EventHandler(this.tbQ_Leave);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(3, 25);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(36, 17);
            this.label1.TabIndex = 2;
            this.label1.Text = "p = ";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(3, 52);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(31, 17);
            this.label2.TabIndex = 3;
            this.label2.Text = "q =";
            // 
            // tbFi
            // 
            this.tbFi.Location = new System.Drawing.Point(151, 49);
            this.tbFi.Name = "tbFi";
            this.tbFi.ReadOnly = true;
            this.tbFi.Size = new System.Drawing.Size(94, 23);
            this.tbFi.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(267, 25);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(40, 17);
            this.label3.TabIndex = 7;
            this.label3.Text = "Kc =";
            // 
            // tbKs
            // 
            this.tbKs.Location = new System.Drawing.Point(309, 22);
            this.tbKs.Name = "tbKs";
            this.tbKs.Size = new System.Drawing.Size(81, 23);
            this.tbKs.TabIndex = 6;
            this.tbKs.Leave += new System.EventHandler(this.tbKs_Leave);
            // 
            // tbTextToCrypt
            // 
            this.tbTextToCrypt.Location = new System.Drawing.Point(11, 60);
            this.tbTextToCrypt.Multiline = true;
            this.tbTextToCrypt.Name = "tbTextToCrypt";
            this.tbTextToCrypt.Size = new System.Drawing.Size(246, 72);
            this.tbTextToCrypt.TabIndex = 8;
            // 
            // tbCryptText
            // 
            this.tbCryptText.Location = new System.Drawing.Point(263, 60);
            this.tbCryptText.Multiline = true;
            this.tbCryptText.Name = "tbCryptText";
            this.tbCryptText.Size = new System.Drawing.Size(251, 72);
            this.tbCryptText.TabIndex = 9;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(266, 51);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(41, 17);
            this.label4.TabIndex = 11;
            this.label4.Text = "Ko =";
            // 
            // tbKo
            // 
            this.tbKo.Location = new System.Drawing.Point(308, 48);
            this.tbKo.Name = "tbKo";
            this.tbKo.ReadOnly = true;
            this.tbKo.Size = new System.Drawing.Size(82, 23);
            this.tbKo.TabIndex = 10;
            // 
            // btnCrypt
            // 
            this.btnCrypt.Location = new System.Drawing.Point(65, 138);
            this.btnCrypt.Name = "btnCrypt";
            this.btnCrypt.Size = new System.Drawing.Size(156, 23);
            this.btnCrypt.TabIndex = 12;
            this.btnCrypt.Text = "Зашифровать";
            this.btnCrypt.UseVisualStyleBackColor = true;
            this.btnCrypt.Click += new System.EventHandler(this.btnCrypt_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(308, 138);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(156, 23);
            this.btnCancel.TabIndex = 13;
            this.btnCancel.Text = "Выход";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.tbKo1);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Controls.Add(this.tbN2);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.tbTextToCrypt);
            this.groupBox1.Controls.Add(this.btnCancel);
            this.groupBox1.Controls.Add(this.btnCrypt);
            this.groupBox1.Controls.Add(this.tbCryptText);
            this.groupBox1.Location = new System.Drawing.Point(12, 85);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(523, 175);
            this.groupBox1.TabIndex = 14;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Шифрование";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // tbKo1
            // 
            this.tbKo1.Location = new System.Drawing.Point(190, 31);
            this.tbKo1.Name = "tbKo1";
            this.tbKo1.Size = new System.Drawing.Size(70, 23);
            this.tbKo1.TabIndex = 14;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(148, 34);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(41, 17);
            this.label9.TabIndex = 15;
            this.label9.Text = "Ko =";
            // 
            // tbN2
            // 
            this.tbN2.Location = new System.Drawing.Point(47, 31);
            this.tbN2.Name = "tbN2";
            this.tbN2.Size = new System.Drawing.Size(89, 23);
            this.tbN2.TabIndex = 14;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(10, 34);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(31, 17);
            this.label7.TabIndex = 15;
            this.label7.Text = "n =";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.tbTextToEncrypt);
            this.groupBox2.Controls.Add(this.btnCancel1);
            this.groupBox2.Controls.Add(this.tbN);
            this.groupBox2.Controls.Add(this.btnEncryptText);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.tbEncryptText);
            this.groupBox2.Controls.Add(this.label8);
            this.groupBox2.Controls.Add(this.tbKsEC);
            this.groupBox2.Location = new System.Drawing.Point(12, 266);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(523, 180);
            this.groupBox2.TabIndex = 15;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Дешифрование";
            // 
            // tbTextToEncrypt
            // 
            this.tbTextToEncrypt.Location = new System.Drawing.Point(263, 61);
            this.tbTextToEncrypt.Multiline = true;
            this.tbTextToEncrypt.Name = "tbTextToEncrypt";
            this.tbTextToEncrypt.Size = new System.Drawing.Size(251, 72);
            this.tbTextToEncrypt.TabIndex = 8;
            // 
            // btnCancel1
            // 
            this.btnCancel1.Location = new System.Drawing.Point(308, 139);
            this.btnCancel1.Name = "btnCancel1";
            this.btnCancel1.Size = new System.Drawing.Size(156, 23);
            this.btnCancel1.TabIndex = 13;
            this.btnCancel1.Text = "Выход";
            this.btnCancel1.UseVisualStyleBackColor = true;
            this.btnCancel1.Click += new System.EventHandler(this.btnCancel1_Click);
            // 
            // tbN
            // 
            this.tbN.Location = new System.Drawing.Point(40, 23);
            this.tbN.Name = "tbN";
            this.tbN.Size = new System.Drawing.Size(96, 23);
            this.tbN.TabIndex = 0;
            // 
            // btnEncryptText
            // 
            this.btnEncryptText.Location = new System.Drawing.Point(65, 139);
            this.btnEncryptText.Name = "btnEncryptText";
            this.btnEncryptText.Size = new System.Drawing.Size(156, 23);
            this.btnEncryptText.TabIndex = 12;
            this.btnEncryptText.Text = "Расшифровать";
            this.btnEncryptText.UseVisualStyleBackColor = true;
            this.btnEncryptText.Click += new System.EventHandler(this.btnEncryptText_Click);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(3, 26);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(36, 17);
            this.label6.TabIndex = 2;
            this.label6.Text = "n = ";
            // 
            // tbEncryptText
            // 
            this.tbEncryptText.Location = new System.Drawing.Point(6, 61);
            this.tbEncryptText.Multiline = true;
            this.tbEncryptText.Name = "tbEncryptText";
            this.tbEncryptText.Size = new System.Drawing.Size(251, 72);
            this.tbEncryptText.TabIndex = 9;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(148, 26);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(40, 17);
            this.label8.TabIndex = 7;
            this.label8.Text = "Kc =";
            // 
            // tbKsEC
            // 
            this.tbKsEC.Location = new System.Drawing.Point(190, 23);
            this.tbKsEC.Name = "tbKsEC";
            this.tbKsEC.Size = new System.Drawing.Size(70, 23);
            this.tbKsEC.TabIndex = 6;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.label10);
            this.groupBox3.Controls.Add(this.tbN1);
            this.groupBox3.Controls.Add(this.label5);
            this.groupBox3.Controls.Add(this.tbP);
            this.groupBox3.Controls.Add(this.tbKs);
            this.groupBox3.Controls.Add(this.label3);
            this.groupBox3.Controls.Add(this.tbFi);
            this.groupBox3.Controls.Add(this.tbQ);
            this.groupBox3.Controls.Add(this.label4);
            this.groupBox3.Controls.Add(this.label2);
            this.groupBox3.Controls.Add(this.label1);
            this.groupBox3.Controls.Add(this.tbKo);
            this.groupBox3.Location = new System.Drawing.Point(12, 1);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(401, 78);
            this.groupBox3.TabIndex = 16;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Генерация ключей";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(109, 52);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(37, 17);
            this.label10.TabIndex = 14;
            this.label10.Text = " φ =";
            // 
            // tbN1
            // 
            this.tbN1.Location = new System.Drawing.Point(151, 22);
            this.tbN1.Name = "tbN1";
            this.tbN1.ReadOnly = true;
            this.tbN1.Size = new System.Drawing.Size(94, 23);
            this.tbN1.TabIndex = 12;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(114, 25);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(31, 17);
            this.label5.TabIndex = 13;
            this.label5.Text = "n =";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(543, 437);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "Form1";
            this.Text = "Лабораторная работа №4";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox tbP;
        private System.Windows.Forms.TextBox tbQ;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tbFi;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbKs;
        private System.Windows.Forms.TextBox tbTextToCrypt;
        private System.Windows.Forms.TextBox tbCryptText;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tbKo;
        private System.Windows.Forms.Button btnCrypt;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox tbTextToEncrypt;
        private System.Windows.Forms.Button btnCancel1;
        private System.Windows.Forms.TextBox tbN;
        private System.Windows.Forms.Button btnEncryptText;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox tbEncryptText;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox tbKsEC;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox tbN1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tbKo1;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox tbN2;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label10;
    }
}

