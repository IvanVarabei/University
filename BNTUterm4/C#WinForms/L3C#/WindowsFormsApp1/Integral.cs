using Syncfusion.Windows.Forms.Chart;
using System;
using System.Windows.Forms.DataVisualization.Charting;

namespace WindowsFormsApp1
{
    public class Integral
    {
        const double DefaultNumOfSteps = 100;
        const double DefaultBottomBorder = 0;
        const double DefaultTopBorder = Double.MaxValue;


        private double numberOfSteps;
        public double NumberOfSteps
        {
            get
            {
                return numberOfSteps;
            }
            set
            {
                if (value > 1)
                {
                    numberOfSteps = value;
                }
                else
                {
                    numberOfSteps = DefaultNumOfSteps;
                }
            }
        }
        public void SetNumberOfSteps(double v)
        {
            if (v > 1)
            {
                NumberOfSteps = v;
            }
            else
            {
                NumberOfSteps = DefaultNumOfSteps;
            }
        }











        private double bottomBorder;
        public double BottomBorder{ 
        get{
            return bottomBorder;
            }
        set{
            if (value >= 0)
            {
                bottomBorder = value;
            }
            else
            {
                bottomBorder = DefaultBottomBorder;
            }
            }
        }
        public void SetBottomBorder(double v)
        {
            if (v >= 0)
            {
                BottomBorder = v;
            }
            else
            {
                BottomBorder = DefaultBottomBorder;
            }
        }









        private double topBorder;
        public double TopBorder
        {
            get
            {
                return topBorder;
            }
            set{
                if (value >= 0)
                {
                    topBorder = value;
                }
                else
                {
                    topBorder = DefaultTopBorder;
                }
            }
        }
        public void SetTopBorder(double v)
        {
            if (v > 0)
            {
                TopBorder = v;
            }
        }








        public Integral(double bottomBorder, double topBorder, double nunberOfSteps)
        {
            BottomBorder = bottomBorder;
            TopBorder = topBorder;
            NumberOfSteps = nunberOfSteps;
        }

        public Integral()
        {

        }


        public virtual double ProcEuat(double x)
        {
            return (Math.Log(1 + Math.Sqrt(x))) / (1 + Math.Sqrt(x));
        }





        public double ProcTrapeze()
        {
            double res = 0, h = (TopBorder - BottomBorder) / (NumberOfSteps + 1),
                x = BottomBorder;
            for (int i = 0; i < NumberOfSteps; i++, x += h)
            {
                res += h * (ProcEuat(x) + ProcEuat(x + h)) / 2;
            }
            return res;
        }


        public void DrawLine(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / DefaultNumOfSteps, x = BottomBorder;
            for (int i = 0; i < DefaultNumOfSteps + 1; i++, x += h)
            {
                chart1.Series[5].Points.AddXY(x, ProcEuat(x));
            }
        }


        public void DrawColor1(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / NumberOfSteps, x = BottomBorder;
            for (int i = 0; i< NumberOfSteps + 1; i++, x += h)
            {
                    chart1.Series[0].Points.AddXY(x, ProcEuat(x));
            }
        }

        public void DrawColor11(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / NumberOfSteps, x = BottomBorder;
            for (int i = 0; i < NumberOfSteps + 1; i++, x += h)
            {
                chart1.Series[1].Points.AddXY(x, ProcEuat(x));
            }
        }


        public void DrawColor2(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / NumberOfSteps, x = BottomBorder;
            for (int i = 0; i < NumberOfSteps+1; i++, x += h)
            {
                    chart1.Series[2].Points.AddXY(x, ProcEuat(x));
            }
        }

        public void DrawColor22(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / NumberOfSteps, x = BottomBorder;
            for (int i = 0; i < NumberOfSteps + 1; i++, x += h)
            {
                chart1.Series[3].Points.AddXY(x, ProcEuat(x));
            }
        }

        public void DrawColor3(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / NumberOfSteps, x = BottomBorder;
            for (int i = 0; i < NumberOfSteps+1; i++, x += h)
            {
                    chart1.Series[4].Points.AddXY(x, ProcEuat(x));
            }
        }


        public static bool HalfwitCheck(double a, double b, double n)
        {
            return !(b < a || a < 0 || n < 1);
        }
    }
}
