//Variant 9 lab 8 Varabei
#include<stdio.h>
#include<iostream>
using namespace std;
void task1(int *m)
{
int max=0, maxnum=0,j=0,indmax;
	for(int i=0;i<100;i++)
	{
		if(*(m+i)<0 && *(m+i+1)<0)
		{
			j++;
			if (j>maxnum)
			{
				indmax=i+1;
				maxnum=j;
			}
			if(*(m+i+2)>=0)
			{	
				if(j>=max)
					max=j;
				j=0;
			}
		}
	}
	for(int i=indmax-max; *(m+i)<0;i++)
	{
		cout<<*(m+i)<<" ";
	}
}

void task2(int *m)
{
	int m1[25][4],i1=0;


		for(int i=0;i<25;i++)
			for(int j=0;j<4;j++)
				*(*(m1+i)+j)=*(m+i1++);
	for(int i =0;i<25;i++)
		cout<<&*(*(m1+i)+0)<<"\t"<<*(*(m1+i)+0)<<"\n";


}

void task3()
{
	char ms[7][12][2];
	for(int x=0;x<7;x++)
		for(int y=0;y<12;y++)
			for(int z=0;z<2;z++)
				*(*(*(ms+x)+y)+z)=rand()%'Z'+'A';

}
void main()
{
	int m[100]={16,78,99,6,-29,19,-52,65,-88,51,
				-79, -22,32, -25, -62, -69,-2, -59, -75,89,
				-87,95,-22,85,-49, -75,76,73,-59, -52,
				30,49, -28, -48,0,57,-6, -85,0, -18,
				-97, -21, -95,64,22,-2,69, -84,-1, -71,
				-25,47,72,43,15, -44,44,61,4,74,
				88, -61,0, -64, -83,97, 0,90,15,8,
				-54,19,73,35, -67, -87,85, -99, -70,10,
				98,58, -10, -29,95,62,77,89,36, -32,
				78,60, -79, -18,30, -13, -34, -92,1, -38};
	//task1(m);
	//task2(m);
	task3();
	system("pause");
}