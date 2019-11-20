import random
from customer import Customer
class God:
    START_ALPHABET_WITH_UPPER_LETTER=65
    END_ALPHABET_WITH_UPPER_LETTER=91

    @staticmethod
    def create(count):
        namesm=["Alexander","Pavel","Artyom","Kirill","Stas"]
        namesw=["Olya","Liza","Nastya","Katia"]
        sexes=["men","women"]
        list_of_customers=[]
        for i in range(count+1):
            sex=random.choice(sexes)
            if sex=="men":
                name=random.choice(namesm)
                name+=" " + chr(random.randint(
                    God.START_ALPHABET_WITH_UPPER_LETTER,
                    God.END_ALPHABET_WITH_UPPER_LETTER))+"."
            else:
                name=random.choice(namesw)
                name+=" " + chr(random.randint(
                    God.START_ALPHABET_WITH_UPPER_LETTER,
                    God.END_ALPHABET_WITH_UPPER_LETTER))+"."
            
            balance=random.randint(20,1000)
            age=random.randint(16,70)
            customer=Customer(name,age,sex,balance)
            list_of_customers.append(customer)
        return list_of_customers
    @staticmethod
    def convert_to_string(list_of_customers):
        string="List of customers:\n"
        for customer in list_of_customers:
            if isinstance(customer, Customer):
                string+=str(customer)+"\n"
        return string
