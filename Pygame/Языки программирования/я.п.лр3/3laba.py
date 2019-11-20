class Car(object):
    def __init__(self, passenger, weight, fuel):
        self.passenger= passenger
        self.weight=weight
        self.fuel=fuel
class Truck(Car):  #inheritance
    pass
class Bus(Car):    #inheritance
    pass
class Autopark(object):
    def __init__(self, car, truck, bus):   #aggregation
        self.car= car
        self.truck=truck
        self.bus=bus
    def sum(self):
        print("Total number of passengers :{}".format(self.car.passenger+self.truck.passenger+self.bus.passenger))
        print("Total weight, which all machines can take :{}".format(self.car.weight+self.truck.weight+self.bus.weight))
        print("Total value of needed fuel :{}".format(self.car.fuel+self.truck.fuel+self.bus.fuel))
car=Car(6,20,25)
truck=Truck(3,1000,50)
bus=Bus(24,70,40)
autopark=Autopark(car, truck, bus)
autopark.sum()
