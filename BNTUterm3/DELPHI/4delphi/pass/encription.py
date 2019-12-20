list1 = ['a', 'b', 'c', 'd', 'e','f','g','h','i',
         'j','k','l','m','n','o','p','q','r','s',
         't','u','v','w','x','y','z']

def Search1(y):
    for i in range(26):
        if y == list1[i]:
            return i

def encription(text,k):
    j = 0
    '''if k=='3' or k==3:
        key=3'''
    key=int(k)
    n = 26
    p=[]
    Newlist=[]
    for i in text:
        x = Search1(i)*key % n
        p=list1[x]
        Newlist.append(p)
        ''.join(Newlist)
    return Newlist

def deincription(Newlist,k):
    Endlist=[]
    key = 3
    n = 26
    for i in Newlist:
        for j in range(26):
            if i==''.join(encription(list1[j],k)):
                Endlist.append(list1[j])
    return Endlist
