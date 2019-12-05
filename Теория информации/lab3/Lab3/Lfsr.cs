using System.Collections;
using System.Text;

namespace Lab3
{
    public class Lfsr
    {
        BitArray register;
        int[] taps;
        StringBuilder builder;


        public Lfsr(bool[] seed, int[] taps)
        {
            register = new BitArray(seed);
            this.taps = taps;
            builder = new StringBuilder(register.Count);
        }

        public void Shift()
        {
            bool newBit = register[taps[0] - 1];
            for (int i = 1; i < taps.Length; i++)
                newBit ^= register[taps[i] - 1];

            for (int i = register.Count - 1; i > 0; i--)
            {
                register[i] = register[i - 1];
            };

            register[0] = newBit;
        }

        public bool GetFeedback()
        {
            return register[register.Count - 1];
        }

        public override string ToString()
        {
            builder.Clear();
            for (int i = 0; i < register.Count; i++)
                builder.Append(register[i] ? '1' : '0');
            return builder.ToString();
        }
    }
}