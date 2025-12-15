using System;

delegate string MyDelegate(int i);

class MyClass
{
    // class member-field of the declared delegate type
    static MyDelegate dt;

    public static void Main()

    {
        Console.Write("\n Введите количество элементов массива:\t");

        int elementsCount = int.Parse(Console.ReadLine());

        int[] numbers = new int[elementsCount];

        for (int i = 0; i < elementsCount; i++)
        {
            Console.WriteLine($"\n Введите элементов массива под индексом {i}:\t ");

            numbers[i] = int.Parse(Console.ReadLine());
        }

        void Sum(params int[] numbers)
        {

            int result = 0;

            foreach (int n in numbers)
            {
                result += n;
            }
            Console.WriteLine(result);
        }
        int k;

        int n;

        if (elementsCount % 2 == 0)

        {
            Console.WriteLine("Вывод сумму первого и последнего, второго и предпоследнего и т.д. элементов массива.");

            int c;

            c = elementsCount / 2;

            for (int a = 0; a < c; a++)

            {
                int b;

                b = a + 1;

                //Sum((numbers[numbers.Length - b]), (numbers[a]));
                Console.WriteLine(numbers[a] + numbers[elementsCount - 1 - a]);
            }

        }

        else

        {
            k = elementsCount / 2;

            n = numbers[k];

            Console.WriteLine("Вывод центрального элемента массива.");

            Console.WriteLine(n);
        }

    }

}

