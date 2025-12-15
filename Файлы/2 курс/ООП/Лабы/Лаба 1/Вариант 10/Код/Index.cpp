#include <stdexcept>
#include "Index.h"

/**
 * Конструктор класса
 *
 * @param word Индексируемое слово
 */
Index::Index(string word) {
    this->word = word;
}

/**
 * Функция добавления страницы в список
 *
 * @param page Номер страницы которую нужно добавить
 */
void Index::addPage(int page) {
    pages.push_back(page);
}

/**
 * Функция получения списка страниц
 *
 * @return Возвращает копию списка страниц.
 */
vector<int> Index::getPages() {
    return pages;
}

/**
 * Получение индексируемого слова
 *
 * @return Возвращает индексируемое слово.
 */
string Index::getWord() {
    return word;
}

/**
 * Деструктор класса
 */
Index::~Index() {
    // Освобождение памяти вектора. Источник: https://stackoverflow.com/questions/10464992/c-delete-vector-objects-free-memory
    pages = std::vector<int>();
}

/**
 * Копирование списка страниц в класс
 *
 * @param pages Список страниц
 */
void Index::setPages(vector<int> pages) {
    this->pages = std::move(pages);
}

/**
 * Получение количества страниц
 *
 * @return Возвращает количество страниц.
 */
long Index::getPagesCount() {
    return pages.size();
}

/**
 * Получение номера страницы по индексу
 *
 * @param index Индекс страницы
 * @return Возвращает номер страницы.
 */
int Index::getPage(int index) {
    if (index < 0 || index >= pages.size())
        throw std::out_of_range("Index out of range");
    return pages[index];
}

/**
 * Объединение двух списков старниц с одинаковым словом
 *
 * @param index Ссылка на класс Index
 * @return Возвращает новый Index.
 */
Index Index::operator+(const Index& index) const {
    if (word != index.word)
        throw std::invalid_argument("Words not equal");

    vector<int> mergedVector;
    mergedVector.reserve(pages.size() + index.pages.size());
    mergedVector.insert(mergedVector.end(), pages.begin(), pages.end());
    mergedVector.insert(mergedVector.end(), index.pages.begin(), index.pages.end());

    Index newindx(word);
    newindx.setPages(mergedVector);
    return newindx;
}
