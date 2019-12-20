from collections import deque

def person_is_seller(name):
    return name[-1] == 'm'

def search_ms(graf):
    searched=[]
    while graf:
        person=graf.popleft()
        if not person in searched:
            if person_is_seller(person):
                print(person+" is a mango seller")
                return 1
            else:
                graf+=graph[person]
    return 0   

graph = {}
graph [ "you"] = [ "alice", "bob", "claire"]
graph["bob"] = ["anuj", "peggy"]
graph["alice"] = ["peggy"]
graph["claire"] = ["liz", "jonny"]
graph["anuj"] = ["artem","ivan"]
graph["artem"] = []
graph["inan"] = []
graph["peggy"] = []
graph["liz"] = []
graph["jonny"] = [] 
search_queue = deque() 
search_queue += graph [ "you"]
if search_ms(search_queue)==0:
    print("he is not")

acts={}
acts["put your clothes on"]=["take a shower","do exersizes","wake up"]
acts["have a breakfast"]=["clean the teeth","wake up"]
acts["to wrap up the dinner"]=["wake up"]
