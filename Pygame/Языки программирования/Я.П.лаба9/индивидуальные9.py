
#application "E" task1,2 fanctions!
def input1(mx):
    while True:
        print("Enter only positive integer")
        n=int(input("Enter amount of colomns : "))
        m=int(input("Enter amount of rows : ")) 
        if n>0 and m>0:break
    for i in range(n):
        mx.append([])
        for j in range(m):
            print("enter[",i,"][",j,"] :", end=' ')
            mx[i].append(input())
    return mx,n,m
def output(mtr,n,m):
    for i in range(n):
        for j in range(m):
            print(mx[i][j], end=' ')
        print()






#application "E" task1,2
#lab9 individual
mx=[]
mx, n,m=input1(mx)
output(mx,n,m)
for i in range(n):
        mx[i]=[float(item) for item in mx[i]]
for i in range(n):
    k=0
    for j in range(m):
        if mx[i][j]==mx[i][j-1] and j!=0:
            k+=1
    if k>0:
        mi=k
        n1=i
        break
for i in range(n):
    k=0
    flag=0
    for j in range(m):
        if mx[i][j]==mx[i][j-1] and j!=0:
            k+=1
            flag=1
    if k<mi and flag==1:
        mi=k
        n1=i
print("Number of string : ",n1)
print(mx[n1])
#sum of negative elements
sm=0
for i in range(n):
    for j in range(m):
        if mx[i][j]<0:
            sm=sm+mx[i][j]
print("Sum of negative elements :", sm)

