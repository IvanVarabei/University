from customer import Customer

class Barista:

    def __init__(self,name, experience=1):
        self.name=name
        self.experience=experience

    def get_info(self):
        return(self.name+"( Experience : "+str(self.experience)+")")

    def count_cups(self, customers_list):
        c=0
        for cus in customers_list:
            c=c+cus.quantity
        return c

    def count_profit(self, customers_list):
        b=0
        for cus in customers_list:
            b=b+cus.suma
        return b
        
