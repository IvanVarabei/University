using System;
using System.Collections.Generic;

using System.Windows.Forms;

namespace Project_5
{
    public partial class Form1 : Form
    {
        public List<Tree> tree = new List<Tree>();
        public Form1()
        {
            InitializeComponent();
        }
        public int Creat()
        {
            List<Tree> tr = new List<Tree>();
            List<Tree> t1 = new List<Tree>();
            List<Tree> t4 = new List<Tree>();
            List<Tree> t5 = new List<Tree>();
            List<Tree> t6 = new List<Tree>();
            List<Tree> t7 = new List<Tree>();
            List<Tree> t8 = new List<Tree>();
            List<Tree> t9 = new List<Tree>();
            List<Tree> t3 = new List<Tree>();
            Tree tr1, tr2, tr3, tr4, tr5, tr6, tr7, tr8, tr9, tr68;
            t1 = null;
            tr1 = new Tree(1, 0, false, 1, t1);
            tree.Add(tr1);
            
            tr2 = new Tree(2, 0, false, 1, t1);
            tree.Add(tr2);
            
            tr3 = new Tree(3, 0, false, 1, t1);
            tree.Add(tr3);

            t4.Add(tr1);
            tr4 = new Tree(4, 0, false, 2, t4);
            tree.Add(tr4);
            
            t5.Add(tr2);
            tr5 = new Tree(5, 0, false, 2, t5);
            tree.Add(tr5);

            t6.Add(tr3);
            tr6 = new Tree(6, 0, false, 2, t6);
            tree.Add(tr6);

            t7.Add(tr4);
            t7.Add(tr5);
            tr7 = new Tree(7, 0, false, 1, t7);
            tree.Add(tr7);

            t8.Add(tr7);
            tr8 = new Tree(8, 0, false, 1, t8);
            tree.Add(tr8);



            t9.Add(tr8);
            t9.Add(tr6);
            tr9 = new Tree(9, 0, false, 1, t9);
            tree.Add(tr9);

            return 0;
        }
        public int Get()
        {
            richTextBox2.Clear();
            int Tstep = int.Parse(textBoxTstep.Text);
            int type1 = 0;
            int type2 = 0;
            int H = -1;
            bool metka = true;
            while(metka)
            {
                List<Tree> tRee = new List<Tree>();
                int type1_1 = 0, type2_1 = 0;
                int end = 0;
                H++;
                foreach (Tree tree1 in tree)
                {
                    if (tree1 == null)
                    {
                        metka = false; break;
                    }
                    int nu = 0;
                    if (tree1.End == false)
                    {
                        end++;
                        if (tree1.list != null)
                        {
                            foreach (Tree tr in tree1.list)
                            {
                                if (tr.End == false)
                                {
                                    nu++;
                                }
                            }
                        }
                        if (nu == 0)
                        {

                            if (tree1.Type < Tstep)
                            {
                                tRee.Add(tree1);
                                tree1.Npri = 1;
                                if (tree1.Type == 1)
                                {
                                    type1_1++;
                                }
                                else
                                {
                                    type2_1++;
                                }
                                bool metka_1 = false;
                                int N = tree1.N;
                                int _tempTstep = tree1.Type;
                                tree1.Npri = 1;
                                foreach (Tree tr in tree)
                                {
                                    int m2 = 0, i2 = 0,t2 =0;
                                    if ((tr.list != null))
                                    {
                                        if(tr.list.Count >1)
                                        {
                                            
                                            foreach (Tree t in tr.list)
                                            {
                                                i2++;
                                                if ((t.Npri == 0) && (t.End == true))
                                                {
                                                    m2++;
                                                }
                                                if(t.End == false)
                                                {
                                                    t2++;
                                                }
                                            }
                                        }
                                        else
                                        {
                                            i2 = 2;
                                            m2 = 1;
                                        }


                                            foreach (Tree t in tr.list)
                                            {
                                                if (((i2 -  m2) == 1))
                                                {

                                                        if (t.N == N)
                                                        {

                                                            if (((tr.Type + _tempTstep) <= Tstep))
                                                            {
                                                                tr.Npri = 1;
                                                                N = tr.N;
                                                                _tempTstep += tr.Type;
                                                                tRee.Add(tr);
                                                                if (tr.Type == 1)
                                                                {
                                                                    type1_1++;
                                                                }
                                                                else
                                                                {
                                                                    type2_1++;
                                                                }
                                                            }
                                                        }
                                                    
                                                }
                                            }


                                        }
                                    
                                }
                            }
                            else if (Tstep == tree1.Type)
                            {
                                tRee.Add(tree1);
                                if (tree1.Type == 1)
                                {
                                    type1_1++;
                                }
                                else
                                {
                                    type2_1++;
                                }
                            }
                        }

                        
                    }
                }
                if (end == 0)
                {
                    metka = false;

                }
                if (type1 < type1_1)
                {
                    type1 = type1_1;
                }
                if (type2 < type2_1)
                {
                    type2 = type2_1;
                }
                string m = "";
                
                foreach(Tree tre in tree)
                {
                    tre.Npri = 0;
                }
                foreach (Tree tre in tRee)
                {
                    m += Convert.ToString(tre.N) + " ";
                    tre.End = true;
                }
                if (end != 0) richTextBox2.Text += "На" + (H + 1) + " шаге выполнения, заплонированы операции (номер(а)):" + m + "\n";

            }


            labelRes.Text = H + " количество процессоров разного типа : первого " + type1 + ", второго " + type2;
            richTextBox1.Clear();
            foreach (Tree tb in tree)
            {
                richTextBox1.Text += "type(" + tb.N + ")" + " -> " + "type(" + tb.Type + ")" + "\n";
            }
            return 0;
        }

        private void buttonPlan_Click(object sender, System.EventArgs e)
        {
            Creat();
            Get();
            tree.Clear();
        }

    }
}
