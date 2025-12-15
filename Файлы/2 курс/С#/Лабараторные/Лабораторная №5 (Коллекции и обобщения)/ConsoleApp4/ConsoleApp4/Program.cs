int[] numbers = { 5, 4, 1, 3, 9, 8, 6, 7, 2, 0 };

int oddNumbers = numbers.Count(n => n % 2 == 1);
var firstNumbersLessThanSix = numbers.TakeWhile(n => n < 6);

Console.WriteLine($"There are {oddNumbers} odd numbers in {string.Join(" ", numbers)}");
Console.WriteLine(string.Join(" ", firstNumbersLessThanSix));