namespace OOP5
{
    class Square : Shape
    {
        public Square(Point p1, Point p2, Point p3, Point p4)
        {
            pointCount = 4;
            points = new Point[pointCount];
            points[0] = p1;
            points[1] = p2;
            points[2] = p3;
            points[3] = p4;
            ID = "Square";
        }

        public override bool IsPointInside(Point point)
        {
            // алгоритм лучей
            int i,
                j,
                nvert = pointCount;
            bool c = false;
            for (i = 0, j = nvert - 1; i < nvert; j = i++)
            {
                if (
                    ((points[i].Y >= point.Y) != (points[j].Y >= point.Y))
                    && (
                        point.X
                        <= (points[j].X - points[i].X)
                            * (point.Y - points[i].Y)
                            / (points[j].Y - points[i].Y)
                            + points[i].X
                    )
                )
                    c = !c;
            }
            return c;
            
        }

        public override float GetArea()
        {
            return (float)Math.Pow(Operations.GetLineLength(points[0], points[1]), 2);
        }
    }

    class Hexagon : Shape
    {
        public Hexagon(Point p1, Point p2, Point p3, Point p4, Point p5, Point p6)
        {
            pointCount = 6;
            points = new Point[pointCount];
            points[0] = p1;
            points[1] = p2;
            points[2] = p3;
            points[3] = p4;
            points[4] = p5;
            points[5] = p6;
            ID = "Hexagon";
        }

        public override bool IsPointInside(Point point)
        {
            // алгоритм лучей
            int i,
                j,
                nvert = pointCount;
            bool c = false;
            for (i = 0, j = nvert - 1; i < nvert; j = i++)
            {
                if (
                    ((points[i].Y >= point.Y) != (points[j].Y >= point.Y))
                    && (
                        point.X
                        <= (points[j].X - points[i].X)
                            * (point.Y - points[i].Y)
                            / (points[j].Y - points[i].Y)
                            + points[i].X
                    )
                )
                    c = !c;
            }
            return c;
        }

        public override float GetArea()
        {
            return 3
                * (float)Math.Sqrt(3)
                * (float)Math.Pow(Operations.GetLineLength(points[0], points[1]), 2)
                / 2;
        }
    }
}
