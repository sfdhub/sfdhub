// Lab5_B.cpp
#include "windows.h"
#include <stdlib.h>
#include <stdio.h>
#include <locale.h>
#include <tchar.h>

#pragma warning(disable: 4996)

int main() {
	char* strReceived;
	HANDLE hMapping, hReceivedEvent, hAnswerEvent;
	setlocale(LC_ALL, "Rus");

	// Открытие объекта "отображение файла" и создание представления strReceived
	hMapping = OpenFileMapping(FILE_MAP_WRITE, FALSE, (LPCWSTR)"Lab5_Mapping");
	strReceived = (char*)MapViewOfFile(hMapping, FILE_MAP_WRITE, 0, 0, 250);

	// Открытие событий для синхронизации обмена с процессом A
	hReceivedEvent = OpenEvent(EVENT_ALL_ACCESS, FALSE, (LPCWSTR)"Lab5_SentEvent");
	hAnswerEvent = OpenEvent(EVENT_ALL_ACCESS, FALSE, (LPCWSTR)"Lab5_AnswEvent");

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
			strcat(strReceived, " : Process B");
		}
		// вывод в канал и сброс буфера
		puts(strReceived);
		fflush(stdout);
	} while (strcmp(strReceived, ""));

	// Закрытие представления strReceived
	UnmapViewOfFile(strReceived);

	// Закрытие хэндла объекта
	CloseHandle(hMapping);
	return 0;
}

