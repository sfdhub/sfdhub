import hashlib

W = "JuniorSkills2021Final"
W = hashlib.sha256(W.encode()).hexdigest() # Хэши слово

WXplus1hash = "28ea4cde0cff6b66a7980653335c38de9ec0173444f7eb26c869928cbbc89e0f5bb39e5f5e4a488ea1d401c66190d951c6324edbc6f60871812ec5fa89b47bb2"

# Задача 1
print("Хэш слова W: " + hashlib.sha256(W.encode()).hexdigest())

# Задача 2
# Так как длина WFXplus1hash - 128 символов, то это sha512 (64-sha256, 96-sha384,128-sha512)

# Поиск хэша методом перебора
Xcounts = 0
X = "0"
for i in range(100000,1000000):
    Wi = W + str(i)
    tmpHash = hashlib.sha512(Wi.encode()).hexdigest()
    if(str(tmpHash) == WXplus1hash and X == "0"): # Второе условие аналог флага, для того что бы получить мин число
        X = str(i - 1) # Мы нашли хэш для X+1, поэтому надо отнять 1
        print("Искомый X: " + X) # Задача 4

    if (tmpHash[0 : 2] == "01" and tmpHash[len(tmpHash) -2:] == "10"): # Задача 5
        Xcounts += 1

print("Искомый хэш: " + hashlib.sha512((W+X).encode()).hexdigest()) # Задача 3
print("Количество X: " + str(Xcounts)) # Задача 5