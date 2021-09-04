using System.Drawing;

namespace Project_Graf
{
    class MovePoint
    {

        public Point origin;
        public Point movePt;
        public int Current { get; set; }
        public MovePoint()
        {
            origin = new Point();
            movePt = new Point();
            Current = 0;
        }
    }

}
