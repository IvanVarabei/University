using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    public class CauchyConditions
    {
        public double X0 { get; private set; }
        public double Y0 { get; private set; }//значение решения задачи Коши в точке x0
        public Func<double, double, double> FirstDeritative { get; private set; }//y' = f(x, y)
        public CauchyConditions(double x0, double y0, Func<double, double, double> firstDeritative)
        {
            this.X0 = x0;
            this.Y0 = y0;
            this.FirstDeritative = firstDeritative;
        }

        public CauchyConditions(Equation e)
        {
            this.X0 = e.X0;
            this.Y0 = e.Y0;
            this.FirstDeritative = e.Derivative;
        }
    }
}
