using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    class Version9 : Equation
    {
        public Version9(double a, double b, double n) : base(a, b, n)
        {

        }

        public override double procEquation(double x)
        {
            return 0.25*Math.Pow(x,3) + x - 1.25;
        }
        //ok
        public override double ProcFi(double x)
        {
            return 1.25/(0.25*x*x +1);
        }

        public override double Derivative(double x)
        {
            return 0.25 * 3 * x * x + 1;
        }
    }
}
