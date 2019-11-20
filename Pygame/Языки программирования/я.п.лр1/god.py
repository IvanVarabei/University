import random
from customer import Customer
class God:
    START_ALPHABET_WITH_UPPER_LETTER=65
    END_ALPHABET_WITH_UPPER_LETTER=91

    def create(self, count):
        namesm=["Alexander","Pavel","Artyom","Kirill","Stas"]
        namesw=["Olya","Liza","Nastya","Katia"]
        sexes=["men","women"]
        statuses=["amateur","bystander","gourmet"]
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
            status=random.choice(statuses)
            customer=Customer(name,age,sex,status,balance)
            list_of_customers.append(customer)
        return list_of_customers

    def convert_to_string(self,list_of_customers):
        string="List of customers:\n"
        for customer in list_of_customers:
            if isinstance(customer, Customer):
                string+=str(customer.get_info())+"\n"
        return string
