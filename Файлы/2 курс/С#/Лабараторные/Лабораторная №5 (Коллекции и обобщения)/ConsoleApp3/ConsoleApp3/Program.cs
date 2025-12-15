using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab5
{
    class Program
    {
        static void Main(string[] args)
        {
            var hashTable = new HashTable<int>(100);
            hashTable.Add(5);
            hashTable.Add(18);
            hashTable.Add(777);

            Console.WriteLine(hashTable.Search(6));
            Console.WriteLine(hashTable.Search(18));
            Console.WriteLine(hashTable.Search(777));
            Console.ReadLine();
        }
    }
}

