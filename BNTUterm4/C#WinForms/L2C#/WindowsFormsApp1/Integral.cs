using Syncfusion.Windows.Forms.Chart;

namespace WindowsFormsApp1
{
    public class Integral
    {
        public double BottomBorder { get; set; }
        private double TopBorder { get; set; }
        private double NumberOfSteps { get; set; }

  
        public Integral(double bottomBorder, double topBorder, double nunberOfSteps)
        {
            BottomBorder = bottomBorder;
            TopBorder = topBorder;
            NumberOfSteps = nunberOfSteps;
        }


        public virtual double ProcEuat(double x)
        {
            return x;
        }


        public double ProcLeftS()
        {
            double res = 0,  h = (TopBorder - BottomBorder) / (NumberOfSteps + 1), 
                x = BottomBorder + h;
            for (int i = 0; i < NumberOfSteps; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }


        public double ProcRightS()
        {
            double res = 0, h = (TopBorder - BottomBorder) / (NumberOfSteps + 1),
                x = BottomBorder;
            for (int i = 0; i < NumberOfSteps; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }


        public double ProcMidlS()
        {
            double res = 0, h = (TopBorder - BottomBorder) / (NumberOfSteps + 1),
                x = BottomBorder+h/2;
            for (int i = 0; i < NumberOfSteps; i++, x += h)
            {
                res += h * ProcEuat(x);
            }
            return res;
        }


        public double ProcTrapeze()
        {
            double res = 0, h = (TopBorder - BottomBorder) / (NumberOfSteps + 1),
                x = BottomBorder;
            for (int i = 0; i < NumberOfSteps; i++, x += h)
            {
                res += h * (ProcEuat(x) + ProcEuat(x + h)) / 2;
            }
            return res;
        }


        public void DrawL(ChartControl chartControl1)
        {
            double h = (TopBorder - BottomBorder) / (NumberOfSteps), x = BottomBorder;
            for (int i = 0; i < NumberOfSteps+1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, ProcEuat(x));
                chartControl1.Series[1].Points.Add(x, ProcEuat(x + h));
            }
        }


        public void DrawR(ChartControl chartControl1)
        {
            double h = (TopBorder - BottomBorder) / (NumberOfSteps), x = BottomBorder;
            for (int i = 0; i < NumberOfSteps + 1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, ProcEuat(x));
                chartControl1.Series[1].Points.Add(x, ProcEuat(x));
            }
        }


        public void DrawM(ChartControl chartControl1)
        {
            double h = (TopBorder - BottomBorder) / (NumberOfSteps), x = BottomBorder;
            for (int i = 0; i < NumberOfSteps + 1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, ProcEuat(x));
                chartControl1.Series[1].Points.Add(x, ProcEuat(x + h / 2));
            }
        }


        public void DrawT(ChartControl chartControl1)
        {
            double h = (TopBorder - BottomBorder) / (NumberOfSteps), x = BottomBorder;
            for (int i = 0; i < NumberOfSteps + 1; i++, x += h)
            {
                chartControl1.Series[0].Points.Add(x, ProcEuat(x));
                if (x != 0)
                {
                    chartControl1.Series[2].Points.Add(x, ProcEuat(x));
                }
            }
        }
    }
}
