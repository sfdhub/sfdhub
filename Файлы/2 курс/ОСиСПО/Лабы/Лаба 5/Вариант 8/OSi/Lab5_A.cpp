// Lab5_A.cpp
#include "windows.h"
#include <stdlib.h>
#include <stdio.h>
#include <locale.h>
#include <io.h>
#include <Fcntl.h>

#pragma warning(disable: 4996)

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

	// Создание процесса-потомка B с перенаправленным выводом
	startInfo.lpTitle = (LPWSTR)"Process B";
	startInfo.dwFlags = STARTF_USESTDHANDLES;
	startInfo.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
	startInfo.hStdOutput = hWritePipe;
	startInfo.hStdError = GetStdHandle(STD_ERROR_HANDLE);
	procBRuns = CreateProcess(L"D:\\Lab45\\Lab5\\X64\\Debug\\Lab5_B.exe", NULL, NULL, NULL, TRUE,
		CREATE_NEW_CONSOLE, NULL, NULL, &startInfo, &procInfo);
	// Закрытие ненужного хэндла вывода в канал
	CloseHandle(hWritePipe);

	// Обработка ошибки создания процесса B
	if (!procBRuns) {
		errCode = 1;
		printf("%s", "Can't start process B\n");
		getchar();
		return 1;
	}

	// Ожидание готовности канала к работе от процесса B и прием начального "мусора" из канала
	WaitForSingleObject(hAnswerEvent, INFINITE);
	fgets(answer, 200, readPipeFile);

	// Основной цикл посылки/приема данных
	do {
		printf("%s", "Input a string: ");
		//		gets(strToSend);
		gets_s(strToSend, 100);
		if (strcmp(strToSend, ""))
			strcat(strToSend, " : Process A");

		// Извещение для B - данные в представлении strToSend готовы
		SetEvent(hDataSentEvent);

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
