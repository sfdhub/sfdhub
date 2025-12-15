// IZ.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//
using namespace std;
#include <iostream>
#include <cmath>

int fun(double x) {
    double a = 0;
    return a = x*x* 2.71*(-x) + x;

}

double dihtomi(double a, double b, double delta, double epsilon) {
    double iter = 0;
    int maxIter = 10000;
    int error = 100;
    double x1 = 0, x2 = 0, y1 = 0, y2 = 0;
    while (error >= epsilon) {
        x1 = (a + b) / 2 - delta;
        x2 = (a + b) / 2 + delta;
        y1 = fun(x1);
        y2 = fun(x2);

        if (y1 < y2) {
            b = x2;
        }
        else {
            a = x1;
        }
        error = abs(b - a);
        iter++;
        if (iter == maxIter)
            break;
    }
    double x = (b + a) / 2;
    return   x;
}

double golden_ratio(double a, double b, double delta) {
    double iter = 0;
    int maxIter = 1000;
    int error = 100;
    double phi = (1 + sqrt(5)) / 2;
    double x1 = 0, x2 = 0, y1 = 0, y2 = 0;
   
    while (error >= delta) {
        x1 = b - (b - a) / phi;
        x2 = a + (b - a) / phi;
        y1 = fun(x1);
        y2 = fun(x2);

        if (y1 >= y2) {

            a = x1;
        }
        else {
            b = x2;
        }
        error = abs(b - a);
        iter++;
        if (iter == maxIter)
            break;
    }
    double x = (b + a) / 2;
    return x;
}

int main()
{
    cout << dihtomi(-1, 1, 0.0001, 0.001) << endl << golden_ratio(-1, 1, 0.001);;
}

