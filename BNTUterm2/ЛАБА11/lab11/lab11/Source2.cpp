#include<iostream>
using namespace std;
template<typename T>
T proc(T** m, int sz){
	T sum = 0;
	for (int i = 0; i < sz; i++)
		sum += m[i][i];
	return sum;
}
void main(){
	int size,ch=1;
	while (1){
		cout << "Enter type of data :\n1)int\n2)double\n3)to STOP program\n"; cin >> ch;
		if (ch == 3)
			break;
		cout << "Enter size of matrix : "; cin >> size;
		if (ch == 1){
			int **m1 = new int*[size];
			for (int i = 0; i < size; i++)
				m1[i] = new int[size];
			for (int i = 0; i < size; i++)
				for (int j = 0; j < size; j++){
					cout << "Enter element [" << i << "][" << j << "] :"; cin >> m1[i][j];
				}
			cout << "Suma=" << proc(m1, size) << endl;
		}
		else{
			double **m1 = new double*[size];
			for (int i = 0; i < size; i++)
				m1[i] = new double[size];
			for (int i = 0; i < size; i++)
				for (int j = 0; j < size; j++){
					cout << "Enter element [" << i << "][" << j << "] :"; cin >> m1[i][j];
				}
			cout <<"Suma="<<proc(m1, size) << endl;
		}
	}
	system("pause");
}