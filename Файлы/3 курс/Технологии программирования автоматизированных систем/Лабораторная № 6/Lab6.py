import datetime
import string

class Lab_6:

    SetOfDeniedSymb = list(string.digits)
    createName = 'Mishenko'
    createGroup = 'KTco3-1'
    createTime = datetime.datetime.now()

    # конструктор класса init
    def __init__(self, insent):
        self.Sentence_List = list(insent)
        for i in range(len(self.Sentence_List)):
            for j in range(len(self.SetOfDeniedSymb)):
                if self.Sentence_List[i] == self.SetOfDeniedSymb[j]:
                    print('\n' + self.Sentence_List[i])

    def info(self):
        print('\nI ', self.createName, '\nin group ', self.createGroup, '\nmade class in ', self.createTime)

    # деструктор класса del с сообщением об уничтожении объекта
    def __del__(self):
        print('\nObject destroyed')


# print('Enter your sentence: ')
sentence = input('Enter 1 your 2 sentence: ')
lab = Lab_6(sentence)
lab.info()
