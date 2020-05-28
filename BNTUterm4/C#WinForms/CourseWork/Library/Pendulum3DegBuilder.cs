using System;

namespace Library
{
    public class Pendulum3DegBuilder : PendulumBuilder
    {
        public Pendulum3DegBuilder()
        {
            pendulum = new Pendulum();
        }

        public override PendulumBuilder BuildT()
        {
            pendulum.T = 2 * (float)(Math.PI * Math.Sqrt(pendulum.Length / pendulum.Acceleration));
            return this;
        }
    }
}
