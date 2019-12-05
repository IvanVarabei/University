using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.IO.Ports;  //Подключение библиотеки для работы с последовательным портом COM1-COM16

namespace Serial_port_test
{
    public partial class Form1 : Form
    {

        private const String FILE_PATH = @"C:\COM_WIN\C# проект\Serial port test\logs.txt";

        public Form1()
        {
            InitializeComponent();
        }

        private SerialPort port;    //создание объекта
        private Form2 form2;

        private void Form1_Load(object sender, EventArgs e)
        {
            label1.Text = "";
            comboBox2.SelectedIndex = 0;
            form2 = new Form2();
            form2.Show();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try { port = new SerialPort(comboBox1.SelectedItem.ToString()); }   //инициализация объекта port
            catch (Exception) { 
                label1.Text = "Ошибка при создании объекта.";
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (comboBox1.SelectedItem == null)
                {
                    label1.Text = "Не выбран порт.";

                    return;
                }
                label1.Text = "";
                form2.textBox2.Text = "";
                port.ReadTimeout = 500; //таймаут на прием-передачу
                port.WriteTimeout = 500;
                port.Open();
                if (comboBox2.SelectedIndex == 0)
                {
                    port.WriteLine(textBox1.Text);
                    form2.textBox2.AppendText(port.ReadLine());
                    writeToFile(form2.textBox2.Text);
                }
                if (comboBox2.SelectedIndex == 1)
                {
                    port.RtsEnable = false;
                    textBox1.Text = "False" + Environment.NewLine;
                    form2.textBox2.Text = port.CtsHolding.ToString() + Environment.NewLine;
                    port.RtsEnable = true;
                    textBox1.Text += "True";
                    form2.textBox2.Text += port.CtsHolding.ToString();
                }
                if (comboBox2.SelectedIndex == 2)
                {
                    port.DtrEnable = false;
                    textBox1.Text = "False" + Environment.NewLine;
                    form2.textBox2.Text = port.DsrHolding.ToString() + Environment.NewLine;
                    port.DtrEnable = true;
                    textBox1.Text += "True";
                    form2.textBox2.Text += port.DsrHolding.ToString();
                }
                port.Close();
            }
            catch (ArgumentNullException)
            {
                label1.Text = "Параметр str имеет значение null.";
            }
            catch (InvalidOperationException)
            {
                //label1.Text = "Указанный порт не открыт.";
                writeToFile("Указанный порт не открыт.");
            }
            catch (TimeoutException)
            {
                label1.Text = "Операция не была завершена до истечения срока ожидания.";
            }
            catch (Exception)
            {
                label1.Text = "Неизвестная ошибка.";
            }
            finally //закрытие порта
            {
                if (label1.Text != "") {
                    writeToFile(label1.Text);
                }
                try { port.Close(); }
                catch (Exception) { }
            }
        }

        private void comboBox1_Click(object sender, EventArgs e)
        {
            label1.Text = "";
            try
            {
                comboBox1.Items.Clear();
                comboBox1.Items.AddRange(SerialPort.GetPortNames());
            }
            catch (Exception) { label1.Text = "Ошибка инициализации."; }
        }

        private void writeToFile(String text) {
            using (StreamWriter sw = File.AppendText(FILE_PATH))
            {
                sw.WriteLine(text);
            }
        }
    }
}
