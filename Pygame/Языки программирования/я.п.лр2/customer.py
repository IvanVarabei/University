import random
class Customer:
    def __init__(self, name, age,sex,balance,quantity=0,suma=0):
        self.__name=name
        self.__age=age
        self.__sex=sex
        self.__balance=balance
        self.__quantity=quantity
        self.__suma=suma

    def get_name(self):
        return self.__name

    def set_name(self,name):
        self.__name=name

    def get_age(self):
        return self.__age

    def set_age(self,age):
        self.__age=age

    def get_sex(self):
        return self.__sex

    def set_sex(self,sex):
        self.__sex=sex

    def get_balance(self):
        return self.__balance

    def set_balance(self,balance):
        self.__balance=balance

    def get_suma(self):
        return self.__suma

    def set_suma(self, suma):
        self.__suma=suma

    def get_quantity(self):
        return self.__quantity

    def set_quantity(self, quabtity):
        self.__quantity=quantity
    
    @property
    def status_set(self):
        statuses=["amateur","bystander","gourmet"]
        status=random.choice(statuses)
        return status
        
    def __str__(self):
        return (self.__name+"(age="+str(self.__age)+
                ", sex="+self.__sex+ ", status="+
                self.status_set+", balance="+str(self.__balance)+"$"+
                ", amount="+str(self.__quantity)+
                ",suma="+str(self.__suma)+"$"+")")
    def choose_quantity(self, customers_list):
        for cus in customers_list:
            cus.__quantity=random.randint(1,5)
            
    def check(self,customers_list):
        for cus in customers_list:
            cus.__suma=2*cus.__quantity

    def pay(self, customers_list):
        for cus in customers_list:
             cus.__balance=cus.__balance-cus.__suma
        
            
        
        
        
        
        
