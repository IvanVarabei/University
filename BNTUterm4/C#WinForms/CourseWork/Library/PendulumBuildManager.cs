using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class PendulumBuildManager
    {
        PendulumBuilder Builder;
        public PendulumBuildManager(PendulumBuilder builder)
        {
            Builder = builder;
        }

        public Pendulum Produce(float l, float a, float g)
        {
            return Builder.BuildA(a)
                          .BuildLength(l)
                          .BuildAcceleration(g)
                          .BuildMaxAlpha()
                          .BuildT()
                          .BuildInfo()
                          .Build();
        }
    }
}
