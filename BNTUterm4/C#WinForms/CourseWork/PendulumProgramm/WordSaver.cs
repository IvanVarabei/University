using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Drawing;
using Xceed.Words.NET;
using Xceed.Document.NET;
using Library;

namespace SingleThread
{
    class WordSaver : ISaver
    {
        public event Tepmlate Done = (string s) => { };
        private string Result = "The WORD document has been created and filled!\n";
        public async void SaveAsync(Pendulum pend)
        {
            await Task.Run(() =>
            {
                try
                {
                    string pathDocument = AppDomain.CurrentDomain.BaseDirectory + "PendulumData.docx";
                    DocX document = DocX.Create(pathDocument);
                    document.InsertParagraph("Pendulum report").
                                 Font("Calibri").
                                 FontSize(36).
                                 Color(Color.Navy).
                                 Bold().
                                 Spacing(15).
                                 Alignment = Alignment.center;
                    Paragraph paragraph = document.InsertParagraph();

                    paragraph.Alignment = Alignment.left;

                    paragraph.AppendLine("The pendulum has swayed one period!").
                                 FontSize(20).
                                 Italic().
                                 UnderlineStyle(UnderlineStyle.dotted).
                                 UnderlineColor(Color.DarkOrange).
                                 Highlight(Highlight.yellow);
                    paragraph.AppendLine();
                    paragraph.AppendLine("Length :" + pend.Length + "\nT :" + pend.T + "\nAmpl :" + pend.A +
                            "\nG :" + pend.Acceleration + "\nMax a :" + pend.MaxAlpha);
                    document.InsertChart(CreateLineChart(pend));
                    document.Save();
                }
                catch
                {
                    Result = "Unpredictable error has occured while writing.\nYou may try again.\n";
                }
            });
            Done(Result);
        }

        private static Chart CreateLineChart(Pendulum pend)
        {
            LineChart lineChart = new LineChart();
            lineChart.AddLegend(ChartLegendPosition.Bottom, false);
            lineChart.AddSeries(TestData.GetSeriesFirst(pend));
            lineChart.AddSeries(TestData.GetSeriesSecond(pend));
            return lineChart;
        }

        private class TestData
        {
            public string name { get; set; }
            public double value { get; set; }

            private static List<TestData> GetTestDataFirst(Pendulum pend)
            {
                List<TestData> testDataFirst = new List<TestData>();
                for (int i = 0; i < pend.Info.Moments.Count; i++)
                {
                    testDataFirst.Add(new TestData()
                    {
                        name = "" +
                        pend.Info.Moments.ElementAt(i).Time,
                        value = pend.Info.Moments.ElementAt(i).X
                    });
                }
                return testDataFirst;
            }

            private static List<TestData> GetTestDataSecond(Pendulum pend)
            {
                List<TestData> testDataSecond = new List<TestData>();
                for (int i = 0; i < pend.Info.Moments.Count; i++)
                {
                    testDataSecond.Add(new TestData()
                    {
                        name = "" +
                        pend.Info.Moments.ElementAt(i).Time,
                        value = Math.Asin(pend.Info.Moments.ElementAt(i).X / (2 * pend.Length)) * 2
                    });
                }
                return testDataSecond;
            }

            public static Series GetSeriesFirst(Pendulum pend)
            {
                Series seriesFirst = new Series("Amplitude");
                seriesFirst.Bind(TestData.GetTestDataFirst(pend), "name", "value");
                return seriesFirst;
            }

            public static Series GetSeriesSecond(Pendulum pend)
            {
                Series seriesSecond = new Series("Angle");
                seriesSecond.Bind(TestData.GetTestDataSecond(pend), "name", "value");
                return seriesSecond;
            }
        }
    }

}
