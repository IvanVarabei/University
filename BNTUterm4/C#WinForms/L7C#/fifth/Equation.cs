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
    public abstract class Equation
    {
        public const double DefaultPrecision = 0.1;
        public const double DefaultBottomBorder = 1;
        public const double DefaultTopBorder = 2;
       // public const double DefaultNumOfSteps = 100;

    public Equation(double bb, double tb, double pr, double st)
        {
            Step = st;
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


        public double X0 { get; set; }
        public double Y0 { get; set; }
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

        public double Step { get; set; }

        public abstract double Derivative(double x,double y);
        public abstract void ShowShedule(DataGridView s);

        public virtual void calcByEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder;
            while (l<TopBorder)
            {            
                chart1.Series[0].Points.AddXY(l, NumDifferentiation.calcByEulerMethod(
                    l, precision, conditions));
                l += Step;
            }
        }

        public virtual void calcByModifiedEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder;
            while (l < TopBorder)
            {
                chart1.Series[0].Points.AddXY(l, NumDifferentiation.calcByModifiedEulerMethod(
                    l, precision, conditions));
                l += Step;
            }
        }

        public virtual void calcByRungeKuttaMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder;
            while (l < TopBorder)
            {
                chart1.Series[0].Points.AddXY(l, NumDifferentiation.calcByRungeKuttaMethod(
                    l, precision, conditions));
                l += Step;
            }
        }

    }
}
