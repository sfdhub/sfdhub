import hashlib

file = open("justhash.json", "r").read().replace("\n", "").replace(" ", "")

print(hashlib.sha256(file.encode()).hexdigest())