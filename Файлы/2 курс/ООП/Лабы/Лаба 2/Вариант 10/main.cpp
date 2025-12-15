// Институт компьютерных технологий и информационной безопасности
// Кафедра МОП ЭВМ
// Дисциплина: Объектно-ориентированное программирование
// Лабараторная работа №2
// Вариант №10
// Исполнитель:

#include <iostream>

using namespace std;

/*
 * Абстрактный класс элемента логической схемы
 * Содержит два входа, один выход и название элемента
 * Содержит виртуальные функции для вычисления и вывода
 */
class Element
{
protected:
    int input1;
    int input2;
    int output;
    string name;

public:
    /**
     * Конструктор класса
     *
     * @param input1 Первый входной сигнал
     * @param input2 Второй входной сигнал
     * @param name Название элемента
     */
    Element(int input1, int input2, string name)
    {
        this->input1 = input1;
        this->input2 = input2;
        this->name = name;
    }

    virtual void calculate() = 0;
    virtual void print() = 0;
    /**
     * Получение результата вычисления
     * 
     * @return Возвращает результат вычисления 
     */
    int getResult()
    {
        this->calculate();
        return output;
    }
};

// Класс логического элемента AND
class AND : public Element
{
public:
    AND(int input1, int input2, string name) : Element(input1, input2, name) {}
    void calculate()
    {
        output = input1 & input2;
    }
    
    void print()
    {
        cout << "AND " << name << " = " << output << endl;
    }
};

// Класс логического элемента OR
class OR : public Element
{
public:
    OR(int input1, int input2, string name) : Element(input1, input2, name) {}
    void calculate()
    {
        output = input1 | input2;
    }

    void print()
    {
        cout << "OR " << name << " = " << output << endl;
    }
};

/*
 * Класс логической схемы
 * Содержит массив элементов логической схемы
 */
class Scheme
{
private:
    Element *elements[10];
    int count;

public:
    Scheme()
    {
        count = 0;
    }

    void addElement(Element *element)
    {
        elements[count++] = element;
    }

    void calculate()
    {
        for (int i = 0; i < count; i++)
            elements[i]->calculate();
    }

    void print()
    {
        for (int i = 0; i < count; i++)
            elements[i]->print();
    }
};

int main()
{
    Element *el1 = new AND(0, 1, "X");
    Element *el2 = new OR(1, 0, "Y");

    Scheme scheme;
    scheme.addElement(new AND(0, 0, "A"));
    scheme.addElement(new AND(0, 1, "B"));
    scheme.addElement(new AND(1, 0, "C"));
    scheme.addElement(new AND(1, 1, "D"));
    scheme.addElement(new OR(0, 0, "E"));
    scheme.addElement(new OR(0, 1, "F"));
    scheme.addElement(new OR(1, 0, "G"));
    scheme.addElement(new OR(el1->getResult(), el2->getResult(), "H"));
    scheme.calculate();
    scheme.print();
    return 0;
}
