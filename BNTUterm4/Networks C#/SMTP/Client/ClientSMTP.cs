using System;
using System.Net.Mail;
using System.Net.Sockets;
using System.Text;

namespace Client
{
    class ClientSMTP
    {
        static void Main(string[] args)
        {
            Console.Write("Enter 1 - to auto connection; 2 - to manual connection:");
            if (Console.ReadLine() == "2")
                ConnectManually();
            else
                ConnectAuto();
            Console.WriteLine("Connection ended.");
            Console.Read();
        }
        private static void ConnectManually()
        {
            try
            {
                TcpClient client = new TcpClient();
                client.Connect("localhost", 25);
                byte[] data = new byte[256];
                StringBuilder response = new StringBuilder();
                NetworkStream stream = client.GetStream();
                try
                {
                    while (true)
                    {
                        do
                        {
                            int bytes = stream.Read(data, 0, data.Length);
                            response.Append(Encoding.UTF8.GetString(data, 0, bytes));
                        }
                        while (stream.DataAvailable); // пока данные есть в потоке
                        Console.Write("Response from server : " + response.ToString());
                        response = new StringBuilder();
                        Console.Write("Enter massege to send to server : ");
                        string mesToServ = Console.ReadLine();
                        data = Encoding.UTF8.GetBytes(mesToServ);
                        stream.Write(data, 0, data.Length);
                    }
                }
                catch
                {
                    stream.Close();
                    client.Close();
                }
            }
            catch (SocketException e)
            {
                Console.WriteLine("SocketException: {0}", e);
            }
            catch (Exception e)
            {
                Console.WriteLine("Exception: {0}", e.Message);
            }
            Console.WriteLine("Request ended.");
        }

        private static void ConnectAuto()
        {
            // отправитель - устанавливаем адрес и отображаемое в письме имя
            MailAddress from = new MailAddress("varabeiivan@gmail.com", "Tom");
            // кому отправляем
            MailAddress to = new MailAddress("epam.systems@gmail.com");
            // создаем объект сообщения
            MailMessage m = new MailMessage(from, to);
            // тема письма
            m.Subject = "Job interview";
            // текст письма
            m.Body = "The content is here";

            SmtpClient smtp = new SmtpClient("localhost");
            smtp.Send(m);//Handles all messages in the protocol
            Console.WriteLine("Request has been sent.");
            smtp.Dispose();//sends a Quit message
        }
    }
}
