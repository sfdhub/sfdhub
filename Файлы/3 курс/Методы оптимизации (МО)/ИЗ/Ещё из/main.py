import math
import numpy as np
import matplotlib.pyplot as plt
import time

start = -10
end = 15

def fun(x):
    return (x**3-3*x+1)

# a и b: границы интервала, на котором ищется минимум или максимум.
# E: точность, с которой ищется минимум или максимум.
# fun: функция, минимум или максимум которой ищется.
# itsMAX: флаг, указывающий, ищется ли максимум.

def compare(a, b, itsMAX):
    if itsMAX:
        return a > b
    else:
        return a < b

# Метод дихотомии. 
# Возвращает кортеж из двух значений: найденный интервал и количество вычислений функции.
def findByDichotomy(a, b, E, fun, itsMAX = False):
    left = a
    right = b
    cycles = 0

    while (right - left) > 2 * E:
        cycles += 2

        x1 = ((left + right) / 2) - E / 2
        x2 = ((left + right) / 2) + E / 2

        if compare(fun(x1), fun(x2), itsMAX):
            right = x1
        else:
            left = x2

    return ((left, right), cycles)

# Метод золотого сечения.
# Возвращает кортеж из двух значений: найденный интервал и количество вычислений функции.
def findByGoldSection(a, b, E, fun, itsMAX = False):
    left = a
    right = b
    cycles = 0

    # Коффициент золотого сечения
    goldenK = (math.sqrt(5) + 1) / 2

    while (right - left) > 2 * E:
        cycles += 2

        x1 = right - (right - left) / goldenK
        x2 = left + (right - left) / goldenK

        if compare(fun(x1), fun(x2), itsMAX):
            right = x1
        else:
            left = x2
            
    return ((left, right), cycles)

# Получаем значения E от 10^0 до 10^(-9)
E = np.arange(0, 10, 1, dtype=float)
Es = np.power(10, -E) # 10^(-x)

dCount = []
gsCount = []

dTime = []
gsTime = []

# Дихотомия
start_time = time.time()
for e in Es:
    dCount.append(findByDichotomy(start, end, e, fun)[1])
end_time = time.time()
dTime.append(end_time - start_time)

# Золотое сечение
start_time = time.time()
for e in Es:
    gsCount.append(findByGoldSection(start, end, e, fun)[1])
end_time = time.time()
gsTime.append(end_time - start_time)

# График
plt.figure("Сравнение методов")
plt.title("дихотомия:" + str(sum(dTime)*1000)[:6] + "мс | золотое сечение:" + str(sum(gsTime)*1000)[:6] + "мс")
plt.xlabel("10^(-x) (E)")
plt.ylabel("Количество циклов")
plt.plot(E, dCount, label="Дихотомия", linestyle='dashed', color='red')
plt.plot(E, gsCount, label="Золотого сечение", linestyle='dashed', color='blue')
plt.legend()
plt.show()
