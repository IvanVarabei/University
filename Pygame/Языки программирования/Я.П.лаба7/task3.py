#laba 7 task 3
#Ivan Varabei
import task3mod
print("Enter 1 to show element\nEnter 2 to show row\nEnter 3 to show special row")
while True:
    k=int(input("Enter number of task, 0 to stop :"))
    if k==0:
        break
    if k==1:
        n=int(input("Enter n : "))
        print(task3mod.fib(n))
    if k==2:
        n=int(input("Enter n : "))
        while n>0:
            print(task3mod.fib(n))
            n-=1
    if k==3:
        n=int(input("Enter n : "))
        x=int(n)
        n=1
        while True:
            if task3mod.fib(n)>=x:
                break
            print(task3mod.fibfib(n))
            n+=1
