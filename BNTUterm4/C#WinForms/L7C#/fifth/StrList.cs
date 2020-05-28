using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace fifth
{
    abstract class StrList : Equation
    {
        List<string> XArr;
        List<string> YArr;

        public StrList(double a, double b, double n, double st) : base(a, b, n, st)
        {
        }
        public override void calcByEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new List<string>();
            YArr = new List<string>();
            while (l < TopBorder)
            {
                c = NumDifferentiation.calcByEulerMethod(l, Precision, conditions);
                XArr.Add("" + l);
                YArr.Add("" + c);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
            }
        }

        public override void calcByModifiedEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new List<string>();
            YArr = new List<string>();
            while (l < TopBorder)
            {
                c = NumDifferentiation.calcByModifiedEulerMethod(l, Precision, conditions);
                XArr.Add("" + l);
                YArr.Add("" + c);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
            }
        }

        public override void calcByRungeKuttaMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new List<string>();
            YArr = new List<string>();
            while (l < TopBorder)
            {
                c = NumDifferentiation.calcByRungeKuttaMethod(l, Precision, conditions);
                XArr.Add("" + l);
                YArr.Add("" + c);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
            }
        }

        public override void ShowShedule(DataGridView s)
        {
            Object[] ms = new object[3];
            for (int i = 0; i < XArr.Count(); i++)
            {
                ms[0] = i;
                ms[1] = XArr[i];
                ms[2] = YArr[i];
                s.Rows.Add(ms);
            }
        }

    }
}
