using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace Lab2
{
    public partial class Form1 : Form
    {
        private CAsap Asap = new CAsap();
        

        public Form1()
        {
            InitializeComponent();
        }       

        private void Form1_Load(object sender, EventArgs e)
        {
            Asap.File_Load("start_param.txt");
            Asap.Planning();
            ViewResults();            
        }

        private void ViewResults()
        {
            // шаги
            richTextBox1.Text = "Всего шагов: " + Asap.steps.Count;
            
            for (int i = 0; i < Asap.steps.Count; i++)
            {
                richTextBox1.Text += "\nНа " + (i + 1) + " шаге запланированы следующие операции: ";

                for (int k = 0; k < Asap.steps[i].Count; k++)
                {
                    richTextBox1.Text += " " + (Asap.steps[i][k] + 1);
                }
                richTextBox1.Text += "\nТипы операций:";
                for (int k = 0; k < Asap.countTypes; k++)
                {
                    richTextBox1.Text += "\nТип " + (k + 1) + ": " + Asap.countOperationsForType[i][k];
                }
            }

            // Количество процессоров каждого типа

            richTextBox1.Text += "\n\nВсего процессоров: " + Asap.maxproc;

            for (int i = 0; i < Asap.countTypes; i++)
            {
                richTextBox1.Text += "\nТип " + (i + 1) + ": " + Asap.countProcessorsByTypes[i];               
            }

            // типы операций

            dataGridView1.ColumnCount = Asap.countTypes + 1;
            dataGridView1.RowCount = Asap.countOperations + 1;
            dataGridView1.Rows[0].Cells[0].Value = "Operation \\  type";
            dataGridView1.ColumnHeadersVisible = false;
            dataGridView1.RowHeadersVisible = false;

            for (int i = -1; i < Asap.countTypes; i++)
            {
                dataGridView1.Rows[0].Cells[i + 1].Style.BackColor = Color.FromArgb(191, 163, 255);
                if (i > -1)
                {
                    dataGridView1.Rows[0].Cells[i + 1].Value = i + 1;
                    dataGridView1.Columns[i + 1].Width = 50;
                }
            }

            for (int i = 0; i < Asap.countOperations; i++)
            {
                dataGridView1.Rows[i + 1].Cells[0].Style.BackColor = Color.FromArgb(191, 163, 255);
                dataGridView1.Rows[i + 1].Cells[0].Value = i + 1;
                
            }

            for (int i = 0; i < Asap.countTypes; i++)
            {
                for (int k = 0; k < Asap.arrayTypes[i].Length; k++)
                {
                    dataGridView1.Rows[Asap.arrayTypes[i][k]].Cells[i + 1].Style.BackColor = Color.FromArgb(1, 1, 1);
                }
            }

            // матрица смежности

            dataGridView2.ColumnCount = Asap.countOperations + 1;
            dataGridView2.RowCount = Asap.countOperations + 1;            
            dataGridView2.ColumnHeadersVisible = false;
            dataGridView2.RowHeadersVisible = false;           

            for (int i = 0; i < Asap.countOperations + 1; i++)
            {
                // по вертикали
                dataGridView2.Rows[i].Cells[0].Style.BackColor = Color.FromArgb(191, 163, 255);
                dataGridView2.Rows[i].Cells[0].Value = i;
                // по горизонали
                dataGridView2.Rows[0].Cells[i].Style.BackColor = Color.FromArgb(191, 163, 255);
                dataGridView2.Rows[0].Cells[i].Value = i;

                dataGridView2.Columns[i].Width = 50;
            }

            dataGridView2.Rows[0].Cells[0].Value = "Operation \\  operation";

            for (int i = 0; i < Asap.countOperations; i++)
            {
                for (int k = 0; k < Asap.arrayH[i].Length; k++)
                {
                    if (Asap.arrayH[i][k] == 1)
                    {
                        dataGridView2.Rows[i + 1].Cells[k + 1].Style.BackColor = Color.FromArgb(1, 1, 1);
                    }
                }
            }
        }

        private void ClearView()
        {
            dataGridView1.ColumnCount = 1;
            dataGridView1.RowCount = 1;
            dataGridView2.ColumnCount = 1;
            dataGridView2.RowCount = 1;            
        }

      
        private void button2_Click_1(object sender, EventArgs e)
        {
            Asap.Clear_Object();
            ClearView();
            Asap.File_Load("start_param.txt");
            Asap.Planning();
            ViewResults();  
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }
    }
}
