#include<iostream>
#include<fstream>
using namespace std;
struct NOTE {
	char *surname = new char;
	char *name = new char;
	int *d = new int[3];
	int salary;
};
void output(NOTE *ar, int k){
	for (int i = 0; i < k; i++){
		cout << "Element number " << i << "\n";
		cout << "Surname : " << ar[i].surname;
		cout << "\nName : " << ar[i].name << "\nDate : ";
		for (int k = 0; k < 3; k++)
			cout << ar[i].d[k] << ".";
		cout << "\nSalary : " << ar[i].salary << "\n\n";
	}
}
NOTE* write(int* size) {
	int number;
	cout << "Enter number of employees : ";
	cin >> number;
	*size = number;
	NOTE *ms = new NOTE[number];
	NOTE *ptr = ms;
	void *end = ms + number;
	do{
		cout << "\nEnter surname : "; cin >> ptr->surname;
		cout << "Enter name : "; cin >> ptr->name;
		cout << "Enter dd,mm,yyyy :"; cin >> ptr->d[0]; cin >> ptr->d[1]; cin >> ptr->d[2];
		cout << "Enter salary : "; cin >> ptr++->salary;
	} while (ptr<end);
	system("cls");
	return ms;
}
void selection(NOTE *ar, int k, bool fl){
	int i1, comparison = 0, permutation = 0;
	NOTE m;
	for (int i = 0; i < k - 1; i++){
		i1 = i;
		for (int j = i + 1; j < k; j++){
			if (fl){
				comparison++;
				if (strcmp(ar[i1].surname, ar[j].surname)>0)
					i1 = j;
			}
			else{
				comparison++;
				if (ar[i1].salary< ar[j].salary)
					i1 = j;
			}
		}
		if (i != i1){
			permutation++;
			m = ar[i];
			ar[i] = ar[i1];
			ar[i1] = m;
		}
	}
	output(ar, k);
	cout << "Comparisons=" << comparison << "\nPermutations=" << permutation;
}
void search_record(NOTE * arr, int key,int size){
	char *xnm = new char;
	switch(key){
	case 1:
		cout << "Enter searched name : ";
		cin >> xnm;
		for (int i= 0; i < size; i++){
			if (!strcmp(xnm, arr[i].name)){
				cout << "Surname : " << arr[i].surname;
				cout << "\nName : " << arr[i].name << "\nDate : ";
				for (int k = 0; k < 3; k++)
					cout << arr[i].d[k] << ".";
				cout << "\nSalary : " << arr[i].salary << "\n\n";
			}
		}
		break;
	case 2:
		int x, left = 0, right = size;
		cout << "Enter searched salary : ";
		cin >> x;
		int midd = 0;
		while (1)
		{
			midd = (left + right) / 2;
			if (x > arr[midd].salary)       // если искомое больше значения в ячейке
				right = midd - 1;      // смещаем правую границу поиска
			else if (x < arr[midd].salary)  // если искомое меньше значения в ячейке
				left = midd + 1;    // смещаем левую границу поиска
			else{                     // иначе (значения равны)
				cout << "Surname : " << arr[midd].surname;
				cout << "\nName : " << arr[midd].name << "\nDate : ";
				for (int k = 0; k < 3; k++)
					cout << arr[midd].d[k] << ".";
				cout << "\nSalary : " << arr[midd].salary << "\n\n";       
				break;
			}
			if (left > right){          // если границы сомкнулись 
				cout << "Element not exist.\n";
				break;
			}
		}
	}
}
void main(){
	bool fl = true;
	int size=1, *num=&size,key;
	NOTE *mass = new NOTE,xxx;
	mass=write(num);
	cout << "Entering was complet.\n";
	size = *num;
	cout << "\nMassive in the ferst state :\n\n";
	output(mass, size);
	cout << "\nSELECTION sort by salary :\n\n";
	selection(mass, size, false);
	do{
		cout << "\n1)Name(unsorted)\t2)Salary(sorted)\t3)STOPE\nEnter key to search : "; cin >> key;
		search_record(mass, key, size);
	} while (key != 3);
	system("pause");
}
/*bool if_sorted (NOTE* arr, int key, int size){
int flag = 0;
switch (key)
{
case 1:
for (int i = 1,j=0; i < size; i++){
if (arr[i].name > arr[i - 1].name)
j++;
if (j == size)
return 1;
}
for (int i = 1, j = 0; i < size; i++){
if (arr[i].name < arr[i - 1].name)
j++;
if (j == size)
return 1;
else
return 0;
}
break;
case 2:
for (int i = 1, j = 0; i < size; i++){
if (arr[i].salary > arr[i - 1].salary)
j++;
if (j == size)
return 1;
}
for (int i = 1, j = 0; i < size; i++){
if (arr[i].salary < arr[i - 1].salary)
j++;
if (j == size)
return 1;
else
return 0;
}
break;
}
}*/