using System;
using System.Windows.Forms;

namespace Lab_1__RiPOD
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private double check_double(TextBox TB)
        {
            double res = 0;
            string text = TB.Text;
            try
            {
                res = double.Parse(text);
            }
            catch
            {
                try
                {
                    string s = text.Replace('.', ',');
                    res = double.Parse(s);
                    TB.Text = s;
                }
                catch
                {
                    TB.Text = "Error";
                    res = 0;
                }
                
            }
           
            return res;
        }

        private void button_ZA_R_a_Click(object sender, EventArgs e)
        {
            double a_1 = 0;
            double a_2 = 0;
            int n;
            double h;
            double R = 0;
            h = check_double(textBox_step_1_1);
            a_1 = check_double(textBox_a_1_1_1);
            a_2 = check_double(textBox_a_1_1_2);
            try
            {
                n = int.Parse(textBox_n_1_1.Text);
            }
            catch 
            {
                textBox_n_1_1.Text = "Error";
                return;
            }
            richTextBox1.Text = "";
            chart1.Series[0].Points.Clear();
            while ((a_1 <= a_2) && h > 0)
            {
                R = 1 / (a_1 + (1 - a_1) / n);
                richTextBox1.Text += "  a = " + a_1 + "  R = " + R + "\n";
                chart1.Series[0].Points.AddXY(a_1, R);
                a_1 += h;
                a_1 = Math.Round(a_1, 5);
            }
        }

        private void button_ZA_R_n_Click(object sender, EventArgs e)
        {
            int n_1 = 0;
            int n_2 = 0;
            double a;
            int h;
            double R = 0;
            try
            {
                h = int.Parse(textBox_step_1_2.Text);
                n_1 = int.Parse(textBox_n_1_2_1.Text);
                n_2 = int.Parse(textBox_n_1_2_2.Text);
            }
            catch
            {
                textBox_step_1_2.Text = "Error";
                textBox_n_1_2_1.Text = "Error";
                textBox_n_1_2_2.Text = "Error";
                textBox_a_1_2.Text = "Error";
                return;
            }
            a = check_double(textBox_a_1_2);
            richTextBox2.Text = "";
            chart2.Series[0].Points.Clear();
            while ((n_1 <= n_2) && h > 0)
            {
                R = 1 / (a + (1 - a) / n_1);
                richTextBox2.Text += "  n = " + n_1 + "  R = " + R + "\n";
                chart2.Series[0].Points.AddXY(n_1, R);
                n_1 += h;                
            }
        }

        private void button_ZA_Rc_Ca_Click(object sender, EventArgs e)
        {
            int n;
            double Ca_1 = 0;
            double Ca_2 = 0;
            double Ct;
            double a;
            double h;
            double c;
            double Rc = 0;
            try
            {
                n = int.Parse(textBox_n_2_1.Text);                
            }
            catch
            {               
                textBox_n_2_1.Text = "Error";                
                return;
            }
            Ca_1 = check_double(textBox_Ca_2_1_1);
            Ca_2 = check_double(textBox_Ca_2_1_2);
            Ct = check_double(textBox_Ct_2_1);
            a = check_double(textBox_a_2_1);
            h = check_double(textBox_step_2_1);

            richTextBox3.Text = "";
            chart3.Series[0].Points.Clear();
            while ((Ca_1 <= Ca_2) & h > 0)
            {
                c = Ct * Ca_1;
                Rc = 1 / (a + (1 - a) / n + c);                
                richTextBox3.Text += "  Ca = " + Ca_1 + "  Rc = " + Rc + "\n";
                chart3.Series[0].Points.AddXY(Ca_1, Rc);
                Ca_1 += h;
                Ca_1 = Math.Round(Ca_1, 5);
            }
        }

        private void button_ZA_Rc_Ct_Click(object sender, EventArgs e)
        {
            int n;
            double Ct_1 = 0;
            double Ct_2 = 0;
            double Ca;
            double a;
            double h;
            double c;
            double Rc = 0;
            try
            {
                n = int.Parse(textBox_n_2_2.Text);
            }
            catch
            {
                textBox_n_2_2.Text = "Error";
                return;
            }
            Ct_1 = check_double(textBox_Ct_2_2_1);
            Ct_2 = check_double(textBox_Ct_2_2_2);
            Ca = check_double(textBox_Ca_2_2);
            a = check_double(textBox_a_2_2);
            h = check_double(textBox_step_2_2);

            richTextBox4.Text = "";
            chart4.Series[0].Points.Clear();
            while ((Ct_1 <= Ct_2) & h > 0)
            {
                c = Ct_1 * Ca;
                Rc = 1 / (a + (1 - a) / n + c);
                richTextBox4.Text += "  Ct = " + Ct_1 + "  Rc = " + Rc + "\n";
                chart4.Series[0].Points.AddXY(Ct_1, Rc);
                Ct_1 += h;
                Ct_1 = Math.Round(Ct_1, 5);
            }
        }
    }
}
