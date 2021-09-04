using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Drawing;

namespace Project_Graf
{
    class DataGridViewManager
    {
        public void Fill(int size, DataGridView datagrid)
        {
            datagrid.RowCount = size;
            datagrid.ColumnCount = size;
            datagrid.RowHeadersWidth = 60;

            for (int i = 0; i < size; i++)
            {
                datagrid.Columns[i].HeaderText = (i + 1).ToString();
                datagrid.Rows[i].HeaderCell.Value = (i + 1).ToString();
                datagrid.Columns[i].Width = 30;
                for (int j = 0; j < size; j++)
                {
                    if( i == j)
                    {
                        datagrid[i, j].Style.BackColor = Color.Blue;
                    }
                    datagrid[i, j].Value = 0;
                }
            }
        }
        public void FillType(int size,DataGridView datagrid)
        {
            datagrid.ColumnCount = 1;
            datagrid.RowCount = size;
            for (int i = 0; i < size; i++)
            {
                datagrid.Rows[i].HeaderCell.Value = (i + 1).ToString();
                
                datagrid[0,i].Value = 1;
            }
        }
        public int [][] GetStringMassGridGraf(DataGridView datagrid)
        {
            int size = datagrid.RowCount;
            int[][] mass = new int[size][];
            

            for(int i = 0; i < size; i++)
            {
                mass[i] = new int[size];
                for(int j = 0; j < size; j++)
                {
                    mass[i][j] = Convert.ToInt32(datagrid[j, i].Value);
                }
            }
            return mass;
        }
        public int[] GetStringMassGridType(DataGridView datagrid)
        {
            int size = datagrid.RowCount;
            int[] mass = new int[size];


            for (int i = 0; i < size; i++)
            {
                mass[i] = Convert.ToInt32(datagrid[0, i].Value);
            }
            return mass;
        }
    }
}
