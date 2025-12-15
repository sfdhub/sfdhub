// Институт компьютерных технологий и информационной безопасности
// Кафедра МОП ЭВМ
// Дисциплина: Объектно-ориентированное программирование
// Лабараторная работа №3
// Вариант №10
// Исполнитель: Карманов Сергей Сергеевич
// 29.11.2023

using OOP5;

Shape? shape1 = null;
Shape? shape2 = null;

while (true)
{
    try
    {
        Console.Write("1. Создать фигуру\n" +
                          "2. Вывести фигуры\n" +
                          "3. Удалить фигуру\n" +
                          "4. Переместить фигуру\n" +
                          "5. Повернуть фигуру\n" +
                          "6. Сравнить фигуры\n" +
                          "7. Включает ли фигура\n" +
                          "8. Поменять фигуры местами\n" +
                          "9. Выход\n" +
                          "Выберите действие:");
        int choice = Convert.ToInt32(Console.ReadLine());
        switch (choice)
        {
            case 1:
            {
                Console.Write("Выберите тип фигуры (S - Square | H - Hexagon):");
                char type = Console.ReadLine()![0];
                Shape? s1 = FactoryShape.CreateShape(type);
                if (s1 == null)
                {
                    Console.WriteLine("Не удалось сформировать фигуру");
                    break;
                }

                Console.Write("Выберите ячейку для сохранения фигуры (1 или 2):");
                choice = Convert.ToInt32(Console.ReadLine());
                if (choice == 1)
                {
                    if (shape1 != null)
                        shape1 = null;
                    shape1 = s1;
                }
                else if (choice == 2)
                {
                    if (shape2 != null)
                        shape2 = null;
                    shape2 = s1;
                }
                else
                {
                    Console.WriteLine("Неверный ввод");
                    break;
                }

                Console.WriteLine("Фигура создана");
                break;
            }
            case 2:
            {
                if (shape1 == null && shape2 == null)
                {
                    Console.WriteLine("Фигур нет");
                    break;
                }

                for (int i = 0; i < 2; i++)
                {
                    Shape shape = i == 0 ? shape1 : shape2;
                    if (shape == null)
                        continue;
                    Console.WriteLine("Фигура " + (i + 1) + " (" + shape.ID + "):");
                    Console.WriteLine("Координаты вершин:");
                    Point[] points = shape.GetPoints();
                    for (int j = 0; j < shape.GetPointCount(); j++)
                    {
                        Console.WriteLine("x:" + points[j].X + " y:" + points[j].Y);
                    }

                    Console.WriteLine("Площадь: " + shape.GetArea());
                    points = null;
                }

                break;
            }
            case 3:
                Console.WriteLine("Введите номер фигуры для удаления (1 или 2):");
                choice = Convert.ToInt32(Console.ReadLine());
                if (choice == 1)
                {
                    if (shape1 != null)
                        shape1 = null;
                }
                else if (choice == 2)
                {
                    if (shape2 != null)
                        shape2 = null;
                }
                else
                {
                    Console.WriteLine("Неверный ввод");
                    break;
                }

                break;
            case 4:
            {
                Console.WriteLine("Введите номер фигуры для перемещения (1 или 2):");
                choice = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Введите дельту перемещения (два числа через пробел <x y>):");
                Point delta = new Point();
                string[] input = Console.ReadLine().Split(' ');
                delta.X = Convert.ToInt32(input[0]);
                delta.Y = Convert.ToInt32(input[1]);
                if (choice == 1 && shape1 != null)
                    shape1.Move(delta);
                else if (choice == 2 && shape2 != null)
                    shape2.Move(delta);
                else
                    Console.WriteLine("Неверный ввод");
                break;
            }
            case 5:
                Console.WriteLine("Введите номер фигуры для вращения (1 или 2):");
                choice = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Введите угол вращения:");
                float angle = Convert.ToSingle(Console.ReadLine());
                if (choice == 1 && shape1 != null)
                    shape1.Rotate(angle);
                else if (choice == 2 && shape2 != null)
                    shape2.Rotate(angle);
                else
                    Console.WriteLine("Неверный ввод");

                break;
            case 6:
                if (shape1 == null || shape2 == null)
                {
                    Console.WriteLine("Фигуры ещё не сформированы");
                    break;
                }

                if (Operations.IsBigger(shape1, shape2))
                    Console.WriteLine("Первая фигура больше по площади");
                else if (Operations.IsLess(shape1, shape2))
                    Console.WriteLine("Первая фигура меньше по площади");
                else
                    Console.WriteLine("Фигуры равны по площади");
                break;
            case 7:
                if (shape1 == null || shape2 == null)
                {
                    Console.WriteLine("Фигуры ещё не сформированы");
                    break;
                }

                if (Operations.IsInclude(shape1, shape2))
                    Console.WriteLine("Первая фигура включает вторую");
                else if (Operations.IsInclude(shape2, shape1))
                    Console.WriteLine("Вторая фигура включает первую");
                else
                    Console.WriteLine("Не включает");
                break;
            case 8:
                Shape tmp_shape = shape1;
                shape1 = shape2;
                shape2 = tmp_shape;
                Console.WriteLine("Фигуры поменялись местами");
                break;
            case 9:
                return 0;
            default:
                Console.WriteLine("Неверный ввод");
                break;
        }
    }
    catch (Exception e)
    {
        Console.WriteLine("Неверный ввод" + e.Message);
    }
}