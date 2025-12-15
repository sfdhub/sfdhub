import hashlib

f = open("Merkl.txt", "r")

hashes = [hashlib.sha3_224(line.removesuffix("\n").encode()).hexdigest() for line in f]
 
LeavesCount = len(hashes) # Количество листьев
print("Хэш первой транзакции: " + hashes[0]) # Задание 1

LevelsCount = 1 # Количество уровней (по умолчанию 1, т.к. корень)
while len(hashes) != 1:
  if len(hashes)%2 == 1: # Если нечетное количество листьев, то добавляем последний элемент ещё раз в конец
    hashes.append(hashes[-1])
    LeavesCount += 1
  LevelsCount += 1
  newArr = []
  for i in range(0, len(hashes), 2):
    strs = hashes[i] + hashes[i+1]
    newArr.append(hashlib.sha3_224(strs.encode()).hexdigest())
  hashes = newArr

print("Количество листьев: " + str(LeavesCount)) # Задание 2
print("Количество уровней: " + str(LevelsCount)) # Задание 3
print("Рут хэш: " + hashes[0]) # Задание 4