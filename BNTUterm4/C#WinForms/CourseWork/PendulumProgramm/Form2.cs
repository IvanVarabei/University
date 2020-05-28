using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SingleThread
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
            Opacity = 0;
            timer1.Start();
        }

        private void timer1_Tick(object sender, EventArgs e)
        { 
            for(int i =0; i< 10; i++)
            {
                Opacity += 0.1;
            }
        }
    }
}
