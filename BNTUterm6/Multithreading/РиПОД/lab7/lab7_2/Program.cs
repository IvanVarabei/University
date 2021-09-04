using System;
using System.Diagnostics;
using System.Linq;

namespace lab7_2
{
    class Program
    {
        static void Main(string[] args)
        {
            var approach1Array = SortUtility.GenRandomArray<int>(size: 10_000_000);
            Console.WriteLine("Size " + approach1Array.Length);
            var approach2Array = new int[approach1Array.Length];
            Array.Copy(approach1Array, approach2Array, approach2Array.Length);

            Stopwatch approach1Stopwatch = new Stopwatch();
            ThreadedQuickSort<int> threadedQuickSort = new ThreadedQuickSort<int>();
            approach1Stopwatch.Start();
            _ = threadedQuickSort.QuickSort(approach1Array);
            approach1Stopwatch.Stop();
            Console.WriteLine($"ThreadedQuickSort - Is sorted? {SortUtility.IsSorted(approach1Array)}. ElapsedMS={approach1Stopwatch.ElapsedMilliseconds}");

            Stopwatch approach2Stopwatch = new Stopwatch();
            approach2Stopwatch.Start();
            approach2Array = Sort.QuickSort(approach2Array);
            approach2Stopwatch.Stop();
            Console.WriteLine($"QuickSort - Is sorted? {SortUtility.IsSorted(approach2Array)}. ElapsedMS={approach2Stopwatch.ElapsedMilliseconds}");

        }
    }
}
