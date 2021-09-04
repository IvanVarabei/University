using System.Collections.Generic;

namespace Project_Graf
{
    class CreateGfafList
    {
        public List<Tree> GetList(int[][] massGraf, int[] massType, int n)
        {
            List<Tree> tree = new List<Tree>();
            for (int i = 0; i < n; i++)
            {
                tree.Add(new Tree(i + 1, 0, massType[i]));
            }
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    if (massGraf[i][j] == 1)
                    {
                        tree[i].nNext = j+1;

                        tree[j].NLast.Add(i+1);
                    }
                }
            }
            return tree;
        }

    }
}
