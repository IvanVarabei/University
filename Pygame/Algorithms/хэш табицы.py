import random
voted = {}

def check_voter(name) :
    if voted.get(name):
        print("kick them out!")
    else :
        voted[name] = True
        print ("let them vote!")

check_voter("tom") 
#####################

def hesh(etem):
    return len(etem)

def app(dict1):
    print("Enter key to add:")
    key=input()
    print("Enter value to add:")
    value=input()
    dict1[hesh(key)]=value

def show(sp):
    print("Enter key to show:")
    key=input()
    print(sp[hesh(key)])
        

dict1=[None]*1000
print('''1-append
2-show''')
while 1:
    t=input()
    if t=='1':
        app(dict1)
    if t=='2':
        show(dict1)
