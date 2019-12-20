DOMAINS
	russian, english = string
	file = f
	Fact=word(russian, english)
	Facti=Fact*
DATABASE
	word(russian, english)
PREDICATES
	nondeterm fact(Fact).
	nondeterm russian_word(russian, english).
	nondeterm word_russian(russian, english).
	nondeterm process(char).
	nondeterm menu.
	nondeterm result.
	nondeterm write_bd(Facti).
	nondeterm out_by_eng(integer, Facti).
CLAUSES
	menu:-
		write("********************����************************"),nl,
		write("1 - ��������� ������� ����� �� ����������\t"),nl,
		write("2 - ��������� ���������� ����� �� �������\t"),nl,
		write("3 - �������� ����� ����� � �������\t"),nl,
		write("4 - �������� ������� �������� �����\t"),nl,	
		write("5 - �������� ������ �� �������\t"),nl,
		write("6 - �������� �������\t"),nl,
		write("7 - ������� �� ������� ���������� ����� ������� ������ ��������. \t"),nl,
		write("0 - �����\t"),nl,nl,
		write("�������� ����� ����:"),
		readln(C1),
		str_char(C1, C),
		process(C).
	process('1'):-
		nl,nl,write("�������-����������"),nl,
		nl,write("������� ������� �����: "), readln(Russian),
		russian_word(Russian, Word),
		write("�������: ",Word), nl,
		nl,write ("������� ����� �������"),nl,nl,
		readchar(_),
	menu,nl.
	process('2'):-
		nl,nl,write("����������-�������"),nl,
		nl,write("������� ���������� �����: "),
		readln(Word),
		word_russian(Russian, Word),
		write("�������: ",Russian),nl,
		nl,write ("������� ����� �������"),nl,nl,
		readchar(_),
	menu,nl.
	process('3'):-
		nl,nl,write("���������� ������ :"),nl,
		nl,write("������� ����� �� �������: "),
		readln(Russian),
		write("�������: "),
		readln(Word),
		assert(word(Russian,Word)),
		nl,write ("������� ����� �������"),nl,nl,
		readchar(_),
	menu,nl.
	process('4'):-
		nl,nl,write("��������� ��������"),nl,
		write("������� ����� �� �������: "),
		readln(Russian),
		write("�������: "),
		readln(Word),
		retract(word(Russian,_)),
		assert(word(Russian,Word)),
		nl,write ("������� ����� �������"),nl,nl,
		readchar(_),
	menu,nl.
	process('5'):-
		nl,nl,write("�������� ������:"),nl,
		write("������� ����� �� ����������: "), nl,
		readln(Word),
		retract(word(_,Word)),
		write ("������� ����� �������"),
		readchar(_),	
	menu,nl.
	process('6'):-
		findall(Fact, fact(Fact), Facti),
		nl,nl,write(" ��� �������:"),nl,nl,
		write_bd(Facti),
		nl,write ("������� ����� �������"),nl,nl,
		readchar(_),
	menu,nl.
	process('7'):-
		findall(Fact, fact(Fact), Facti),
		nl,nl,write("����� ���� �� ����������: "),nl,
		write("������� ������ �����: "),nl,
		readint(N),
		out_by_eng(N, Facti),
		nl,write ("������� ����� �������"),nl,nl,
		readchar(_),
	menu,nl.
	process('0'):-
		save("C:\\maze\\Prolog\\11prolog\\DataBase.txt").
	process(_):- menu.
	russian_word(Russian,Word):-
		word(Russian,Word),!.
	russian_word(_,"��� ����������� ��������").
	word_russian(Russian,Word):-
		word(Russian,Word).
	word_russian("��� �������� �������� ",_).
	fact(word(Russian,English)):-	
		word(Russian, English).
	
	out_by_eng(_,[]).
	out_by_eng(N, [word(_,English)|L]) :-
		str_len(English,Len),Len<N,
		write(English),nl,
		out_by_eng(N, L).
	out_by_eng(N, [_|L]):-!,out_by_eng(N, L).
	write_bd([]).
	write_bd([word(Russian,English)|L]):-
		write(" ",Russian," - ", English),nl,
	write_bd(L).
	result:-
		existfile("C:\\maze\\Prolog\\11prolog\\DataBase.txt"),!,
		consult("C:\\maze\\Prolog\\11prolog\\DataBase.txt"),
	menu.
	result:-
		openwrite(f,"C:\\maze\\Prolog\\11prolog\\DataBase.txt"),
		closefile(f),
	menu.
GOAL
	result.
