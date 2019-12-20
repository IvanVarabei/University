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
		write("********************МЕНЮ************************"),nl,
		write("1 - Перевести русское слово на английское\t"),nl,
		write("2 - Перевести английское слово на русское\t"),nl,
		write("3 - Добавить новое слово в словарь\t"),nl,
		write("4 - Изменить перевод русского слова\t"),nl,	
		write("5 - Удаление записи из словаря\t"),nl,
		write("6 - Просмотр словаря\t"),nl,
		write("7 - Выбрать из словаря английские слова длинной меньше заданной. \t"),nl,
		write("0 - Выйти\t"),nl,nl,
		write("Выберите пункт меню:"),
		readln(C1),
		str_char(C1, C),
		process(C).
	process('1'):-
		nl,nl,write("Русский-английский"),nl,
		nl,write("Введите русское слово: "), readln(Russian),
		russian_word(Russian, Word),
		write("Перевод: ",Word), nl,
		nl,write ("Нажмите любую клавишу"),nl,nl,
		readchar(_),
	menu,nl.
	process('2'):-
		nl,nl,write("Английский-русский"),nl,
		nl,write("Введите английское слово: "),
		readln(Word),
		word_russian(Russian, Word),
		write("Перевод: ",Russian),nl,
		nl,write ("Нажмите любую клавишу"),nl,nl,
		readchar(_),
	menu,nl.
	process('3'):-
		nl,nl,write("Добавление записи :"),nl,
		nl,write("Введите слово на русском: "),
		readln(Russian),
		write("Перевод: "),
		readln(Word),
		assert(word(Russian,Word)),
		nl,write ("Нажмите любую клавишу"),nl,nl,
		readchar(_),
	menu,nl.
	process('4'):-
		nl,nl,write("Изменение перевода"),nl,
		write("Введите слово на русском: "),
		readln(Russian),
		write("Перевод: "),
		readln(Word),
		retract(word(Russian,_)),
		assert(word(Russian,Word)),
		nl,write ("Нажмите любую клавишу"),nl,nl,
		readchar(_),
	menu,nl.
	process('5'):-
		nl,nl,write("Удаление записи:"),nl,
		write("Введите слово на английском: "), nl,
		readln(Word),
		retract(word(_,Word)),
		write ("Нажмите любую клавишу"),
		readchar(_),	
	menu,nl.
	process('6'):-
		findall(Fact, fact(Fact), Facti),
		nl,nl,write(" Ваш словарь:"),nl,nl,
		write_bd(Facti),
		nl,write ("Нажмите любую клавишу"),nl,nl,
		readchar(_),
	menu,nl.
	process('7'):-
		findall(Fact, fact(Fact), Facti),
		nl,nl,write("Вывод слов на английском: "),nl,
		write("Введите длинну слова: "),nl,
		readint(N),
		out_by_eng(N, Facti),
		nl,write ("Нажмите любую клавишу"),nl,nl,
		readchar(_),
	menu,nl.
	process('0'):-
		save("C:\\maze\\Prolog\\11prolog\\DataBase.txt").
	process(_):- menu.
	russian_word(Russian,Word):-
		word(Russian,Word),!.
	russian_word(_,"Нет английского перевода").
	word_russian(Russian,Word):-
		word(Russian,Word).
	word_russian("Нет русского перевода ",_).
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
