using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using SolidWorks.Interop.sldworks;
using SolidWorks.Interop.swconst;
using System.Runtime.InteropServices;


namespace ЧертежЛиния
{
    public partial class Form1 : Form
    {
        private SldWorks swApp;
        private ModelDoc2 swModel;
        private SketchManager swSketchManager;
        private SelectionMgr swSelMgr;
        public Form1()
        {       
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // Если не получилось открыть деталь в SolidWorks то завершить
            if (!GetSolidworks())
            {
                return;
            }

            double x=0, y=0, x2 = 0, y2 = 0;
            double.TryParse(textBox1.Text, out x);
            double.TryParse(textBox2.Text, out y);
            double.TryParse(textBox3.Text, out x2);
            double.TryParse(textBox4.Text, out y2);
            swModel.SketchManager.CreateLine(x, y, 0, x2, y2, 0);
        }

        private Boolean GetSolidworks()
        {
            try
            {
                // Присваиваем переменной ссылку на запущенный solidworks (по названию)
                swApp = (SldWorks)Marshal.GetActiveObject("SldWorks.Application");
            }
            catch
            {
                // Отображает окно сообщения с заданным текстом
                MessageBox.Show("Не удалось найти запущенный Solidworks!");
                return false;
            }

            if (swApp.ActiveDoc == null)
            {
                // Отображает окно сообщения с заданным текстом
                MessageBox.Show("Надо открыть деталь перед использованием");
                return false;
            }


            // Присваиваем переменной ссылку на открытый активный проект в  SolidWorks
            swModel = (ModelDoc2)swApp.ActiveDoc;

            // Получает ISketchManager объект, который позволяет получить доступ к процедурам эскиза
            swSketchManager = (SketchManager)swModel.SketchManager;

            // Получает ISelectionMgr объект для данного документа, что делает выбранный объект доступным
            swSelMgr = (SelectionMgr)swModel.SelectionManager;
            

            // Проверка на открытие именно детали в SolidWorks
            if (swModel.GetType() != (int)swDocumentTypes_e.swDocDRAWING)
            {
                string text = "Это работает только на уровне чертежа";
                // Отображает окно сообщения с заданным текстом
                MessageBox.Show(text, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            return true;
        }
        
    }
}
