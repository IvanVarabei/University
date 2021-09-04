using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;

namespace Project_Graf
{
    class DrawGraf
    {
        private Bitmap btm;
        private Bitmap btmO;
        private int[][] m;
        private int[] mtype;

        public int[] Xc;
        public int[] Yc;
        public Graphics g { get; set; }
        public Graphics gO { get; set; }
        public bool Draw { get; set; }

        public DrawGraf(int[][] mass, int[] mtype1, int n)
        {
            m = new int[n][];
            m = mass;
            mtype = mtype1;
            btm = new Bitmap(802, 442);
            g = Graphics.FromImage(btm);

            btmO = new Bitmap(805, 448);
            gO = Graphics.FromImage(btmO);
            Draw = false;
        }
        //рисует граф 
        public void GrafPic(PictureBox picbox, int n)
        {
            picbox.Image = btm;
            Xc = new int[n];
            Yc = new int[n];
            double a = 0;
            double da = 0;

            da = (double)((Math.PI * 2) / n);

            for (int i = 0; i < n; i++)
            {
                Xc[i] = (int)(420 + Math.Round(100 * Math.Sin(a)));
                Yc[i] = (int)(225 - Math.Round(100 * Math.Cos(a)));
                a = a + da;
            }

            for (int i = 0; i < n; i++)
            {
                for (int j = i; j < n; j++)
                {
                    if (m[i][j] == 1)
                    {
                        g.DrawLine(new Pen(Color.Black), Xc[i], Yc[i] + 16, Xc[j], Yc[j] - 16);
                    }
                }
            }

            Font drawFont = new Font("Arial", 12);
            SolidBrush drawBrush = new SolidBrush(Color.Black);
            StringFormat drawFormat = new StringFormat();

            for (int i = 0; i < n; i++)
            {
                PointF drawPoint = new PointF(Xc[i] - 32, Yc[i] - 32);
                PointF drawPoint1 = new PointF(Xc[i] - 6, Yc[i] - 6);
                g.DrawEllipse(new Pen(Color.Red), Xc[i] - 16, Yc[i] - 16, 32, 32);
                g.DrawString((i + 1).ToString(), drawFont, drawBrush, drawPoint, drawFormat);
                g.DrawString(mtype[i].ToString(), new Font("Arial", 10), new SolidBrush(Color.Blue), drawPoint1, drawFormat);
            }
            picbox.Refresh();
        }
        public void DrawMove(Point origin, Point movePt, int current)
        {
            Xc[current] = Xc[current] - origin.X + movePt.X;
            Yc[current] = Yc[current] - origin.Y + movePt.Y;
            int n = m.Length;
            for (int i = 0; i < n; i++)
            {
                for (int j = i; j < n; j++)
                {
                    if (m[i][j] == 1)
                    {
                        g.DrawLine(new Pen(Color.Black), Xc[i], Yc[i] + 16, Xc[j], Yc[j] - 16);
                    }
                }
            }
            Font drawFont = new Font("Arial", 12);
            SolidBrush drawBrush = new SolidBrush(Color.Black);
            StringFormat drawFormat = new StringFormat();

            for (int i = 0; i < n; i++)
            {
                PointF drawPoint = new PointF(Xc[i] - 32, Yc[i] - 32);
                PointF drawPoint1 = new PointF(Xc[i] - 6, Yc[i] - 6);
                g.DrawEllipse(new Pen(Color.Red), Xc[i] - 16, Yc[i] - 16, 32, 32);
                g.DrawString((i + 1).ToString(), drawFont, drawBrush, drawPoint, drawFormat);
                g.DrawString(mtype[i].ToString(), new Font("Arial", 10), new SolidBrush(Color.Blue), drawPoint1, drawFormat);
            }
        }


        public void DrawParal(List<Paral> paral, PictureBox pic)
        {
            gO.Clear(Color.White);
            pic.Image = btmO;
            int gl = 0;
            for (int i = 0; i < paral.Count-1; i++)
            {
                if (paral[i].N != 999)
                {
                    for (int j = 0; j < paral[i].NL.Count; j++)
                    {
                        gl = paral[i].NL[j];
                        if (paral[gl - 1].N != 999)
                        {
                            gO.DrawLine(new Pen(Color.Black), Xc[i], Yc[i] + 16, Xc[gl - 1], Yc[gl-1] - 16);
                        }
                    }
                }
            }
            Font drawFont = new Font("Arial", 12);
            SolidBrush drawBrush = new SolidBrush(Color.Black);
            StringFormat drawFormat = new StringFormat();
            for (int i = 0; i < paral.Count; i++)
            {
                if (paral[i].N != 999)
                {
                    PointF drawPoint = new PointF(Xc[i] - 6, Yc[i] - 6);
                    PointF drawPoint1 = new PointF(Xc[i] - 32, Yc[i] - 32);

                    gO.DrawEllipse(new Pen(Color.Red), Xc[i] - 16, Yc[i] - 16, 32, 32);

                    gO.DrawString(paral[i].AllN.ToString(), drawFont, drawBrush, drawPoint, drawFormat);
                    gO.DrawString("(" + paral[i].Type_1.ToString() + "," + paral[i].Type_2.ToString() + ")", new Font("Arial", 10), new SolidBrush(Color.Blue), drawPoint1, drawFormat);
                }
            }
        }



        public List<Paral> DrawGrafOperation(PictureBox pic, int n, List<Tree> tree)
        {
            pic.Image = btmO;
            List<int> m_ = new List<int>();
            List<Paral> paral = new List<Paral>();

            foreach (Tree tr in tree)
            {
                if (tr.Type == 1)
                {
                    paral.Add(new Paral(tr.N, 1, 0, tr.N.ToString()));
                }
                else
                {
                    paral.Add(new Paral(tr.N, 0, 1, tr.N.ToString()));
                }
            }

            for (int r = 0; r < n; r++)
            {
                m_.Add(1);
            }
            for (int i = 0; i < n; i++)
            {

                for (int r = 0; r < n; r++)
                {
                    m_[r] = 1;
                }
                bool metka = true;
                if (tree.Count - 1 != i)
                {
                    metka = false;
                    m_[tree[i].nNext - 1] = tree[i].nNext;
                    int t = tree[i].nNext - 1;
                    for (int k = i; k < tree.Count; k++)
                    {

                        if (tree[m_[t] - 1].nNext == k + 1)
                        {
                            m_[k] = k + 1;
                            t = k;
                        }
                        else
                        {
                            if (m_[k] == 1)
                            {
                                m_[k] = 0;
                            }
                        }
                    }
                }

                for (int j = i + 1; j < n; j++)
                {
                    if (metka != true)
                    {
                        if (m_[j] == 0)
                        {
                            paral[i].NL.Add(j + 1);
                            gO.DrawLine(new Pen(Color.Black), Xc[i], Yc[i] + 16, Xc[j], Yc[j] - 16);
                        }
                    }
                }
            }

            Font drawFont = new Font("Arial", 12);
            SolidBrush drawBrush = new SolidBrush(Color.Black);
            StringFormat drawFormat = new StringFormat();

            for (int i = 0; i < n; i++)
            {
                PointF drawPoint = new PointF(Xc[i] - 6, Yc[i] - 6);
                PointF drawPoint1 = new PointF(Xc[i] - 32, Yc[i] - 32);

                gO.DrawEllipse(new Pen(Color.Red), Xc[i] - 16, Yc[i] - 16, 32, 32);

                gO.DrawString((i + 1).ToString(), drawFont, drawBrush, drawPoint, drawFormat);
                if (mtype[i] == 1)
                {
                    gO.DrawString("(1,0)", new Font("Arial", 10), new SolidBrush(Color.Blue), drawPoint1, drawFormat);
                }
                else
                {
                    gO.DrawString("(0,1)", new Font("Arial", 10), new SolidBrush(Color.Blue), drawPoint1, drawFormat);
                }

            }
            pic.Refresh();
            return paral;

        }
    }
}
