using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;

namespace L6_RiPOD
{
    public partial class Form1 : Form
    {
        private EdgeZeroingStrategy EZS;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            EZS = new EdgeZeroingStrategy();
            EZS.File_Load("start_param.txt");
            EZS.Planning();
            ViewResults();
            PlanResult();
        }

        private void ViewResults()
        {
            ClearView();

            // матрица смежности

            dataGridView1.ColumnCount = EZS.OperationsCount + 1;
            dataGridView1.RowCount = EZS.OperationsCount + 1;
            dataGridView1.ColumnHeadersVisible = false;
            dataGridView1.RowHeadersVisible = false;

            for (int i = 0; i < EZS.OperationsCount + 1; i++)
            {
                // по вертикали
                dataGridView1.Rows[i].Cells[0].Style.BackColor = Color.FromArgb(168, 196, 26);
                //dataGridView1.Rows[i].Cells[0].Style.ForeColor = Color.FromArgb(255, 255, 255);
                dataGridView1.Rows[i].Cells[0].Value = i;
                // по горизонали
                //dataGridView1.Rows[0].Cells[i].Style.ForeColor = Color.FromArgb(255, 255, 255);
                dataGridView1.Rows[0].Cells[i].Style.BackColor = Color.FromArgb(168, 196, 26);
                dataGridView1.Rows[0].Cells[i].Value = i;

                dataGridView1.Columns[i].Width = 50;
            }

            dataGridView1.Rows[0].Cells[0].Value = "Operation \\  operation";

            for (int i = 0; i < EZS.OperationsCount; i++)
            {
                for (int k = 0; k < EZS.TasksConnections[i].Length; k++)
                {
                    if (EZS.TasksConnections[i][k] !="0")
                    {
                        dataGridView1.Rows[i + 1].Cells[k + 1].Style.BackColor = Color.FromArgb(214, 63, 13);
                    }
                    dataGridView1.Rows[i + 1].Cells[k + 1].Value = EZS.TasksConnections[i][k];
                }
            }
        }

        private void ClearView()
        {
            dataGridView1.ColumnCount = 1;
            dataGridView1.RowCount = 1;
            dataGridView1.ColumnCount = 1;
            dataGridView1.RowCount = 1;
            richTextBox1.Text = "";
        }

        private void PlanResult()
        {
            int lenPlan = EZS.FindLengthPlan(EZS.ProcessorsList);

            richTextBox1.Text = "time";

            List<int> power = new List<int>();

            for (int i = 0; i < EZS.ProcessorsList.Count; i++)
            {
                richTextBox1.Text += "\t\tPE" + i;
                power.Add(0);
            }

            richTextBox1.Text += "\n";

            

            for (int i = 0; i < lenPlan + 1; i++)
            {
                richTextBox1.Text += i;
                for (int pe = 0; pe < EZS.ProcessorsList.Count; pe++)
                {
                    string name = GetTaskNameOnThisTime(EZS.ProcessorsList, i, pe);
                    richTextBox1.Text += "\t\t" + name;
                }

                richTextBox1.Text += "\n";
            }

            for (int i = 0; i < EZS.ProcessorsList.Count; i++)
            {
                for (int k = 0; k < EZS.ProcessorsList[i].Count; k++)
                {
                    power[i] += EZS.ProcessorsList[i][k].TimeCalculation;
                }
            }

            richTextBox1.Text += "\nLoad:";

            for (int i = 0; i < EZS.ProcessorsList.Count; i++)
            {
                double load = Convert.ToDouble(power[i]) / Convert.ToDouble(lenPlan);
                richTextBox1.Text += "\t\t" + load.ToString(String.Format("##.## %"));
            }
        }

        private string GetTaskNameOnThisTime(List<List<EZTask>> procList, int time, int pe)
        {
            foreach (var task in procList[pe])
            {
                if (time >= task.StartTime && time <= task.EndTime)
                {
                    return task.Name;
                }
            }

            return " ";
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }
    }
}
