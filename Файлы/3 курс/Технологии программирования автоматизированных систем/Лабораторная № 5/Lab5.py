f = open('Harry_Potter.txt', 'r', encoding="ANSI")
text = f.read()
letters = set(text)
letters = sorted(letters)
uniqueSymbol = []
print("\nQuantity of unique symbols: " + str(len(letters)))
output = open('output.txt', 'w', encoding="utf-8")
output.write("Quantity of unique symbols: " + str(len(letters)))
output.write("\nQuantity of using every symbols: " + str(len(text)))
for i in range(len(letters)):
    count = 0
    for j in range(len(text)):
        if text[j] == letters[i]:
            count += 1
    if letters[i] == " ":
        output.write("\nSpace : " + str(count))
    elif letters[i] == "\n":
        output.write("\nNewline : " + str(count))
    else:
        output.write("\n" + str(letters[i]) + " : " + str(count))
    if count == 1:
        uniqueSymbol.append(letters[i])
output.write("\nUnique symbol: " + str(uniqueSymbol))

personInput = ''
personInput = personInput.split()
unique = 10

for i in range(len(personInput)):
    for j in range(len(letters)):
        if personInput[i] == letters[j]:
            unique += 1
if unique == len(personInput):
    output.write("\n\nThe symbols matches")
else:
    output.write("\n\nThe symbols don't matches")

print ("Input symbol : ", personInput)