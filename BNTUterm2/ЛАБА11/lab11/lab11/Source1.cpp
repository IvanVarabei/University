/*#include<iostream>
using namespace std;
struct comp{
	double x;
	double i;
};
struct NOTE{
	char *surname = new char;
	char *name = new char;
	int *d = new int[3];
	int salary;
};
void output(int** m1, int size){
	cout << "\nMatrix :\n";
	for (int i = 0; i < size; i++){
		for (int j = 0; j < size; j++)
			cout << m1[i][j] << "\t";
		cout << "\n";
	}
}
void output(comp a){
	cout << "\nComplex number : " << a.x << "+" << a.i << "i\n";
}
void output(NOTE* reciv){
	cout << "Surname : " << reciv->surname;
	cout << "\nName : " << reciv->name << "\nDate : ";
	for (int k = 0; k < 3; k++)
	{
		cout << reciv->d[k] << ".";
	}
	cout << "\nSalary : " << reciv->salary << "\n\n";
}
void main(){
	int size;
	cout << "Enter size of matrix : "; cin >> size;
	int **m1 = new int*[size];
	for (int i = 0; i < size; i++)
		m1[i] = new int[size];
	for (int i = 0; i < size; i++)
		for (int j = 0; j < size; j++){
			m1[i][j]=rand();
		}
	output(m1,size);//ÂÛÇÎÂ ÔÓÍÊÖÈÈ
	comp a;
	cout << "Enter first complex number x,i : ";
	cin >> a.x;
	cin >> a.i;
	output(a);//ÂÛÇÎÂ ÔÓÍÊÖÈÈ

	int number;
	NOTE *ms = new NOTE;
	cout << "Enter surname : "; cin >> ms->surname;
	cout << "Enter name : "; cin >> ms->name;
	cout << "Enter dd,mm,yyyy :\n"; cin >> ms->d[0]; cin >> ms->d[1]; cin >> ms->d[2];
	cout << "Enter salary : "; cin >> ms->salary;
	output(ms);//ÂÛÇÎÂ ÔÓÍÊÖÈÈ
	system("pause");
}*/