using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Windows.Forms;
using System.IO;

namespace ServerSMTP
{
    public partial class Dashboard : Form
    {
        TcpListener listener = new TcpListener(new IPEndPoint(IPAddress.Any, 25));
        List<TcpClient> clients = new List<TcpClient>();
        Queue<string> logs = new Queue<string>();
        int numberOfClients;
        Thread loger;

        public Dashboard()
        {
            InitializeComponent();
            loger = new Thread(new ThreadStart(Write));
            loger.Start();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            listener.Start();
            button1.Enabled = groupBox1.Enabled = false;
            button2.Enabled = true;
            await Task.Run(() =>
  {
      while (true)
      {
          try
          {
              TcpClient client = listener.AcceptTcpClient();
              clients.Add(client);
              SMTPServer handler = new SMTPServer(client);
              handler.Detached += (s) => { numberOfClients--; ShowNumber(); };
              handler.Detached += Detach;
              handler.Detached += (text) => logs.Enqueue(text);
              if (radioButton2.Checked == true)
                  handler.Processed += ShowDilog;
              Thread thread = new Thread(new ThreadStart(handler.Run));
              thread.Start();
              Attach();
              numberOfClients++;
              ShowNumber();
              if (radioButton2.Checked == true)
              {
                  listener.Stop();
                  break;
              }
          }
          catch
          {
              return;
          }
      }
  });

        }

        private void button2_Click(object sender, EventArgs e)
        {
            clients.ForEach((s) => s.Close());
            button2.Enabled = false;
            groupBox1.Enabled = button1.Enabled = true;
            listener.Stop();
            ShowNumber();
        }

        public void ShowDilog(string s)
        {
            Action action = () =>
            {
                richTextBox1.AppendText(s);
                richTextBox1.ScrollToCaret();
            };
            this.InvokeEx(action);
        }

        public void Attach()
        {
            Action action = () =>
            {
                richTextBox1.AppendText("********New client has connected********\n");
                richTextBox1.ScrollToCaret();
            };
            this.InvokeEx(action);
        }

        public void Detach(string s)
        {
            Action action = () =>
            {
                richTextBox1.AppendText("********A client has detached********\n");
                richTextBox1.ScrollToCaret();
            };
            this.InvokeEx(action);
        }

        void ShowNumber()
        {
            Action action = () => label1.Text = "" + numberOfClients;
            this.InvokeEx(action);
        }

        void Write()
        {
            while (true)
            {
                if (logs.Count > 0)
                {
                    string writePath = @"C:\fourth\ksis\SMTP\log.txt";
                    try
                    {
                        using (StreamWriter sw = new StreamWriter(writePath, true, Encoding.Default))
                        {
                            sw.WriteLine(logs.Dequeue());
                        }
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e.Message);
                    }
                }
                else
                {
                    Thread.Sleep(50);
                }
            }
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            while (logs.Count > 0) { }
            loger.Abort();
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e) => button1.Enabled = true;

        private void radioButton2_CheckedChanged(object sender, EventArgs e) => button1.Enabled = true;

        private void button3_Click(object sender, EventArgs e) => richTextBox1.Clear();

    }
}
