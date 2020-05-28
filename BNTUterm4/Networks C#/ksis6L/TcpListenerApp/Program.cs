using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace TcpListenerApp
{
    class Program
    {
        const int port = 8888; // порт для прослушивания подключений
        static void Main(string[] args)
        {
            TcpListener server = null;
            try
            {
                IPAddress localAddr = IPAddress.Parse("127.0.0.1");///000
                server = new TcpListener(localAddr, port);
                server.Start();
                while (true)
                {
                    Console.WriteLine("\nAwaiting to the conections... ");
                    TcpClient client = server.AcceptTcpClient();
                    Console.WriteLine("Client has conected. Request is being processed...");
                    NetworkStream stream = client.GetStream();
                    
                    byte[] buf = new byte[2];
                    StringBuilder clientMessage = new StringBuilder();
                    do
                    {
                        int bytes = stream.Read(buf, 0, buf.Length);
                        clientMessage.Append(Encoding.UTF8.GetString(buf, 0, bytes));
                    }
                    while (stream.DataAvailable);
                    Console.WriteLine("Message from client : " + clientMessage.ToString());
                    
                    Console.WriteLine("Enter message to client : ");
                    string response = Console.ReadLine();
                    buf= Encoding.UTF8.GetBytes(response);
                    stream.Write(buf, 0, buf.Length);

                    stream.Close();
                    client.Close();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            finally
            {
                server?.Stop();
            }
        }
    }
}
