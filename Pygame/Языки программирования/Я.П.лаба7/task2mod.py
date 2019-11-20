def pow(x,n):
    if n==1:
        return x
    return (x)*pow(x,n-1)
