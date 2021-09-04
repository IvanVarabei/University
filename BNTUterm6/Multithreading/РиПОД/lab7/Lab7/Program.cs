using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace Lab7
{
    class Program
    {
        static int[] initial; //generating random array only once and using copies of it later
        private static void Main(string[] args)
        {
            initial = Enumerable.Range(0, 100000000).ToArray();
            Shuffle();
            TestLength<Quicksort<int>>(5);
            TestLength<Quicksort<int>>(10);
            TestLength<Quicksort<int>>(100);
            TestLength<Quicksort<int>>(1000);
            TestLength<Quicksort<int>>(10000);
            TestLength<Quicksort<int>>(100000);
            TestLength<Quicksort<int>>(1000000);
            TestLength<Quicksort<int>>(10000000);

            TestLength<Quicksort<int>>(100000000);
            Console.ReadKey();
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

        private static void TestLength<T>(int length) where T : ISortAlgorithm<int>, new()
        {
            var arr = new int[length];

            Console.WriteLine("Length: " + length);

            Array.Copy(initial, arr, length);
            var timer = new Stopwatch();
            var algorithm = new T { Elements = arr };
            timer.Start();
            algorithm.ParallelSort();
            timer.Stop();

            Console.WriteLine("Elapsed parallel: " + timer.Elapsed);

            Array.Copy(initial, arr, length);
            timer.Reset();
            algorithm = new T { Elements = arr };
            timer.Start();
            algorithm.Sort();
            timer.Stop();
            Console.WriteLine("Elapsed:      " + timer.Elapsed);
            Console.WriteLine();
        }
    }

    public interface ISortAlgorithm<T> where T : IComparable
    {
        T[] Elements { get; set; }
        void ParallelSort();
        void Sort();
        void SortNoRecursion();
    }

    public class Quicksort<T> : ISortAlgorithm<T> where T : IComparable
    {
        T[] _elements;
        int _threshold;

        //begin interface implementation
        public T[] Elements
        {
            get
            {
                return _elements;
            }
            set
            {
                _elements = value;
                _threshold = (int)Math.Sqrt(Math.Log(value.Length));
            }
        }

        public void ParallelSort()
        {
            Sort(0, _elements.Length, 0, (int)Math.Log(Environment.ProcessorCount, 2) + 4);
            var s = new InsertionSort<T>
            {
                Elements = _elements
            };
            s.SortNoRecursion();
        }

        public void Sort()
        {
            Sort(0, _elements.Length, 0, 0);
            var s = new InsertionSort<T>
            {
                Elements = _elements
            };
            s.SortNoRecursion();
        }

        public void SortNoRecursion()
        {
            SortNoRecursion(0, _elements.Length);
            var s = new InsertionSort<T>
            {
                Elements = _elements
            };
            s.SortNoRecursion();
        }
        //end interface implementation

        private void Sort(int low, int high, int depth, int pdepth)
        {
            if (high - low < _threshold)
            {
                return;
            }
            if (depth > 7000)
            {
                //avoids stack overflow
                SortNoRecursion(low, high);
                return;
            }

            var mid = Partition(low, high);

            if (pdepth > 0)
            {
                Parallel.Invoke(
                    () => Sort(low, mid, depth + 1, pdepth - 1),
                    () => Sort(mid + 1, high, depth + 1, pdepth - 1)
                    );
            }
            else
            {
                Sort(low, mid, depth + 1, 0);
                Sort(mid + 1, high, depth + 1, 0);
            }
        }

        private struct Frame
        {
            public int Low;
            public int High;
        }

        private void SortNoRecursion(int low, int high)
        {
            var stack = new Stack<Frame>();
            stack.Push(new Frame { Low = low, High = high });
            while (stack.Count > 0)
            {
                var frame = stack.Pop();
                low = frame.Low;
                high = frame.High;

                if (high - low < _threshold)
                {
                    continue;
                }

                var mid = Partition(low, high);

                stack.Push(new Frame { Low = low, High = mid });
                stack.Push(new Frame { Low = mid + 1, High = high });
            }
        }

        private int Partition(int low, int high)
        {
            var pivot = ChoosePivot(low, high);
            var store = low;
            for (var i = low; i < high - 1; i++)
            {
                if (_elements[i].CompareTo(pivot) >= 0)
                {
                    continue;
                }
                var temp = _elements[store];
                _elements[store] = _elements[i];
                _elements[i] = temp;
                store++;
            }
            _elements[high - 1] = _elements[store];
            _elements[store] = pivot;
            return store;
        }

        private T ChoosePivot(int low, int high)
        {
            T pivot = _elements[high - 1];
            T pivot2 = _elements[low];
            T pivot3 = _elements[(low + high) / 2];

            if (pivot.CompareTo(pivot2) < 0 && pivot.CompareTo(pivot3) < 0)
            {
                if (pivot2.CompareTo(pivot3) < 0)
                {
                    _elements[high - 1] = pivot2;
                    _elements[low] = pivot;
                    pivot = pivot2;
                }
                else
                {
                    _elements[high - 1] = pivot3;
                    _elements[(low + high) / 2] = pivot;
                    pivot = pivot3;
                }
            }
            else if (pivot.CompareTo(pivot2) > 0 && pivot.CompareTo(pivot3) > 0)
            {
                if (pivot2.CompareTo(pivot3) < 0)
                {
                    _elements[high - 1] = pivot3;
                    _elements[(low + high) / 2] = pivot;
                    pivot = pivot3;
                }
                else
                {
                    _elements[high - 1] = pivot2;
                    _elements[low] = pivot;
                    pivot = pivot2;
                }
            }
            return pivot;
        }
    }

    public class InsertionSort<T> : ISortAlgorithm<T> where T : IComparable
    {
        T[] _elements;
        public T[] Elements { get { return _elements; } set { _elements = value; } }
        public void ParallelSort()
        {
            SortNoRecursion();
        }
        public void Sort()
        {
            SortNoRecursion();
        }
        public void SortNoRecursion()
        {
            var length = _elements.Length;
            for (var i = 1; i < length; i++)
            {
                var x = _elements[i];
                var j = i;
                while (j > 0 && x.CompareTo(_elements[j - 1]) < 0)
                {
                    _elements[j] = _elements[j - 1];
                    j--;
                }
                _elements[j] = x;
            }
        }
    }
}
