using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace fifth
{
    abstract class Map : Equation
    {
        Dictionary<double, double> XArr;

        public Map(double a, double b, double n, double st) : base(a, b, n, st)
        {
        }
        public override void calcByEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new Dictionary<double, double>();
            while (l < TopBorder)
            {
                c = NumDifferentiation.calcByEulerMethod(l, Precision, conditions);
                XArr.Add(l, c);  
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
            }
        }

        public override void calcByModifiedEulerMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new Dictionary<double, double>();
            while (l < TopBorder)
            {
                c = NumDifferentiation.calcByModifiedEulerMethod(l, Precision, conditions);
                XArr.Add(l, c);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
            }
        }

        public override void calcByRungeKuttaMethod(Chart chart1)
        {
            CauchyConditions conditions = new CauchyConditions(this);
            double l = BottomBorder, c;
            XArr = new Dictionary<double, double>();
            while (l < TopBorder)
            {
                c = NumDifferentiation.calcByRungeKuttaMethod(l, Precision, conditions);
                XArr.Add(l, c);
                chart1.Series[0].Points.AddXY(l, c);
                l += Step;
            }
        }

        public override void ShowShedule(DataGridView s)
        {
            Object[] ms = new object[3];
            int i = 1;
            foreach(KeyValuePair<double,double> key in XArr)
            {
                ms[0] = i;
                ms[1] = key.Key;
                ms[2] = key.Value;
                s.Rows.Add(ms);
            }
        }

    }
}
