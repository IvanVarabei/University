using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project_2
{
   public class Tree
    {
        public int N;
        public int Npri;
        public bool End;
        public int Type;
        public List<Tree> list;
        public Tree(int n, int nPri, bool end, int type, List<Tree> lIst )
        {
            N = n;
            End = end;
            Type = type;
            Npri = nPri;
            if (lIst != null)
            {
                list = lIst;
            }
            else list = null;
        }
    }
}
