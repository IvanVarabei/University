using System.Security.Cryptography;
using System.Text;
using static System.Console;

namespace DigitalSignature
{
    class Message
    {
        public string plainText;
        public byte[] signature;
        public DSA x_dsa;

        public Message(string plainText, byte[] signature, DSA dsa)
        {
            this.plainText = plainText;
            this.signature = signature;
            x_dsa = dsa;
        }
    }
    class EDS
    {
        static SHA384 x_sha = SHA384.Create();

        static void Main(string[] args)
        {
            Message message = CreateDS();
            bool isVerified = VerifyDS(message);
            WriteLine("Is verified : " + isVerified);
        }

        static Message CreateDS()
        {
            Write("Insert plain text : ");
            string palinText = ReadLine();
            DSA x_dsa = DSA.Create();
            byte[] x_plaintext = Encoding.Default.GetBytes(palinText);
            byte[] x_hashcode = x_sha.ComputeHash(x_plaintext);
            byte[] x_signature = x_dsa.CreateSignature(x_hashcode);
            WriteLine("Hashcode : {0}\n", ByteArrayToString(x_hashcode));
            WriteLine("Hashcode size : {0}\n", x_hashcode.Length);
            WriteLine("Signiture : {0}\n", ArrayToString(x_signature));
            WriteLine("Key size : {0}\n", x_dsa.KeySize);
            WriteLine("SignatureAlgorithm : {0}\n", x_dsa.SignatureAlgorithm);
            WriteLine("Private key X : {0}\n", ArrayToString(x_dsa.ExportParameters(true).X));
            WriteLine("Public key P : {0}\n", ArrayToString(x_dsa.ExportParameters(false).P));
            WriteLine("Public key Q : {0}\n", ArrayToString(x_dsa.ExportParameters(false).Q));
            WriteLine("Public key G : {0}\n", ArrayToString(x_dsa.ExportParameters(false).G));
            WriteLine("Public key Y : {0}\n", ArrayToString(x_dsa.ExportParameters(false).Y));
            return new Message(palinText, x_signature, x_dsa);
        }

        static bool VerifyDS(Message message)
        {
            byte[] x_plaintext = Encoding.Default.GetBytes(message.plainText);
            byte[] x_signature = message.signature;
            byte[] x_hashcode = x_sha.ComputeHash(x_plaintext);
            DSA x_dsa = message.x_dsa;
            return x_dsa.VerifySignature(x_hashcode, x_signature);
        }

        static string ArrayToString(byte[] array)
        {
            StringBuilder sb = new StringBuilder();
            foreach(byte b in array)
            {
                sb.Append(b).Append(" ");
            }
            return sb.ToString();
        }

        public static string ByteArrayToString(byte[] ba)
        {
            StringBuilder hex = new StringBuilder(ba.Length * 2);
            foreach (byte b in ba)
                hex.AppendFormat("{0:x2}", b);
            return hex.ToString();
        }
    }
}
