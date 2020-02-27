using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
            if (Logic.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";               
                Logic.DrawL(chartControl1, a, b, n);
                label1.Text = Logic.ProcLeftS(a, b, n).ToString();
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
            if (Logic.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";              
                Logic.DrawR(chartControl1, a, b, n);
                label1.Text = Logic.ProcRightS(a, b, n).ToString();
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
            if (Logic.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";               
                Logic.DrawM(chartControl1, a, b, n);
                label1.Text = Logic.ProcMidlS(a, b, n).ToString();
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
            if (Logic.HalfwitCheck(a, b, n))
            {
                label7.Text = "OK";              
                Logic.DrawT(chartControl1, a, b, n);
                label1.Text = Logic.ProcTrapeze(a, b, n).ToString();
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

        private void chartControl1_Click(object sender, EventArgs e)
        {

        }
    }
}
