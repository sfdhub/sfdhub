namespace OOP5
{
    public static class Operations
    {
        public static float GetLineLength(Point p1, Point p2)
        {
            return (float)Math.Sqrt(Math.Pow(p2.X - p1.X, 2) + Math.Pow(p2.Y - p1.Y, 2));
        }

        public static bool IsInclude(Shape? first, Shape? second)
        {
            bool flag = true;
            Point[] points = second.GetPoints();
            for (int i = 0; i < second.GetPointCount(); i++)
            {
                if (!first.IsPointInside(points[i]))
                {
                    flag = false;
                }
            }
            return flag;
        }

        public static bool IsLess(Shape? first, Shape? second)
        {
            return first.GetArea() < second.GetArea();
        }

        public static bool IsBigger(Shape? first, Shape? second)
        {
            return first.GetArea() > second.GetArea();
        }
    }
}
