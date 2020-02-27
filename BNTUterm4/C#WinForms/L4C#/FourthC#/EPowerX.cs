using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fourth
{
    class EPowerX : Integral
    {
        public EPowerX(double a, double b, double n) : base(a, b, n)
        {

        }

        public override double ProcEuat(double x)
        {
            return Math.Pow(Math.E, x);
        }
    }
}
