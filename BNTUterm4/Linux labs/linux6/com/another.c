#include "another.h"
#include <stdio.h>

int shedule(int  n){
	int l, r, i = 0;
	while(i<n){
		for(l=2; l<10; l++){
			for(r = 2; r<10; r++){
				if(l<=r){
					printf("%d*%d\n", l,r);
					i++;
					if(n==i)
						return 0;
				}
			}
		}
	}
	return 0;
}

