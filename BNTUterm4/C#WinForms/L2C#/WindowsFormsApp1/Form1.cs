using System;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }


        private void CleanChart()
        {
            chartControl1.Series[0].Points.Clear();
            chartControl1.Series[1].Points.Clear();
            chartControl1.Series[2].Points.Clear();
        }


        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text),
                b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            CleanChart();
            if (MyIntegral.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";
                MyIntegral integral = new MyIntegral(a, b,n);
                //integral.BottomBorder = 0.1;
                integral.DrawL(chartControl1);
                label1.Text = integral.ProcLeftS().ToString();
            }
            else
            {
                label7.Text = "!DATA ERRORE!";               
            }
        }


        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text),
                b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            CleanChart();
            if (MyIntegral.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";
                MyIntegral integral = new MyIntegral(a, b, n);
                integral.DrawR(chartControl1);
                label1.Text = integral.ProcRightS().ToString();
            }
            else
            {
                label7.Text = "!DATA ERRORE!";               
            }
        }


        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text),
                b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            CleanChart();
            if (MyIntegral.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";
                MyIntegral integral = new MyIntegral(a, b, n);
                integral.DrawM(chartControl1);
                label1.Text = integral.ProcMidlS().ToString();
            }
            else
            {
                label7.Text = "!DATA ERRORE!";                
            }
        }


        private void radioButton4_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text),
                b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            CleanChart();
            if (MyIntegral.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";
                MyIntegral integral = new MyIntegral(a, b, n);
                integral.DrawT(chartControl1);
                label1.Text = integral.ProcTrapeze().ToString();
            }
            else
            {
                label7.Text = "!DATA ERRORE!";             
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
