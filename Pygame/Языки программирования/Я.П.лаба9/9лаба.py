import random
HANGMANPICS = ['''
    +---+
    |   |
        |
        |
        |
        |
 =========''','''
    +---+
    |   |
    O   |
        |
        |
        |
 =========''','''
    +---+
    |   |
    O   |
    |   |
        |
        |
 =========''','''
    +---+
    |   |
    O   |
   /|   |
        |
        |
 =========''','''
    +---+
    |   |
    O   |
   /|\  |
        |
        |
 =========''','''
    +---+
    |   |
    O   |
   /|\  |
   /    |
        |
 =========''','''
    +---+
    |   |
    O   |
   /|\  |
   / \  |
        |
 =========''']
def getRandomWord(wordList):
    wordIndex = random.randint(0, len(wordList) - 1)
    return wordList[wordIndex]

def getGuess(alreadyGuessed):
    
    #Возвращает букву, которую ввел игрок. Эта функция проверяет, что введена
# буква, а не какой-то другой символ
    while True:
        print('Введите букву')
        guess = input()
        guess = guess.lower()
        if len(guess) != 1:
            print('Вводите по одной букве.')
        elif guess in alreadyGuessed:
            print ('Вы уже пробовали эту букву. Выберите другую')
        elif guess not in 'ёйцукенгшщзхъфывапролджэячсмитьбю':
            print('Пожалуйста, введите букву кириллицы')
        else:
          return guess

def displayBoard(HANGMANPICS, missedletters, correctLetters,secretWord):
    print(HANGMANPICS[len(missedLetters)])
    print()
    print('Неправильные буквы:', end=' ')
    for letter in missedLetters:
        print(letter, end=' ')
    print()
 
    blanks = '_'*len(secretWord)
     #Заменяем звездочки на правильно угаданные буквы
    for i in range(len(secretWord)):
        if secretWord[i] in correctLetters:
            blanks = blanks[:i] + secretWord[i] + blanks[i+1:]
      #Показываем загаданное слово с пробелами между букв
    for letter in blanks: 
        print(letter, end=' ')
    print()
def playAgain():
    print('Хотите попробовать еще раз? ("Да" или "Нет")')
    return input().lower().startswith('д')

easy = '''лук суп сок бок шум шов ток тук бук куш'''.split()
medium = '''слива забор город тема вечер змея указ'''.split()
hard = '''калейдоскоп компьютер аутентификация аутофагия'''.split()
#print(words)
words=''' '''
print('В И С Е Л И Ц А')
fl=0
while True:
    fl=int(input("Введите уровень сложности: 1-easy, 2-medium, 3-HARD : "))
    if fl==1:
        words=easy
        break
    elif fl==2:
        words=medium
        break
    elif fl==3:
        words=hard
        break
    else:
        print("Введите число от 1 до 3")
missedLetters = ''
correctLetters = ''
secretWord = getRandomWord(words)
print(secretWord)
gameIsDone = False
while True:
    displayBoard(HANGMANPICS, missedLetters, correctLetters, secretWord)
    guess = getGuess(missedLetters+correctLetters)
    if guess in secretWord:
        correctLetters = correctLetters + guess
#Проверка условия победы игрокая
        foundAllLetters = True  
        for i in range(len(secretWord)):
            if secretWord[i] not in correctLetters:
                foundAllLetters = False
                break
        if foundAllLetters:
            print('Превосходно! Было загадано слово "'+secretWord+'" Вы победили!')#плюсы убирают пробелы
            gameIsDone = True
    else:
        missedLetters = missedLetters+guess

         #Проверка условия проигрыша игрока
        if len(missedLetters) == len(HANGMANPICS) - 1:
            displayBoard(HANGMANPICS, missedLetters, correctLetters, secretWord)
            print('У вас не осталось попыток!\nПосле '+str(len(missedLetters))+' ошибок и '+str(len(correctLetters))+'угаданных букв. Загаданное слово:'+secretWord+'"')
            gameIsDone = True
    if gameIsDone:
        if playAgain():
            missedLetters = ''
            correctLetters = ''
            gameIsDone = False
            secretWord = getRandomWord(words)
        else:
            break







