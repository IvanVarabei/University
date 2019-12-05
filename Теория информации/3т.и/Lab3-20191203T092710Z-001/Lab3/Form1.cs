using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Lab3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private string Encrypt(string plainText)
        {
            int booln = 0;
            int intn = 0;
            TextBox[] tb1 = { textBox6, textBox7, textBox8, textBox9, textBox10, textBox11, textBox12, textBox13, textBox14 };
            TextBox[] tb2 = { textBox16, textBox17, textBox18, textBox19, textBox20, textBox21, textBox22, textBox23, textBox24 };
            for (int i = 0; i < tb1.Length; i++) if (tb1[i].Visible) booln++;
            for (int i = 0; i < tb2.Length; i++) if (tb2[i].Visible)
                {
                    if (tb2[i].Text == "*")
                    {
                        intn++;
                    }
                }
            if (booln == 0 || intn == 0) return "";
            bool[] seed = new bool[booln];
            int[] taps = new int[intn];
            try
            {
                for (int i = 0; i < tb1.Length; i++)
                    if (tb1[i].Visible)
                        if (Convert.ToInt32(tb1[i].Text) == 0) seed[i] = false;
                        else
                            if (Convert.ToInt32(tb1[i].Text) == 1) seed[i] = true; else return "";

                for (int i = 0, j = 0; i < tb2.Length; i++)
                {
                    if (tb2[i].Visible)
                    {
                        if (tb2[i].Text == "*")
                        {
                            taps[j] = i + 1;
                            j++;
                        }
                    }
                }
            }
            catch (Exception) { return ""; }

            Lfsr lfsr = new Lfsr(seed, taps);
            bool flag = checkBox1.Checked;
            textBox4.Text = "";
            StringBuilder builder = new StringBuilder();
            var startState = lfsr.ToString();
            if (flag) builder.AppendLine(0 + ":  " + startState);
            var charArray = plainText.ToCharArray();

            lfsr.Shift();
            char[] encodedCharArray = new char[charArray.Length];
            for (int i = 0; i < charArray.Length; i++)
            {
                var charKey = new BitArray(16);
                for (int j = 0; j < 16; j++)
                {
                    if (flag)
                    {
                        var currentState = lfsr.ToString();
                        if (currentState == startState)
                            builder.AppendLine("Повторение!");
                        builder.AppendLine((16 * i + j + 1) + ":  " + currentState);
                    };
                    charKey[j] = lfsr.GetFeedback();
                    lfsr.Shift();
                }
                int[] ch = new int[1];
                charKey.CopyTo(ch, 0);
                encodedCharArray[i] = (char)(charArray[i] ^ (char)ch[0]);
            }
            if (flag) textBox4.Text = builder.ToString();
            return string.Concat(encodedCharArray);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            textBox2.Text = "";
            textBox2.Text = Encrypt(textBox1.Text);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox3.Text = "";
            textBox3.Text = Encrypt(textBox2.Text);
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {
            TextBox[] tb1 = { textBox6, textBox7, textBox8, textBox9, textBox10, textBox11, textBox12, textBox13, textBox14 };
            TextBox[] tb2 = { textBox16, textBox17, textBox18, textBox19, textBox20, textBox21, textBox22, textBox23, textBox24 };
            for (int i = 0; i < tb1.Length; i++) tb1[i].Visible = false;
           int n = 0;
            try { n = Convert.ToInt32(textBox5.Text); }
            catch (Exception) { return; }
            if (n > 9 || n < 1) return;
            for (int i = 0; i < tb1.Length; i++) if (i < n) tb1[i].Visible = true; else tb2[i].Visible = false;
            for (int i = 0; i < tb2.Length; i++) if (i < n && tb1[i].Visible) tb2[i].Visible = true;
        }

        private void textBox5_Click(object sender, EventArgs e)
        {
            textBox5.Text = "";
        }


        private void button3_Click(object sender, EventArgs e)
        {
            textBox1.Text = "";
        }

        private void button4_Click(object sender, EventArgs e)
        {
            textBox2.Text = "";
        }

        private void button5_Click(object sender, EventArgs e)
        {
            textBox3.Text = "";
        }

        private void button6_Click(object sender, EventArgs e)
        {
            textBox4.Text = "";
        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
