using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    class Version3 : Map
    {
        public Version3(double a, double b, double n, double st) : base(a, b, n, st)
        {
            X0 = 1;
            Y0 = 3;
        }

        public override double Derivative(double x, double y)
        {
            return x * x * x + x + 3 *y / x;
        }
    }
}
