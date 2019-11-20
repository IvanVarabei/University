from god import God
from barista import Barista
from customer import Customer 
def main():
    customers_list=God.create(10)
    barista=Barista(6)
    print(barista)
    print('''1)To show cost of a cup and barista info.
2)To show list of customers befor the ordering.
3)To show list of customers with number of caps. Customers make the orders.
4)To show check, and total barista's profit. Customers calculate chekc. Barista calculate profit. 
5)To show ramaining balance of customers. 
6)To stop the programm.''')
    while True:
        ch=int(input())
        if ch==1:
            print("Cost of one cap is 2$") 
            print(barista)
        elif ch==2:
            print(God.convert_to_string(customers_list))
        elif ch==3:
            Customer.choose_quantity(customers_list)
            print(God.convert_to_string(customers_list))
            print("Number of cups : ",Barista.count_cups(customers_list))
        elif ch==4:
            Customer.check(customers_list)
            print(God.convert_to_string(customers_list))
            print("Profit : ",barista.count_profit(customers_list),"$")
            print(barista)
        elif ch==5:
            Customer.pay(customers_list)
            print(God.convert_to_string(customers_list))
        else:
            break
if __name__=="__main__":
    main()



