from customer import Customer

class Barista:

    def __init__(self,name, experience=1):
        self.__name=name
        self.__experience=experience

    def get_name(self):
        return self.__name

    def set_name(self,name):
        self.__name=name

    def get_experience(self):
        return self.__experience

    def set_experience(self, experience):
        if experience>=0:
            self.__experience=experience

    def __str__(self):
        return(self.__name+"( Experience : "+str(self.__experience)+")")

    def count_cups(self, customers_list):
        c=0
        for cus in customers_list:
            c=c+cus.get_quantity()
        return c

    def count_profit(self, customers_list):
        b=0
        for cus in customers_list:
            b=b+cus.get_suma()
        return b
        
