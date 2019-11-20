from customer import Customer
from c_name import Name
from money import Money
class Barista:
    def __init__(self, experience=1):
        origin_name=Name()#composition
        self.__name=origin_name.name#object(barista) has name
        self.__experience=experience
        self.__balance=Money.balance#composition, object(barista) has money
    def get_name(self):
        if isinstance(self, Barista):
            return self.__name
    def set_name(self,name):
        if isinstance(self, Barista):
            self.__name=name
    def get_experience(self):
        if isinstance(self, Barista):
            return self.__experience
    def set_experience(self, experience):
        if experience>=0:
            if isinstance(self, Barista):
                self.__experience=experience
    def __str__(self):
        return(self.__name+"( Experience : "+
               str(self.__experience)+
               ", balance :"+str(self.__balance)+"$ )")
    @staticmethod
    def count_cups(customers_list):
        c=0
        cus=Customer
        for cus in customers_list:
            if isinstance(cus, Customer):
                c=c+cus.get_quantity()
        return c
    def count_profit(self,customers_list):
        b=0
        cus=Customer
        for cus in customers_list:
            if isinstance(cus, Customer):
                b=b+cus.get_suma()
        self.__balance=self.__balance+b
        return b
        
