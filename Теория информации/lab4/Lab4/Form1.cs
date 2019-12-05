using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Lab4
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
        }
        private char[] alphabet = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', '.' };

     

        public int GetIndexAlphabet(char c)
        {  
            for(int i = 0; i < alphabet.Length; i++)
            {
                if (c == alphabet[i])
                {
                    return i;                    
                }
            }
            return -1;
        }

        public string CryptText(string text, int Ko, int n)
        {
            string outStr = "";
            
            int num;
            for (int i = 0; i < text.Length; i++)
            {
                int ret = 1;
                if (GetIndexAlphabet(text[i]) != -1)
                {
                    num = GetIndexAlphabet(text[i]) + 2;
                    for (int j = 0; j < Ko; j++)
                    {
                        ret = (ret * num) % n;
                    }
                    outStr += (char)(ret + 1);
                }
                else
                {
                    outStr += text[i];
                }
            }
                return outStr;
        }


        public string EnCryptText(string text, int Ks, int n)
        {
            string outStr = "";
            
            int num;
            for (int i = 0; i < text.Length; i++)
            {
                int ret = 1;
                /*if (text[i] != ' ')
                {*/
                    num = (int)text[i] - 1;
                    for (int j = 0; j < Ks; j++)
                    {
                        ret = (ret * num) % n;
                    }

                    if (ret - 2 < 25)
                    {
                        outStr += alphabet[ret - 2];
                    }
                    else
                    {
                        outStr += text[i];
                    }


                /*}
                else
                {
                    outStr += " ";
                }*/
                
            }
            return outStr;
        }

        private void countFi_Click(object sender, EventArgs e)
        {
            
        }
        public int NOD(int a, int b)
        {
            while (true)
            {
                if (a == 0 || b == 0)
                {
                    break;
                }
                else
                {
                    if (a > b)
                    {
                        a = a % b;
                    }
                    else
                    {
                        b = b % a;
                    }
                }
            }
            return a + b;
        }

        private void tbP_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void tbP_Leave(object sender, EventArgs e)
        {
            if (tbP.Text != "")
            {
                if (!SimpleDigit(Convert.ToInt32(tbP.Text)))
                {
                    tbP.Text = "";
                    MessageBox.Show("Число должно быть простым!");
                }
                if (tbQ.Text != "")
                {
                    tbN1.Text = (Convert.ToInt32(tbP.Text) * Convert.ToInt32(tbQ.Text)).ToString();
                    tbFi.Text = Convert.ToString((Convert.ToInt32(tbP.Text) - 1) * (Convert.ToInt32(tbQ.Text) - 1));
                }
            }
        }

        private void tbKs_Leave(object sender, EventArgs e)
        {
            if (tbKs.Text != "")
            {
                if (NOD(Convert.ToInt32(tbKs.Text), Convert.ToInt32(tbFi.Text)) != 1)
                {
                    MessageBox.Show("Число должно быть взаимнопростым с фи!");
                    tbKs.Text = "";
                }
                else
                {
                    int x;
                    int y;
                    int d = this.EuclidExtended(Convert.ToInt32(tbFi.Text), Convert.ToInt32(tbKs.Text), out x, out y);
                    if (y < 0)
                    {
                        y += Convert.ToInt32(tbFi.Text);
                    }
                    tbKo.Text = y.ToString();
                }
            }
        }


        public bool SimpleDigit(int y)
        {
            for (int i = y - 1; i > 1; i--)
            {
                if (y % i == 0)
                {
                    return false;
                }
            }
            return true;
        }

        private void btnCrypt_Click(object sender, EventArgs e)
        {
            
            int x;
            int y;
            int d = this.EuclidExtended(Convert.ToInt32(tbFi.Text), Convert.ToInt32(tbKs.Text),out x, out y);
            if (y < 0)
            {
                y += Convert.ToInt32(tbFi.Text);
            }
           
            tbCryptText.Text = CryptText(tbTextToCrypt.Text, Convert.ToInt32(tbKo1.Text), Convert.ToInt32(tbN2.Text));
            tbEncryptText.Text = CryptText(tbTextToCrypt.Text, Convert.ToInt32(tbKo1.Text), Convert.ToInt32(tbN2.Text));
        }

        public int EuclidExtended(int a, int b, out int x, out int y)
        {
            int q, r, x1, x2, y1, y2, d;

            if (b == 0)
            {
                d = a;
                x = 1;
                y = 0;
                return d;
            }

            x2 = 1;
            x1 = 0;
            y2 = 0;
            y1 = 1;

            while (b > 0)
            {

                q = a / b;
                r = a - q * b;

                x = x2 - q * x1;
                y = y2 - q * y1;

                a = b;
                b = r;

                x2 = x1;
                x1 = x;
                y2 = y1;
                y1 = y;

            }

            d = a;
            x = x2;
            y = y2;

            return d;
        }


        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnEncryptText_Click(object sender, EventArgs e)
        {
            tbTextToEncrypt.Text = EnCryptText(tbEncryptText.Text, Convert.ToInt32(tbKsEC.Text), Convert.ToInt32(tbN.Text));
        }

        private void tbQ_Leave(object sender, EventArgs e)
        {
            if (tbQ.Text != "")
            {
                if (!SimpleDigit(Convert.ToInt32(tbQ.Text)))
                {
                    tbQ.Text = "";
                    MessageBox.Show("Число должно быть простым!");
                }
                if (tbP.Text != "")
                {
                    tbN1.Text = (Convert.ToInt32(tbP.Text) * Convert.ToInt32(tbQ.Text)).ToString();
                    tbFi.Text = Convert.ToString((Convert.ToInt32(tbP.Text) - 1) * (Convert.ToInt32(tbQ.Text) - 1));
                }
            }
        }

        private void btnCancel1_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

    }
}