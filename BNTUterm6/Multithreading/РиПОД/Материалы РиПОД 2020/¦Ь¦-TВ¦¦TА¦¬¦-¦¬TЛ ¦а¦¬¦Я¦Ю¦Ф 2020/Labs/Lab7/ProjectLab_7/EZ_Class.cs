using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ProjectLab_7
{
    class EzClass
    {
        public int N;
        public int Weight;
        public List<ClassObjectPlan> PlanObj;

        public EzClass(int n, int weight)
        {
            N = n;
            Weight = weight;
            PlanObj = new List<ClassObjectPlan>();
        }

    } 
}
