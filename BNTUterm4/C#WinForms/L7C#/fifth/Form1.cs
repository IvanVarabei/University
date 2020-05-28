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
            dataGridView1.Rows.Clear();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Clean();
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text), st = double.Parse(textBox4.Text);
            Equation equ;
            if (radioButton1.Checked == true)
            {
                if (radioButton4.Checked == true)
                {
                    equ = new Version1(a, b, n, st);
                    equ.calcByEulerMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
                if (radioButton5.Checked == true)
                {
                    equ = new Version2(a, b, n, st);
                    equ.calcByEulerMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
                if (radioButton6.Checked == true)
                {
                    equ = new Version3(a, b, n, st);
                    equ.calcByEulerMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
                
            }
            if (radioButton2.Checked == true)
            {
                if (radioButton4.Checked == true)
                {
                    equ = new Version1(a, b, n, st);
                    equ.calcByModifiedEulerMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
                if (radioButton5.Checked == true)
                {
                    equ = new Version2(a, b, n, st);
                    equ.calcByModifiedEulerMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
                if (radioButton6.Checked == true)
                {
                    equ = new Version3(a, b, n, st);
                    equ.calcByModifiedEulerMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }

            }
            if (radioButton3.Checked == true)
            {
                if (radioButton4.Checked == true)
                {
                    equ = new Version1(a, b, n, st);
                    equ.calcByRungeKuttaMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
                if (radioButton5.Checked == true)
                {
                    equ = new Version2(a, b, n, st);
                    equ.calcByRungeKuttaMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
                if (radioButton6.Checked == true)
                {
                    equ = new Version3(a, b, n, st);
                    equ.calcByRungeKuttaMethod(chart1);
                    equ.ShowShedule(dataGridView1);
                }
            }
        }


        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

    }
}
