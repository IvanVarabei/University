#include "view.c"
#include "model.h"

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
	int i=8,cur;
	while(1){
		showText1();
		scanf("%d", &cur);
		if(cur==i){
			showText2();
			break;
		}
		if(cur>i){
			showText3();
		}
		if(cur<i){
			showText4();
		}
	}
}




