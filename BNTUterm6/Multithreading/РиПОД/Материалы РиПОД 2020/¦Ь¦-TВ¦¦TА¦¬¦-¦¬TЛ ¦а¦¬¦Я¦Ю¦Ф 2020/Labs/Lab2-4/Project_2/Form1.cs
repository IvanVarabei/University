using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Project_2
{
    public partial class Form1 : Form
    {
        public List<Tree> tree = new List<Tree>();
        public Form1()
        {
            InitializeComponent();
            Creat();
            Gen();
            label2.Text = "При неограниченном количестве ресурсов : ";
            tree.Clear();
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
            List<Tree> t68 = new List<Tree>();
            Tree tr1, tr2, tr3,tr4,tr5,tr6,tr7,tr8,tr9,tr68;
            t1 = null;
            tr1 = new Tree(1, 1, false, 1, t1);
            tree.Add(tr1);
            tr2 = new Tree(2, 1, false, 1, t1);
            tree.Add(tr2);
            t68 = null;
            tr68 = new Tree(3, 2, false, 2, t68);
            tree.Add(tr68);
            tr3 = new Tree(4, 1, false, 1, t1);
            tree.Add(tr3);
            t4.Add(tr1);
            tr4 = new Tree(5, 2, false, 2, t4);
            tree.Add(tr4);
            t5.Add(tr2);
            tr5 = new Tree(6, 2, false, 2, t5);
            tree.Add(tr5);
            t6.Add(tr3);
            tr6 = new Tree(7, 2, false, 2, t6);
            tree.Add(tr6);
            
            t7.Add(tr4);
            t7.Add(tr5);
            tr7 = new Tree(8, 1, false, 1, t7);
            tree.Add(tr7);



            t8.Add(tr6);
            tr8 = new Tree(9, 2, false, 2, t8);
            tree.Add(tr8);
            
            t9.Add(tr7);
            t9.Add(tr8);
            t9.Add(tr68);
            tr9 = new Tree(10, 1, false, 1, t9);
            tree.Add(tr9);
            return 0;
        }
        public int Gen()
        {
            int type1 = 0;
            int type2 = 0;
            int H = -1;
            
            
            bool metka = true;
            while(metka)
            {
                int end = 0;
                List<Tree> tRee = new List<Tree>();
                int type1_1 = 0,type2_1 = 0;
                H++;
                foreach(Tree tree1 in tree)
                {
                    if (tree1 == null)
                    {
                        metka = false; break; }

                    int nu = 0;
                    if(tree1.End == false)
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
                            if (nu == 0)
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
                        else
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
                if(end == 0)
                {
                    metka = false;
                    
                }
                if(type1 < type1_1)
                {
                    type1 = type1_1;
                }
                if (type2 < type2_1)
                {
                    type2 = type2_1;
                }
                string m  = "";
                foreach (Tree tre in tRee)
                {
                    m +=  Convert.ToString(tre.N)+ " ";
                    tre.End = true;
                }
                if (end !=0) richTextBox1.Text += "На" + (H+1) + " шаге выполнения, заплонированы операции (номер(а)):" + m + "\n";

            }
            foreach(Tree tb in tree)
            {
                richTextBox2.Text += "type(" + tb.N + ")" + " -> " + "type(" + tb.Type + ")" + "\n";
            }
            label1.Text = "понадобится процессоров первого типа :"+type1 + ", второго : " + type2 + "  шагов :" + H;
            return 0;
        }

        private void buttonResult_Click(object sender, EventArgs e)
        {
            Creat();
            GetList();
        }
        public void GetList()
        {
            //int type1 = 0,type2 = 0;
            int typeProc1 = int.Parse(textBoxType1.Text);
            int typeProc2 = int.Parse(textBoxType2.Text);
            int H = 0;
            List<Tree> listn = new List<Tree>();//первая часть
            List<Tree> listk = new List<Tree>();//вторая часть

            foreach (Tree tree1 in tree)
            {
                if (tree1.End != true)
                {
                    int nu = 0;
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
                        listn.Add(tree1);
                    }
                }
            }

            bool metka = true;
            while (metka)
            {
                int end = 0;
                List<Tree> tRee = new List<Tree>();
                int type1 = 0;
                int type2 = 0;
                if(listn !=null)
                {
                    foreach(Tree tree2 in listn)
                    {
                        if((tree2.Type == 1) && (type1 != typeProc1))
                        {
                            tRee.Add(tree2);
                            type1++;
                        }
                        else if ((tree2.Type == 2) && (type2 != typeProc2))
                        {
                            tRee.Add(tree2);
                            type2++;
                        }
                    }
                }
                if(listk !=null)
                {
                    foreach (Tree tree2 in listk)
                    {
                        if ((tree2.Type == 1) && (type1 != typeProc1))
                        {
                            tRee.Add(tree2);
                            type1++;
                        }
                        else if ((tree2.Type == 2) && (type2 != typeProc2))
                        {
                            tRee.Add(tree2);
                            type2++;
                        }
                    }
                }
                foreach (Tree tre in tRee)
                {
                    tre.End = true;
                }
                H++;
                List<Tree> temp = new List<Tree>();
                foreach(Tree ti in listn)
                {
                    if(ti.End == false)
                    {
                        end++;
                        temp.Add(ti);
                    }
                }
                listn.Clear();
                foreach(Tree t in temp)
                {
                    listn.Add(t);
                }
                temp.Clear();


                foreach(Tree ty in listk)
                {
                    if(ty.End !=true)
                    {
                        end++;
                        listn.Add(ty);    
                    }
                }
                listk.Clear();
                tRee.Clear();
                foreach (Tree tree1 in tree)
                {
                    if(tree1.End !=true)
                    {
                        int nu = 0;
                        if(tree1.list !=null)
                        {
                            foreach (Tree tr in tree1.list)
                            {
                                if (tr.End == false)
                                {
                                    nu++;
                                }
                            }
                            
                        }
                        if(nu == 0)
                        {
                            end++;
                            listk.Add(tree1);
                        }
                    }
                }
                if(end == 0)
                {
                    break;
                }
            }
            labelResult.Text = "Количество шагов : " + H;
        }

        private void buttonResultM_Click(object sender, EventArgs e)
        {
            tree.Clear();
            Creat();
            GetM();
        }
        public void GetM()
        {
            int Tstep = int.Parse(textBoxTstep.Text);
            int type1 = 0;
            int type2 = 0;
            int H = -1;


            bool metka = true;
            while (metka)
            {
                int end = 0;
                List<Tree> tRee = new List<Tree>();
                int type1_1 = 0, type2_1 = 0;
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
                            if (nu == 0)
                            {
                                
                                if (tree1.Npri < Tstep)
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
                                else if(Tstep == tree1.Npri)
                                {
                                    tRee.Add(tree1);
                                    tree1.Npri -= Tstep;
                                    if (tree1.Type == 1)
                                    {
                                        type1_1++;
                                    }
                                    else
                                    {
                                        type2_1++;
                                    }
                                }
                                else if (Tstep< tree1.Npri)
                                {
                                    tree1.Npri -= Tstep;
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
                        else
                        {
                            if (tree1.Npri < Tstep)
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
                            else if (Tstep == tree1.Npri)
                            {
                                tRee.Add(tree1);
                                tree1.Npri -= Tstep;
                                if (tree1.Type == 1)
                                {
                                    type1_1++;
                                }
                                else
                                {
                                    type2_1++;
                                }
                            }
                            else if (Tstep < tree1.Npri)
                            {
                                tree1.Npri -= Tstep;
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
                foreach (Tree tre in tRee)
                {
                    tre.End = true;
                }

            }
            labelRes.Text = H + " количество процессоров разного типа : первого " + type1 + ", второго " + type2;
            
        }

    }
}
