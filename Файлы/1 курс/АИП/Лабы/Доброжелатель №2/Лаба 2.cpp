#include <iostream>
using namespace std;

int main()
{
    setlocale(LC_ALL, "RU");
    int n,sum=0;
    cout << "Введите длинну массива: ";
    cin >> n;
    int* m = new int[n];
    cout << "Введите элементы массива:" << endl;
    for (int i = 0; i < n; i++)
    {
        cout << "Элемент номер " << i + 1 << ": ";
        cin >> m[i];
    }

    for (int i = 0; i < n; i++)
    {
        if (m[i] > 0)
            sum += m[i];
    }
    cout << "Сумма положительных элементов массива: " << sum << endl;
    delete m;

    return 0;
}