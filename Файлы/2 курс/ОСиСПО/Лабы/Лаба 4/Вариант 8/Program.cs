/*
Процесс создает три нити, A, B и C. Нить A с интервалом 1 с
присваивает переменной x случайные значения. Нить B после каждого
изменения x делает паузу 0.5 с, после чего копирует значение x в
переменную y. Нить C выводит на экран значения x и y, затем делает
паузу случайной длительности от 2 до 3 с. Требуется организовать
процесс так, чтобы нить C всегда считывала равные значения x и y
*/

int x = 0;
int y = 0;
Random rand = new Random();

var waitHandler = new AutoResetEvent(false);
var printHandler = new AutoResetEvent(false);

var threadA = new Thread(new ThreadStart(A));
var threadB = new Thread(new ThreadStart(B));
var threadC = new Thread(new ThreadStart(C));

threadA.Start();
threadB.Start();
threadC.Start();

threadA.Join();
threadB.Join();
threadC.Join();


void A()
{
    while (true)
    {
        x = rand.Next(0, 100);
        waitHandler.Set();
        Thread.Sleep(100);
    }
}

void B()
{
    while (true)
    {
        waitHandler.WaitOne();
        Thread.Sleep(50);
        y = x;
        printHandler.Set();
    }
}

void C()
{
    while (true)
    {
        printHandler.WaitOne();

        Console.WriteLine("x = {0}, y = {1}", x, y);
        Thread.Sleep(rand.Next(200, 300));
        printHandler.Reset();
    }
}