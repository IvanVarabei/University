using Library;

namespace SingleThread
{
   public  delegate void Tepmlate(string s);
    interface ISaver
    {
        void SaveAsync(Pendulum pend);
        
        event Tepmlate Done ;
    }
}
