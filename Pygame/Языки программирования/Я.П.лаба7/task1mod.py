def stepen(x,n):
    if n==1:
        return x
    return (x/n)*stepen(x,n-1)

