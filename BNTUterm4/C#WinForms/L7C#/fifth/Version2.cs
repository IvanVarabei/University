using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    class Version2 : StrList
    {
        public Version2(double a, double b, double n, double st) : base(a, b, n, st)
        {
            X0 = 1;
            Y0 = 1;
        }

        public override double Derivative(double x, double y)
        {
            return x*x -2 * y ;
        }
    }
}
