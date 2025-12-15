// Институт компьютерных технологий и информационной безопасности
// Кафедра МОП ЭВМ
// Дисциплина: Объектно-ориентированное программирование
// Лабараторная работа №1
// Вариант №10
// Исполнитель:

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include "Index.h"

using namespace std;

int main() {
    system("chcp 65001");

    string word;
    cout << "Введите слово для поиска: ";
    cin >> word;

    auto *indx = new Index(word); // Создание объекта класса Index с искомым словом

    // Считывание файла
    string filename = "file.txt";
    ifstream file(filename);
    string line;

    int page_number = 1;
    // Поиск слова в файле
    while (getline(file, line)) {
        if (line.find(indx->getWord()) != string::npos) {
            indx->addPage(page_number);
        }
        // Разделитель страниц - пустая строка
        if (line.empty() || line == "\n") {
            page_number++;
        }
    }

    // Вывод результата
    if (indx->getPagesCount() == 0) {
        cout << "Слово \"" << indx->getWord() << "\" не найдено" << endl;
    } else {
        cout << "Слово \"" << indx->getWord() << "\" найдено на следующих страницах: ";
        for (int i = 0; i < indx->getPagesCount(); i++) {
            try {
                cout << indx->getPage(i) << " ";
            } catch (out_of_range &e) {
                cout << endl << "Ошибка индекс " << i << " не существует" << endl;
            }
        }
    }

    cout << endl;
    delete indx; // Освобождение памяти

    return 0;
}

