using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace fifth
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Clean()
        {
            chart1.Series[0].Points.Clear();
            chart1.Series[1].Points.Clear();
            chart1.Series[2].Points.Clear();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Clean();
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text), time = double.Parse(numericUpDown1.Text), answ;

            if (radioButton1.Checked == true)
            {
                if (radioButton5.Checked == true)
                {
                    Version1 equation = new Version1(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcHD();
                    if (checkBox1.Checked == true && !equation.ProcHD().Equals("INDEFINED"))
                    {
                        equation.DrowHD(chart1, time);
                    }
                }
                if (radioButton6.Checked == true)
                {
                    Version2 equation = new Version2(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcHD();
                    if (checkBox1.Checked == true && !equation.ProcHD().Equals("INDEFINED"))
                    {
                        equation.DrowHD(chart1, time);
                    }
                }
                if (radioButton7.Checked == true)
                {
                    Version9 equation = new Version9(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcHD();
                    if (checkBox1.Checked == true && !equation.ProcHD().Equals("INDEFINED"))
                    {
                        equation.DrowHD(chart1, time);
                    }
                }
            }
            if (radioButton2.Checked == true)
            {
                if (radioButton5.Checked == true)
                {
                    Version1 equation = new Version1(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcI();
                    if (checkBox1.Checked == true && !equation.ProcI().Equals("INDEFINED"))
                    {
                        equation.DrowI(chart1, time);
                    }
                }
                if (radioButton6.Checked == true)
                {
                    Version2 equation = new Version2(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcI();
                    if (checkBox1.Checked == true && !equation.ProcI().Equals("INDEFINED"))
                    {
                        equation.DrowI(chart1, time);
                    }
                }
                if (radioButton7.Checked == true)
                {
                    Version9 equation = new Version9(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcI();
                    if (checkBox1.Checked == true && !equation.ProcI().Equals("INDEFINED"))
                    {
                        equation.DrowI(chart1, time);
                    }
                }
            }
            if (radioButton3.Checked == true)
            {
                if (radioButton5.Checked == true)
                {
                    Version1 equation = new Version1(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcN();
                    if (checkBox1.Checked == true && !equation.ProcN().Equals("INDEFINED"))
                    {
                        equation.DrowN(chart1, time);
                    }
                }
                if (radioButton6.Checked == true)
                {
                    Version2 equation = new Version2(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcN();
                    if (checkBox1.Checked == true && !equation.ProcN().Equals("INDEFINED"))
                    {
                        equation.DrowN(chart1, time);
                    }
                }
                if (radioButton7.Checked == true)
                {
                    Version9 equation = new Version9(a, b, n);
                    equation.DrawLine(chart1);
                    label1.Text = equation.ProcN();
                    if (checkBox1.Checked == true && !equation.ProcN().Equals("INDEFINED"))
                    {
                        equation.DrowN(chart1, time);
                    }
                }
            }
        }


        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

     
    }
}
