/*#include<iostream>
using namespace std;
struct comp{
	double x;
	double i;
};
int** product(int** m1, int** m2, int size)
{
	int **m3 = new int*[size];
	for (int i = 0; i < size; i++)
		m3[i] = new int[size];
	for (int i = 0; i < size; i++)
		for (int j = 0; j < size; j++){
			m3[i][j] = 0;
			for (int g = 0; g < size; g++)
				m3[i][j] += m1[i][g] * m2[g][j];
		}
	return m3;
}
comp product(comp a,comp b){
	comp ret;
	ret.x = a.x*b.x-a.i*b.i;
	ret.i = a.x*b.i + a.i*b.x;
	return ret;
}
void main(){
	int size;
	cout << "Enter size of matrix : "; cin >> size;
	int **m1 = new int*[size], **m2 = new int*[size], **m3 = new int*[size];
	cout << "\nFerst matrix :\n";
	for (int i = 0; i < size;i++)
		m1[i] = new int[size];
	for (int i = 0; i < size; i++)
		for (int j = 0; j < size; j++){
			cout << "Enter element [" << i << "][" << j << "] :"; cin >> m1[i][j];
		}
	cout << "\nSecond matrix :\n";
	for (int i = 0; i < size; i++)
		m2[i] = new int[size];
	for (int i = 0; i < size; i++)
		for (int j = 0; j < size; j++){
			cout << "Enter element [" << i << "][" << j << "] :"; cin >> m2[i][j];
		}
	for (int i = 0; i < size; i++)
		m3[i] = new int[size];
	m3=product(m1,m2,size);//ÂÛÇÎÂ ÔÓÍÊÖÈÈ
	for (int i = 0; i < size; i++){
		for (int j = 0; j < size; j++)
			cout << m3[i][j] << "\t";
		cout << "\n";
	}
	comp a, b;
	comp composition;
	cout << "Enter first complex number x,i : ";
	cin >> a.x;
	cin >> a.i;
	cout << "Enter second complex number x,i : ";
	cin >> b.x;
	cin >> b.i;
	composition=product(a, b);
	cout << "\nComposition : " << composition.x << "+" << composition.i << "i\n";
	system("pause");
}*/

