using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace TCPClient
{
    class TCP_Client
    {
        private const int Port = 11000;
        private const int Size = 1024;

        static void Main(String[] args)
        {
            try
            {
                Console.WriteLine("Client is on...");

                IPHostEntry ipHost = Dns.Resolve("192.168.43.99");
                IPAddress ipAddr = ipHost.AddressList[0];
                IPEndPoint ipEndPoint = new IPEndPoint(ipAddr, Port);

                Socket s1 = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

                Console.WriteLine("Connecting with server: {0}", ipEndPoint);
                s1.Connect(ipEndPoint);

                String textClient = DateTime.Now.ToString() + "<The End>";
                byte[] byteSend = Encoding.ASCII.GetBytes(textClient);
                s1.Send(byteSend);

                byte[] byteRec = new byte[Size];
                int len = s1.Receive(byteRec);

                String textServer = null;
                textServer = Encoding.ASCII.GetString(byteRec, 0, len);

                Console.WriteLine("From server receive: {0}", textServer);
                Console.WriteLine("Local end point: {0}", s1.LocalEndPoint);

              
                s1.Shutdown(SocketShutdown.Both);
                s1.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.ToString());
            }
            finally
            {
                Console.ReadLine();
            }
        }
    }
}
