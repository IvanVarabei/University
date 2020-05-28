using System;
using System.Text;
using System.Net.Sockets;
using System.Text.RegularExpressions;

namespace httpClient
{
    class Program
    {
        static string targetIP;//= "185.165.123.36";
        static string url;//= "http://stopcovid.belta.by/";
        static int port;//= 80;

        static void Main(string[] args)
        {
            initialize();
            Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            socket.Connect(targetIP, port);
            string GETrequest = "GET " + url + " HTTP/1.1\r\n" +
                "Host: localhost\r\nConnection: keep-alive\r\nAccept: text/html\r\n" +
                "User-Agent: CSharpTests\r\n\r\n";
            socket.Send(Encoding.ASCII.GetBytes(GETrequest));
            Console.WriteLine("Request from client:\n" + GETrequest);

            bool flag = true; // just so we know we are still reading
            string headerString = ""; // to store header information
            byte[] bodyBuff = new byte[0]; // to later hold the body content
            while (flag)
            {
                // read the header byte by byte, until \r\n\r\n
                byte[] buffer = new byte[1];
                socket.Receive(buffer, 0, 1, 0);
                headerString += Encoding.ASCII.GetString(buffer);
                if (headerString.Contains("\r\n\r\n"))
                {
                    Regex reg = new Regex("\\\r\nContent-Length: (.*?)\\\r\n");
                    Match m = reg.Match(headerString);
                    int contentLength = int.Parse(m.Groups[1].ToString());
                    flag = false;
                    // read the body
                    bodyBuff = new byte[contentLength];
                    socket.Receive(bodyBuff, 0, contentLength, 0);
                }
            }
            Console.WriteLine("Server Response :\n" + headerString+ Encoding.ASCII.GetString(bodyBuff));
            socket.Close();
            Console.Read();
        }


        static void initialize()
        {
            Console.Write("Enter target IP:");
            targetIP = Console.ReadLine();
            Console.Write("Enter target url:");
            url = Console.ReadLine();
            Console.Write("Enter target port:");
            port = int.Parse(Console.ReadLine());
            Console.WriteLine();
        }
    }
}
