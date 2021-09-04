using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=DESKTOP-2KEE99S\\SQLEXPRESS; Initial Catalog=timetable; Integrated Security=true";
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = con;
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * FROM airport";
            string result = "";
            con.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                result = reader.GetValue(0) + " " + reader.GetValue(1);
                listBox1.Items.Insert(0, result);
            }
            reader.Close();
        }

        private void airportBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.airportBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.timetableDataSet);

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'timetableDataSet.airport' table. You can move, or remove it, as needed.
            this.airportTableAdapter.Fill(this.timetableDataSet.airport);

        }
    }
}
