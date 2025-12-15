import numpy as np
import matplotlib.pyplot as plt

# Дальше понадобится
birthyear = 2004
# Скачаем нужные для нашего варианта файлы 25563.txt и 37123.txt
# также переименовали их соответственно в anadyr.txt и kislovodsk.txt дабы не путаться

# Занесём данные из них в Матрицы numpy
kv = np.genfromtxt('kislovodsk.txt')
ad = np.genfromtxt('anadyr.txt')

# 4.6
# Оставим только нужные нам колонки
# год, месяц, день, мин. темп., среднесуточная темп., макс. темп., осадки
kv = np.delete(kv, [0,4,6,8,10,12,13], axis=1)
ad = np.delete(ad, [0,4,6,8,10,12,13], axis=1)
# 4.7
# Для каждого из наборов данных создадим колонку с временем года
# (0-зима, 1-весна, 2-лето, 3-осень) 
season = []
for i in kv[:,1]:
    if(i in [1,2,12]):
        season.append(0)
    elif(i in [3,4,5]):
        season.append(1)
    elif(i in [6,7,8]):
        season.append(2)
    else:
        season.append(3)
season = np.array(season)
kv = np.insert(kv,0,season,axis=1)

season = []
for i in ad[:,1]:
    if(i in [1,2,12]):
        season.append(0)
    elif(i in [3,4,5]):
        season.append(1)
    elif(i in [6,7,8]):
        season.append(2)
    else:
        season.append(3)
season = np.array(season)
ad = np.insert(ad,0,season,axis=1)

# Отделим зиму и лето от других сезонов в каждом городе
s_ad = ad[(ad[:,0] == 2)]
w_ad = ad[(ad[:,0] == 0)]
s_kv = kv[(kv[:,0] == 2)]
w_kv = kv[(kv[:,0] == 0)]

# Для каждого из городов и зимы\лета найдем годовые средние и запишем
# эти агрегированные данные в новый массив
# первая колонка - город (0=ad, 1=kv)
# вторая - год
# тертья - зима\лето
# четвертое - среднее
agged = []

for i in np.unique(s_ad[:,1]):
    tmp = s_ad[np.where(s_ad[:,1] == i)][:,5]
    agged.append([0,i,2,np.mean(tmp)])

for i in np.unique(w_ad[:,1]):
    tmp = w_ad[np.where(w_ad[:,1] == i)][:,5]
    agged.append([0,i,0,np.mean(tmp)])

for i in np.unique(s_kv[:,1]):
    tmp = s_kv[np.where(s_kv[:,1] == i)][:,5]
    agged.append([1,i,2,np.mean(tmp)])

for i in np.unique(w_kv[:,1]):
    tmp = w_kv[np.where(w_kv[:,1] == i)][:,5]
    agged.append([1,i,0,np.mean(tmp)])
agged = np.array(agged)
# массив в файл
np.savetxt("agg.txt", agged)

# 4.8
# Построим среднегодовые температуры для Кисловодска (слева зима, спарва лето)
fig, axs = plt.subplots(1,2)
fig.suptitle('Кисловодск')
axs[0].plot(agged[(agged[:,0]==1) & (agged[:,2]==0)][:,1], agged[(agged[:,0]==1) & (agged[:,2]==0)][:,3])
axs[1].plot(agged[(agged[:,0]==1) & (agged[:,2]==2)][:,1], agged[(agged[:,0]==1) & (agged[:,2]==2)][:,3])
plt.show()


# Построим среднегодовые температуры для Анадыри (слева зима, спарва лето)
fig,axs = plt.subplots(1,2)
fig.suptitle('Анадырь')
axs[0].plot(agged[(agged[:,0]==0) & (agged[:,2]==0)][:,1], agged[(agged[:,0]==0) & (agged[:,2]==0)][:,3])
axs[1].plot(agged[(agged[:,0]==0) & (agged[:,2]==2)][:,1], agged[(agged[:,0]==0) & (agged[:,2]==2)][:,3])
plt.show()

# 4.9
# Агрегируем данные без деления на сезоны
# Первая колонка - год
# Вторая - среднее
mean_kv = []
mean_ad = []

for i in np.unique(kv[:,1]):
    tmp = kv[np.where(kv[:,1] == i)][:,5]
    mean_kv.append([i,np.mean(tmp)])

for i in np.unique(ad[:,1]):
    tmp = ad[np.where(ad[:,1] == i)][:,5]
    mean_ad.append([i,np.mean(tmp)])

# Заметим, что логирование по Анадыри начинается с 1898 (позже чем в кисловодске)
# -> берем разницу с этого года
diff = []
d = len(mean_kv)-len(mean_ad)
for i in range(len(mean_ad)):
    diff.append([mean_ad[i][0], mean_ad[i][1]-mean_kv[i+d][1]])
np.savetxt("diff.txt", diff)

# 4.10
# год рождения храню в переменной birthyear
# сразу отфильтруем этот год
kv_b = kv[kv[:,1]==birthyear]

# Получим средние по каждому месяцу
kv_agg = []
for i in np.unique(kv_b[:,2]):
    tmp = kv_b[np.where(kv_b[:,2] == i)][:,5]
    kv_agg.append([i,np.mean(tmp)])

print(type(kv_agg))
# Применив встроенную функцию видим что это список, а нам удобней работать с
# с массивами numpy, конвертируем
kv_agg = np.array(kv_agg)

# дисперсия равна одному числу, но да ладно, выведем в файл
disp = np.var(kv_agg[:,1])
np.savetxt("variation.txt", [disp])

# 4.11
# год рождения храню в переменной birthyear
# сразу отфильтруем этот год
kv_b = kv[kv[:,1]==birthyear]

# Получим средние по каждому месяцу
kv_agg = []
for i in np.unique(kv_b[:,2]):
    tmp = kv_b[np.where(kv_b[:,2] == i)][:,7]
    kv_agg.append([i,np.mean(tmp)])
kv_agg = np.array(kv_agg)

# Объем осадков строим
plt.hist(kv_agg[:,1])
plt.title("гистограмма объема осадков")
plt.show()

# Агрегируем по годам и берем дисперсии
kv_agg = []
for i in np.unique(kv[:,1]):
    tmp = kv[np.where(kv[:,1] == i)][:,7]
    kv_agg.append([i,np.var(tmp)])
kv_agg = np.array(kv_agg)

# Дисперсии осадков строим
plt.hist(kv_agg[:,1])
plt.title("гистограмма дисперсии среднемесячных осадков")
plt.show()

# Замечание к анализу: везде где пропуски база данных видимо заменяет пропуск на значение -99, что приводит
# к явным выбросам в отрицательную сторону на графиках и гистограммах
