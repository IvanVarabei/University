domains

	student = student(integer, string, real)
	slist = string*
	db_selector = db

predicates

	nondeterm repeat
	nondeterm process(integer)
	nondeterm showUpByNumber(bt_selector)
	nondeterm showUpByLastName(bt_selector)
	nondeterm showUpByMark(bt_selector)
	nondeterm find_symbol(bt_selector, char)
	nondeterm find_terms(bt_selector)
	nondeterm delete_term(string, bt_selector)
	nondeterm show_menu
	nondeterm result
 	nondeterm start
 	nondeterm to_list(bt_selector,slist)
 	nondeterm choose(slist)
 	nondeterm select(string)
 	nondeterm check(char,string)

clauses
	start:-
		existfile("my.db"), !,
  		db_open(db, "my.db", in_file),
  		bt_open(db, "number", _),
  		bt_open(db,"lastName", _),
  		bt_open(db,"averageMark", _);
  		db_create(db, "my.db", in_file),
   	 	bt_create(db, "number", _,10, 4),
   	 	bt_create(db, "lastName", _,10, 4),
   	 	bt_create(db, "averageMark", _, 10, 4).

	result:-
		start,
		show_menu, nl,
		write("Нажмите любую клавишу..."),
		db_close(db),
		exit.

	repeat.
	repeat:-
		repeat.
	
	show_menu:-
		repeat,
		write("-------------------------------------------------"), nl,
		write("1   Создать БД."), nl,
		write("2   Открыть БД."), nl,
		write("3   Добавить студента."), nl,
		write("4   Вывести фамилии студентов в порядке возрастания номеров зачетной книжки."), nl,
		write("5   Вывести фамилии студентов в алфавитном порядке."), nl,
		write("6   Вывести фамилии студентов в порядке убывания среднего балла."), nl,
		write("7   Удаление студента."), nl,
		write("8   Фамилии студентов заканчивающиеся на заданную букву."), nl,
		write("9   Выход."), nl, 
		write("-------------------------------------------------"), nl, nl,
		write("Выберете операцию..."),
		readint(N),
		N<10, process(N), N=9, !.
	
	process(1):-
		db_close(db),
		write("Введите имя БД - "),
		readln(Name), 
		db_create(db, Name, in_file),
   	 	bt_create(db, "number", _,10, 4),
   	 	bt_create(db, "lastName", _,10, 4),
   	 	bt_create(db, "averageMark", _, 10, 4),
		write("БД открыта"),nl.
		
	process(2):-
		write("Введите имя БД - "),
		readln(Name),
		existfile(Name),
		db_close(db),
		db_open(db, Name, in_file),
  		bt_open(db, "number", _),
  		bt_open(db,"lastName", _),
  		bt_open(db,"averageMark", _),
		write("БД открыта"), nl, !;
		write("Нет БД"),nl, !.
			
	process(3):-
		bt_open(db, "number", Bt_number),
  		bt_open(db, "lastName", Bt_lastName),
  		bt_open(db, "averageMark", Bt_averageMark),
  		write("Введите фамилию... "),
 		readln(LastName),
 		write("Введите номер зачётной книжки..."),
 		readint(Number),
 		write("Введите средний балл..."),
 		readreal(Mark),
 		chain_inserta(db, "chain", student, student(Number, LastName, Mark), Ref),
 		str_int(StrNumber, Number),
 		key_insert(db, Bt_number, StrNumber, Ref),
 		key_insert(db, Bt_lastName, LastName, Ref),
 		str_real(StrMark, Mark),
 		key_insert(db, Bt_averageMark, StrMark, Ref),
 		bt_close(db,Bt_number),
 		bt_close(db, Bt_lastName),
 		bt_close(db, Bt_averageMark),
		write("Студент добавлен"), nl,
    		readchar(_).

	process(4):-
  		bt_open(db, "number", Bt_number),
  		key_first(db, Bt_number, _),
  		showUpByNumber(Bt_number),
 		bt_close(db, Bt_number). 

	process(5):-
  		bt_open(db, "lastName", Bt_lastName),
  		key_first(db, Bt_lastName, _),
  		showUpByLastName(Bt_lastName),
 		bt_close(db, Bt_lastName).

	process(6):-
  		bt_open(db, "averageMark", Bt_averageMark),
  		key_last(db, Bt_averageMark, _),
  		showUpByMark(Bt_averageMark),
 		bt_close(db, Bt_averageMark).

 	process(7):-
  		write("Введите фамилию..."),
		readln(LastName),
		bt_open(db, "number", Bt_number),
  		bt_open(db, "lastName", Bt_lastName),
  		bt_open(db, "averageMark", Bt_averageMark),
  		delete_term(LastName, Bt_number),
  		delete_term(LastName, Bt_lastName),
  		delete_term(LastName, Bt_averageMark),
  		db_chains(db, Chain),
  		chain_terms(db, Chain, student, student(_, LastName, _), Ref),
  		term_delete(db, Chain, Ref),
  		write("Студент удалён."), nl, nl. 

  		
  	process(8):-
  		write("Введите символ: "), nl,
  		readchar(C),
		write(C), 
		readchar(_), nl, 
		bt_open(db, "lastName", Bt_LName),
  		key_first(db, Bt_LName, _),
  		find_symbol(Bt_LName, C). 
  		
	process(9):-
		nl, write("Выход..."), nl.
		
		
	to_list(Bt_sel,[H|T]):-key_current(db,Bt_sel,H,_),key_next(db,Bt_sel,_),to_list(Bt_sel,T),!.
 	to_list(Bt_sel,[H]):-key_prev(db,Bt_sel,_),key_current(db,Bt_sel,H,_). 
 	
 	choose([H|T]):-upper_lower(H,H1),select(H1),choose(T),!; write(H),nl,choose(T),!.
 	choose([]).
 	
 	
 	select(S):-frontchar(S,_,""),!.
 	select(S):-frontchar(S,C,Ost),check(C,Ost),select(Ost); !,fail.
 	select("").
 	
 	check(C,S):-frontchar(S,CC,Ost), CC <> C,  check(C,Ost).
 	check(_,S):-frontchar(S,_,"").
		
	find_symbol(Bt_LName, C):-
 		key_current(db,Bt_LName,_,Ref),
 		ref_term(db, student, Ref, student(Numb, LastName, Mark)),
 		str_len(LastName, Len),
 		Len1=Len-1,
 		frontstr(Len1, LastName,Str,LastStr),
 		str_char(LastStr,LastChar),
 		upper_lower(C, C1),
 		upper_lower(LastChar, LastChar1),
 		C1 = LastChar1,
 		write(LastName,"\t",Numb, "\t", Mark),nl,
 		fail.
 	find_symbol(Bt_LName, C):-
 		key_next(db, Bt_LName,_),
 		find_symbol(Bt_Lname, C).
	find_symbol(_, _).
	
	find_terms(Bt_LName):-
 		key_current(db,Bt_LName,_,Ref),
 		ref_term(db, student, Ref, student(Numb, LastName, Mark)),
 		frontchar(LastName, FirstChar, Ost),
 		str_len(Ost, LenOst),
 		Int = LenOst - 1,
 		frontstr(Int, Ost, _, StrLastChar),
 		upper_lower(FirstChar, NFirstChar),
 		str_char(StrLastChar, LastChar),
 		LastChar = NFirstChar,
 		write(LastName," ",Numb, " ", Mark),nl,
 		fail.
 	find_terms(Bt_lastName):-
 		key_next(db, Bt_lastName,_),
 		find_terms(Bt_lastName).
	find_terms(_).

	delete_term(LastName, Bt_selector):-
		key_current(db, Bt_selector, Key, Ref),
		ref_term(db, student, Ref, student(_, LastName, _)),
		key_delete(db, Bt_selector, Key, Ref).
	delete_term(LastName, Bt_selector):-
		key_next(db, Bt_selector,_),
		delete_term(LastName, Bt_selector).

 	showUpByNumber(Bt_selector):-
 		key_current(db, Bt_selector, _, Ref),
 		ref_term(db, student, Ref, student(Number, LastName, _)),
 		write(LastName, "\t", Number),nl,
 		fail.
	showUpByNumber(Bt_selector):-
		key_next(db, Bt_selector, _),
		showUpByNumber(Bt_selector).
	showUpByNumber(_). 
	
	showUpByMark(Bt_selector):-
 		key_current(db, Bt_selector, _, Ref),
 		ref_term(db, student, Ref, student(_, LastName,M)),
 		write(LastName, "\t", M),nl,
 		fail.
	showUpByMark(Bt_selector):-
		key_prev(db, Bt_selector, _),
		
		showUpByMark(Bt_selector).
	showUpByMark(_). 

	showUpByLastName(Bt_selector):-
 		key_current(db, Bt_selector, _, Ref),
 		ref_term(db, student, Ref, student(_, LastName, _)),
 		write(LastName),nl,
 		fail.
	showUpByLastName(Bt_selector):-
		key_next(db, Bt_selector, _),
		showUpByLastName(Bt_selector).
	showUpByLastName(_).  
	
goal
	result.
