using System;
using System.Windows.Forms;
using Library;


namespace SingleThread
{
    public partial class Form1 : Form
    {
        private Pendulum Pend;
        private Drawer Drawer;
        private ISaver Saver;

        public Form1()
        {
            InitializeComponent();
            ShowIcon = false;
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            float l, a,g, maxAlpha;
            while (true)
            {
                l = float.Parse(textBox1?.Text); a = float.Parse(textBox2?.Text);
                g = float.Parse(textBox3?.Text); maxAlpha = (float)Math.Asin(a / (2 * l));
                if (g > 0 && l*1.3 > a && l>0 && a > 0)
                {
                    break;
                }
                else
                {
                    richTextBox1.AppendText("The initial data is wrong!\nTry again.\n");
                    richTextBox1.ScrollToCaret();
                    return;
                }
            }
            PendulumBuilder builder;
            if (maxAlpha <= 0.0524)
            {
                builder = new Pendulum3DegBuilder();
            }
            else
            {//question
                builder = maxAlpha <= 1 ? new Pendulum60DegBuilder() : (PendulumBuilder)new Pendulum90DegBuilder();
            }
            PendulumBuildManager manager = new PendulumBuildManager(builder);
            Pend = manager.Produce(l, a, g);
            label5.Text = Math.Round(Pend.T, 4).ToString();
            Drawer?.Tmr?.Stop();
            Drawer = new Drawer(Pend, pictureBox1, label7);
            Processor.Process(Pend, pictureBox1);
            Drawer.Draw();
            button2.Enabled = true;
            button3.Enabled = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            richTextBox1.AppendText("WORD saving is in process...\n");
            richTextBox1.ScrollToCaret();
            Saver = new WordSaver();
            Saver.Done += (s) =>
            {
                richTextBox1.AppendText(s);
                richTextBox1.ScrollToCaret();
            };
            Saver.SaveAsync(Pend);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            richTextBox1.AppendText("EXCEL saving is in process...\n");
            richTextBox1.ScrollToCaret();
            Saver = new ExcelSaver();
            Saver.Done += (s) =>
            {
                richTextBox1.AppendText(s);
            };
            Saver.SaveAsync(Pend);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Drawer?.Tmr?.Stop();
        }

        private void userManualToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(
                "C:\\Users\\Asus\\Documents\\HelpNDoc\\Output\\chm\\Pendulum.chm");
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Drawer?.Tmr?.Start();
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start(
                "C:\\Users\\Asus\\Documents\\HelpNDoc\\Output\\chm\\Pendulum.chm");
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

    }
}
