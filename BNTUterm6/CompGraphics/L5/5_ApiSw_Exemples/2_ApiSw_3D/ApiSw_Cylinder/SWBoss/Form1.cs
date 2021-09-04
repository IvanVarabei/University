using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
// Эта библиотека используется для маршаллинга
using System.Runtime.InteropServices;
// Библиотеки SolidWorks API
using SolidWorks.Interop.swcommands;
using SolidWorks.Interop.sldworks;
using SolidWorks.Interop.swconst;

namespace SWBoss
{
    public partial class Form1 : Form
    {
        SldWorks SwApp;
        IModelDoc2 swModel;

        public Form1()
        {
            InitializeComponent();
        }

        private void buttonB_Click(object sender, EventArgs e)
        {
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
                MessageBox.Show("Следует открыть документ SW перед использованием");
                System.Environment.Exit(-1); //моментальный выход из программы            
            }
            swModel = SwApp.IActiveDoc2;     //стандартное присвоение

            bool done = true;
            int x, y, z, r;
            int depth;
            x = y = r = 0;
            if (int.TryParse(boxX.Text, out x) == false)
                done = false;
            if (int.TryParse(boxY.Text, out y) == false)
                done = false;
            if (int.TryParse(boxZ.Text, out z) == false)
                done = false;
            if (int.TryParse(boxR.Text, out r) == false)
                done = false;
            if (int.TryParse(boxDepth.Text, out depth) == false)
                done = false;
            if (done == true)
            {
                Circle tCircle = new Circle(x, y, z, r);
                swModel.Extension.SelectByID2("Спереди", "PLANE", 0, 0, 0, false, 0, null, 0); //выбрал плоскость  
                swModel.SketchManager.InsertSketch(true); //вставил эскиз в режиме редактирования  
                swModel.SketchManager.CreateCircle(tCircle.Center.X, tCircle.Center.Y, tCircle.Center.Z, tCircle.Center.X - tCircle.R, tCircle.Center.Y - tCircle.R, tCircle.Center.Z - tCircle.R); // создал круг
                swModel.FeatureManager.FeatureExtrusion2(true, false, false, 0, 0, depth, 0.01, false, false, false, false, 1.74532925199433E-02, 1.74532925199433E-02, false, false, false, false, true, true, true, 0, 0, false);
                swModel.SketchManager.InsertSketch(true); //закрыл эскиз  
                swModel.ClearSelection2(true); //снял выделение с линии
            }
            else System.Console.WriteLine("Неправильные параметры круга!");
        }

    }
    // Класс Точка
    public class Point
    {
        public int x, y, z;
        public int X
        {
            get
            {
                return x;
            }
            set
            {
                x = value;
            }
        }
        public int Y
        {
            get
            {
                return y;
            }
            set
            {
                y = value;
            }
        }
        public int Z
        {
            get
            {
                return z;
            }
            set
            {
                z = value;
            }
        }
        public Point()
        {
            x = y = z = 0;
        }
        public Point(int inX, int inY, int inZ)
        {
            this.X = inX;
            this.Y = inY;
            this.Z = inZ;
        }
    };
    // Класс Круг
    public class Circle
    {
        public int r;
        public int R
        {
            get
            {
                return r;
            }
            set
            {
                r = value;
            }
        }
        public Point Center;
        public Circle()
        {
            Point Center = new Point();
            this.R = 0;
        }
        public Circle(int x0, int y0, int z0, int r0)
        {
            this.Center = new Point(x0, y0, z0);
            this.R = r0;
        }
    }
}

