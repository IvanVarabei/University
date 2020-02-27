using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Syncfusion.Windows.Forms.Chart;

namespace WindowsFormsApp1
{
    class Logic
    {
        public static bool HalfwitCheck(double a, double b, double n)
        {
                return !(b < a || a < 0 || n < 1);
        }
        public static double ProcEuat(double x)
        {
            return (Math.Log(1 + Math.Sqrt(x))) / (1 + Math.Sqrt(x));
        }
        public static double ProcLeftS(double a, double b, double n)
        {
            double res = 0, h = (b - a) / (n + 1), x = a + h;
            for (int i = 0; i < n; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }
        public static double ProcRightS(double a, double b, double n)
        {
            double res = 0, h = (b - a) / (n + 1), x = a;
            for (int i = 0; i < n; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }

        public static double ProcMidlS(double a, double b, double n)
        {
            double res = 0, h = (b - a) / (n + 1), x = a + h / 2;
            for (int i = 0; i < n; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }
        public static double ProcTrapeze(double a, double b , double n)
        {
            double res = 0, h = (b - a) / (n + 1), x = a;
            for (int i = 0; i < n; i++, x += h)
            {
                res += h * (ProcEuat(x) + ProcEuat(x + h)) / 2;
            }
            return res;
        }

        public static void DrawL(ChartControl chartControl1, double a, double b, double n)
        {
            double h = (b - a) / n, x = a;
            for (int i = 0; i < n + 1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, Logic.ProcEuat(x));
                chartControl1.Series[1].Points.Add(x, Logic.ProcEuat(x + h));
            }
        }
        public static void DrawR(ChartControl chartControl1, double a, double b, double n)
        {
            double h = (b - a) / n, x = a;
            for (int i = 0; i < n + 1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, Logic.ProcEuat(x));
                chartControl1.Series[1].Points.Add(x, Logic.ProcEuat(x));
            }
        }
        public static void DrawM(ChartControl chartControl1, double a, double b, double n)
        {
            double h = (b - a) / n, x = a;
            for (int i = 0; i < n + 1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, Logic.ProcEuat(x));
                chartControl1.Series[1].Points.Add(x, Logic.ProcEuat(x + h / 2));
            }
        }
        public static void DrawT(ChartControl chartControl1, double a, double b, double n)
        {
            double h = (b - a) / n, x = a;
            for (int i = 0; i < n + 1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, Logic.ProcEuat(x));
                if (x != 0)
                {
                    chartControl1.Series[2].Points.Add(x, Logic.ProcEuat(x));
                }
            }
        }
    }

}
