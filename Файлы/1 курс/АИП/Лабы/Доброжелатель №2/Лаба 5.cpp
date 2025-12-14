#pragma warning (disable : 4996)
#include <iostream>
#include <stdio.h>
#include <stdlib.h>


int main()
{
	system("chcp 1251");
	FILE* file;
	int len, answer, field, len_s, count, points;
	int start, finish, min_el, max_el;
	struct football_team {
		char team_name[20];
		char city[20];
		char surname[20];
		int played_games;
		int win;
		int lose;
		int draw;
		int players;
		int points = 3 * win + draw;
	};
	football_team* a;
	football_team one;
	char buf[256];
	char ch;
	char str_playedgames[3], str_players[3], str_points[3];
	char* ptr_buf;

	file = fopen("File.txt", "at");
	if (file == NULL)
		return 1;
	//добавление новых записей
	do {
		printf("Добавить структуру в массив?\nДа-1.\nНет-остальное.\n> ");
		scanf_s("%d%c", &answer, &ch, 1);
		if (answer == 1)
		{//если пользователь хочет добавить запись, то ввод данных
			printf("Введите название команды: ");
			gets_s(one.team_name);
			printf("Введите город команды: ");
			gets_s(one.city);
			printf("Введите количество игр: ");
			scanf_s("%d", &one.played_games);
			sprintf(str_playedgames, "%d", one.played_games);
			printf("Введите количество побед: ");
			scanf_s("%d", &one.win);
			printf("Введите количество проигрешей: ");
			scanf_s("%d", &one.lose);
			printf("Введите количество ничиьих: ");
			scanf_s("%d", &one.draw);
			int points = 3 * one.win + one.draw;
			sprintf(str_points, "%d", points);
			printf("Введите количество игроков: ");
			scanf_s("%d", &one.players);
			sprintf(str_players, "%d", one.players);
			printf("Введите фамилию тренера: ");
			std::cin.ignore();
			gets_s(one.surname);/////Почему то если один gets c вводом фамилии он не работает(вроде это из-за того что после scanf_s отсется пустой символ в новой строке)

			//формирование строки для записи
			strcpy(buf, one.team_name);
			strcat(buf, " ");
			strcat(buf, one.city);
			strcat(buf, " ");
			strcat(buf, str_playedgames);
			strcat(buf, " ");
			strcat(buf, str_points);
			strcat(buf, " ");
			strcat(buf, str_players);
			strcat(buf, " ");
			strcat(buf, one.surname);
			strcat(buf, "\n");
			fputs(buf, file);
		}
	} while (answer == 1);
	fclose(file);

	file = fopen("File.txt", "rt");
	if (file == NULL)
		return 2;
	count = 0;
	fseek(file, 0, SEEK_END);
	len = ftell(file);
	fseek(file, 0, SEEK_SET);
	while (ftell(file) < len)
	{//подсчёт количества записей в файле
		fgets(buf, 255, file);
		count++;
	}
	len_s = sizeof(football_team);
	a = (football_team*)calloc(count, len_s);
	if (a == NULL)
	{
		fclose(file);
		return 3;
	}
	fseek(file, 0, SEEK_SET);
	for (int i = 0; i < count; i++)
	{//считывание данных в массив
		fgets(buf, 255, file);
		ptr_buf = buf;
		ptr_buf = strtok(buf, " ");
		strcpy(a[i].team_name, ptr_buf);
		ptr_buf = strtok(NULL, " ");
		strcpy(a[i].city, ptr_buf);
		ptr_buf = strtok(NULL, " ");
		sscanf(ptr_buf, "%d",  &a[i].played_games);
		ptr_buf = strtok(NULL, " ");
		sscanf(ptr_buf, "%d", &a[i].points);
		ptr_buf = strtok(NULL, " ");
		sscanf(ptr_buf, "%d", &a[i].players);
		ptr_buf = strtok(NULL, " ");
		strcpy(a[i].surname, ptr_buf);
	}
	//Типа менюшка
	printf("Выберете операцию:\n1.Вывод всего массива структур.\n2.Поиск в массиве структур.\n3.Сортировка массива структур.\n>");
	scanf_s("%d%c", &answer, &ch, 1);
	if ((answer == 2) or (answer == 3))//Есть	ли сортировка или поиск сразу спросить
	{
		printf("Выберете поле:\n1.Название команды\n2.Город\n3.Количество игр\n4.Количество очков\n5.Количество игроков\n6.Фамилия тренера\n>");
		scanf_s("%d%c", &field, &ch, 1);
	}
	switch (answer) {
	case 1://вывод всех записей
		printf("Список всех команд:\n");
		for (int i = 0; i < count; i++)
			printf("%s %s\t%d\t%d\t%d\t%s", a[i].team_name, a[i].city, a[i].played_games, a[i].points, a[i].players, a[i].surname);
		break;

		//блок поиска записей по ключу
			
	case 2: //Поиск
		printf("Введите по какому эллементу будет поиск: ");
		gets_s(buf);
		for (int i = 0; i < count; i++)
		{
			ptr_buf = NULL;
			sprintf(str_playedgames, "%d", a[i].played_games);
			sprintf(str_points, "%d", a[i].points);
			sprintf(str_players, "%d", a[i].players);
			switch (field) {
			case 1:
				if (strcmp(buf, a[i].team_name) == 0)
					ptr_buf = a[i].team_name;
				break;
			case 2:
				if (strcmp(buf, a[i].city) == 0)
					ptr_buf = a[i].city;
				break;
			case 3:
				if (strcmp(buf, str_playedgames) == 0)
					ptr_buf = str_playedgames;
				break;
			case 4:

				if (strcmp(buf, str_points) == 0)
					ptr_buf = str_points;
				break;
			case 5:
				if (strcmp(buf, str_players) == 0)
					ptr_buf = str_players;
				break;
			case 6:
				if (strcmp(buf, a[i].surname) == 0)
					ptr_buf = a[i].surname;
				break;
			default: printf("Неправильное поле!");
			}
			if (ptr_buf != NULL)
				printf("%s %s\t%s\t%s\t%s\t%s", a[i].team_name,	a[i].city, str_playedgames, str_points, str_players, a[i].surname);
		}
		break;
		
	case 3: //Сортировка
		start = 0;
		finish = count - 1;
		while (start < finish)
		{
			min_el = start;
			max_el = start;
			for (int i = start; i <= finish; i++)
			{
				switch (field) {
				case 1:
					if (strcmp(a[min_el].team_name, a[i].team_name) > 0)
						min_el = i;

					break;
				case 2:
					if (strcmp(a[min_el].city, a[i].city) > 0)
						min_el = i;

					break;
				case 3:
					sprintf(str_playedgames, "%d", a[i].played_games);
					sprintf(buf, "%d", a[min_el].played_games);
					if (strcmp(buf,str_playedgames) > 0)
						min_el = i;

					break;
				case 4:
					sprintf(str_points, "%d", a[i].points);
					sprintf(buf, "%d", a[min_el].points);
					if (strcmp(buf, str_points) > 0)
						min_el = i;

					break;
				case 5:
					sprintf(str_players, "%d", a[i].players);
					sprintf(buf, "%d", a[min_el].players);
					if (strcmp(buf, str_players) > 0)
						min_el = i;

					break;
				case 6:
					if (strcmp(a[min_el].surname, a[i].surname) > 0)
						min_el = i;

					break;
				default: printf("Неправильное поле!");
				}
			}
			//перестановка минимального элемента
			one = a[min_el];
			a[min_el] = a[start];
			a[start] = one;
			start++;
		}
		for (int i = 0; i < count; i++)
			printf("%s %s\t%d \t%d \t%d \t%s", a[i].team_name, a[i].city, a[i].played_games, a[i].points, a[i].players, a[i].surname);
		break;
	default: printf("Incorrect operation!!!");
	}
	fclose(file);
	free(a);
	system("pause");
	return 0;
}

