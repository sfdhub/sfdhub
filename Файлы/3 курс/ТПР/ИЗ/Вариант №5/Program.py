"""
Вариант №7:	Метод ELECTRE I: построение матриц согласия и несогласия
"""

#Константа для ELECTRE I
ALF = 0.5

def inputMatrix():
	"""Функция для ввода альтернатив и критериев"""
	mat = []
	for i in range(int(input("Введите количесвто альтернатив: "))):
		print("A" + str(i+1))
		mat.append(tuple(map(int,input("Введите значения критериев альтернативы (через пробел): ").split())))
		
	return mat


def inputVP():
	"""Функция для ввода веса и констант"""
	vp = []#матрица для констант пользователя
	vp.append(tuple(map(float,input("Введите весы критериев (через пробел): ").split())))	
	vp.append(tuple(map(float,input("Введите прот. константы (через пробел): ").split())))
	
	return vp	
	
def temp(num, con):
	"""Маленькая вспомогательная функция для суммы(agreeFunk)"""
	res = 0
	for i in range(len(num)):
		res+= con[num[i]]
		
	return res

def agreeFunk(atr, const):
	"""Функция определения согласия"""
	gen = sum(const)
	resulter = (temp(atr[0], const) + ALF*temp(atr[2], const))/gen
	
	return resulter
	
	
def disAgreeFunk(arr, dis_arr, const):
	"""Функция определения несогласия"""
	
	d = [] #Массив, в котором будет выбран максимум. По формуле
	for i in range(len(dis_arr)):
		raz = arr[1][dis_arr[i]] - arr[0][dis_arr[i]]#Различие критериев
		d.append(raz*const[dis_arr[i]])	
	
	return max(d)

def couple(mat, const):
	"""Распределение пар"""
	Ip = []#I+
	Im = []#I-
	Ieq = []#I=
	
	#Распределение на под массивы
	for i in range(len(mat[0])):
		if (mat[0][i] > mat[1][i]):
			Ip.append(i)
		elif (mat[0][i] == mat[1][i]):
			Ieq.append(i)
		else:
			Im.append(i)
	
	return (agreeFunk((Ip,Im,Ieq), const[0]), disAgreeFunk(mat, Im, const[1]))
	
def show(arr, text):
	"""Ввывод матриц на экран в правильной форме"""
	print("Матрица " + text)
	for i in range(len(arr)):
		for j in range(len(arr)):
			print(arr[i][j], end=" ")
		print()
	print()
			


def main():
	"""Основаная функция, запускающая функции"""
	
	#Искомые таблицы
	agree = []#Таблица согласия
	disagree = []#Таблица несогласия
	
	#Ввод значений
	matrix = inputMatrix()
	ves_prot = inputVP()#0 -- весы, 1 -- прот. константы
	
	#Формерование пар
	for row in range(len(matrix)):
		ag_tmp = []
		dis_tmp = []
		for j in range(len(matrix)):
			if (row != j):
				tmp = couple((matrix[row], matrix[j]), ves_prot)
				ag_tmp.append(tmp[0])	
				dis_tmp.append(tmp[1])
			else:
				ag_tmp.append("-")	
				dis_tmp.append("-")
		agree.append(ag_tmp)
		disagree.append(dis_tmp)
	
	#Вывод на экран
	print()
	show(agree, "согласия")	
	show(disagree, "несогласия")
	
	input("Нажмите любую кнопку для продолжения...")#Для просмотра результата выполнения	
	
#Запуск программы	
if __name__ == "__main__":
	main()
