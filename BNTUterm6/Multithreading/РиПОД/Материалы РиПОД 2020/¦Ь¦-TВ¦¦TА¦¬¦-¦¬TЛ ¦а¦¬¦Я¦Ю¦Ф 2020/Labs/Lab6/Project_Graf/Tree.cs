using System.Collections.Generic;

namespace Project_Graf
{
   public class Tree
    {
        public int N {get; set; }
        public int nNext {get;set;}
        public List<int> NLast;
        public int Type {get;set;}
        public Tree(int n, int nnext, int type)
        {
            N = n;
            nNext = nnext;
            Type = type;
            NLast = new List<int>();
        }
    }
}
