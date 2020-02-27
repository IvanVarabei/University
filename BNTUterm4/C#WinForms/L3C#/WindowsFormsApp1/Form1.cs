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
