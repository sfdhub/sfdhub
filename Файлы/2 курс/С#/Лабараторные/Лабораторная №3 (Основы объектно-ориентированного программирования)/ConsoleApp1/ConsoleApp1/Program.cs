using System.Text.RegularExpressions;
class MyClasss
{

    public static void Main()
    {
        Console.Write("\n Введите текст:\t");

        string words = Console.ReadLine();       
        {
            
            string[] textMass = words.Split(' ');

            Console.Write("\n Количество удаленных пробелов:\t");
            Console.WriteLine(textMass.Length - 1);
            
            string none = "( )";

            int n = textMass.Length - 1;
            for (int i = 4; i <= n; i++)
            {
                int temp = 0;
                int c = 4;
                if (c <= n)
                {
                    temp++;
                    Console.Write("\n Количество табуляций: \t");
                    Console.WriteLine(temp);
                }
                else
                {
                    
                    Console.Write("\n Количество табуляций: \t");
                    Console.WriteLine(temp);
                }
            }
            
            string result = Regex.Replace(words, none, "");
            Console.Write("\n Изменённый текст: \t");
            Console.WriteLine(result);

            Console.WriteLine();        
        }

    }   
}



