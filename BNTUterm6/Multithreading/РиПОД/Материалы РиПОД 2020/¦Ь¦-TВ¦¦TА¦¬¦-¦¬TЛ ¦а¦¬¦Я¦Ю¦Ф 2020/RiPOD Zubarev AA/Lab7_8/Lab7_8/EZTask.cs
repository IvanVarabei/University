using System.Collections.Generic;

namespace Lab7_8
{
    struct EZTask
    {
        public string Name { get; set; }
        public int TimeCalculation { get; set; }
        public int StartTime { get; set; }
        public int EndTime { get; set; }

        public List<Connection> Connections;
    }
}
