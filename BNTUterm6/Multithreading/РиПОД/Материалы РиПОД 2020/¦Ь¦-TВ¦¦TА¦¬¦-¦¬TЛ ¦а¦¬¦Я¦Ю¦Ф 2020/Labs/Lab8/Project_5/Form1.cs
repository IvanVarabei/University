using System;
using System.Reflection;
using System.Windows.Forms;

namespace Project_5
{


    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();

        }
        private void buttonPlan_Click(object sender, System.EventArgs e)
        {

            //Беру Guid
            Guid myGuid = new Guid("b5fe8884-c20c-4743-a1b3-851daad6d188");
            Type oobjType = Type.GetTypeFromCLSID(myGuid);
            //Теперь пытаюсь вызвать на этом объекте метод
            object a = Activator.CreateInstance(oobjType, true);
            
            string[] str;
            object[] args = new object[] {Int16.Parse(textBoxTstep.Text)};
            str = (string[]) oobjType.InvokeMember("Get", BindingFlags.DeclaredOnly |
                                                          BindingFlags.Public | BindingFlags.NonPublic |
                                                          BindingFlags.Instance | BindingFlags.InvokeMethod, null, a, args);
            richTextBox1.Text = str[1];
            richTextBox2.Text = str[0];
        }

    }
}
