using System;
using System.Windows.Forms.DataVisualization.Charting;

namespace fourth
{
    public class Integral
    {
        const double DefaultNumOfSteps = 100;
        const double DefaultBottomBorder = 0;
        const double DefaultTopBorder = 1;


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
        public double BottomBorder
        {
            get
            {
                return bottomBorder;
            }
            set
            {
                    bottomBorder = value;
            }
        }
        public void SetBottomBorder(double v)
        {
                BottomBorder = v;
        }









        private double topBorder;
        public double TopBorder
        {
            get
            {
                return topBorder;
            }
            set
            {
                    topBorder = value;
            }
        }
        public void SetTopBorder(double v)
        {
                TopBorder = v;
        }








        public Integral(double bb, double tb, double ns)
        {
            if (bb <= tb)
            {
                bottomBorder = bb;
                topBorder = tb;
            }
            else
            {
                bottomBorder = DefaultBottomBorder;
                topBorder = DefaultTopBorder;
            }
            if (ns > 1)
                this.numberOfSteps = ns;
            else
                this.numberOfSteps = DefaultNumOfSteps;
        }

        public Integral()
        {

        }

        //a static member can not be marked as override, virtual,abstract
        public virtual double ProcEuat(double x)
        {
            return x;
        }




        public double ProcLeftS()
        {
            double res = 0, h = (topBorder - bottomBorder) / (numberOfSteps + 1),
                x = bottomBorder + h;
            for (int i = 0; i < numberOfSteps; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }


        public double ProcRightS()
        {
            double res = 0, h = (topBorder - bottomBorder) / (numberOfSteps + 1),
                x = bottomBorder;
            for (int i = 0; i < numberOfSteps; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }


        public double ProcMidlS()
        {
            double res = 0, h = (topBorder - bottomBorder) / (numberOfSteps + 1),
                x = bottomBorder + h / 2;
            for (int i = 0; i < numberOfSteps; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }


        public double ProcTrapeze()
        {
            double res = 0, h = (topBorder - bottomBorder) / (numberOfSteps + 1),
                x = bottomBorder;
            for (int i = 0; i < numberOfSteps; i++, x += h)
            {
                double vf = (ProcEuat(x) + ProcEuat(x + h)) / 2;
                    res += h * (ProcEuat(x) + ProcEuat(x + h)) / 2;               
            }
            return res;
        }


        public void DrawLeftLine(Chart chart1)
        {
            double h = (topBorder - bottomBorder) / DefaultNumOfSteps, x = bottomBorder;
            for (int i = 0; i < DefaultNumOfSteps + 1; i++, x += h)
            {
                chart1.Series[1].Points.AddXY(x, ProcEuat(x));
            }
        }

        public void DrawRightLine(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / DefaultNumOfSteps, x = BottomBorder;
            for (int i = 0; i < DefaultNumOfSteps + 1; i++, x += h)
            {
                chart1.Series[3].Points.AddXY(x, ProcEuat(x));
            }
        }


        public void DrawColor1(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / NumberOfSteps, x = BottomBorder;
            for (int i = 0; i < NumberOfSteps + 1; i++, x += h)
            {
                chart1.Series[0].Points.AddXY(x, ProcEuat(x));
            }
        }


        public void DrawColor2(Chart chart1)
        {
            double h = (TopBorder - BottomBorder) / NumberOfSteps, x = BottomBorder;
            for (int i = 0; i < NumberOfSteps + 1; i++, x += h)
            {
                chart1.Series[2].Points.AddXY(x, ProcEuat(x));
            }
        }


        public virtual bool HalfwitCheck(double a, double b, double n)
        {
            return !(b < a || a < 0 || n < 1);
        }
    }
}

