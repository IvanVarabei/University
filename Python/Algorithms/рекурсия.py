def sum(arr):
    total = 0
    for х in arr:
        total += х
    return total

def su(arr):
    try:
        k=arr[1]
        flag=1
    except IndexError : 
        flag=0
    if flag==0:
        return arr[0]
    else:
        m=arr[0]
        del arr[0]
        return m+su(arr)

def lens(arr):
    try:
        k=arr[0]
        flag=1
    except IndexError : 
        flag=0
    if flag==0:
        return 0
    else:
        del arr[0]
        return 1+lens(arr)

def mx(arr,ind):
    try:
        k=arr[1]
        flag=1
    except IndexError : 
        flag=0
    if flag==0:
        if arr[0]>ind:
            return arr[0]
        else:
            return ind
    else:
        if arr[1]>=arr[0] and arr[1]>=ind:
            del arr[0]
            return mx(arr,arr[0])
        else:
            del arr[0]
            return 0+mx(arr,ind)

def bins(ar,pnt):
    dl=len(ar)
    mid=int(dl//2)
    while True:
        if ar[mid]>pnt:
            mid=mid//2
            continue
        elif ar[mid]<pnt:
            mid=mid+(dl-mid)//2
            continue
        else :
            return ar[mid]

def rbin(arr,pn,mi,ma,md):
    if arr[md]==pn:
        return arr[md] 
    else:
        if arr[md]>pn:
            return rbin(arr,pn,mi,md,md//2)
        else:
            if (ma-md)//2==0:
                return rbin(arr,pn,md,ma,md+1)
            else:
                return rbin(arr,pn,md,ma,md+(ma-md)//2)



cvcv=[1,2,3,4,5,6,7,8,9,99,678]    
print(bins(cvcv,678))
q=[1,2,3,4,9,3]
w=[1,2,3,4]
r=[1,2,9,3,4]
e=[1,2,3,4]
print(lens(q))
print (sum(w) )
print (su(e) )
print(mx(r,r[0]))
cv=[1,2,3,4,5,99]    
print(rbin(cv,99,0,len(cv)-1,len(cv)//2))










