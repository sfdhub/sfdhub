#include <Windows.h>
#include <iostream>
#include <random>
#include <thread>

const short TIME_MULTIPLIER = 10;

int x = 0;
int y = 0;
std::random_device rd;
std::mt19937 gen(rd());
std::uniform_int_distribution<> dis(0, 100);

HANDLE waitHandler = CreateEvent(NULL, FALSE, FALSE, NULL);
HANDLE printHandler = CreateEvent(NULL, FALSE, FALSE, NULL);

DWORD WINAPI A(LPVOID lpParam)
{
    while (true)
    {
        x = dis(gen);
        SetEvent(waitHandler);
        Sleep(10 * TIME_MULTIPLIER);
    }
}

DWORD WINAPI B(LPVOID lpParam)
{
    while (true)
    {
        WaitForSingleObject(waitHandler, INFINITE);
        Sleep(5 * TIME_MULTIPLIER);
        y = x;
        SetEvent(printHandler);
    }
}

DWORD WINAPI C(LPVOID lpParam)
{
    while (true)
    {
        WaitForSingleObject(printHandler, INFINITE);
        std::cout << x << " == " << y << std::endl;

        Sleep(dis(gen) * TIME_MULTIPLIER);
        ResetEvent(printHandler);
    }
}

int main()
{
    HANDLE threads[3];
    threads[0] = CreateThread(NULL, 0, A, NULL, 0, NULL);
    threads[1] = CreateThread(NULL, 0, B, NULL, 0, NULL);
    threads[2] = CreateThread(NULL, 0, C, NULL, 0, NULL);

    WaitForMultipleObjects(3, threads, TRUE, INFINITE);

    CloseHandle(waitHandler);
    CloseHandle(printHandler);

    return 0;
}
