using System;
using System.Windows.Forms;
//using ClassLibrary1;
using System.Reflection;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            ClassLibrary1.Form1 fm = new ClassLibrary1.Form1();
            fm.ShowDialog();
            label1.ForeColor = fm.BackColor;
            this.ShowDialog();
            
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
            Assembly aa = Assembly.Load("_ClassLibrary1");
            Object o = aa.CreateInstance("MyIntegral");
            Type t = aa.GetType("MyIntegral");
            Object []numbers = new Object[3];
            numbers[0] = a;
            numbers[1] = b;
            numbers[2] = n;
            MethodInfo mi = t.GetMethod("HalfwitCheck");
            //if (t.HalfwitCheck(a, b, n))
            if ((bool)mi.Invoke(t, numbers))
            {
                label7.Text = "OK";
                //Assembly aaa = Assembly.Load("_ClassLibrary1");
                Object oo = aa.CreateInstance("MyIntegral");
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
