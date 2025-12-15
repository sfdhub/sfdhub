// Lab5_B.cpp
#include "windows.h"
#include <string>
#include <tchar.h>
#include <algorithm>

int main() {
    char* strReceived;
    HANDLE hMapping, hReceivedEvent, hAnswerEvent;

    // Открытие объекта "отображение файла" и создание представления strReceived
    hMapping = OpenFileMapping(FILE_MAP_WRITE, FALSE, reinterpret_cast<LPCSTR>((LPCWSTR) "Lab5_Mapping"));
    strReceived = (char*)MapViewOfFile(hMapping, FILE_MAP_WRITE, 0, 0, 250);

    // Открытие событий для синхронизации обмена с процессом A
    hReceivedEvent = OpenEvent(EVENT_ALL_ACCESS, FALSE, reinterpret_cast<LPCSTR>((LPCWSTR) "Lab5_SentEvent"));
    hAnswerEvent = OpenEvent(EVENT_ALL_ACCESS, FALSE, reinterpret_cast<LPCSTR>((LPCWSTR) "Lab5_AnswEvent"));

    // Начальная очистка "мусора" в канале и сброс буфера
    puts("");
    fflush(stdout);
    // Извещение для процесса A: прими мусор
    SetEvent(hAnswerEvent);

    // Основной цикл приема/посылки данных
    do {
        // Ожидание готовности данных в представлении strReceived
        WaitForSingleObject(hReceivedEvent, INFINITE);

        // Вывод на stderr, потому что stdout перенаправлен в канал
        fprintf(stderr, "Received from A: %s\n", strReceived);
        if (strcmp(strReceived, "")) {
            // реверс строки
            std::string str(strReceived);
            std::reverse(str.begin(), str.end());
            strcpy(strReceived, str.c_str());
        }
        // вывод в канал и сброс буфера
        puts(strReceived);
        fflush(stdout);

        // Проверка на выход
        int cliAnswer = 0;
        printf("Enter 1 to continue or 0 to exit: ");
        scanf("%d", &cliAnswer);
        if (cliAnswer != 1) {
            // отправка данных обратно
            char* strToSend = "SFDSDSKDSOKDOSKD";

            // Копирование строки в общую память
            strcpy(strReceived, strToSend);
            SetEvent(hAnswerEvent);

            // Закрытие представления strReceived
            UnmapViewOfFile(strReceived);

            // Закрытие хэндла объекта
            CloseHandle(hMapping);

            return 0;
        }

    } while (strcmp(strReceived, ""));
    
    return 0;
}