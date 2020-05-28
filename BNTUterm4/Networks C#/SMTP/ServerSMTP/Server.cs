using System;
using System.Net.Sockets;
using System.Text;


namespace ServerSMTP
{
    class SMTPServer
    {
        public TcpClient Client { get; set; }
        public string Log { get; private set; } = "";
        public event Action<string> Processed = (w) => { };//UpperCase event
        public event Action<string> Detached = (s) => { };//UpperCase event

        public SMTPServer(TcpClient client)
        {
            Client = client;
        }

        public void Run()
        {
            Write("220 localhost -- Fake proxy server");
            string strMessage = String.Empty;
            while (true)
            {
                try
                {
                    strMessage = Read();
                }
                catch 
                {
                    Detached(Log);
                    break;
                }
                if (strMessage.Length > 0)
                {  
                    if (strMessage.StartsWith("QUIT"))
                    {
                        Write("221 The connection has successfully ended");
                        Client.Close();
                        Detached(Log);
                        break;
                    }
                    else if (strMessage.StartsWith("EHLO") || strMessage.StartsWith("HELO"))
                    {
                        Write("250 localhost");
                    }
                    else if(strMessage.StartsWith("RCPT TO"))
                    {
                        Write("250 OK");
                    }
                    else if(strMessage.StartsWith("MAIL FROM"))
                    {
                        Write("250 OK");
                    }
                    else if (strMessage.StartsWith("HELP"))
                    {
                        Write("EHLO\nHELO\nQUIT\nRCPT TO\nMAIL FROM\nDATA\nHELP");
                    }
                    else if(strMessage.StartsWith("DATA"))
                    {
                        Write("354 send the mail data, end with .");
                        strMessage = Read();
                        Write("250 OK");
                    }
                    else
                    {
                        Write("502 Error: cmmand not recognized");
                    }
                }
            }
        }

        private void Write(String strMessage)
        {
            NetworkStream clientStream = Client.GetStream();
            ASCIIEncoding encoder = new ASCIIEncoding();
            byte[] buffer = encoder.GetBytes(strMessage + "\r\n");
            clientStream.Write(buffer, 0, buffer.Length);
            clientStream.Flush();
            Log += "S : " + strMessage + "\n";
            Processed("S : " + strMessage + "\n");
           
        }

        private String Read()
        {
            byte[] messageBytes = new byte[8192];
            int bytesRead = 0;
            NetworkStream clientStream = Client.GetStream();
            ASCIIEncoding encoder = new ASCIIEncoding();
            bytesRead = clientStream.Read(messageBytes, 0, 8192);
            string strMessage = encoder.GetString(messageBytes, 0, bytesRead);
            if (strMessage.EndsWith("\n"))
            {
                Processed("C : " + strMessage);
                Log += "C : " + strMessage;
            }
            else
            {
                Processed("C : " + strMessage + "\n");
                Log += "C : " + strMessage + "\n";
            }
            return strMessage;
        }
    }
}
