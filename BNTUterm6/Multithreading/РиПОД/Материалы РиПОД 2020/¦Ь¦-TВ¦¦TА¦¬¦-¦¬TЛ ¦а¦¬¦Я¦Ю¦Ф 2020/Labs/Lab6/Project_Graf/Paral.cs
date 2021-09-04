using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project_Graf
{
    class Paral
    {
        public int N{get;set;}
        public List<int> NL;
        public int Type_1 { get; set; }
        public int Type_2 { get; set; }
        public string AllN { get; set; }
        public Paral(int n,int type_1,int type_2,string str)
        {
            N = n;
            AllN = str;
            Type_1 = type_1;
            Type_2 = type_2;
            NL = new List<int>();
        }
    }
}
