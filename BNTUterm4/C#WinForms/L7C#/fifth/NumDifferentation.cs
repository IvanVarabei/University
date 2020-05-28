using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace fifth
{
    public static class NumDifferentiation
    {
        private static double RungeMethod(double x, double eps, CauchyConditions conditions,
        Func<double, CauchyConditions, double> wayCalc, int power)
        {
            double step = (x - conditions.X0) / 2;
            double resultFullStep = calculation(x, step, conditions, wayCalc);
            double resultHalfStep = calculation(x, step / 2, conditions, wayCalc);
            double error = Math.Abs((resultHalfStep - resultFullStep) / (Math.Pow(2, power) - 1));
            int i = 0;
            while (error > eps && i < 20)
            {
                step /= 2;
                resultFullStep = calculation(x, step, conditions, wayCalc);
                resultHalfStep = calculation(x, step / 2, conditions, wayCalc);
                error = Math.Abs(resultHalfStep - resultFullStep);
                i++;
            }
            return resultHalfStep + error;
        }

        private static double calculation(double x, double step, CauchyConditions conditions,
        Func<double, CauchyConditions, double> waycalc)
        {
            double previousX = conditions.X0;
            double result = conditions.Y0;
            while (previousX < x)
            {
                result += waycalc(step, new CauchyConditions(previousX, result, conditions.FirstDeritative));
                previousX += step;
            }
            return result;
        }
        // Формула:
        private static double __calcByEulerMethod(double step, CauchyConditions conditions)
        {
            return step * conditions.FirstDeritative(conditions.X0, conditions.Y0);
        }
        private static double __calcByModifiedEulerMethod(double step, CauchyConditions conditions)
        {
            double x = conditions.X0;
            double y = conditions.Y0;
            double halfStep = step / 2;
            double firstValue = conditions.FirstDeritative(x, y);
            double secondValue = conditions.FirstDeritative(x + halfStep, y + halfStep * firstValue);
            return step * secondValue;
        }
        private static double __calcByRungeKuttaMethod(double step, CauchyConditions conditions)
        {
            double x = conditions.X0;
            double y = conditions.Y0;
            double halfStep = step / 2;
            double firstValue = conditions.FirstDeritative(x, y);
            double secondValue = conditions.FirstDeritative(x + halfStep, y + halfStep * firstValue);
            double thirdValue = conditions.FirstDeritative(x + halfStep, y + halfStep * secondValue);
            double fourthValue = conditions.FirstDeritative(x + halfStep, y + step * thirdValue);
            return step / 6 * (firstValue + 2 * secondValue + 2 * thirdValue + fourthValue);
        }
       
        
        
        // Метод Эйлера
        public static double calcByEulerMethod(double x, double eps, CauchyConditions conditions)
        {
            return RungeMethod(x, eps, conditions, __calcByEulerMethod, 1);
        }
        // Модифицированный метод Эйлера
        public static double calcByModifiedEulerMethod(double x, double eps, CauchyConditions conditions)
        {
            return RungeMethod(x, eps, conditions, __calcByModifiedEulerMethod, 2);
        }
        // Метод Рунге-Кутты
        public static double calcByRungeKuttaMethod(double x, double eps, CauchyConditions conditions)
        {
            return RungeMethod(x, eps, conditions, __calcByRungeKuttaMethod, 4);
        }
    }
}
