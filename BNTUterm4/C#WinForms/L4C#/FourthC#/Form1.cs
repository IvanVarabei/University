using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace fourth
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void CleanLeft()
        {
            chart1.Series[0].Points.Clear();
            chart1.Series[1].Points.Clear();
        }

        private void CleanRight()
        {
            chart1.Series[2].Points.Clear();
            chart1.Series[3].Points.Clear();
        }
        //1
        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            CleanLeft();
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            XX integral = new XX(a, b, n);
            //integral.
            integral.DrawColor1(chart1);
            integral.DrawLeftLine(chart1);
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            CleanLeft();
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            XXX integral = new XXX(a, b, n);
            integral.DrawColor1(chart1);
            integral.DrawLeftLine(chart1);
        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            CleanLeft();
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            EPowerX integral = new EPowerX(a, b, n);
            integral.DrawColor1(chart1);
            integral.DrawLeftLine(chart1);

        }

        private void radioButton4_CheckedChanged(object sender, EventArgs e)
        {
            CleanLeft();
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            ABSx integral = new ABSx(a, b, n);
            integral.DrawColor1(chart1);
            integral.DrawLeftLine(chart1);
        }
        //2
        private void radioButton5_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            ProcLSHere1(a, b, n);
            ProcOther1();
        }     

        private void radioButton6_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            ProcRSHere1(a, b, n);
            ProcOther1();
        }

        private void radioButton7_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            ProcMSHere1(a, b, n);
            ProcOther1();
        }

        private void radioButton8_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text);
            ProcTrapezeHere1(a, b, n);
            ProcOther1();
        }
        //3
        private void radioButton9_CheckedChanged(object sender, EventArgs e)
        {
            CleanRight();
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            XX integral = new XX(a, b, n);
            integral.DrawColor2(chart1);
            integral.DrawRightLine(chart1);

        }

        private void radioButton10_CheckedChanged(object sender, EventArgs e)
        {
            CleanRight();
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            XXX integral = new XXX(a, b, n);
            integral.DrawColor2(chart1);
            integral.DrawRightLine(chart1);
        }

        private void radioButton11_CheckedChanged(object sender, EventArgs e)
        {
            CleanRight();
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            EPowerX integral = new EPowerX(a, b, n);
            integral.DrawColor2(chart1);
            integral.DrawRightLine(chart1);

        }

        private void radioButton12_CheckedChanged(object sender, EventArgs e)
        {
            CleanRight();
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            ABSx integral = new ABSx(a, b, n);
            integral.DrawColor2(chart1);
            integral.DrawRightLine(chart1);

        }
        //4
        private void radioButton13_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            ProcLSHere2(a, b, n);
            ProcOther2();
        }

        private void radioButton14_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            ProcRSHere2(a, b, n);
            ProcOther2();
        }

        private void radioButton15_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            ProcMSHere2(a, b, n);
            ProcOther2();
        }

        private void radioButton16_CheckedChanged(object sender, EventArgs e)
        {
            double a = double.Parse(textBox5.Text), b = double.Parse(textBox4.Text),
                n = double.Parse(textBox6.Text);
            ProcTrapezeHere2(a, b, n);
            ProcOther2();
        }
        //1/1
        private void ProcLSHere1(double a, double b, double n)
        {
            if (radioButton1.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label1.Text = integral.ProcLeftS().ToString();
            }
            if (radioButton2.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label1.Text = integral.ProcLeftS().ToString();
            }
            if (radioButton3.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label1.Text = integral.ProcLeftS().ToString();
            }
            if (radioButton4.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label1.Text = integral.ProcLeftS().ToString();
            }
        }
       
        private void ProcRSHere1(double a, double b, double n)
        {
            if (radioButton1.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label1.Text = integral.ProcRightS().ToString();
            }
            if (radioButton2.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label1.Text = integral.ProcRightS().ToString();
            }
            if (radioButton3.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label1.Text = integral.ProcRightS().ToString();
            }
            if (radioButton4.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label1.Text = integral.ProcRightS().ToString();
            }
        }

        private void ProcMSHere1(double a, double b, double n)
        {
            if (radioButton1.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label1.Text = integral.ProcMidlS().ToString();
            }
            if (radioButton2.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label1.Text = integral.ProcMidlS().ToString();
            }
            if (radioButton3.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label1.Text = integral.ProcMidlS().ToString();
            }
            if (radioButton4.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label1.Text = integral.ProcMidlS().ToString();
            }
        }

        private void ProcTrapezeHere1(double a, double b, double n)
        {
            if (radioButton1.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label1.Text = integral.ProcTrapeze().ToString();
            }
            if (radioButton2.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label1.Text = integral.ProcTrapeze().ToString();
            }
            if (radioButton3.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label1.Text = integral.ProcTrapeze().ToString();
            }
            if (radioButton4.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label1.Text = integral.ProcTrapeze().ToString();
            }
        }
        //2/2
        private void ProcLSHere2(double a, double b, double n)
        {
            if (radioButton9.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label13.Text = integral.ProcLeftS().ToString();
            }
            if (radioButton10.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label13.Text = integral.ProcLeftS().ToString();
            }
            if (radioButton11.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label13.Text = integral.ProcLeftS().ToString();
            }
            if (radioButton12.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label13.Text = integral.ProcLeftS().ToString();
            }
        }
        
        private void ProcRSHere2(double a, double b, double n)
        {
            if (radioButton9.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label13.Text = integral.ProcRightS().ToString();
            }
            if (radioButton10.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label13.Text = integral.ProcRightS().ToString();
            }
            if (radioButton11.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label13.Text = integral.ProcRightS().ToString();
            }
            if (radioButton12.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label13.Text = integral.ProcRightS().ToString();
            }
        }

        private void ProcMSHere2(double a, double b, double n)
        {
            if (radioButton9.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label13.Text = integral.ProcMidlS().ToString();
            }
            if (radioButton10.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label13.Text = integral.ProcMidlS().ToString();
            }
            if (radioButton11.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label13.Text = integral.ProcMidlS().ToString();
            }
            if (radioButton12.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label13.Text = integral.ProcMidlS().ToString();
            }
        }

        private void ProcTrapezeHere2(double a, double b, double n)
        {
            if (radioButton9.Checked == true)
            {
                XX integral = new XX(a, b, n);
                label13.Text = integral.ProcTrapeze().ToString();
            }
            if (radioButton10.Checked == true)
            {
                XXX integral = new XXX(a, b, n);
                label13.Text = integral.ProcTrapeze().ToString();
            }
            if (radioButton11.Checked == true)
            {
                EPowerX integral = new EPowerX(a, b, n);
                label13.Text = integral.ProcTrapeze().ToString();
            }
            if (radioButton12.Checked == true)
            {
                ABSx integral = new ABSx(a, b, n);
                label13.Text = integral.ProcTrapeze().ToString();
            }
        }

        private void ProcOther1()
        {
            double c1 = 0, c2 = 0;
            if (label1.Text != "INDEFINED")
            {
                c1 = Convert.ToDouble(label1.Text);
            }
            if (label13.Text != "INDEFINED")
            {
                c2 = Convert.ToDouble(label13.Text);
                label15.Text = (c1 + c2).ToString();
                label16.Text = (Math.Abs(c1 - c2)).ToString();
            }
        }

        private void ProcOther2()
        {
            double c1 = 0, c2=0;
            if (label13.Text != "INDEFINED")
            {
                c1 = Convert.ToDouble(label13.Text);
            }
            if (label1.Text != "INDEFINED")
            {
                c2 = Convert.ToDouble(label1.Text);
                label15.Text = (c1 + c2).ToString();
                label16.Text = (Math.Abs(c1 - c2)).ToString();
            }
        }
    }
}


/*

using System;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        Integral left = new Integral();
        Integral right = new Integral();
        Integral line = new Integral();

        public Form1()
        {
            InitializeComponent();
        }


        private void CleanChart()
        {
            chart1.Series[0].Points.Clear();
            chart1.Series[1].Points.Clear();
            chart1.Series[2].Points.Clear();
            chart1.Series[3].Points.Clear();
            chart1.Series[4].Points.Clear();
            chart1.Series[5].Points.Clear();
        }

        private void OutputInfo(double a, double b, double n, double a1, double b1, double n1,Integral general=null)
        {
            left.SetBottomBorder(a);
            left.SetTopBorder(b);
            left.SetNumberOfSteps(n);

            right.SetBottomBorder(a1);
            right.SetTopBorder(b1);
            right.SetNumberOfSteps(n1);


            label1.Text = left.ProcTrapeze().ToString();
            label13.Text = right.ProcTrapeze().ToString();
            label15.Text = (left.ProcTrapeze() + right.ProcTrapeze()).ToString();
            label16.Text = (Math.Abs(left.ProcTrapeze() - right.ProcTrapeze())).ToString();
            if (general != null)
            {
                label18.Text = general.ProcTrapeze().ToString();
            }
        }

        private void DrawLFTR(double a, double b, double n, double a1, double b1, double n1)
        {
            line.BottomBorder=a;
            line.TopBorder=b1;

            right.BottomBorder=a1;
            right.TopBorder=b1;
            right.NumberOfSteps=n1;
            

            left.BottomBorder=a;
            left.TopBorder=b;
            left.NumberOfSteps=n;

            line.DrawLine(chart1);
            left.DrawColor1(chart1);
            right.DrawColor2(chart1);
        }
     
        private void DrawRFTL(double a, double b, double n, double a1, double b1, double n1)
        {
            line.BottomBorder=a1;
            line.TopBorder=b;

            right.BottomBorder=a1;
            right.TopBorder=b1;
            right.NumberOfSteps=n1;

            left.BottomBorder=a;
            left.TopBorder=b;
            left.NumberOfSteps=n;

            line.DrawLine(chart1);
            left.DrawColor1(chart1);
            right.DrawColor2(chart1);
        }  

        private void DrawRIL(double a, double b, double n, double a1, double b1, double n1, Integral general)
        {
            line.BottomBorder=a;
            line.TopBorder=b;
            
            left.NumberOfSteps=n;
            left.BottomBorder=a;
            left.TopBorder=a1;
            left.DrawColor1(chart1);
            left.BottomBorder=b1;
            left.TopBorder=b;
            left.DrawColor11(chart1);

            line.DrawLine(chart1);
            general.DrawColor3(chart1);
        }

        private void DrawLIR(double a, double b, double n, double a1, double b1, double n1, Integral general)
        {
            line.BottomBorder=a1;
            line.TopBorder=b1;
            
            right.NumberOfSteps=n;
            right.BottomBorder=a1;
            right.TopBorder=a;
            right.DrawColor2(chart1);
            right.BottomBorder=b;
            right.TopBorder=b1;
            right.DrawColor22(chart1);

            line.DrawLine(chart1);
            general.DrawColor3(chart1);
        }

        private void DrawLFO(double a, double b, double n, double a1, double b1, double n1, Integral general)
        {
            line.BottomBorder=a;
            line.TopBorder=b1;
            
            left.NumberOfSteps=n;
            left.BottomBorder=a;
            left.TopBorder=a1;
            
            right.NumberOfSteps=n1;
            right.BottomBorder=b;
            right.TopBorder=b1;

            left.DrawColor1(chart1);
            right.DrawColor2(chart1);
            general.DrawColor3(chart1);
            line.DrawLine(chart1);
        }

        private void DrawRFO(double a, double b, double n, double a1, double b1, double n1, Integral general)
        {
            line.BottomBorder=a1;
            line.TopBorder=b;
          
            right.NumberOfSteps=n1;
            right.BottomBorder=a1;
            right.TopBorder=a;

            left.NumberOfSteps=n;
            left.BottomBorder=b1;
            left.TopBorder=b;

            right.DrawColor2(chart1);
            left.DrawColor1(chart1);
            general.DrawColor3(chart1);
            line.DrawLine(chart1);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            CleanChart();
            double a = double.Parse(textBox1.Text), b = double.Parse(textBox2.Text),
                n = double.Parse(textBox3.Text), a1 = double.Parse(textBox5.Text),
                b1 = double.Parse(textBox4.Text), n1 = double.Parse(textBox6.Text);
            if (Integral.HalfwitCheck(a, b, n) && Integral.HalfwitCheck(a1, b1, n1))
            {
                label7.Text = "OK";
                if (a < a1 && b <= a1)
                {
                    DrawLFTR(a, b, n, a1, b1, n1);
                    OutputInfo(a, b, n, a1, b1, n1);
                    return;
                }
                if (a > a1 && b1 <= a)//at first right,then left
                {
                    DrawRFTL(a, b, n, a1, b1, n1);
                    OutputInfo(a, b, n, a1, b1, n1);
                    return;
                }
                if (a <= a1 && b1 <= b)
                {
                    Integral general = new Integral(a1, b1, 50);
                    DrawRIL(a, b, n, a1, b1, n1,general);
                    OutputInfo(a, b, n, a1, b1, n1, general);
                    return;
                }
                if (a1 <= a && b <= b1)
                {
                    Integral general = new Integral(a, b, 50);
                    DrawLIR(a, b, n, a1, b1, n1, general);
                    OutputInfo(a, b, n, a1, b1, n1, general);
                    return;
                }
                if (a < a1 && b > a1)//left at first overlay
                {
                    Integral general = new Integral(a1, b, 50);
                    
                    DrawLFO(a, b, n, a1, b1, n1,general);
                    OutputInfo(a, b, n, a1, b1, n1, general);
                    return;
                }
                if (a1 < a && b1 > a)//right at first overlay
                {
                    Integral general = new Integral(a, b1, 50);
                    DrawRFO(a, b, n, a1, b1, n1, general);
                    OutputInfo(a, b, n, a1, b1, n1, general);
                    return;
                }
            }
            else
            {
                label7.Text = "DATA ERROR!";
                label15.Text = "INDEFINED";
                label16.Text = "INDEFINED";
                label1.Text = "INDEFINED";
                label13.Text = "INDEFINED";
                label18.Text = "INDEFINED";
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}


    */
