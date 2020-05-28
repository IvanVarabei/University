//#include <stdio.h>
#include <stdlib.h>

int getSumOfArrayElements(int*, int);
int getMultOfArrayElements(int*, int);
int seekMaxPos(int*,int);
int considerNegMultBefore(int*,int);
int considerPositSumBefore(int*, int);

int main(){

	int size;
	int *array = NULL;

	printf("Input the array size: ");	
	scanf("%d", &size);

	array = malloc(size * sizeof(int));

	printf("Input array elements: ");
	int i = 0;
	for (; i  < size; i++) {
		scanf("%d",(array + i));
	}

	int positiveSum = getSumOfArrayElements(array,size);
	int negativeSum = getMultOfArrayElements(array,size);
	int mp =seekMaxPos(array,size);

	printf("\nResult of general task:");
	printf("\n\tsum of all elements = %d", positiveSum);
	printf("\n\tMult of all elements = %d\n\n", negativeSum);

	printf("\nResult of persoonal v9 task:");
	printf("\n\tsum of positive elements before max = %d", considerPositSumBefore(array,mp));
	printf("\n\tMult of negative elements before max = %d\n\n", considerNegMultBefore(array,mp));

	free(array);

	return 0;
}

int considerNegMultBefore(int* ms,int mp){
	int res=1;
	for(int i =0;i<mp;i++){
		if(ms[i]<0){
			res*=ms[i];
		}
	}
	return res;
}

int considerPositSumBefore(int* ms,int mp){
	int res=0;
	for(int i =0;i<mp;i++){
		if(ms[i]>0){
			res+=ms[i];
		}
	}
	return res;
}

int seekMaxPos(int* array, int size){
	int mp=0;
	for(int i =0 ; i<size;i++){
			if(array[i]>array[mp]){
				mp=i;
			}
	}
	return mp;
}



int getSumOfArrayElements(int* array, int size){
	
	int sum = 0;
	int i = 0;

	for (; i < size; i++){
			sum += array[i];
	}
		
	return sum;
}

int getMultOfArrayElements(int* array, int size){
	
	int mult = 1;
	int i = 0;

	for (; i < size; i++){
			mult *= array[i];
	}
		
	return	mult;
}
