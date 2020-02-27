using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;
using Timer = System.Windows.Forms.Timer;

namespace fifth
{
    abstract class Equation
    {
        public const double DefaultPrecision = 0.1;
        public const double DefaultBottomBorder = 1;
        public const double DefaultTopBorder = 2;
        public const double DefaultNumOfSteps = 100;

        public Equation(double bb, double tb, double pr)
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
            if (pr <= 1)
                this.precision = pr;
            else
                this.precision = DefaultPrecision;
        }

        public Equation()
        {

        }

        private double precision;
        public double Precision
        {
            get
            {
                return precision;
            }
            set
            {
                if (value <= 1)
                {
                    precision = value;
                }
                else
                {
                    precision = DefaultPrecision;
                }
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
        //
        public abstract double procEquation(double x);
        public abstract double ProcFi(double x);
        public abstract double Derivative(double x);

        public void DrawLine(Chart chart1)
        {
            double h = (topBorder - bottomBorder) / DefaultNumOfSteps, x = bottomBorder;

            for (int i = 0; i < DefaultNumOfSteps + 1; i++, x += h)
            {
                
                chart1.Series[0].Points.AddXY(x, procEquation(x));
            }
        }

        public void DrowHD(Chart chart1, double time)
        {
            double t = topBorder, b = bottomBorder, midl;
            var timer = new Timer();
            timer.Interval =(int) time;
            timer.Tick += (sender, args) =>
            {
                chart1.Series[1].Points.AddXY(b, 0);
                chart1.Series[1].Points.AddXY(t, 0);
                midl = t - (t - b) / 2;
                if (Math.Abs(t - b) <= precision)
                {
                    timer.Stop();
                }
                if ((procEquation(midl) > 0 && procEquation(t) < 0) || (procEquation(midl) < 0 && procEquation(t) > 0))
                {
                    b = midl;
                }
                else
                {
                    t = midl;

                }
            };
            timer.Start();
        }

        public void DrowI(Chart chart1, double time)
        {
            double eps = precision,x = BottomBorder + (TopBorder - BottomBorder)/2,
                xLast, dx = double.MaxValue;
            var timer = new Timer();
            timer.Interval = (int)time;
            timer.Tick += (sender, args) =>
            {
                xLast = x;
                x = ProcFi(xLast);
                dx = x - xLast;
                if((BottomBorder<= x && x <=TopBorder) && (BottomBorder <= xLast && xLast<= TopBorder))
                {
                    chart1.Series[2].Points.AddXY(xLast, procEquation(xLast));
                    chart1.Series[2].Points.AddXY(x, 0);
                }
                
                if (Math.Abs(dx) < eps)
                {
                    timer.Stop();
                }
            }; timer.Start();
                       
        }

        public void DrowN(Chart chart1, double time)
        {
            var timer = new Timer();
            timer.Interval = (int)time;
            ///double x1, y, x = BottomBorder+ (TopBorder- BottomBorder)/2;
            double x1, y, x = BottomBorder;
            timer.Tick += (sender, args) =>
            {
                chart1.Series[2].Points.AddXY(x, procEquation(x));
                x1 = x - procEquation(x) / Derivative(x);
                chart1.Series[2].Points.AddXY(x1, 0);
                x = x1;
                y = procEquation(x);
                if (Math.Abs(y) <= precision)
                {
                    timer.Stop();
                }
            };
            timer.Start();
            
        }

        public String ProcHD()
        {
            double t = topBorder, b = bottomBorder, midl, h = Math.Abs(t-b)/100, x=b;
            Boolean fl = true;
            for(int i =0; i< 100; i++)
            {
                if (procEquation(x) < 0 && procEquation(x+h) > 0 || procEquation(x) > 0 && procEquation(x+h) < 0)
                {
                    fl = false;
                    break;
                }
                x += h;
            }
            if (fl)
            {
                return "INDEFINED";
            }

            while (true)
            {
                midl = t - (t - b) / 2;
                if (Math.Abs(t - b) <= precision)
                {
                    if (BottomBorder < midl && midl < TopBorder)
                        return midl.ToString();
                    else
                        return "INDEFINED";
                }
                if ((procEquation(midl) > 0 && procEquation(t) < 0) || (procEquation(midl) < 0 && procEquation(t) > 0))
                {
                    b = midl;
                }
                else
                {
                    t = midl;
                }
            }
        }

        public String ProcI()
        {
            double eps = precision, x  = BottomBorder + (TopBorder - BottomBorder) / 2,
                xLast, dx = double.MaxValue;
            while (Math.Abs(dx)>eps)
            {
                xLast = x;
                x = ProcFi(xLast);
                dx = x - xLast;
            }
            if (BottomBorder < x && x < TopBorder)
                return x.ToString();
            else
                return "INDEFINED";

        }

        public String ProcN()
        {
            double x1, y, x = BottomBorder;
            do
            {
                x1 = x - procEquation(x) / Derivative( x);
                x = x1;
                y = procEquation(x);
            }
            while (Math.Abs(y) >= precision);
            if (BottomBorder < x && x < TopBorder)
                return x.ToString();
            else
                return "INDEFINED";
        }

    }
}
