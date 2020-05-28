using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    class Version1 : Array
    {
        

        public Version1(double a, double b, double n, double st) : base(a, b, n, st)
        {
            X0 = 0;
            Y0 = 1;
        }

        public override double Derivative(double x, double y)
        {
            return 2 * x *y;
        }
    }
}
