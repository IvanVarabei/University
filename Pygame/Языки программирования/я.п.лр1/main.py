from god import God
from barista import Barista
from customer import Customer 
def main():
    god=God()
    cus=Customer(1,2,3,4,5,6,7)
    customers_list=god.create(10)
    barista=Barista("Liz", 7)
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
            print(barista.get_info())
        elif ch==2:
            print(god.convert_to_string(customers_list))
        elif ch==3:
            cus.choose_quantity(customers_list)
            print(god.convert_to_string(customers_list))
            print("Number of cups : ",barista.count_cups(customers_list))
        elif ch==4:
            cus.check(customers_list)
            print(god.convert_to_string(customers_list))
            print("Profit : ",barista.count_profit(customers_list),"$")
        elif ch==5:
            cus.pay(customers_list)
            print(god.convert_to_string(customers_list))
        else:
            break
if __name__=="__main__":
    main()



