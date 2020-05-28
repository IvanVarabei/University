using System.Collections.Generic;
using System.Drawing;

namespace Library
{
    public class Data
    {
        public Dictionary<int, Bitmap> Shots { get; set; } = new Dictionary<int, Bitmap>();
        public List<Moment> Moments { get; set; } = new List<Moment>();
        public int Interval { get; set; }

        public int NumberOfShots { get; set; }

        public override bool Equals(object obj)
        {
            return obj is Data data &&
                   EqualityComparer<Dictionary<int, Bitmap>>.Default.Equals(Shots, data.Shots) &&
                   EqualityComparer<List<Moment>>.Default.Equals(Moments, data.Moments) &&
                   Interval == data.Interval &&
                   NumberOfShots == data.NumberOfShots;
        }

        public override int GetHashCode()
        {
            var hashCode = 1050476186;
            hashCode = hashCode * -1521134295 + EqualityComparer<Dictionary<int, Bitmap>>.Default.GetHashCode(Shots);
            hashCode = hashCode * -1521134295 + EqualityComparer<List<Moment>>.Default.GetHashCode(Moments);
            hashCode = hashCode * -1521134295 + Interval.GetHashCode();
            hashCode = hashCode * -1521134295 + NumberOfShots.GetHashCode();
            return hashCode;
        }

    }
}
