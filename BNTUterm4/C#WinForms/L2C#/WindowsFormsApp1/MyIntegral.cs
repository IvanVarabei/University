using System;

namespace WindowsFormsApp1
{
    public class MyIntegral : Integral
    {
        private int version = 9;

        public MyIntegral(double bottomBorder, double topBorder, double nunberOfSteps) 
            :base (bottomBorder,  topBorder, nunberOfSteps)
        { }


        public override double ProcEuat(double x)
        {
            return (Math.Log(1 + Math.Sqrt(x))) / (1 + Math.Sqrt(x));
        }


        public static bool HalfwitCheck(double a, double b, double n)
        {
            return !(b < a || a < 0 || n < 1);
        }
    }
}
