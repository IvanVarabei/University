using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
namespace Project_Graf
{
    class ClassAllClass
    {
        public DrawGraf drawgraf;
        public DataGridViewManager datamanager;
        public MovePoint movepoint;
        public List<Tree> tree;
        public CreateGfafList createGraflist;
        public int[] masType;
        public int[][] masGraf;
        public List<Paral> paral;

        public ClassAllClass()
        {
            datamanager = new DataGridViewManager();
            movepoint = new MovePoint();
            paral = new List<Paral>();
            tree = new List<Tree>();
            createGraflist = new CreateGfafList();

        }

        public int CreateDrawGraf(int n)
        {
            drawgraf = new DrawGraf(masGraf, masType, n);
            return 0;
        }

        public int MassGrafType(DataGridView datagridType, DataGridView datagridGraf)
        {
            masType = datamanager.GetStringMassGridType(datagridType);
            masGraf = datamanager.GetStringMassGridGraf(datagridGraf);
            return 0;
        }

        public int ClearDraw()
        {
            drawgraf.g.Clear(Color.White);
            return 0;
        }
        public int List(int n)
        {
            tree = createGraflist.GetList(masGraf, masType, n);
            return 0;
        }

        public void Plain(int n)
        {
            int begin = 0;
            int next = 0;
            int coll = paral.Count;
            int x = 0;
            int sw = 0;
            //int x_1 = 0;
            int x_0 = 0;
            int x_2 = 0;
            for (int h = 0; h < paral.Count; h++)
            {
                if(paral[h].N != 999)
                {
                    if(x_0 == 0)
                    {
                        x_0 = h;
                    }
                    else
                    {
                        x_2 = h;
                    }
                    sw++;
                }
            }
            if(sw == 2)
            {
                int c = 0;
                foreach(int _int in paral[x_0].NL)
                {
                    if(_int == x_2 + 1)
                    {
                        c++;
                    }
                }
                if(c == 0)
                {
                    paral[x_0].AllN += paral[x_2].AllN;
                    if (paral[x_0].Type_1 < paral[x_2].Type_1)
                    {
                        paral[x_0].Type_1 = paral[x_2].Type_1;
                    }
                    if (paral[x_0].Type_2 < paral[x_2].Type_2)
                    {
                        paral[x_0].Type_2 = paral[x_2].Type_2;
                    }
                    paral[x_2].N = 999;
                }
                else
                {
                    paral[x_0].AllN += paral[x_2].AllN;
                    paral[x_0].Type_1 += paral[x_2].Type_1;
                    paral[x_0].Type_2 += paral[x_2].Type_2;
                    paral[x_2].N = 999;
                }
            }
            for (int j = 0; j < coll; j++)
            {
                if ((paral[j].N != 999) && (paral[j].AllN.Length == 1))
                {
                    for (int i = 0; i < coll; i++)
                    {
                        if (paral[j].N != i + 1)
                        {
                            int l = 0;
                            foreach (int _int in paral[j].NL)
                            {
                                if (_int == paral[i].N)
                                {
                                    l++;
                                }
                            }
                            foreach (int _int in paral[i].NL)
                            {
                                if (_int == paral[j].N)
                                {
                                    l++;
                                }
                            }
                            if (l == 0)
                            {
                                if ((paral[i].N != 999) && (paral[i].AllN.Length == 1) && (i != paral.Count - 1))
                                {
                                    x++;
                                    begin = j;
                                    next = i;
                                    break;
                                }
                            }
                            if (x != 0)
                            {
                                break;
                            }
                        }
                    }
                    if (x != 0)
                    {
                        break;
                    }
                }
            }
            if (next == 0)
            {
                int next_1 = 0;
                int begin_1 = 0;
                int x_1 = 0;
                for (int i = 0; i < coll; i++)
                {
                    if (paral[i].N != 999)
                    {
                        for (int j = 0; j < coll; j++)
                        {
                            if (paral[j].N != 999)
                            {
                                foreach (int _int in paral[i].NL)
                                {
                                    if (_int == j + 1)
                                    {
                                        if (paral[_int - 1].N != 999)
                                        {
                                            if ((i != paral.Count - 1))
                                            {
                                                x_1++;
                                                begin_1 = i;
                                                next_1 = j;
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                            if (x_1 != 0)
                            {
                                break;
                            }
                        }
                        if (x_1 != 0)
                        {
                            break;
                        }
                    }

                }
                if (next_1 == 0)
                {
                    //проверка если вообще ничего не нашло, перед этим....и ес
                }
                else
                {
                    paral[begin_1].AllN += paral[next_1].AllN;
                    paral[begin_1].Type_1 += paral[next_1].Type_1;
                    paral[begin_1].Type_2 += paral[next_1].Type_2;
                    paral[next_1].N = 999;
                }
            }
            else
            {
                paral[begin].AllN += paral[next].AllN;
                if (paral[begin].Type_1 < paral[next].Type_1)
                {
                    paral[begin].Type_1 = paral[next].Type_1;
                }
                if (paral[begin].Type_2 < paral[next].Type_2)
                {
                    paral[begin].Type_2 = paral[next].Type_2;
                }
                int a = 0;
                for (int j = 0; j < paral[next].NL.Count - 1; j++)
                {
                    for (int i = 0; i < paral[begin].NL.Count - 1; i++)
                    {
                        if (paral[next].NL[i] == paral[begin].NL[j])
                        {
                            a++;

                        }
                    }
                    if (a == 0)
                    {
                        paral[begin].NL.Add(j);
                        a = 0;
                    }
                }
                paral[next].N = 999;
            }

        }

    }

}
