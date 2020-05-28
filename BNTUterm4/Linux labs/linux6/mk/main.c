#include <stdio.h>
#include "another.h"
#include <stdlib.h>


int main(){

	tryGess();
	printf("\nNext task is about matrix from thierd lab\n");
	matrixShort();
	return 0;
}

void matrixShort(){
	int n,m,i,j;
	int *a = NULL;

	printf("Input rows: ");	
	scanf("%d", &n);
	printf("Input colons: ");	
	scanf("%d", &m);
	a = (int*)malloc(n*m*sizeof(int));

	for(i =0; i<n; i++){
		for(j= 0; j<m;j++){
			printf("a[%d][%d] : ", i,j);
			scanf("%d",(a + i*m + j));
		}
	}
	showMatrix(a, n ,m);

	

	
	printf("%d",seekNumOfStrLongestSeq(a, n, m));

	free(a);
}

int seekNumOfStrLongestSeq(int *a, int n, int m){
	int maxl=0,l,strNum;

	for(int i=0;i<n;i++){
		l=0;
		for(int j=0;j<m;j++){
			l=0;
			for(int e=j; e<m-1; e++){
				if(*(a + i*m + e) == *(a + i*m + e+1)){
					l+=1;
				}
				if(l>maxl){
					maxl=l;
					strNum=i;
				}
			}
		}
	}
	return strNum;
}

void tryGess(){
	int l = 1, r =10, m ,flag;
	printf("Make up the number from %d to %d \n", l ,r);
	while(1){
		m = (r+ l)/2;
		printf("If it is yours : %d , press '0'\nif it is so hight press 1,\nif it is so low, press -1\n", m);
		scanf("%d", &flag);
		if(flag == 0){
			break;
		}
		if(flag == 1){
			r = m-1;
		}
		if(flag == -1){
			l = m+1;
		}
		else{
			continue;
		}
	}

}