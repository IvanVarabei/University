using System;
using System.Collections.Generic;
using System.Drawing;
using Library;
using System.Windows.Forms;

namespace SingleThread
{

    static class Processor
    {
        static public void Process(Pendulum p,  PictureBox pictureBox1)
        {
            double r = pictureBox1.ClientSize.Height / 10;
            double h = pictureBox1.ClientSize.Height - r - pictureBox1.ClientSize.Height*0.1;
            double px1 = CountY(0, p.Length) / h;
            PointF pt;
            for (int i = 0; i  <= p.Info.NumberOfShots; i++)
            {
                double phase = ((Math.PI * 2) / p.T) * ((i * p.Info.Interval) / 1000d);
                double X = p.A * Math.Sin(phase);
                p.Info.Moments.Add(new Moment(phase, X, i * p.Info.Interval));
                Bitmap bmp = new Bitmap(pictureBox1.ClientSize.Width, pictureBox1.ClientSize.Height);
                using (Graphics g = Graphics.FromImage(bmp))
                {
                    g.TranslateTransform(bmp.Width / 2, 0);
                    pt = new PointF((float)(CountX(X, p.Length) / px1), (float)(CountY(X, p.Length) / px1));
                    RectangleF rect = RectangleF.FromLTRB((float)(pt.X - r), (float)(pt.Y - r),
                        (float)(pt.X + r), (float)(pt.Y + r));
                    g.DrawLine(Pens.Black, 0f, 0f, pt.X, pt.Y);
                    g.FillEllipse(Brushes.CornflowerBlue, rect);
                }
                p.Info.Shots.Add(i, bmp);
            }
        }

       static double CountBetta(double x, double l = 8f)
        {
            double alpha = Math.Asin(x / (2 * l)) * 2;
            return (90 / 57.296) - alpha;
        }

        static double CountX(double x, double l) => l * Math.Cos(CountBetta(x, l));

        static double CountY(double x, double l) => l * Math.Sin(CountBetta(x, l));

    }
}