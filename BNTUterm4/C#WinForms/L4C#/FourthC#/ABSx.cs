using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fourth
{
    public class ABSx : Integral
    {
        public ABSx(double a, double b, double n) : base(a, b, n)
        {

        }

        public override double ProcEuat(double x)
        {
            return Math.Abs(x);
        }
    }
}
