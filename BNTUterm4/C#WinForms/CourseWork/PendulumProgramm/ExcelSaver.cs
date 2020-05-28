using System;
using System.Linq;
using System.Threading.Tasks;
using Excel = Microsoft.Office.Interop.Excel;
using Library;

namespace SingleThread
{
    public class ExcelSaver : ISaver
    {
        private string Result = "The EXCEL document has been created and filled!\n";
        private Excel.Range excelcells;
        public event Tepmlate Done = (s) => { };
        public async void SaveAsync(Pendulum pend)
        {

            await Task.Run(() =>
            {
                try
                {
                    string path = System.IO.Directory.GetCurrentDirectory() + @"\" + "Save.xlsx";
                    Excel.Application excelapp = new Excel.Application();
                    Excel.Workbook workbook = excelapp.Workbooks.Add();
                    Excel.Worksheet worksheet = workbook.ActiveSheet;
                    int j = 0;
                    worksheet.Rows[1].Columns[5] = "Length :";
                    worksheet.Rows[1].Columns[6] = pend.Length;

                    worksheet.Rows[2].Columns[5] = "T :";
                    worksheet.Rows[2].Columns[6] = pend.T;

                    worksheet.Rows[3].Columns[5] = "Ampl :";
                    worksheet.Rows[3].Columns[6] = pend.A;

                    worksheet.Rows[4].Columns[5] = "G :";
                    worksheet.Rows[4].Columns[6] = pend.Acceleration;

                    worksheet.Rows[5].Columns[5] = "Max a :";
                    worksheet.Rows[5].Columns[6] = pend.MaxAlpha;

                    worksheet.Rows[1].Columns[1] = "Phase";
                    worksheet.Rows[1].Columns[2] = "X";
                    worksheet.Rows[1].Columns[3] = "Time";
                    for (int i = 2; i <= pend.Info.Moments.Count; i++)
                    {
                        worksheet.Rows[i].Columns[1] = pend.Info.Moments.ElementAt(i - 1).Phase;
                        worksheet.Rows[i].Columns[2] = pend.Info.Moments.ElementAt(i - 1).X;
                        worksheet.Rows[i].Columns[3] = pend.Info.Moments.ElementAt(i - 1).Time;
                        j = i;
                    }

                    excelcells = worksheet.get_Range("A1", "C" + j);
                        //Устанавливаем цвет обводки
                        excelcells.Borders.ColorIndex = 3;
                        //Устанавливаем стиль и толщину линии
                        excelcells.Borders.LineStyle = Excel.XlLineStyle.xlContinuous;
                    excelcells.Borders.Weight = Excel.XlBorderWeight.xlThick;

                    string s = "B" + (j);
                    excelcells = worksheet.get_Range("B2", s);
                    excelcells.Select();
                    Excel.Chart excelchart = (Excel.Chart)excelapp.Charts.Add(Type.Missing,
                         Type.Missing, Type.Missing, Type.Missing);
                    excelchart.Activate();
                    excelchart.Select(Type.Missing);
                    excelapp.ActiveChart.ChartType = Excel.XlChartType.xlConeCol;
                    excelapp.ActiveChart.HasTitle = true;
                    excelapp.ActiveChart.ChartTitle.Text
                           = "The first period of pendulum";
                        //Меняем шрифт, можно поменять и другие параметры шрифта
                        excelapp.ActiveChart.ChartTitle.Font.Size = 14;
                    excelapp.ActiveChart.ChartTitle.Font.Color = 156;
                        //Обрамление для надписи c тенями
                        excelapp.ActiveChart.ChartTitle.Shadow = true;
                    excelapp.ActiveChart.ChartTitle.Border.LineStyle = Excel.Constants.xlSolid;

                    excelapp.ActiveChart.HasLegend = true;
                        //Расположение легенды
                        excelapp.ActiveChart.Legend.Position
                               = Excel.XlLegendPosition.xlLegendPositionLeft;

                    ((Excel.LegendEntry)excelapp.ActiveChart.Legend.LegendEntries(1)).Font.Size = 12;

                    Excel.SeriesCollection seriesCollection =
                         (Excel.SeriesCollection)excelapp.ActiveChart.SeriesCollection(Type.Missing);
                    Excel.Series series = seriesCollection.Item(1);
                    series.Name = "Amplitude";

                    excelapp.ActiveChart.Location(Excel.XlChartLocation.xlLocationAsObject, "Лист1");
                    worksheet.Shapes.Item(1).IncrementLeft(-201);
                    worksheet.Shapes.Item(1).IncrementTop(1);

                    worksheet.Shapes.Item(1).Height = 800;
                    worksheet.Shapes.Item(1).Width = 800;

                    excelapp.AlertBeforeOverwriting = false;
                    workbook.SaveAs(path);
                    excelapp.Quit();
                }
                catch
                {
                    Result = "Unpredictable error has occured while writing.\nYou may try again.\n";
                }
            });
            Done(Result);
        }
    }
}
