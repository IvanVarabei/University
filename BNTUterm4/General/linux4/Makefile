app : controller.o model.o view.o
	cc -o app controller.o model.o view.o

controller.o : controller.c model.h 
	cc -c controller.c 

model.o : model.c model.h 
	cc -c model.c 
	
view.o : view.c view.h 
	cc -c view.c

clean : 
	rm controller.o model.o app view.o app