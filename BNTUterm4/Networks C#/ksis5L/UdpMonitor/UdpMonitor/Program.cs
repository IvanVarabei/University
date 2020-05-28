using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace UdpMonitor
{
    delegate void Check(int i);
    class Program
    {
        event Check TrueReserved;

        Program(){
        TrueReserved = i =>
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("The {0} socket is reserved", i);
                Thread.Sleep(7000);
                Console.ResetColor();
            };
        }

        static void Main(string[] args)
        {
            new Program().Monitor("127.0.0.1");
            Console.ReadKey();
        }

        void Monitor(string ip)
        {
            for (int i = 0; i <= 65535; i++ )
            {
                try
                {
                    Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
                    IPEndPoint localIP = new IPEndPoint(IPAddress.Parse(ip), i);
                    socket.Bind(localIP);
                    Console.WriteLine("The {0} socket is spare", i);
                    socket.Close();
                }
                catch(SocketException e)
                {
                    Console.WriteLine(e.Message);
                    TrueReserved(i);
                    continue;
                }
            }

        }
    }
}
