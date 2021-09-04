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
using System.Diagnostics;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        SldWorks SwApp;
        IModelDoc2 swModel;

        double main_rectangle_L = 110.0 / 1000;
        double main_rectangle_W = 80.0 / 1000;
        double main_rectangle_H = 50.0 / 1000;

        double to_up_rectangle_L = 80.0 / 1000;
        double to_up_rectangle_W = 50.0 / 1000;
        double to_up_rectangle_H = 90.0 / 1000;

        double vurez_rectangle_L = 40.0 / 1000;
        double vurez_rectangle_W = 15.0 / 1000;
        double vurez_rectangle_H = 30.0 / 1000;

        double cilinder_rectangle_R = 25.0 / 1000;
        double cilinder_rectangle_H = 50.0 / 1000;

        Feature main_rectangle;
        Feature up_rectangle_3d;
        Feature from_side_rec;
        Feature from_side_rec_vurez;

        public Form1()
        {

            start();
        }

        private void start()
        {
            try
            {
                SwApp = (SldWorks)Marshal.GetActiveObject("SldWorks.Application");
            }
            catch
            {
                MessageBox.Show("Не удалось подключиться к solidworks");
                return;
            }
            // создание 3d документа
            SwApp.NewPart();
            swModel = SwApp.IActiveDoc2;
            swModel.SetUnits((short)swLengthUnit_e.swMM, (short)swFractionDisplay_e.swDECIMAL, 0, 0, false);
            int pref_toggle = (int)swUserPreferenceToggle_e.swInputDimValOnCreate;
            SwApp.SetUserPreferenceToggle(pref_toggle, false);

            // -- Нижний параллелепипед
            swModel.Extension.SelectByID2("Top Plane", "PLANE", 0, 0, 0, false, 0, null, 0);
            swModel.SketchManager.InsertSketch(true);
            swModel.SketchManager.CreateCenterRectangle(0, 0, 0, main_rectangle_L / 2, main_rectangle_W / 2, 0);
            swModel.ClearSelection2(true);
            var main_rectangle = swModel.FeatureManager.FeatureExtrusion2(true, false, false, 0, 0, main_rectangle_H, 0.01, false, false, false, false, 1.74532925199433E-02, 1.74532925199433E-02,
                false, false, false, false, true, true, true, 0, 0, false);


            // -- Высокий параллелепипед
            var buttom_side = main_rectangle.GetFaces();
            var ent = buttom_side[0] as Entity;
            ent.Select(true);
            swModel.SketchManager.InsertSketch(true);
            swModel.Extension.SelectByID2("Top Plane", "PLANE", 0, 0, 0, false, 0, null, 0);
            var up_rectangle = swModel.SketchManager
                .CreateCornerRectangle(main_rectangle_W / 2, to_up_rectangle_L / 2, 0,
                                   -to_up_rectangle_L / 2 , main_rectangle_W / 2 - to_up_rectangle_W, 0);
            swModel.ClearSelection2(true);
            var from_side_rec = swModel.FeatureManager.FeatureExtrusion2(true, false, true, 0, 0, to_up_rectangle_H, 0.01, false, false, false, false, 1.74532925199433E-02, 1.74532925199433E-02,
                false, false, false, false, true, true, true, 0, 0, false);

            // Приямоугольный вырез
            var from_side_rec_ = from_side_rec.GetFaces();
            var ent2 = from_side_rec_[2] as Entity;
            ent2.Select(true);
            swModel.SketchManager.InsertSketch(true);
            swModel.Extension.SelectByID2("Top Plane", "PLANE", 0, 0, 0, false, 0, null, 0);
            var from_side_rec_2d = swModel.SketchManager.CreateCornerRectangle(- vurez_rectangle_L/2, main_rectangle_H, 0,
                vurez_rectangle_L / 2, main_rectangle_H - vurez_rectangle_W, 0);
            swModel.ClearSelection2(true);
            var from_side_rec_vurez = swModel.FeatureManager.FeatureCut3(false, false, false, 0, 0, 0.0000001, vurez_rectangle_H, false, false, false, false, 1.74532925199433E-02, 1.74532925199433E-02,
                false, false, false, false, false, true, true, true, true, false, 0, 0, false);
            //0.0000001

            // Вырезать цилидр
            var ent_2 = buttom_side[2] as Entity;
            ent_2.Select(true);
            swModel.SketchManager.InsertSketch(true);

            swModel.Extension.SelectByID2("Front Plane", "PLANE", 0, 0, 0, false, 0, null, 0);
            var cilinder_2d = swModel.SketchManager.CreateCircleByRadius(0, to_up_rectangle_H, 0, cilinder_rectangle_R);
            swModel.ClearSelection2(true);
            var cilinder_2d_virez = swModel.FeatureManager.FeatureCut3(false, false, false, 0, 0, cilinder_rectangle_H, 0.01, false, false, false, false, 1.74532925199433E-02, 1.74532925199433E-02,
                false, false, false, false, false, true, true, true, true, false, 0, 0, false);
        }
    }
}// 5 6 9 10
