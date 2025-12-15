// Lab5_A.cpp
#include "windows.h"
#include <io.h>
#include <Fcntl.h>
#include "iostream"

int main() {
	int errCode;
	char* strToSend, answer[250];
	BOOL procBRuns;
	HANDLE hReadPipe, hWritePipe, hMapping, hDataSentEvent, hAnswerEvent;
	FILE* readPipeFile;
	STARTUPINFO startInfo = { sizeof(startInfo) };
	PROCESS_INFORMATION procInfo;
	SECURITY_ATTRIBUTES pipeAttributes = { sizeof(SECURITY_ATTRIBUTES), NULL, TRUE };

	SetWindowText(GetForegroundWindow(), (LPCTSTR)"Process A");

	// Создание объекта "отображение файла" и представления strToSend
	hMapping = CreateFileMapping(INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0, 4096, (LPCTSTR)"Lab5_Mapping");
	strToSend = (char *)MapViewOfFile(hMapping, FILE_MAP_WRITE, 0, 0, 250);

	// Создание событий для синхронизации обмена с процессом B
	hDataSentEvent = CreateEvent(NULL, FALSE, FALSE, (LPCTSTR)"Lab5_SentEvent");
	hAnswerEvent = CreateEvent(NULL, FALSE, FALSE, (LPCTSTR)"Lab5_AnswEvent");

	// Создание безымянного канала
	CreatePipe(&hReadPipe, &hWritePipe, &pipeAttributes, 0);

	// Создание объекта языка C типа FILE для работы с каналом с помощью функцмй C
	readPipeFile = _fdopen((HFILE)_open_osfhandle((intptr_t)hReadPipe, _O_TEXT | _O_RDONLY), "rt");

    while (true) {
		int digits[5] = { 0,0,0,0,0 };
    	printf("%s", "Enter 5 digits with space:");
		scanf("%d %d %d %d %d", &digits[0], &digits[1], &digits[2], &digits[3], &digits[4]);

		// Переносим данные в строку для отправки
		sprintf(strToSend, "%d %d %d %d %d", digits[0], digits[1], digits[2], digits[3], digits[4]);

		// Извещение для B - данные в представлении strToSend готовы
		SetEvent(hDataSentEvent);

		WaitForSingleObject(hAnswerEvent, INFINITE);
		fprintf(stderr, "Received from A: %s\n", answer);
 
        // вывод в канал и сброс буфера
        puts(answer);
        fflush(stdout);
	

	}

	// Основной цикл посылки/приема данных
	do {
		// Прием строки из канала
		fgets(answer, 200, readPipeFile);
		// Функция fgets не удаляет символ перевода строки. Удалим его сами.
		answer[strlen(answer) - 1] = '\0';
		printf("Received from B: %s\n", answer);
		printf("===============================================\n\n");
	} while (strcmp(answer, ""));

	// Закрытие представления strToSend
	UnmapViewOfFile(strToSend);

	// Закрытие хэндла объекта
	CloseHandle(hMapping);
	return 0;
}
