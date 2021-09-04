using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            ATLProject2Lib.ATLSimpleObject comObj = new ATLProject2Lib.ATLSimpleObject();
            double a = 5.25;
            comObj.Square(a, out double result);
            Console.WriteLine($"SQUARE = {result}");

        }
    }
}
