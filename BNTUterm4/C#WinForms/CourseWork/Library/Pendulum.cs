using System;
using System.Collections.Generic;
using System.Drawing;
using System.Threading;

namespace Library
{
    public class Pendulum
    {
        public Data Info { get; set; }
        public float A { get; set; }

        public float Length { get; set; }

        public float T { get; set; }

        public float MaxAlpha { get; set; }

        public float Acceleration { get; set; }

        public Pendulum()
        {

        }

        public Pendulum(Pendulum pendulum)
        {
            A = pendulum.A;
            Length = pendulum.Length;
            T = pendulum.T;
            Acceleration = pendulum.Acceleration;
        }


        public override string ToString()
        {
            return string.Format("Amplitude: {2} m; Length: {0} m; T: {1} s; " +
                "Acceleration: {3} m/s^2", Length, T, A, Acceleration);
        }

        public override bool Equals(object obj)
        {
            return obj is Pendulum pendulum &&
                   EqualityComparer<Data>.Default.Equals(Info, pendulum.Info) &&
                   A == pendulum.A &&
                   Length == pendulum.Length &&
                   T == pendulum.T &&
                   MaxAlpha == pendulum.MaxAlpha &&
                   Acceleration == pendulum.Acceleration;
        }

        public override int GetHashCode()
        {
            var hashCode = 2031769565;
            hashCode = hashCode * -1521134295 + EqualityComparer<Data>.Default.GetHashCode(Info);
            hashCode = hashCode * -1521134295 + A.GetHashCode();
            hashCode = hashCode * -1521134295 + Length.GetHashCode();
            hashCode = hashCode * -1521134295 + T.GetHashCode();
            hashCode = hashCode * -1521134295 + MaxAlpha.GetHashCode();
            hashCode = hashCode * -1521134295 + Acceleration.GetHashCode();
            return hashCode;
        }
    }
}