#include <iostream>
using namespace std;

constexpr uint16_t maxArraySize = 1001;

/**
 * @brief Удаляет начальные и концевые пробелы
 * @param inStr Входная строка
 * @param outStr Выходная
 */
void reverseAndClean(const char inStr[], char outStr[])
{
    const char *start, *stop;
    for (start = inStr; *start == ' ' && *start != '\0'; ++start)
        ;

    for (stop = start; *stop; ++stop)
        ;

    for (--stop; *stop == ' ' && stop > start; --stop)
        ;

    char *to = outStr;
    for (; stop >= start; --stop, ++to)
        *to = *stop;
    *to = '\0';
}

int main()
{
    char inpStr[maxArraySize], outStr[maxArraySize];
    cin.getline(inpStr, maxArraySize);
    reverseAndClean(inpStr, outStr);
    cout << outStr << endl;
    return 0;
}