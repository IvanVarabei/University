#include "another.h"
#include <stdio.h>


void showText1(){
	printf("Try to guess the number : ");
}

void showText2(){
	printf("Congratulations!\n");
}

void showText3(){
	printf("Too big!\n");
}

void showText4(){
	printf("Too little!\n");
}

void showMatrix(int *a, int n, int m){
	for(int i =0; i<n; i++){
		for(int j= 0; j<m;j++){
			printf("%5d",*(a + i*m + j));
		}
		printf("\n");
	}
}