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
        //IVAN
        double dementionFromLeftEdgeToCircleCenter = 0.03;
        double leftOutsideDemention = 0.040;
        double leftInsideDemention = 0.020;
        double leftBigSircleRadius = 0.025;
        double leftLittleCircleRadius = 0.015;
        double length = 0.1;
        double rightHight = 0.03;
        double rightCircleRadius = 0.01;
        double rightCircleCenterFromBottom = 0.015;
        double rightCircleCenterFromRightEdge = 0.015;
        double rightTangentBottomToRightEdge = 0.035;

        public Form1()
        {
            InitializeComponent();
            textBox1.Text = dementionFromLeftEdgeToCircleCenter.ToString();
            textBox2.Text = leftOutsideDemention.ToString();
            textBox3.Text = leftInsideDemention.ToString();
            textBox4.Text = leftBigSircleRadius.ToString();
            textBox5.Text = leftLittleCircleRadius.ToString();
            textBox6.Text = length.ToString();
            textBox7.Text = rightHight.ToString();
            textBox8.Text = rightCircleRadius.ToString();
            textBox9.Text = rightCircleCenterFromBottom.ToString();
            textBox10.Text = rightCircleCenterFromRightEdge.ToString();
            textBox11.Text = rightTangentBottomToRightEdge.ToString();
        }

        private ISldWorks app = null;

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                app = new SldWorks();
                app.FrameState = (int)swWindowState_e.swWindowMaximized;
                app.Visible = true;
            }
            catch
            {
                try
                {
                   app = (SldWorks)Marshal.GetActiveObject("SldWorks.Application");
                }
                catch
                {
                    MessageBox.Show("Не удалось cоединится с SolidWorks.");
                    return;
                }
            }
 
            ModelDoc2 doc;
            
            if (app.ActiveDoc == null)
            {
                doc = (ModelDoc2)app.INewDrawing((int)swDwgTemplates_e.swDwgTemplateA4sizeVertical);
                
                doc.SetUnits((short)swLengthUnit_e.swMM, (short)swFractionDisplay_e.swDECIMAL, 0, 0, false);
            }

            doc = (ModelDoc2)app.ActiveDoc;
            SketchManager sm = doc.SketchManager;
            int pref_toggle = (int)swUserPreferenceToggle_e.swInputDimValOnCreate;
            app.SetUserPreferenceToggle(pref_toggle, false);

            double startX = 0.050;
            double startY = 0.220;
            // START
              dementionFromLeftEdgeToCircleCenter = Convert.ToDouble(textBox1.Text);
            leftOutsideDemention = Convert.ToDouble(textBox2.Text);
            leftInsideDemention = Convert.ToDouble(textBox3.Text);
            leftBigSircleRadius = Convert.ToDouble(textBox4.Text);
            leftLittleCircleRadius = Convert.ToDouble(textBox5.Text);
            length = Convert.ToDouble(textBox6.Text);
            rightHight = Convert.ToDouble(textBox7.Text);
            rightCircleRadius = Convert.ToDouble(textBox8.Text);
            rightCircleCenterFromBottom = Convert.ToDouble(textBox9.Text);
            rightCircleCenterFromRightEdge = Convert.ToDouble(textBox10.Text);
            rightTangentBottomToRightEdge = Convert.ToDouble(textBox11.Text);

            // oprional handling
            if (false)
            {
                MessageBox.Show("Not valid.");
                return;
            }

            //CALCULATION
            double dementionFromLeftUpCornerToCircleCenter = leftOutsideDemention / 2;
            double leftShortLineLength = (leftOutsideDemention - leftInsideDemention) / 2;

            //POINTS
            var pointLeftUpOut = sm.CreatePoint(startX, startY, 0);
            var pointLeftUpIn = sm.CreatePoint(startX, startY - leftShortLineLength, 0);
            var pointLeftDownIn = sm.CreatePoint(startX, startY - leftOutsideDemention + leftShortLineLength, 0);
            var pointLeftDownOut = sm.CreatePoint(startX, startY - leftOutsideDemention, 0);
            var pointLeftCircle = sm.CreatePoint(startX + dementionFromLeftEdgeToCircleCenter, startY - dementionFromLeftUpCornerToCircleCenter, 0);
            var pointRightUp = sm.CreatePoint(startX + length, startY - leftShortLineLength, 0);
            var pointRightDown = sm.CreatePoint(startX + length, startY - leftShortLineLength - rightHight, 0);
            var pointRightDownIn = sm.CreatePoint(startX + length - rightCircleCenterFromRightEdge + rightCircleRadius, startY - leftShortLineLength - rightHight, 0);
            var pointRightCircle = sm.CreatePoint(pointRightDown.X - rightCircleCenterFromRightEdge, pointRightDown.Y + rightCircleCenterFromBottom, 0);
            var pointRightTangentBottom = sm.CreatePoint(pointRightDown.X - rightTangentBottomToRightEdge, pointRightDown.Y, 0);
            doc.ClearSelection();

            //DEMENTIONS
            //left inside
            pointLeftUpIn.Select(true);
            pointLeftDownIn.Select(true);
            doc.IAddVerticalDimension2(startX - 0.01, startY - 0.02, 0);
            doc.ClearSelection();

            //left outside
            pointLeftUpOut.Select(true);
            pointLeftDownOut.Select(true);
            doc.IAddVerticalDimension2(startX - 0.02, startY - 0.02, 0);
            doc.ClearSelection();

            //left edge to circle center
            pointLeftUpOut.Select(true);
            pointLeftCircle.Select(true);
            doc.IAddHorizontalDimension2(pointLeftUpOut.X + dementionFromLeftEdgeToCircleCenter / 2, pointLeftUpOut.Y + 0.01, 0);
            doc.ClearSelection();

            //right vertical
            pointRightUp.Select(true);
            pointRightDown.Select(true);
            doc.IAddVerticalDimension2(pointRightUp.X + 0.02, pointRightUp.Y - rightHight / 2, 0);
            doc.ClearSelection();

            //up main horizontal
            pointLeftUpOut.Select(true);
            pointRightUp.Select(true);
            doc.IAddHorizontalDimension2(pointLeftUpOut.X + length /2, pointLeftUpOut.Y + 0.03, 0);
            doc.ClearSelection();

            // from right bottom to right circle center
            pointRightCircle.Select(true);
            pointRightDown.Select(true);
            doc.IAddVerticalDimension2(pointRightUp.X + 0.01, pointRightDown.Y + rightCircleCenterFromBottom / 2, 0);
            doc.ClearSelection();

            // from right edge to right circle center
            pointRightCircle.Select(true);
            pointRightDown.Select(true);
            doc.IAddHorizontalDimension2(pointRightUp.X - rightCircleCenterFromRightEdge / 2, pointRightDown.Y - 0.01, 0);
            doc.ClearSelection();

            // from right edge to right circle center
            pointRightTangentBottom.Select(true);
            pointRightDown.Select(true);
            doc.IAddHorizontalDimension2(pointRightTangentBottom.X + rightTangentBottomToRightEdge / 2, pointRightDown.Y - 0.02, 0);
            doc.ClearSelection();

            //MAIN LINES
            sm.CreateLine(pointLeftUpOut.X, pointLeftUpOut.Y, 0, pointLeftUpIn.X, pointLeftUpIn.Y, 0);
            sm.CreateLine(pointLeftDownOut.X, pointLeftDownOut.Y, 0, pointLeftDownIn.X, pointLeftDownIn.Y, 0);
            sm.CreateLine(pointRightUp.X, pointRightUp.Y, 0, pointRightDown.X, pointRightDown.Y, 0);
            sm.CreateLine(pointRightDownIn.X, pointRightDownIn.Y, 0, pointRightDown.X, pointRightDown.Y, 0);
            var rightCircle = sm.CreateCircleByRadius(pointRightCircle.X, pointRightCircle.Y, 0, rightCircleRadius);
            rightCircle.Select(true);
            doc.IAddRadialDimension2(pointRightUp.X + 0.02, pointRightUp.Y + 0.02, 0);
            doc.ClearSelection();


            //a tangent right right line
            var tangentRightRight = sm.CreateLine(pointRightDownIn.X, pointRightDownIn.Y, 0, pointRightDownIn.X, pointRightDownIn.Y + rightCircleCenterFromBottom, 0);
            var pointTangentRightRight = sm.CreatePoint(pointRightDownIn.X, pointRightDownIn.Y + rightCircleCenterFromBottom, 0);
            rightCircle.Select(true);
            pointTangentRightRight.Select(true);
            doc.SketchAddConstraints("sgCOINCIDENT");
            doc.SketchAddConstraints("sgTANGENT");
            doc.ClearSelection();

            //a tangent right left line
            var tangentRightLeft = sm.CreateLine(pointRightTangentBottom.X, pointRightTangentBottom.Y, 0,
                pointRightTangentBottom.X + 0.005, pointRightTangentBottom.Y + 0.03, 0);
            var pointTangentRightLeft = sm.CreatePoint(pointRightTangentBottom.X + 0.005, pointRightTangentBottom.Y + 0.03, 0);
            rightCircle.Select(true);
             pointTangentRightLeft.Select(true);
            doc.SketchAddConstraints("sgCOINCIDENT");
            doc.SketchAddConstraints("sgTANGENT");

            doc.ClearSelection();
            rightCircle.Select(true);
            tangentRightLeft.Select(true);
            doc.SketchAddConstraints("sgTANGENT");
            doc.ClearSelection();

            //trim, redundant right circle part
            rightCircle.Select(true);
            sm.SketchTrim(0, pointRightCircle.X, pointRightCircle.Y - rightCircleRadius, 0);
            doc.ClearSelection();

            //left circles
            var leftBigCircle = sm.CreateCircleByRadius(pointLeftCircle.X, pointLeftCircle.Y, 0, leftBigSircleRadius);
            leftBigCircle.Select(true);
            doc.IAddDiameterDimension2(pointLeftCircle.X - leftLittleCircleRadius * 1, pointLeftCircle.Y - leftLittleCircleRadius * 2.5, 0);
            doc.ClearSelection();

            var leftLittleCircle = sm.CreateCircleByRadius(pointLeftCircle.X, pointLeftCircle.Y, 0, leftLittleCircleRadius);
            leftLittleCircle.Select(true);
            doc.IAddRadialDimension2(pointLeftCircle.X + leftLittleCircleRadius * 2.5, pointLeftCircle.Y + leftLittleCircleRadius * 2, 0);
            doc.ClearSelection();

            var lineHorizontalUpLittle = sm.CreateLine(pointLeftUpOut.X, pointLeftUpOut.Y, 0,
                pointLeftUpOut.X + dementionFromLeftEdgeToCircleCenter, pointLeftUpOut.Y, 0);
            var lineHorizontalUp = sm.CreateLine(pointLeftUpIn.X, pointLeftUpIn.Y, 0,
                pointRightUp.X, pointRightUp.Y, 0);
            var lineHorizontalInDown = sm.CreateLine(pointLeftDownIn.X, pointLeftDownIn.Y, 0,
                pointLeftDownIn.X + dementionFromLeftEdgeToCircleCenter + leftLittleCircleRadius, pointLeftDownIn.Y, 0);
            var lineHorizontalDown = sm.CreateLine(pointLeftDownOut.X, pointLeftDownOut.Y, 0,
                pointRightTangentBottom.X, pointRightTangentBottom.Y, 0);

            //trim, redundant left
            leftBigCircle.Select(true);
            sm.SketchTrim(0, pointLeftCircle.X + leftBigSircleRadius, pointLeftCircle.Y, 0);
            doc.ClearSelection();

            double verticalKatet = (leftOutsideDemention / 8) * 3;
            double horizontalKatet = Math.Sqrt(Math.Pow(leftBigSircleRadius, 2) - Math.Pow(verticalKatet, 2));
            leftBigCircle.Select(true);
            sm.SketchTrim(0, pointLeftDownOut.X + dementionFromLeftEdgeToCircleCenter - horizontalKatet, pointLeftCircle.Y - leftOutsideDemention * 3.0 / 8.0, 0);
            doc.ClearSelection();

            leftBigCircle.Select(true);
            sm.SketchTrim(0, pointLeftCircle.X - leftBigSircleRadius, pointLeftCircle.Y, 0);
            doc.ClearSelection();

            leftLittleCircle.Select(true);
            sm.SketchTrim(0, pointLeftCircle.X - leftLittleCircleRadius, pointLeftCircle.Y, 0);
            doc.ClearSelection();

            leftLittleCircle.Select(true);
            sm.SketchTrim(0, pointLeftCircle.X , pointLeftCircle.Y - leftLittleCircleRadius, 0);
            doc.ClearSelection();

            leftLittleCircle.Select(true);
            sm.SketchTrim(0, pointLeftCircle.X, pointLeftCircle.Y + leftLittleCircleRadius, 0);
            doc.ClearSelection();

            lineHorizontalUp.Select(true);
            sm.SketchTrim(0, pointLeftUpIn.X + dementionFromLeftEdgeToCircleCenter +  leftLittleCircleRadius, pointLeftUpIn.Y, 0);
            doc.ClearSelection();

            lineHorizontalInDown.Select(true);
            sm.SketchTrim(0, pointLeftDownIn.X + dementionFromLeftEdgeToCircleCenter + leftLittleCircleRadius, pointLeftDownIn.Y, 0);
            doc.ClearSelection();

            lineHorizontalDown.Select(true);
            sm.SketchTrim(0, pointLeftDownOut.X + dementionFromLeftEdgeToCircleCenter, pointLeftDownOut.Y, 0);
            doc.ClearSelection();

            lineHorizontalUpLittle.Select(true);
            sm.SketchTrim(0, pointLeftUpOut.X + dementionFromLeftEdgeToCircleCenter, pointLeftUpOut.Y, 0);
            doc.ClearSelection();

            leftBigCircle.Select(true);
            sm.SketchTrim(0, pointLeftUpOut.X + dementionFromLeftEdgeToCircleCenter - horizontalKatet, pointLeftUpOut.Y - leftOutsideDemention / 8, 0);
            doc.ClearSelection();


            //DASH LINES
            // left cercle
            sm.CreateCenterLine(pointLeftCircle.X - dementionFromLeftEdgeToCircleCenter, pointLeftCircle.Y, 0,
                pointLeftCircle.X + leftBigSircleRadius, pointLeftCircle.Y, 0);
            sm.CreateCenterLine(pointLeftCircle.X, pointLeftCircle.Y + leftBigSircleRadius * 1.1, 0,
                pointLeftCircle.X, pointLeftCircle.Y - leftBigSircleRadius * 1.1, 0);

            // right cercle
            sm.CreateCenterLine(pointRightCircle.X - rightCircleCenterFromRightEdge * 1.1, pointRightCircle.Y, 0,
                pointRightCircle.X + rightCircleCenterFromRightEdge * 1.1, pointRightCircle.Y, 0);
            sm.CreateCenterLine(pointRightCircle.X, pointRightCircle.Y + rightCircleCenterFromBottom * 1.1, 0,
                pointRightCircle.X, pointRightCircle.Y - rightCircleCenterFromBottom * 1.1, 0);
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void label9_Click(object sender, EventArgs e)
        {

        }
    }// 5 6 9 10
}
