using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public abstract class PendulumBuilder
    {
        protected Pendulum pendulum;
        public PendulumBuilder BuildA(float a)
        {
            pendulum.A = a;
            return this;
        }
        public PendulumBuilder BuildLength(float l)
        {
            pendulum.Length = l;
            return this;
        }

        public PendulumBuilder BuildAcceleration(float g = 9.8f)
        {
            pendulum.Acceleration = g;
            return this;
        }

        public PendulumBuilder BuildMaxAlpha()
        {
            pendulum.MaxAlpha = 2 * (float)Math.Asin(pendulum.A / (2 * pendulum.Length));
            return this;
        }

        public PendulumBuilder BuildInfo(int interval = 30)
        {
            pendulum.Info = new Data();
            pendulum.Info.Interval = interval;
            pendulum.Info.NumberOfShots =(int) ((pendulum.T * 1000) / interval);
            return this;
        }

        public abstract PendulumBuilder BuildT();

        public Pendulum Build()
        {
            return pendulum;
        }
    }
}
