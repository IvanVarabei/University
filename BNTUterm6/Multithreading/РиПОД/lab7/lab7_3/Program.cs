using System;
using System.Diagnostics;
using System.Linq;

namespace lab7_3
{
    class Program
    {
        static int[] initial;

        static void Main(string[] args)
        {
            initial = Enumerable.Range(0, 10000).ToArray();
            Shuffle();
            int[] initial2 = new int[initial.Length];
            Array.Copy(initial, initial2, initial.Length);

            Stopwatch timer = new Stopwatch();
            timer.Start();
            Sort.SequentialQuickSort<int>(initial);
            timer.Stop();
            Console.WriteLine($"Sequential QuickSort(10000): time={timer.ElapsedMilliseconds}ms");

            timer = new Stopwatch();
            timer.Start();
            Sort.ParallelQuickSort<int>(initial2);
            timer.Stop();
            Console.WriteLine($"Parallel QuickSort(10000): time={timer.ElapsedMilliseconds}ms");
            Console.WriteLine("-------------------------------------");

            //-------------------------
            initial = Enumerable.Range(0, 100000).ToArray();
            Shuffle();
            initial2 = new int[initial.Length];
            Array.Copy(initial, initial2, initial.Length);

            timer = new Stopwatch();
            timer.Start();
            Sort.SequentialQuickSort<int>(initial);
            timer.Stop();
            Console.WriteLine($"Sequential QuickSort(100000): time={timer.ElapsedMilliseconds}ms");

            timer = new Stopwatch();
            timer.Start();
            Sort.ParallelQuickSort<int>(initial2);
            timer.Stop();
            Console.WriteLine($"Parallel QuickSort(100000): time={timer.ElapsedMilliseconds}ms");
            Console.WriteLine("-------------------------------------");

            //-------------------------
            initial = Enumerable.Range(0, 1_000_000).ToArray();
            Shuffle();
            initial2 = new int[initial.Length];
            Array.Copy(initial, initial2, initial.Length);

            timer = new Stopwatch();
            timer.Start();
            Sort.SequentialQuickSort<int>(initial);
            timer.Stop();
            Console.WriteLine($"Sequential QuickSort(1_000_000): time={timer.ElapsedMilliseconds}ms");

            timer = new Stopwatch();
            timer.Start();
            Sort.ParallelQuickSort<int>(initial2);
            timer.Stop();
            Console.WriteLine($"Parallel QuickSort(1_000_000): time={timer.ElapsedMilliseconds}ms");
            Console.WriteLine("-------------------------------------");

            //--------------------
            initial = Enumerable.Range(0, 10_000_000).ToArray();
            Shuffle();
            initial2 = new int[initial.Length];
            Array.Copy(initial, initial2, initial.Length);

            timer = new Stopwatch();
            timer.Start();
            Sort.SequentialQuickSort<int>(initial);
            timer.Stop();
            Console.WriteLine($"Sequential QuickSort(10_000_000): time={timer.ElapsedMilliseconds}ms");

            timer = new Stopwatch();
            timer.Start();
            Sort.ParallelQuickSort<int>(initial2);
            timer.Stop();
            Console.WriteLine($"Parallel QuickSort(10_000_000): time={timer.ElapsedMilliseconds}ms");
        }

        private static void Shuffle()
        {
            //simple Fisher-Yates shuffle
            var random = new Random();
            for (int i = initial.Length - 1; i > 0; i--)
            {
                int j = random.Next(i);
                int value = initial[i];
                initial[i] = initial[j];
                initial[j] = value;
            }
        }
    }
}
