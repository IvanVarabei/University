using System;
using System.Collections.Generic;
using System.Drawing;
using System.Threading;
using System.Windows.Forms;

namespace Lab7_8
{
    public partial class Form1 : Form
    {
        private EdgeZeroingStrategy EZS;
        private int lenPlan;
        private List<string> StatusPe = new List<string>();
        private double time;

        public delegate void SetTextCallback(double t);
        public delegate void SetRichTextCallback(string s);

        private Thread[] poolThreads;

        private List<bool> AccessTask = new List<bool>();

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
                dataGridView1.Rows[i].Cells[0].Style.BackColor = Color.FromArgb(110, 110, 110);
                dataGridView1.Rows[i].Cells[0].Style.ForeColor = Color.FromArgb(255, 255, 255);
                dataGridView1.Rows[i].Cells[0].Value = i;
                // по горизонали
                dataGridView1.Rows[0].Cells[i].Style.ForeColor = Color.FromArgb(255, 255, 255);
                dataGridView1.Rows[0].Cells[i].Style.BackColor = Color.FromArgb(110, 110, 110);
                dataGridView1.Rows[0].Cells[i].Value = i;

                dataGridView1.Columns[i].Width = 50;
            }

            dataGridView1.Rows[0].Cells[0].Value = "Operation \\  operation";

            for (int i = 0; i < EZS.OperationsCount; i++)
            {
                for (int k = 0; k < EZS.TasksConnections[i].Length; k++)
                {
                    if (EZS.TasksConnections[i][k] != "0")
                    {
                        dataGridView1.Rows[i + 1].Cells[k + 1].Style.BackColor = Color.FromArgb(82, 97, 160);
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
            lenPlan = EZS.FindLengthPlan(EZS.ProcessorsList);

            richTextBox1.Text = "time";

            List<int> power = new List<int>();

            for (int i = 0; i < EZS.ProcessorsList.Count; i++)
            {
                richTextBox1.Text += "\tPE" + i;
                power.Add(0);
            }

            richTextBox1.Text += "\n";



            for (int i = 0; i < lenPlan + 1; i++)
            {
                richTextBox1.Text += i;
                for (int pe = 0; pe < EZS.ProcessorsList.Count; pe++)
                {
                    string name = GetTaskNameOnThisTime(EZS.ProcessorsList, i, pe);
                    richTextBox1.Text += "\t" + name;
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
                richTextBox1.Text += "\t" + load.ToString(String.Format("##.## %"));
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
        private void Clock()
        {
            while (time * 10 < lenPlan)
            {
                lock (this)
                {
                    time += 0.01;
                    SetTextTime(time);
                    Thread.Sleep(10);
                }

                int a = (int)((time * 10 - Math.Truncate(time * 10)) * 10);

                // Каждые 100 мс вывод результатов на форму.
                // Внимание! Аномалия вывода!
                // При выводе, не останавливая все потоки, выводит с задержкой.
                // При Debug выводит правильно.
                if (a == 0)
                {
                    SetTextStatus(time.ToString(String.Format("#0.#")) + "  ");
                    for (int pe = 0; pe < EZS.ProcessorsList.Count; pe++)
                    {
                        lock (StatusPe)
                        {
                            if (pe != 0)
                            {
                                if (StatusPe[pe] == "Free")
                                {
                                    SetTextStatus(StatusPe[pe] + "\t\t");
                                }
                                else
                                {
                                    SetTextStatus(StatusPe[pe] + "\t");
                                }
                            }
                            else
                            {
                                SetTextStatus(StatusPe[pe] + "\t\t");
                            }
                        }
                    }
                    SetTextStatus("\n");

                    
                }
            }
        }

        // Запись значения времени в том потоке, где находится Label
        public void SetTextTime(double t)
        {

            if (this.labelTime.InvokeRequired)
            {
                SetTextCallback d = new SetTextCallback(SetTextTime);
                this.Invoke(d, new object[] { t });
            }
            else
            {
                this.labelTime.Text = t.ToString(String.Format("##.#"));
            }
        }

        // Вывод результата в том потоке, где находится RichTextBox
        public void SetTextStatus(string s)
        {

            if (this.richTextBox2.InvokeRequired)
            {
                SetRichTextCallback d = new SetRichTextCallback(SetTextStatus);
                this.Invoke(d, new object[] { s });
            }
            else
            {
                this.richTextBox2.Text += s.ToString();
            }
        }

        // Реализация плана
        private void button2_Click(object sender, EventArgs e)
        {
            // Пул потоков на рассчитанное количество процессоров
            poolThreads = new Thread[EZS.ProcessorsList.Count];

            // Очистка статусов каждого процессора
            StatusPe.Clear();
            labelTime.Text = "0";
            time = 0; // Начало времени
            richTextBox2.Text = "";

            // Создание n потоков - процессоров
            for (int i = 0; i < EZS.ProcessorsList.Count; i++)
            {
                poolThreads[i] = new Thread(new ParameterizedThreadStart(Processor));
                StatusPe.Add("");
            }
            
            // Запуск часов
            Thread clock = new Thread(Clock);
            clock.Start();

            // Запуск потоков - процессоров
            for (int i = 0; i < EZS.ProcessorsList.Count; i++)
            {
                poolThreads[i].Start(i);
            }
        }

        private void Processor(object pe)
        {
            while (Math.Truncate(time * 10) < lenPlan)
            {
                string s = "";
                int sleepLength = 0;
                int task = -1;
                lock (EZS)
                {
                    // Получение имени задачи на текущее время на указанном процессоре
                    s = GetTaskNameOnThisTime(EZS.ProcessorsList,
                        (int)Math.Truncate(time * 10), (int)pe);

                    lock (StatusPe[(int)pe])
                    {
                        if (s == " ")
                        {
                            StatusPe[(int)pe] = "Free"; // Свободный процессов
                        }
                        else
                        {
                            // Процессор занят
                            StatusPe[(int)pe] = "Work " + s;
                            sleepLength = EZS.FindEZTaskTimeCalculation(s) * 100;
                            task = EZS.FindTask(s);
                        }
                    }
                }
                
                if (s != " ")
                {
                    Thread.Sleep(sleepLength); // Имитация выполнения задачи

                    // Запуск имитации передачи данных на другие задачи
                    // Если таковые имеются
                    Thread conThread = new Thread(RunConnect);
                    conThread.Start(task);
                }
            }
        }

        // Имитация передачи данных на другие задачи
        private void RunConnect(object task)
        {
            if (EZS.Tasks[(int)task].Connections.Count > 0)
            {
                // Отправить в отдельный поток передачу данных с указанной задачи
                foreach (Connection connection in EZS.Tasks[(int)task].Connections)
                {
                    Thread conThread = new Thread(ConnectThread);
                    conThread.Name = "connect + " + connection.BeginTaskName + "-" + connection.TaskName;

                    // Запуск потока с передачей времени передачи данных в мс
                    conThread.Start(connection.TimeConnection * 100);
                }
            }
        }

        // Имитация передачи данных на одну задачу
        private void ConnectThread(object sleep)
        {
            Thread.Sleep((int)sleep);
        }
    }
}
