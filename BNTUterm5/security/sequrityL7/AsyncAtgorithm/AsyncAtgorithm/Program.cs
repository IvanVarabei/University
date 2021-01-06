using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace AsyncAtgorithm
{
    class Program
    {
        static int KEY_SIZE_4096 = 1 << 12;
        static string CONTAINER_NAME = "MyContainerName";
        static void Main(string[] args)
        {
            Console.Write("Plain:\t ");
            string message = Console.ReadLine();
            PersistKeys();
            Console.WriteLine("---------------------Encription---------------------");
            byte[] encrypted = Encrypt(Encoding.UTF8.GetBytes(message));
            Console.WriteLine("---------------------Decription---------------------");
            byte[] decrypted = Decrypt(encrypted);
            Console.WriteLine("---------------------Result---------------------");
            DeleteKeyInCSP();
            Console.WriteLine("Encrypted:\t" + BitConverter.ToString(encrypted).Replace("-", "") + "\n");
            Console.WriteLine("Decrypted:\t" + Encoding.UTF8.GetString(decrypted));
            Console.ReadLine();
        }

        static void PersistKeys()
        {
            int rsa_provider = 1;
            CspParameters cspParameters =
                new CspParameters(rsa_provider); //1 for rsa ; 13 for DSA ( Digital signature algorithm)
            cspParameters.KeyContainerName = CONTAINER_NAME;
            cspParameters.Flags = CspProviderFlags.UseMachineKeyStore;
            cspParameters.ProviderName = "Microsoft Strong Cryptographic Provider";
            var rsa = new RSACryptoServiceProvider(cspParameters);
            rsa.PersistKeyInCsp = true;
            Console.WriteLine("Min key size: " + rsa.LegalKeySizes[0].MinSize);
            Console.WriteLine("Max key size: " + rsa.LegalKeySizes[0].MaxSize);
            Console.WriteLine("Skip size: " + rsa.LegalKeySizes[0].SkipSize);
        }

        public static void DeleteKeyInCSP()
        {
            var cspParams = new CspParameters();
            cspParams.KeyContainerName = CONTAINER_NAME;
            var rsa = new RSACryptoServiceProvider(cspParams);
            rsa.PersistKeyInCsp = false;
            rsa.Clear();
        }

        private static byte[] Encrypt(byte[] plain)
        {
            byte[] encrypted;
            int rsa_provider = 1;
            CspParameters cspParameters = new CspParameters(rsa_provider);
            cspParameters.KeyContainerName = CONTAINER_NAME;
            var rsa = new RSACryptoServiceProvider(KEY_SIZE_4096, cspParameters);
            RSAParameters rSAParameters = rsa.ExportParameters(true);
            string modules = "";
            foreach(Byte b in rSAParameters.Modulus) { modules += b + " "; }
            string exps = "";
            foreach (Byte b in rSAParameters.Exponent) { exps += b + " "; }
            Console.WriteLine("Key size: " + rsa.KeySize + "\n");
            Console.WriteLine("Modules: " + modules + "\n");
            Console.WriteLine("Exponents: " + exps + "\n");
            encrypted = rsa.Encrypt(plain, true);
            return encrypted;
        }

        private static byte[] Decrypt(byte[] encrypted)
        {
            byte[] decrypted;
            CspParameters cspParameters = new CspParameters();
            cspParameters.KeyContainerName = CONTAINER_NAME;
            var rsa = new RSACryptoServiceProvider(KEY_SIZE_4096, cspParameters);
            RSAParameters rSAParameters = rsa.ExportParameters(true);
            Console.WriteLine("P: " + ArrayToStr(rSAParameters.P) + "\n");
            Console.WriteLine("Q: " + ArrayToStr(rSAParameters.Q) + "\n");
            Console.WriteLine("e: " + ArrayToStr(rSAParameters.Exponent) + "\n");
            Console.WriteLine("d: " + ArrayToStr(rSAParameters.D) + "\n");
            decrypted = rsa.Decrypt(encrypted, true);
            return decrypted;
        }
        private static string ArrayToStr(Byte[] array)
        {
            string modules = "";
            foreach (Byte b in array) { modules += b + " "; }
            return modules;
        }
    }
}



//using System;
//using System.Linq;
//using System.Security.Cryptography;
//using System.Text;

//namespace AsyncAtgorithm
//{
//    class Program
//    {
//        static int KEY_SIZE_4096 = 1 << 12;
//        static string CONTAINER_NAME = "MyContainerName";
//        static void Main(string[] args)
//        {
//            string message = "The quick brown fox jumps over the lazy dog";
//            Console.WriteLine("Original\n\t " + message + "\n");
//            PersistKeys();
//            byte[] encrypted = Encrypt(Encoding.UTF8.GetBytes(message));
//            byte[] decrypted = Decrypt(encrypted);
//            DeleteKeyInCSP();
//            Console.WriteLine("Encrypted\n\t" + BitConverter.ToString(encrypted).Replace("-", "") + "\n");
//            Console.WriteLine("Decrypted\n\t" + Encoding.UTF8.GetString(decrypted));
//            Console.ReadLine();
//        }

//        static void PersistKeys()
//        {
//            int rsa_provider = 1;
//            CspParameters cspParameters = 
//                new CspParameters(rsa_provider); //1 for rsa ; 13 for DSA ( Digital signature algorithm)
//            cspParameters.KeyContainerName = CONTAINER_NAME;
//            cspParameters.Flags = CspProviderFlags.UseMachineKeyStore;
//            cspParameters.ProviderName = "Microsoft Strong Cryptographic Provider";
//            var rsa = new RSACryptoServiceProvider(cspParameters);
//            rsa.PersistKeyInCsp = true;
//        }

//        public static void DeleteKeyInCSP()
//        {
//            var cspParams = new CspParameters();
//            cspParams.KeyContainerName = CONTAINER_NAME;
//            var rsa = new RSACryptoServiceProvider(cspParams);
//            rsa.PersistKeyInCsp = false;
//            rsa.Clear();
//        }

//        private static byte[] Encrypt(byte[] plain)
//        {
//            byte[] encrypted;
//            int rsa_provider = 1;
//            CspParameters cspParameters = new CspParameters(rsa_provider);
//            cspParameters.KeyContainerName = CONTAINER_NAME;
//            using (var rsa = new RSACryptoServiceProvider(KEY_SIZE_4096, cspParameters))
//            {
//                Console.WriteLine("Key size: " + rsa.KeySize);
//                encrypted = rsa.Encrypt(plain, true);

//            }
//            return encrypted;
//        }

//        private static byte[] Decrypt(byte[] encrypted)
//        {
//            byte[] decrypted;
//            CspParameters cspParameters = new CspParameters();
//            cspParameters.KeyContainerName = CONTAINER_NAME;
//            using (var rsa = new RSACryptoServiceProvider(KEY_SIZE_4096, cspParameters))
//            {
//                decrypted = rsa.Decrypt(encrypted, true);
//            }
//            return decrypted;
//        }     
//    }
//}
