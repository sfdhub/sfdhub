using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Test
    {
        static void Main(string[] args)
        {
            int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 };

            int oddNumbers = numbers.Count(n => n % 2 == 1);
            var firstNumbersLessThanSix = numbers.TakeWhile(n => n < 6);

            Console.WriteLine($"There are {oddNumbers} odd numbers in {string.Join(" ", numbers)}");
            Console.WriteLine(string.Join(" ", firstNumbersLessThanSix));
        }
    }
}
