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
using SolidWorks.Interop.swcommands;
using SolidWorks.Interop.swconst;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace Square
{
    public partial class Form1 : Form
    {
        SldWorks SwApp;
        IModelDoc2 swModel;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double K, L, M, N, D;
            K = Convert.ToDouble(textBox1.Text) / 1000;
            L = Convert.ToDouble(textBox2.Text) / 1000;
            M = Convert.ToDouble(textBox3.Text) / 1000;
            N = Convert.ToDouble(textBox4.Text) / 1000;
            D = Convert.ToDouble(textBox5.Text) / 1000;

            //Process[] processes = Process.GetProcessesByName("SLDWORKS");
            //foreach (Process process in processes)
            //{
            //    process.CloseMainWindow();
            //    process.Kill();
            //}
            //Guid myGuid1 = new Guid("F16137AD-8EE8-4D2A-8CAC-DFF5D1F67522");
            //object processSW = System.Activator.CreateInstance(System.Type.GetTypeFromCLSID(myGuid1));

            //SwApp = (SldWorks)processSW;
            //SwApp.Visible = true;

            try //блоком try-catch обычно оборачивают участок кода, который вызвает ошибку,   
            //и если она выскакивает, нужно ее отловить и распознать.  
            {
                SwApp = (SldWorks)Marshal.GetActiveObject("SldWorks.Application");
            }
            catch
            {
                MessageBox.Show("Не удалось подключиться к solidworks");
                return;
            }
            if (SwApp.IActiveDoc == null)     //если никакой документ не открыт  
            {
                // создание 3d документа
                SwApp.NewPart();

                //MessageBox.Show("Надо открыть документ SW перед использованием");
                //System.Environment.Exit(-1); //моментальный выход из программы, если   
                //не выполняются наши условия -   
                //дальнейший код бесполезен.   
                //Только ошибки посыпятся  
            }

            swModel = SwApp.IActiveDoc2;

            // построение 3d модели
            swModel.Extension.SelectByID2("Спереди", "PLANE", 0, 0, 0, false, 0, null, 0); //выбрал плоскость
            swModel.SketchManager.InsertSketch(true); //вставил эскиз в режиме редактирования  
            swModel.SketchManager.CreateCenterRectangle(0, 0, 0, K / 2, L / 2, 0);
            swModel.FeatureManager.FeatureExtrusion2(true, false, false, 0, 0, D, 0.01, false, false, false, false, 1.74532925199433E-02, 1.74532925199433E-02,
                false, false, false, false, true, true, true, 0, 0, false);

            swModel.Extension.SelectByID2("", "FACE", -3.14573861840017E-02, 1.44077058280914E-02, 0.03, false, 0, null, 0);
            swModel.SketchManager.InsertSketch(true); //вставил эскиз в режиме редактирования 
            swModel.SketchManager.CreateCenterRectangle(0, 0, 0, M / 2, N / 2, 0);
            swModel.ClearSelection2(true);
            //swModel.SketchManager.InsertSketch(false);

            swModel.Extension.SelectByID2("Эскиз2", "SKETCH", 0, 0, 0, false, 4, null, 0);
            swModel.FeatureManager.FeatureCut3(true, false, false, 1, 0, 0.01, 0.01, false, false, false, false, 1.74532925199433E-02, 1.74532925199433E-02,
                false, false, false, false, false, true, true, true, true, false, 0, 0, false);
            swModel.ClearSelection2(true);

            // построение шара
            //swModel.SketchManager.CreateCircle(0, 0, 0, -0.026781, -0.034413, 0);
            //swModel.SketchManager.CreateCenterLine(0, 0.080744, 0, 0, -0.074584, 0);
            //swModel.Extension.SelectByID2("Дуга1", "SKETCHSEGMENT", 0, 0, 0, false, 0, null, 0);
            //swModel.SketchManager.SketchTrim(1, 4.92765597546085E-02, 4.95443671445792E-03, 0);
            //swModel.SketchManager.InsertSketch(true);
            //swModel.Extension.SelectByID2("Line1@Эскиз1", "EXTSKETCHSEGMENT", -0.289231981168354, 0.115291081382386, 0, true, 0, null, 0);
        }
    }
}
