import random
class Customer:
    def __init__(self, name, age,sex,status,balance,quantity=0,suma=0):
        self.name=name
        self.age=age
        self.sex=sex
        self.status=status
        self.balance=balance
        self.quantity=quantity
        self.suma=suma
    def get_info(self):
        return (self.name+"(age="+str(self.age)+
                ", sex="+self.sex+ ", status="+
                self.status+", balance="+str(self.balance)+"$"+
                ", amount="+str(self.quantity)+
                ",suma="+str(self.suma)+"$"+")")
    def choose_quantity(self, customers_list):
        for cus in customers_list:
            cus.quantity=random.randint(1,5)
            
    def check(self,customers_list):
        for cus in customers_list:
            cus.suma=2*cus.quantity

    def pay(self, customers_list):
        for cus in customers_list:
             cus.balance=cus.balance-cus.suma
        
            
        
        
        
        
        
