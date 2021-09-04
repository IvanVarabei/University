using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ProjectLab_7
{
    
    class PlanClassStep
    {
        public int N;
        public int Ves;
        public int Weight;
        public int NNext;
        public PlanClassStep(int n, int ves, int weight, int nnext)
        {
            N = n;
            Ves = ves;
            Weight = weight;
            NNext = nnext;
        }
    }
}
