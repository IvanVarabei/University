using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace lab7_2
{
    public static class SortUtility
    {
        public static T[] GenRandomArray<T>(int size = 10000)
        {
            var a = new T[size];
            Random r = new Random();

            for (int i = 0; i < size; i++)
            {
                a[i] = (T)Convert.ChangeType(r.Next(Int32.MinValue, Int32.MaxValue), typeof(T));
            }

            return a;

        }
        public static bool IsSorted<T>(T[] a) where T : IComparable<T>
        {
            if (!a.Any())
                return true;

            var prev = a.First();

            for (int i = 1; i < a.Length; i++)
            {
                if (a[i].CompareTo(prev) < 0)
                    return false;

                prev = a[i];
            }

            return true;
        }
    }
}
