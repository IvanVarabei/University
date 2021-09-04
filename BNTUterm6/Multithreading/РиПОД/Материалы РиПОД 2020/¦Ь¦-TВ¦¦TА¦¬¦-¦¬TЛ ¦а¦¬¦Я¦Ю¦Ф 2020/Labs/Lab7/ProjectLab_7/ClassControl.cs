using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace ProjectLab_7
{
    public class ClassControl
    {
        private RichTextBox _rch;
        private List<EzClass> _ezClass = new List<EzClass>();

        private List<ClassObjectPlan> _planmax = new List<ClassObjectPlan>();

        private List<List<PlanClassStep>> newEZ = new List<List<PlanClassStep>>();



        public ClassControl(RichTextBox rch)
        {
            _rch = rch;
            CreatePlan();
            MaxListPlan(0);
            Planning();
        }


        private void CreatePlan()
        {
            _ezClass.Add(new EzClass(1, 5));
            _ezClass[0].PlanObj.Add(new ClassObjectPlan(2, 1, 1));
            _ezClass[0].PlanObj.Add(new ClassObjectPlan(3, 1, 20));

            _ezClass.Add(new EzClass(2, 20));
            _ezClass[1].PlanObj.Add(new ClassObjectPlan(4, 2, 1));

            _ezClass.Add(new EzClass(3, 10));
            _ezClass[2].PlanObj.Add(new ClassObjectPlan(4, 3, 10));

            _ezClass.Add(new EzClass(4, 8));
            _ezClass[3].PlanObj = null;
        }

        private void MaxListPlan(int n)
        {
            ClassObjectPlan max = new ClassObjectPlan(0, 0, 0);
            int ColP = 0;
            foreach (var ezClass in _ezClass)
            {
                if (ezClass.PlanObj != null)
                {
                    foreach (var plan in ezClass.PlanObj)
                    {

                        if (plan.Weight > max.Weight)
                        {
                            int metk = 0;
                            foreach (var classObjectPlan in _planmax)
                            {
                                if ((classObjectPlan.N == plan.N) && (classObjectPlan.NLast == plan.NLast) && (classObjectPlan.Weight == plan.Weight))
                                {
                                    metk++;
                                }

                            }
                            if (metk == 0)
                            {
                                ColP++;
                                max.Weight = plan.Weight;
                                max.N = plan.N;
                                max.NLast = plan.NLast;
                            }
                        }
                    }
                }

            }
            if (ColP != 0)
            {
                _planmax.Add(max);
                MaxListPlan(0);
            }
        }

        public void Planning()
        {
            bool metka = true;
            int step = 0;
            int ColProc = 1;
            int Weight_All = 0;
            _rch.Text = "\t\tPE0\t\t\tPE1";
            foreach (var planmax in _planmax)
            {
                step++;
                
                _rch.Text += "\n\nШаг " + step + "(N" + planmax.NLast + ",N" + planmax.N + ") - " + planmax.Weight;

                if (step == 1)
                {
                    newEZ.Add(new List<PlanClassStep>());
                    ColProc++;
                    newEZ[0].Add(new PlanClassStep(planmax.NLast, _ezClass[planmax.NLast - 1].Weight, planmax.Weight, planmax.N));
                    newEZ[0].Add(new PlanClassStep(planmax.N, _ezClass[planmax.N - 1].Weight, 0, 0));
                    //первый проц
                    int Weight = 0;
                    foreach (var ez in newEZ[0])
                    {
                        Weight += ez.Ves;
                    }

                    int Weight_EZ1 = 0;
                    int i = 0;
                    foreach (var ez in newEZ[0])
                    {
                        if (i != newEZ[0].Count - 1)
                        {
                            Weight_EZ1 += ez.Ves + ez.Weight;
                        }
                        else
                        {
                            Weight_EZ1 += ez.Ves;
                        }
                        i++;
                    }

                    if (Weight <= Weight_EZ1)
                    {
                        Weight_All += Weight;
                        _rch.Text += "\n\n Длина пути - " + Weight_All;
                        for (int j = 0; j < newEZ[0].Count; j++)
                        {
                            _rch.Text += " \n\t\t(N" + newEZ[0][j].N + "|" + newEZ[0][j].Ves + ")";
                        }
                    }
                    else
                    {
                        Weight_All += Weight_EZ1;

                        newEZ.Add(new List<PlanClassStep>());
                        newEZ[1].Add(new PlanClassStep(newEZ[0][1].N, newEZ[0][1].Ves, newEZ[0][1].Weight, newEZ[0][1].NNext));

                        newEZ[0][1].N = 0;

                        _rch.Text += "\n\n Длина пути - " + Weight_All;
                        _rch.Text += " \n\t\t\t\t\t(N" + newEZ[0][0].N + "|" + newEZ[0][0].Ves + ")+" + newEZ[0][0].Weight + "(N" + newEZ[1][0].N +
                                     "|" + newEZ[0][1].Ves + ")";
                        ColProc = 2;
                    }
                    for (int j = 0; j < newEZ[0].Count - 1; j++)
                    {
                        newEZ[0][j].Weight = 0;
                    }
                }
                else
                {
                    foreach (var pl in newEZ[0])
                    {
                        if (pl.N == planmax.NLast)
                        {
                            pl.NNext = planmax.N;
                            pl.Weight = planmax.Weight;
                        }

                    }
                    if(newEZ.Count != 1)
                    {
                        foreach (var pl in newEZ[1])
                        {
                            if (pl.N == planmax.NLast)
                            {
                                pl.NNext = planmax.N;
                                pl.Weight = planmax.Weight;
                            }

                        }
                    }

                    int r = 0;
                    foreach (var pl in newEZ[0])
                    {
                        if (pl.N == planmax.N)
                        {
                            r++;
                        }
                    }
                    if (r == 0)
                    {
                        newEZ[0].Add(new PlanClassStep(planmax.N, _ezClass[planmax.N - 1].Weight, 0, 0));
                    }


                    //проверка есть илил нету уже ))

                    //первый проц
                    int Weight = 0;

                    foreach (var pl in newEZ[0])
                    {
                        Weight += pl.Ves;
                    }
                    int o = newEZ[0][0].N;

                    int Weight_EZ1 = 0;
                    int i = 0;
                    int t = 0;
                    foreach (var ez in newEZ[0])
                    {
                        foreach (var pl in newEZ[0])
                        {
                            if (pl.N == o)
                            {
                                t++;
                                Weight_EZ1 += pl.Ves + pl.Weight;
                                o = pl.NNext;
                                break;
                            }
                        }
                        if(t == 0)
                        {
                            foreach (var pl in newEZ[1])
                            {
                                if (pl.N == o)
                                {
                                    t++;
                                    Weight_EZ1 += pl.Ves + pl.Weight;
                                    o = pl.NNext;
                                    break;
                                }
                            }
                        }
                        if (o == 0)
                        {
                            break;
                        }
                        t = 0;

                    }

                    if (Weight <= Weight_EZ1)
                    {
                        Weight_All = Weight;
                        _rch.Text += "\n\n Длина пути - " + Weight_All;
                        int l = 0;
                        for (int j = 0; j < newEZ[0].Count; j++)
                        {
                            if (newEZ[0][j].N != 0)
                            {
                                _rch.Text += " \n\t\t(N" + newEZ[0][j].N + "|" + newEZ[0][j].Ves + ")";
                            }
                            else
                            {
                                _rch.Text += " \n\t\t\t\t\t(N" + newEZ[1][l].N + "|" + newEZ[1][l].Ves + ")";
                                l++;
                            }
                        }
                    }
                    else
                    {
                        Weight_All = Weight_EZ1;
                        newEZ.Add(new List<PlanClassStep>());

                        int k = newEZ[0].Count - 1;

                        newEZ[1].Add(new PlanClassStep(newEZ[0][k].N, newEZ[0][k].Ves, newEZ[0][k].Weight, newEZ[0][k].NNext));

                        newEZ[0][k].N = 0;
                        _rch.Text += "\n Длина пути - " + Weight_All;
                        int l = 0;
                        for (int j = 0; j < newEZ[0].Count; j++)
                        {
                            if (newEZ[0][j].N != 0)
                            {
                                _rch.Text += " \n\t\t(N" + newEZ[0][j].N + "|" + newEZ[0][j].Ves + ")";
                            }
                            else
                            {
                                _rch.Text += " \n\t\t\t\t\t(N" + newEZ[1][l].N + "|" + newEZ[1][l].Ves + ")";
                                l++;
                            }
                        }
                        ColProc = 2;
                    }
                }
            }

            int PEO = 0;
            foreach (var pl in newEZ[0])
            {
                PEO +=pl.Ves;
            }
            int PE1 = 0;
            foreach (var pl in newEZ[1])
            {
                if(pl.N != 0)
                {
                    PE1 += pl.Ves;    
                }
                
            }

            int PEO_1 = (int) ((double) ((PEO - PE1)/(double) Weight_All)*(double)100);
            int PEO_2 = (int)((double)((PE1) / (double)Weight_All) * (double)100);
            _rch.Text += "\nPE0 - загруженность -" + PEO_1 + "% PE1 - загруженность -" + PEO_2+"%";
        }
    }
}
