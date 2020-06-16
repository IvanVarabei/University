using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    delegate int Operation(int x, int y);
    class Calc
    {
        public static int Perform(String s)
        { 
            int left = 1, right = 1, i =0, j;
            char sign = ' ';
            char[] ms = s.ToCharArray();
            List<char> l = new List<char>();
            List<char> r = new List<char>();
            if (ms[0] != '*' && ms[0]!='/' && ms[ms.Length-1]>= 48 && ms[ms.Length-1]<= 57)
            {
                while(ms[i]!= '+' && ms[i] != '-' && ms[i] != '*' && ms[i] != '/')
                {
                    l.Add(ms[i++]);
                }
                sign = ms[i];
                left = Int32.Parse(new string(l.ToArray()));
                j = i + 1;
                while (j<ms.Length)
                {
                    r.Add( ms[j++]);
                }
                right = Int32.Parse(new string(r.ToArray()));
               return DoAction(sign, left, right);
            }
            else
            {
                throw new CalcException();
            }
            
        }
        static int DoAction(char sign, int left, int right)
        {
            Operation DoOperation = (int x, int y) => { return 0; };
            switch (sign)
            {
                case '+':
                    DoOperation = Add;
                    break;
                case '-':
                    DoOperation = Substract;
                    break;
                case '/':
                    DoOperation = Div;
                    break;
                case '*':
                    DoOperation = Multiplay;
                    break;
            }
            return DoOperation(left, right);
        }

        static int Add(int x, int y) => x + y;
        static int Substract(int x, int y) => x - y;
        static int Multiplay(int x, int y) => x * y;
        static int Div(int x, int y) => x / y;
    }

    class CalcException : Exception
    {
        public CalcException()
        {
            Console.WriteLine("You have poked invalid exprasion!");
        }
    }
}

