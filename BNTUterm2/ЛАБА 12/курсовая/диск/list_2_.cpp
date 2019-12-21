#include<iostream>
#include<string>
using namespace std;
struct list
{
	string name;
	int size, left, right; // поле данных
	struct list *next; // указатель на следующий элемент
	struct list *prev; // указатель на предыдущий элемент
};
struct spaces
{
	int size, left, right; // поле данных
	struct spaces *next; // указатель на следующий элемент
	struct spaces *prev; // указатель на предыдущий элемент
	struct list *lpr, *lnx;
};
list * init(int a, string name)  {
	struct list *lst;// выделение памяти под корень списка
	lst = new list;
	lst->size = a;
	lst->name = name;
	lst->left = 1;
	lst->right = a;
	lst->next = NULL; // указатель на следующий узел
	lst->prev = NULL; // указатель на предыдущий узел
	return(lst);
}
spaces * zero(){
	struct spaces *spc;// выделение памяти под корень списка
	spc = new spaces;
	spc->next = NULL; // указатель на следующий узел
	spc->prev = NULL; // указатель на предыдущий узел
	spc->size = 0;
	return(spc);
}
void change(spaces* spc, list* lst){
	spc->size = spc->size - lst->size;
	spc->lpr = lst;
}
void plus1(spaces* spc, list *lst){
	spc->size = spc->size + lst->size;
	spc->lpr = lst->prev;
	spc->lnx = lst->next;
}
list * addelem(list *lst, int number, string name)
{
	struct list *temp, *p;
	temp = new  list;
	p = lst->next; // сохранение указателя на следующий узел//
	lst->next = temp; // предыдущий узел указывает на создаваемый
	temp->size = number; // сохранение поля данных добавляемого узла
	temp->name = name;
	temp->next = p; // созданный узел указывает на следующий узел
	temp->prev = lst; // созданный узел указывает на предыдущий узел
	temp->left = lst->right + 1;
	temp->right = temp->left + number - 1;
	if (p != NULL)
		p->prev = temp;
	return(temp);
}
spaces * addsp(spaces *lst, int size, list*l)
{
	struct spaces *temp, *p;
	temp = new  spaces;
	p = lst->next; // сохранение указателя на следующий узел
	lst->next = temp; // предыдущий узел указывает на создаваемый
	temp->size = size; // сохранение поля данных добавляемого узла
	temp->next = p; // созданный узел указывает на следующий узел
	temp->prev = lst; // созданный узел указывает на предыдущий узел
	temp->left = lst->right + 1;
	temp->right = temp->left + size - 1;
	temp->lpr = l->prev;
	temp->lnx = l->next;
	if (p != NULL)
		p->prev = temp;
	return(temp);
}
void listprint(list *lst){
	struct list *p;
	p = lst;
	do {
		cout << "File name : " << p->name << ", size : " << p->size << " , from " << p->left << " to " << p->right << endl;
		p = p->next; // переход к следующему узлу
	} while (p != NULL); // условие окончания обхода
}
spaces * deletelem(list *lst, spaces *spc){
	spaces* temp;
	int fl = 0;
	if (spc->size == 0 && lst->next != NULL){
		plus1(spc, lst);
		fl = 1;
		temp = spc;
	}
	if (spc->lnx == lst || spc->lpr == lst){
		plus1(spc, lst);
		fl = 1;
		temp = spc;
	}
	if (fl == 0)
	{
		if (lst->next != NULL)
			temp = addsp(spc, lst->size, lst);
		else
			temp = spc;
	}
	struct list *prev, *next;
	prev = lst->prev; // узел, предшествующий lst
	next = lst->next; // узел, следующий за lst
	if (prev != NULL)
		prev->next = lst->next; // переставляем указатель
	if (next != NULL)
		next->prev = lst->prev; // переставляем указатель
	free(lst); // освобождаем память удаляемого элемента
	return(temp);
}
list * serch(list*lst, string n){
	struct list *p;
	p = lst;
	do {
		if (p->name == n)
			return p;
		p = p->next; // переход к следующему узлу
	} while (p != NULL); // условие окончания обхода
}
void main(int argc, char* argv[]) {
	string n, n1;
	spaces *fr = zero(), *frcur = fr;
	list *cur, *first;
	struct list *p, *p1;
	int sw, flag = 0, i = 0, fl = 1, f = 1;
	while (1){
		cout << "1)ADD\t2)del\t3)view\n";
		cin >> sw;
		switch (sw)
		{
		case 1:
			int s;
			while (1){
				cout << "Enter size in byte, 32 kbyte=32 768 byte : "; cin >> s;
				if (18 <= s&&s <= 32768)
					break;
				else
					cout << "Incorrect size. It must 17<Size<32769\n";
			}
			if (flag){
				if (368640 - cur->right - s < 0){
					p = p1 = first;
					p1 = p1->next;
					do {
						f = 1;
						if (p1->left - p->right >= s){
							f = 0;
							break;
						}
						p = p->next; // переход к следующему узлу
						p1 = p1->next;
					} while (p1->next != NULL); // условие окончания обхода
					if (f == 1){
						cout << "Out of memory\n";
						continue;
					}
				}
			}
			cout << "Enter name of file : "; cin >> n;
			if (!flag){
				first = init(s, n);
				cur = first;
			}
			else{
				fl = 1;
				struct spaces *p;
				p = fr;
				do {
					if (p->size >= s){
						change(p, addelem(p->lpr, s, n));
						fl = 0;
						break;
					}
					p = p->next; // переход к следующему узлу
				} while (p != NULL); // условие окончаобхода
				if (fl){
					cur = addelem(cur, s, n);
				}
			}
			i++;
			flag = 1;
			break;
		case 2:
			list *buf;
			cout << "Enter name of file, which you want to delete : "; cin >> n1;
			buf = serch(first, n1);
			if (buf->name == cur->name)
				cur = buf->prev;
			frcur = deletelem(buf, frcur);
			break;
		case 3:
			listprint(first);
			break;
		}
	}
	system("pause");
}
