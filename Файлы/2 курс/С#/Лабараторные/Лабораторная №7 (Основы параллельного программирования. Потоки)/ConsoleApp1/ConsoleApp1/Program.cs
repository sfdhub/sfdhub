using System;
using System.Threading;
namespace ConsoleThread
{
    // Класс для передачи параметров в поток 
    class SeriesParams
    {
        public int begin, end;
        public SeriesParams(int b, int e)
        {
            begin = b;
            end = e;
        }
    }
    class Program
    {
        public static int NumThread = 8; // Количество потоков
        public static double Sum = 0; // Итоговая сумма
        static void Main(string[] args)
        {
            Thread[] thr = new Thread[NumThread];
            var MaxIter = 1000000; // Общее количество итераций
            var step = MaxIter / NumThread; // Количество итераций в потоке
                                            // Запуск потоков
            for (int i = 0; i < NumThread; i++)
            {
                // Создание i-го потока
                thr[i] = new Thread(new ParameterizedThreadStart(CalcSeries));
                // Запуск потока и передача в него параметров
                thr[i].Start(new SeriesParams(i * step, (i == NumThread - 1) ? MaxIter : (i + 1) * step));
            }
            for (int i = 0; i < NumThread; i++) // Ожидание завершения потоков
                thr[i].Join();
            Console.WriteLine("Sum of series: {0}", Sum);
            Console.ReadKey();
        }
        // Вычисление суммы ряда для заданного диапазона итераций
        public static void CalcSeries(object param)
        {
            double sum = 0;

            if (param is SeriesParams)
            {
                for (double i = ((SeriesParams)param).begin; i < ((SeriesParams)param).end; i++)
                    sum += (1.0 / (1 + i * i * i));
                Sum += sum;
            }
        }
    }
}

