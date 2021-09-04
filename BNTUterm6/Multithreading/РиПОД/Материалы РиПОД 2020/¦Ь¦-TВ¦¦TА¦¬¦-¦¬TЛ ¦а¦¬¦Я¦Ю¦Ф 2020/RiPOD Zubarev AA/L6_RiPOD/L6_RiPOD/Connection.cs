namespace L6_RiPOD
{
    struct Connection
    {
        public string BeginTaskName { get; set; }
        public string TaskName { get; set; }
        public int TimeConnection { get; set; }

        public static bool operator ==(Connection con1, Connection con2)
        {
            if (con1.BeginTaskName == con2.BeginTaskName &&
                con1.TaskName == con2.TaskName &&
                con1.TimeConnection == con2.TimeConnection)
                return true;
            return false;
        }

        public static bool operator !=(Connection con1, Connection con2)
        {
            if (con1.BeginTaskName == con2.BeginTaskName &&
                con1.TaskName == con2.TaskName &&
                con1.TimeConnection == con2.TimeConnection)
                return false;
            return true;
        }
    }
    
}
