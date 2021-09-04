using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace Lab1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                int n;
                float h;
                h = float.Parse(textBox4.Text);
                float a1 = float.Parse(textBox2.Text);
                float a2 = float.Parse(textBox3.Text);
                n = int.Parse(textBox1.Text);

                if (n <= 0)
                {
                    throw new ArgumentException($"{nameof(n)} can't be less 1.");
                }

                richTextBox1.Text = string.Empty;

                while (a1 < a2)
                {
                    float R = 1 / (a1 + (1 - a1) / n);
                    richTextBox1.Text += $"  a = {a1}  R = {R}\n";
                    chart1.Series[0].Points.AddXY(R, a1);
                    a1 += h;
                }
            }
            catch(FormatException)
            {
                MessageBox.Show("Invalid data, try again", "Error", MessageBoxButtons.RetryCancel, MessageBoxIcon.Error);
            }
            catch (ArgumentException ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.RetryCancel, MessageBoxIcon.Error);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                int n;
                float h;
                var Ct = float.Parse(textBox9.Text);
                float a = float.Parse(textBox10.Text);

                h = float.Parse(textBox5.Text);
                float c1 = float.Parse(textBox7.Text);
                float c2 = float.Parse(textBox6.Text);
                n = int.Parse(textBox8.Text);

                if (n <= 0)
                {
                    throw new ArgumentException($"{nameof(n)} can't be less 1.");
                }

                richTextBox2.Text = string.Empty;

                while (c1 <= c2)
                {
                    float c = Ct * c1;
                    float Rc = 1 / (a + (1 - a) / n + c);
                    richTextBox2.Text += $"  c = {c1}  Rc = {Rc}\n";
                    chart2.Series[0].Points.AddXY(Rc, c1);
                    c1 += h;
                }
            }
            catch (FormatException)
            {
                MessageBox.Show("Invalid data, try again", "Error", MessageBoxButtons.RetryCancel, MessageBoxIcon.Error);
            }
            catch (ArgumentException ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.RetryCancel, MessageBoxIcon.Error);
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
