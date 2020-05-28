using System;
using System.Collections.Generic;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace ConsoleClient
{
    class Program
    {
        const int n = 5000;

        static void Main(string[] args)
        {
            int port = 8888;
            for(int i = 0; i<n; i++)
            {
                Client clientObject = new Client(port);
                Thread clientThread = new Thread(new ThreadStart(clientObject.Connect));
                clientThread.Start();
                Thread.Sleep(3000);
            }
        }

        
    }

    public class Client
    {
        int port;
        const string address = "127.0.0.1";
        string[] names = { "Ivan", "Valera", "Piter", "Liz","Eugen","Maria"};
        string[] messages = { "first", "second", "therd", "fourth", "fifth", "sixth" };
        Random rnd = new Random();
        public Client(int p)
        {
            port = p;
        }

        public void Connect()
        {
            string userName = names[rnd.Next(0,names.Length-1)];//rand

            TcpClient client = null;
            try
            {
                client = new TcpClient(address, port);
                NetworkStream stream = client.GetStream();

                while (true)
                {
                    Console.Write(userName + ": ");
                    // ввод сообщения
                    string message = messages[rnd.Next(0, messages.Length - 1)];//rand
                    message = String.Format("{0}: {1}", userName, message);
                    // преобразуем сообщение в массив байтов
                    byte[] data = Encoding.Unicode.GetBytes(message);
                    // отправка сообщения
                    stream.Write(data, 0, data.Length);

                    // получаем ответ
                    data = new byte[64]; // буфер для получаемых данных
                    StringBuilder builder = new StringBuilder();
                    int bytes = 0;
                    do
                    {
                        bytes = stream.Read(data, 0, data.Length);
                        builder.Append(Encoding.Unicode.GetString(data, 0, bytes));
                    }
                    while (stream.DataAvailable);

                    message = builder.ToString();
                    Console.WriteLine("Сервер: {0}", message);
                    Thread.Sleep(10000);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                client.Close();
            }
        }

    }
}