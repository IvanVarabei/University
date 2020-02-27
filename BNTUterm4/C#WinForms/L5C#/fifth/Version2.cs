using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    class Version2 : Equation
    {
        public Version2(double a, double b, double n) : base(a, b, n)
        {

        }

        public override double procEquation(double x)
        {
            return 0.5 * Math.Pow(x,2) - 1;
        }

        public override double ProcFi(double x)
        {
            return x + 0.5 * x * x - 1;
        }

        public override double Derivative(double x)
        {
            return 0.5 * 2 * x ;
        }
    }
}
