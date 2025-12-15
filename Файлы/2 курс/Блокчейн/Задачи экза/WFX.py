import hashlib

W = "Blockchain"
W = hashlib.sha3_256(W.encode()).hexdigest() # Хэши слово

WFXplus1hash = "1111a4a1bbbd020ac010fbfb9946e19c12addb8feb5783365bb20c86bfee2b19b206f77b2e93fc099b961f3383fe7462"

# Задача 1
print("Хэш слова W: " + hashlib.sha256(W.encode()).hexdigest())

F = "Buterin" # Задача 2

# Задача 3
# Так как длина WFXplus1hash - 96 символов, то это sha384 (64-sha256, 96-sha384,128-sha512)

# Задача 4 Поиск хэша методом перебора
Xcounts = 0
X = "0"
for i in range(1000000,10000000):
    WFi = W + F + str(i)
    tmpHash = hashlib.sha384(WFi.encode()).hexdigest()
    if(str(tmpHash) == WFXplus1hash and X == "0"): # Второе условие аналог флага, для того что бы получить мин число
        X = str(i - 1) # Мы нашли хэш для X+1, поэтому надо отнять 1
        print("Искомый X: " + X) # Задача 5

    if (tmpHash[0 : 4] == "cafe"): # Задача 6, если первые 4 символа хэша равны cafe, то X++
        Xcounts += 1

print("Искомый хэш: " + hashlib.sha384((W+F+X).encode()).hexdigest()) # Задача 7
print("Количество X: " + str(Xcounts)) # Задача 6