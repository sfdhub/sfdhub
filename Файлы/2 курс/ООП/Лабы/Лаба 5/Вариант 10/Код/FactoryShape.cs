namespace OOP5
{
    // Класс - фабрика производных от
    // Shape объектов
    class FactoryShape
    {
        public static Shape? CreateShape(char Ch)
        {
            Point[] p;
            switch (Ch)
            {
                case 'S':
                    Console.Write("Введите координаты центра и одну сторону X Y A: ");
                    string[] res = Console.ReadLine().Split(' ');
                    int x = Convert.ToInt32(res[0]), y = Convert.ToInt32(res[1]);
                    float a2 = Convert.ToSingle(res[2]) / 2;
                    return new Square(new Point(x - a2, y + a2), new Point(x + a2, y + a2), new Point(x + a2, y - a2), new Point(x - a2, y - a2));
                case 'H':
                    p = new Point[6] { new Point(), new Point(), new Point(), new Point(), new Point(), new Point() };
                    Console.WriteLine("Введите координаты вершин шестиугольника (6 точек): ");
                    for (int i = 0; i < 6; i++)
                    {
                        Console.Write("Введите координаты вершины " + (i + 1) + "X Y: ");
                        string[] s = Console.ReadLine().Split(' '); 
                        p[i].X = Convert.ToInt32(s[0]);
                        p[i].Y = Convert.ToInt32(s[1]);
                    }
                    return new Hexagon(p[0], p[1], p[2], p[3], p[4], p[5]);
                default:
                    return null;
            }
        }
    };
}
