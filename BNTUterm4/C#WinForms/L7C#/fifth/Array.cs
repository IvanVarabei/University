using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace fifth
{
    abstract class Array : Equation
    {
        double[] XArr;
        double[] YArr;

        public Array(double a, double b, double n, double st) : base(a, b, n, st)
        {
        }
        public override void calcByEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new double[1 + Math.Abs((int)((TopBorder - BottomBorder) / Step))];
            YArr = new double[1 + Math.Abs((int)((TopBorder - BottomBorder) / Step))];
            int i = 0;
            while (l < TopBorder)
            {
                XArr[i] = l;
                YArr[i] = c = NumDifferentiation.calcByEulerMethod(l, Precision, conditions);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
                i++;
            }
        }

        public override void calcByModifiedEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new double[1 + Math.Abs((int)((TopBorder - BottomBorder) / Step))];
            YArr = new double[1 + Math.Abs((int)((TopBorder - BottomBorder) / Step))];
            int i = 0;
            while (l < TopBorder)
            {
                XArr[i] = l;
                YArr[i] = c = NumDifferentiation.calcByModifiedEulerMethod(l, Precision, conditions);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
                i++;
            }
        }

        public override void calcByRungeKuttaMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new double[1 + Math.Abs((int)((TopBorder - BottomBorder) / Step))];
            YArr = new double[1 + Math.Abs((int)((TopBorder - BottomBorder) / Step))];
            int i = 0;
            while (l < TopBorder)
            {
                XArr[i] = l;
                YArr[i] = c = NumDifferentiation.calcByRungeKuttaMethod(l, Precision, conditions);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
                i++;
            }
        }

        public override void ShowShedule(DataGridView s)
        {
            Object[] ms = new object[3];
            for(int i =1; i< XArr.Length; i++)
            {
                ms[0] = i;
                ms[1] = XArr[i - 1];
                ms[2] = YArr[i - 1];
                s.Rows.Add(ms);
            }
        }

    }
}
