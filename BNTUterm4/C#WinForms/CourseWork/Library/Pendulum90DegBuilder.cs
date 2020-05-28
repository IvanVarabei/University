using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class Pendulum90DegBuilder : PendulumBuilder
    {
        public Pendulum90DegBuilder()
        {
            pendulum = new Pendulum();
        }
        
        public override PendulumBuilder BuildT()
        {
            pendulum.T = 2 * (float)(Math.PI * Math.Sqrt(pendulum.Length / pendulum.Acceleration));
            pendulum.T *= (float)(1 + 0.25 * Math.Pow(Math.Sin(pendulum.MaxAlpha / 2),2) +
                (3/8)* Math.Pow(Math.Sin(pendulum.MaxAlpha / 2), 4));
            return this;
        }
    }
}
