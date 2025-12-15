namespace OOP5;

public abstract class Shape
{
    protected Point[] points;
    protected int pointCount = 0;
    public string ID { get; set; } = "";

    public Point[] GetPoints() { return points; }
    public int GetPointCount() { return pointCount; }
    public void Move(Point delta)
    {
        for (int i = 0; i < pointCount; i++)
        {
            points[i].X += delta.X;
            points[i].Y += delta.Y;
        }
    }

    public void Rotate(float angle)
    {
        Point center = GetCenterOfMass();
        for (int i = 0; i < pointCount; i++)
        {
            points[i].X = (float)(Math.Cos(angle) * (points[i].X - center.X) - Math.Sin(angle) * (points[i].Y - center.Y) + center.X);
            points[i].Y = (float)(Math.Sin(angle) * (points[i].X - center.X) + Math.Cos(angle) * (points[i].Y - center.Y) + center.Y);
        }
    }

    public Point GetCenterOfMass()
    {
        Point p = new Point();
        for (int i = 0; i < pointCount; i++)
        {
            p.X += points[i].X;
            p.Y += points[i].Y;
        }
        p.X = p.X / pointCount;
        p.Y = p.Y / pointCount;
        return p;
    }
    
    public abstract float GetArea();
    public abstract bool IsPointInside(Point p);
}