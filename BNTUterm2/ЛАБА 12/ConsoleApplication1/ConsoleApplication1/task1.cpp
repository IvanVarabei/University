/*#include<iostream>
#include<fstream>
using namespace std;
struct NOTE {
	char *surname = new char;
	char *name = new char;
	int *d = new int[3];
	int salary;
};
NOTE* read(int* num)
{
	NOTE *mass=new NOTE;
	ifstream in;
	in.open("9.txt",ios::binary|ios::in);
	int n = 0;
	for (;; n++){
		NOTE *ms1 = new NOTE;
		if (!in.read((char*)ms1, sizeof(NOTE)))
			break;
		mass[n] = *ms1;
	}
	in.close();
	*num = n;
	return mass;
}
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
void selection(NOTE *ar,int k,bool fl){
	int i1,comparison=0,permutation=0;
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
void shel(NOTE *ar, int k, bool fl){
	int flg, comparison = 0, permutation = 0;
	NOTE n;
	for (int gap = k / 2; gap > 0; gap = gap / 2)
		do{
			flg = 0;
			for (int i = 0, j = gap; j < k; i++, j++){
				if (fl){
					comparison++;
					if (strcmp(ar[i].surname, ar[j].surname)>0){
						permutation++;
						n = ar[j];
						ar[j] = ar[i];
						ar[i] = n;
						flg = 1;
					}
				}
				else{
					comparison++;
					if (ar[i].salary < ar[j].salary){
						permutation++;
						n = ar[j];
						ar[j] = ar[i];
						ar[i] = n;
						flg = 1;
					}
				}
			}
		} while (flg);
		output(ar, k);
		cout << "Comparisons=" << comparison << "\nPermutations=" << permutation;
}
int write() {
	int number;
	cout << "Enter number of employees : ";
	cin >> number;
	NOTE *ms = new NOTE[number];
	NOTE *ptr = ms;
	void *end = ms + number;
	do{
		cout << "\nEnter surname : "; cin >> ptr->surname;
		cout << "Enter name : "; cin >> ptr->name;
		cout << "Enter dd,mm,yyyy :"; cin >> ptr->d[0]; cin >> ptr->d[1]; cin >> ptr->d[2];
		cout << "Enter salary : "; cin >> ptr++->salary;
	} while (ptr<end);
	ofstream fout;
	fout.open("9.txt", ofstream::app | ios::binary | ios::out);
	for (int n = 0; n < number; n++)
		fout.write((char*)&ms[n], sizeof(NOTE));
	fout.close();
	cout << "Entering was complet, massiv has loaded into the file.\n";
	delete ms;
	return number;
}
void main(){
	bool fl = true;
	int size=1,*num=&size;
	NOTE *mass = new NOTE, *mass1 = new NOTE, *mass2 = new NOTE,*mass3 = new NOTE;
	write();
	mass=mass1=mass2=mass3=read(num);
	size=*num;
	cout << "\nMassive in the ferst state :\n\n";
	output(mass, size);
	cout << "SELECTION sort by surname :\n\n";
	selection(mass,size,true);
	cout << "\nSELECTION sort by salary :\n\n";
	selection(mass1, size,false);
	cout << "\nSHEL sort by surname :\n\n";
	shel(mass2, size, true);
	cout << "\nSHEL sort by salary :\n\n";
	shel(mass3, size, false);
	system("pause");
}
*/