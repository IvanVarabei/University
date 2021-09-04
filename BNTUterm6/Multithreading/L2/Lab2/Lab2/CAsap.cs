using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Lab2
{
    class CAsap
    {
        public int countOperations = 0;
        public int countTypes = 0;
        public int[][] arrayTypes;
        public int[][] arrayH;
        public List<List<int>> List_chains = new List<List<int>>();
        private List<List<bool>> List_chains_ready_for_step = new List<List<bool>>();
        public List<List<int>> steps = new List<List<int>>();
        public List<List<int>> countOperationsForType = new List<List<int>>();
        public List<int> countProcessorsByTypes = new List<int>();
        public int maxproc = 0;

        public CAsap()
        {
            maxproc = 0;

        }

        public void Clear_Object()
        {
            countOperations = 0;
            countTypes = 0;
            arrayTypes = null;
            arrayH = null;
            List_chains.Clear();
            List_chains_ready_for_step.Clear();
            steps.Clear();
            countOperationsForType.Clear();
            countProcessorsByTypes.Clear();
            maxproc = 0;

        }


        private string Find_value(string s)
        {
            int index = 0;
            for (int i = 0; i < s.Length; i++)
            {
                if (s[i] == ':')
                {
                    index = i + 2;
                }
            }

            string value = "";
            s += '\0';
            while (s[index] != '\0')
            {
                value += s[index];
                index++;
            }

            return value;
        
        }

        private int[] GetArray(string s)
        {
            
            string[] nums = s.Split(' ');
            int[] arr = new int[nums.Length];
            for (int i = 0; i < nums.Length; i++)
            {
               arr[i] = int.Parse(nums[i]);
            }
                       
            return arr;
        }


        public void File_Load(string filestr)
        {
            // получение данных из файла

            StreamReader file = new StreamReader(filestr);
            string buff = "";
            buff = file.ReadLine();

            buff = Find_value(buff);            
            countOperations =  Convert.ToInt32(buff);
            
            buff = "";
            buff = file.ReadLine();
            buff = Find_value(buff);
            countTypes = Convert.ToInt32(buff);

            arrayTypes = new int[countTypes][];

            for (int i = 0; i < countTypes; i++)
            {
                buff = "";
                buff = file.ReadLine();
                buff = Find_value(buff);              
                arrayTypes[i] = GetArray(buff);
            }

            buff = "";
            buff = file.ReadLine();
            

            arrayH = new int[countOperations][];

            for (int i = 0; i < countOperations; i++)
            {
                buff = "";
                buff = file.ReadLine();
                buff = Find_value(buff);
                arrayH[i] = GetArray(buff);
            }

            file.Close();                
        }

        public void Planning()
        {
            GetChains();
            List_chains_ready_for_step = Create_clone_chains_ready();
            WriteSteps();
            CountTypesOnSteps();
            CountProcessorsEveryType();
            maxproc = Maxprocessors(countProcessorsByTypes);
           
        }

        private void CountProcessorsEveryType()
        {
            for (int i = 0; i < countTypes; i++)
            {
                int max = 0;

                for (int k = 0; k < countOperationsForType.Count; k++)
                {
                    if (max < countOperationsForType[k][i])
                    {
                        max = countOperationsForType[i][k];
                    }
                }

                countProcessorsByTypes.Add(max);                
            }
        }

        private int Maxprocessors(List<int> L)
        {
            int sum = 0;

            for (int i = 0; i < L.Count; i++)
            {
                sum += L[i];
            }

            return sum;
        }

        private void CountTypesOnSteps()
        {
            for (int i = 0; i < steps.Count; i++)
            {
                countOperationsForType.Add(new List<int>());
                
                // добавить в список количества операций по типам нули
                for (int k = 0; k < countTypes; k++)
                {
                    countOperationsForType[i].Add(0);

                    for (int t = 0; t < steps[i].Count; t++)
                    {
                        if (arrayTypes[k].Contains(steps[i][t]+1))
                        {
                            countOperationsForType[i][k]++;
                        }
                    }
                }
            }
        
        }

       
        private void WriteSteps()
        {
            // step one
           
            steps.Add(new List<int>());
            int index_step = 0;
            // добавление на первый шаг все операции на началах чепочек
            for (int i = 0; i < List_chains.Count; i++)
            {
                steps[index_step].Add(List_chains[i][0]);
            }

            
            bool exist_nonplanOperation = false;
            // 2 и более шаги
            while (true)
            {
                exist_nonplanOperation = false;
                // проверка на наличие нераспланированных шагов
                for (int i = 0; i < List_chains_ready_for_step.Count; i++)
                {
                    if (List_chains_ready_for_step[i].Contains(false))
                    {
                        exist_nonplanOperation = true;
                        break;
                    }
                }
                // если нераспланированных шагов не осталось, то выйти
                if (!exist_nonplanOperation)
                {
                    break;
                }

                // добавление нового шага
                steps.Add(new List<int>());
                index_step++;
                int index_false = 0;
                
                for (int i = 0; i < List_chains_ready_for_step.Count; i++)
                {
                    // поиск индекса в цепи, где значение = false
                    index_false = Find_index(List_chains_ready_for_step[i]);

                    // если есть значение индекса и предшественники операции по индексу
                    // уже распланированы
                    if (index_false != -1 && Check_predecessors(List_chains[i][index_false]))
                    {
                        // против дублирования обработки одной и той же операции
                        if (!steps[index_step].Contains(List_chains[i][index_false]))
                        {
                            steps[index_step].Add(List_chains[i][index_false]);
                        }
                        
                    }                   
                }

                // изменение на true всех операций, которые распределены на текущем шаге
                for (int i = 0; i < List_chains_ready_for_step.Count; i++)
                {
                   index_false = Find_index(List_chains_ready_for_step[i]);
                   if (index_false != -1)
                   {
                       List_chains_ready_for_step[i][index_false] = true;
                   }
                }
            }
        }

        private bool Check_predecessors(int operation)
        {
            //проверить всех предшественников, все ли они распранированы
            List<bool> predesessors = new List<bool>();
            bool check = false;
            for (int i = 0; i < List_chains.Count; i++)
            {
                int index = Find_index(List_chains[i], operation);
                index--;
                if (index != -2)
                {
                    predesessors.Add(List_chains_ready_for_step[i][index]);
                }
            }
            // проверить в списке на наличие хоть одного нераспланированного
            check = !predesessors.Contains(false);
            return check;
        }

        private int Find_index(List<bool> L)
        {
            int index = -1;
            for(int i = 0; i < L.Count; i++)
            {
                if (L[i] == false)
                {
                    index = i;
                    return index;
                }
            }

            return index;
        }

        private int Find_index(List<int> L, int operation)
        {
            int index = -1;
            for (int i = 0; i < L.Count; i++)
            {
                if (L[i] == operation)
                {
                    index = i;
                    return index;
                }
            }

            return index;
        }

        private List<List<bool>> Create_clone_chains_ready()
        {
            List<List<bool>> ready = new List<List<bool>>();
            for (int i = 0; i < List_chains.Count; i++)
            {
                ready.Add(new List<bool>());

                for (int k = 0; k < List_chains[i].Count; k++)
                {
                    if (k == 0)
                    {
                        ready[i].Add(true);
                    }
                    else
                    {
                        ready[i].Add(false);
                    }
                }
            }

            return ready;
        }
        private void GetChains()
        { 
            // построить цепи зависимостей
            List<int> List_use = new List<int>();
            
            List<int> Chain = new List<int>();
            int operation = 0;

            while (List_use.Count < countOperations)
            {
                operation = 0;
                while (List_use.Contains(operation))
                {
                    operation++;
                }
               
                Chain.Clear();
                Chain.Add(operation);
                List_use.Add(operation);
                while (true)
                {
                    // найти в строке таблицы смежности следующее направление
                    bool index = false;
                    for (int i = 0; i < arrayH[operation].Length; i++)
                    {
                        if (arrayH[operation][i] == 1)
                        {
                            index = true;
                            operation = i;
                            break;
                        }
                    }

                    if (index)
                    {
                        Chain.Add(operation);
                        if (!List_use.Contains(operation))
                        {
                            List_use.Add(operation);
                        }
                    }
                    else
                    {
                        break;
                    }
                }
                
                List_chains.Add(new List<int>(Chain));                
            }
            
        }

   
    
    }
}
