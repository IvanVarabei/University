using System;
using System.Net;
using System.Net.Sockets;
using System.Text;


//BELOVA
namespace Server
{
    class SocketServer
    {
        private const string DefaultGateway = "192.168.43.99";
        private const int PORT = 11000;
        private const int LengthQueue = 10;
        private const int SIZE = 1024;


        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("Server is on...\n");
                IPEndPoint ipEndPoint = new IPEndPoint(IPAddress.Parse(DefaultGateway), PORT);

                Socket s1 = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

                s1.Bind(ipEndPoint);
                s1.Listen(LengthQueue);

                Console.WriteLine("Listening socket: \n" +
                                  "Descriptor of socket {0}\n " +
                                  "Ip-address {1}\n" +
                                  "Port of listening socket {2}", s1.Handle, ipEndPoint.Address, ipEndPoint.Port);
                while (true)
                {
                    Console.WriteLine("\nServer is waiting for connection...\n");

                    while (true)
                    {
                        Socket s2 = s1.Accept();
                        String dataRec = null;

                        Console.WriteLine("\nrequest received: \n" +
                                          "Descriptor of  new socket {0}\n " +
                                          "Ip-address of client {1}\n" +
                                          "Port of client socket {2}", s2.Handle,
                            ((IPEndPoint) s2.RemoteEndPoint).Address,
                            ((IPEndPoint) s2.RemoteEndPoint).Port);

                        String dataSend = GetPortUDP();

                        byte[] byteSend = Encoding.ASCII.GetBytes(dataSend);

                        //передаем данные клиенту
                        int lenBytesSend = s2.Send(byteSend);
                        Console.WriteLine("Send to client amount of bytes: {0}", lenBytesSend);
                        break;
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.ToString());
            }
            finally
            {
                Console.ReadLine();
                Console.WriteLine("Test");
            }
        }

        private static string GetPortUDP()
        {
            string ports = null;

            for (int i = 200; i < 250; i++)
            {
                try
                {
                    IPEndPoint endPoint = new IPEndPoint(IPAddress.Parse("127.0.0.1"), i);
                    Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
                    socket.Bind(endPoint);
                    socket.Close();

                    ports += "\nOpen UDP port: " + i;
                }
                catch (SocketException e)
                {
                    ports += "\nClosed UDP port: " + i;
                }
            }

            return ports;
        }
    }
}