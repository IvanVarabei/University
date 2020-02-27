app : main.o another.o 
	cc -o app main.o another.o
main.o : main.c another.h
	cc -c main.c
another.o : another.c another.h
	cc -c another.c

clean : 
	rm main.o another.o app