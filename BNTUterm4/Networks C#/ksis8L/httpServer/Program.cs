using System;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;



namespace httpServer
{
    class HttpServer
    {
        public static HttpListener listener;
        public static string url = "http://localhost:8000/Varabei_10701118/";
        public static int pageViews = 0;
        public static int requestCount = 0;
        public static string pageData = ReadFile(@"C:\fourth\ksis\ksis8L\httpServer\page.html");


        public static async Task HandleIncomingConnections()
        {
            bool runServer = true;
            while (runServer)
            {
                HttpListenerContext ctx = await listener.GetContextAsync();
                HttpListenerRequest req = ctx.Request;
                HttpListenerResponse resp = ctx.Response;
                OutRequestInfo(req);
                string disableSubmit = !runServer ? "disabled" : "";
                byte[] data = Encoding.UTF8.GetBytes(String.Format(pageData, ++pageViews, disableSubmit));
                resp.ContentType = "text/html";
                resp.ContentEncoding = Encoding.UTF8;
                resp.ContentLength64 = data.LongLength;

                OutResponseInfo(resp);

                if (req.HttpMethod == "POST" && req.Url.AbsolutePath == "/Varabei_10701118/shutdown")
                {
                    Console.WriteLine("Shutdown requested");
                    runServer = false;
                }
                await resp.OutputStream.WriteAsync(data, 0, data.Length);
                resp.Close();
            }
        }

        static void OutRequestInfo(HttpListenerRequest req)
        {
            Console.WriteLine("Request #: {0}", ++requestCount);
            Console.WriteLine(req.HttpMethod + " " + req.Url.AbsoluteUri
               + " " + req.Url.Scheme + "/" + req.ProtocolVersion);
            Console.WriteLine("AbsoluteUri: " + req.Url.AbsoluteUri);
            Console.WriteLine("Scheme: " + req.Url.Scheme);
            Console.WriteLine("Authority: " + req.Url.Host);
            Console.WriteLine("AbsolutePath: " + req.Url.AbsolutePath);
            Console.WriteLine("UserHostName: " + req.UserHostName);
            Console.WriteLine("UserAgent: " + req.UserAgent);
            Console.WriteLine("Accept: " + ArrayToStr(req.AcceptTypes));
            Console.WriteLine("HasEntityBody: " + req.HasEntityBody);
            Console.WriteLine();
        }

        static void OutResponseInfo(HttpListenerResponse resp)
        {
            Console.WriteLine("Response #: {0}", requestCount);
            Console.WriteLine("http/" + resp.ProtocolVersion + " " + resp.StatusCode + " " + resp.StatusDescription);
            Console.WriteLine("ContentType: " + resp.ContentType);
            Console.WriteLine("ContentLength64: " + resp.ContentLength64);
            Console.WriteLine();
            Console.WriteLine(pageData);
            Console.WriteLine();
        }

        static string ArrayToStr(string[] ms)
        {
            string res = "";
            for (int i = 0; i < ms.Length; i++)
            {
                res += ms[i] + "; ";
            }
            return res;
        }
        public static string ReadFile(String path)
        {
            string content = "";

            try
            {
                using (StreamReader sr = new StreamReader(path))
                {
                    content = sr.ReadToEnd();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return content;
        }


        public static void Main(string[] args)
        {
            // Create a Http server and start listening for incoming connections
            listener = new HttpListener();
            listener.Prefixes.Add(url);
            listener.Start();
            Console.WriteLine("Listening for connections on {0}\n", url);

            // Handle requests
            Task listenTask = HandleIncomingConnections();
            listenTask.GetAwaiter().GetResult();

            // Close the listener
            listener.Close();
            Console.Read();
        }
    }

}
