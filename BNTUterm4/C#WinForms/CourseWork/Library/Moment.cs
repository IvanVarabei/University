
namespace Library
{
    public class Moment
    {
        public double Phase { get; set; }
        public double X { get; set; }
        public double Time { get; set; }
        public Moment(double phase, double x, double t)
        {
            Phase = phase;
            X = x;
            Time = t;
        }

        public override bool Equals(object obj)
        {
            return obj is Moment moment &&
                   Phase == moment.Phase &&
                   X == moment.X &&
                   Time == moment.Time;
        }

        public override int GetHashCode()
        {
            var hashCode = 1951886939;
            hashCode = hashCode * -1521134295 + Phase.GetHashCode();
            hashCode = hashCode * -1521134295 + X.GetHashCode();
            hashCode = hashCode * -1521134295 + Time.GetHashCode();
            return hashCode;
        }

    }
}
