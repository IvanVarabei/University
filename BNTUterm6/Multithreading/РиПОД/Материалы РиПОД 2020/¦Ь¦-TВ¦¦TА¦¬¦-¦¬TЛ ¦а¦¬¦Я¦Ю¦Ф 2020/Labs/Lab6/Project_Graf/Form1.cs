using System;
using System.Drawing;
using System.Windows.Forms;

namespace Project_Graf
{
    public partial class Form1 : Form
    {
        private ClassAllClass classAll = new ClassAllClass();
        private int n;
        public Form1()
        {
            InitializeComponent();
            classAll.datamanager.Fill(3, dataGridViewGraf);
            classAll.datamanager.FillType(3, dataGridViewType);

        }

        private void numericUpDownPor_Click(object sender, EventArgs e)
        {
            classAll.datamanager.Fill((Int16)numericUpDownPor.Value, dataGridViewGraf);
            classAll.datamanager.FillType((Int16)numericUpDownPor.Value, dataGridViewType);
        }

        private void buttonCreateList_Click(object sender, EventArgs e)
        {

            classAll.MassGrafType(dataGridViewType, dataGridViewGraf);
            classAll.CreateDrawGraf((int)numericUpDownPor.Value);
            classAll.ClearDraw();
            classAll.List((int)numericUpDownPor.Value);
            classAll.drawgraf.GrafPic(pictureBox1, (int)numericUpDownPor.Value);
        }

        private void pictureBox1_MouseDown(object sender, MouseEventArgs e)
        {
            int n = (int)numericUpDownPor.Value;
            if (e.Button == MouseButtons.Left)
            {
                for (int i = 0; i < n; i++)
                {
                    if ((Math.Pow(Math.Abs(classAll.drawgraf.Xc[i] - e.X), 2)) + (Math.Pow(Math.Abs(classAll.drawgraf.Yc[i] - e.Y), 2)) <= 256)
                    {
                        classAll.drawgraf.Draw = true;
                        classAll.movepoint.origin.X = e.X;
                        classAll.movepoint.origin.Y = e.Y;
                        classAll.movepoint.movePt.X = e.X;
                        classAll.movepoint.movePt.Y = e.Y;
                        classAll.movepoint.Current = i;
                    }
                }
            }
        }

        private void pictureBox1_MouseUp(object sender, MouseEventArgs e)
        {
            classAll.drawgraf.g.Clear(Color.White);
            if (classAll.drawgraf.Draw)
            {
                Point p = new Point();
                p.X = classAll.movepoint.movePt.X;
                p.Y = classAll.movepoint.movePt.Y;
                classAll.drawgraf.DrawMove(classAll.movepoint.origin, new Point(e.X, e.Y), classAll.movepoint.Current);
                pictureBox1.Invalidate();
                classAll.movepoint.movePt.X = p.X;
                classAll.movepoint.movePt.Y = p.Y;
                classAll.drawgraf.Draw = false;
            }
        }

        private void pictureBox1_MouseMove(object sender, MouseEventArgs e)
        {

            if (classAll.drawgraf.Draw)
            {
                classAll.drawgraf.g.Clear(Color.White);
                classAll.movepoint.origin.X = classAll.movepoint.movePt.X;
                classAll.movepoint.origin.Y = classAll.movepoint.movePt.Y;
                //classAll.drawgraf.DrawMove(classAll.movepoint.origin, classAll.movepoint.movePt, classAll.movepoint.Current);
                //pictureBox1.Invalidate();
                classAll.movepoint.movePt.X = e.X;
                classAll.movepoint.movePt.Y = e.Y;
                classAll.drawgraf.DrawMove(classAll.movepoint.origin, classAll.movepoint.movePt, classAll.movepoint.Current);
                pictureBox1.Invalidate();
            }

        }

        private void buttonOper_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 2;
            classAll.paral = classAll.drawgraf.DrawGrafOperation(pictureBoxGrafSl, (int)numericUpDownPor.Value, classAll.tree);
            n = 0;

        }

        private void button1_Click(object sender, EventArgs e)
        {
            classAll.Plain(n);
            classAll.drawgraf.DrawParal(classAll.paral, pictureBoxGrafSl);
            n++;
        }

    }
}
