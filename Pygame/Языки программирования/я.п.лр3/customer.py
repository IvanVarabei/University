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
        if isinstance(self, Customer):
            return self.__name
    def set_name(self,name):
        if isinstance(self, Customer):
            self.__name=name
    def get_age(self):
        if isinstance(self, Customer):
            return self.__age
    def set_age(self,age):
        if isinstance(self, Customer):
            self.__age=age
    def get_sex(self):
        if isinstance(self, Customer):
            return self.__sex
    def set_sex(self,sex):
        if isinstance(self, Customer):
            self.__sex=sex
    def get_balance(self):
        if isinstance(self, Customer):
            return self.__balance
    def set_balance(self,balance):
        if isinstance(self, Customer):
            self.__balance=balance
    def get_suma(self):
        if isinstance(self, Customer):
            return self.__suma
    def set_suma(self, suma):
        if isinstance(self, Customer):
            self.__suma=suma
    def get_quantity(self):
        if isinstance(self, Customer):
            return self.__quantity
    def set_quantity(self, quabtity):
        if isinstance(self, Customer):
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
    @staticmethod
    def choose_quantity(customers_list):
        cus=Customer
        for cus in customers_list:
            if isinstance(cus, Customer):
                cus.__quantity=random.randint(1,5)
    @staticmethod       
    def check(customers_list):
        cus=Customer
        for cus in customers_list:
            if isinstance(cus, Customer):
                cus.__suma=2*cus.__quantity
    @staticmethod
    def pay(customers_list):
        cus=Customer
        for cus in customers_list:
            if isinstance(cus, Customer):
                cus.__balance=cus.__balance-cus.__suma
        
            
        
        
        
        
        
