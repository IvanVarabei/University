using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fourth
{
    class XXX : Integral
    {
        public XXX(double a, double b, double n) : base(a, b, n)
        {

        }

        public override double ProcEuat(double x)
        {
            return Math.Pow(x, 3);
        }
    }
}
