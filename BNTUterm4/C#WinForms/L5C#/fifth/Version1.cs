using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    class Version1 : Equation
    {

        public Version1(double a, double b, double n) : base(a, b, n)
        {

        }
        public override double procEquation(double x)
        {
            return x * x + 2 * x - 3;
        }

        public override double ProcFi(double x)
        {
            return 3 / (x + 2);
        }

        public override double Derivative(double x)
        {
            return 2 * x + 2;
        }
    }
}
