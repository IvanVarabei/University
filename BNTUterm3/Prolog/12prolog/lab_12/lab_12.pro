domains
  		db_selector = vdb
  		name,surname,pol = string
  		day,month,year = integer
  		d = date(day,month,year)
  		st = student(name,surname,d,pol)
predicates
  		nondeterm repeat         
  		nondeterm menu
  		nondeterm process(integer)
  		nondeterm error
  		nondeterm start         
 
clauses

  start:-existfile("my.db"),
    	db_open(vdb,"my.db",in_file),
    	write("БД открыта"),nl;
    	db_create(vdb,"my.db",in_file),
    	write("БД создана"),nl.
    	   
  repeat.
  repeat:-repeat. 
  
  menu:-repeat,
    write("*************МЕНЮ*************"),nl,
    write("  1 - Фамилия и имя студентов, указанного пола (gr210)"),nl,
    write("  2 - Фамилия и имя студентов, родившихся в определенный месяц (gr210 и gr310)"),nl,
    write("  3 - Просмотр информации (gr210 или gr310)"),nl,
    write("  4 - Добавление информации"),nl,
    write("  5 - Удаление информации"),nl,
    write("  6 - Выбрать из всей БД фамилии и имена, где длина фамилии меньше длины имени"),nl,
    write("  7 - Выход"),nl,
    write("*********************************"),nl,
    write("Введите одну и цифр(1-7)"),nl,
    readint(X),%вводим номер пункта меню
    process(X),X=7,!.    
  
  
  process(1):-write("Введите пол студента (м/ж) -  "),
    	readln(Pol),%вводим пол студента
    	upper_lower(Pol,Pol1),
    	chain_terms(vdb, "gr210", st, student(Name, Surname, _, Pol1), _),
          write(Name, ' ', Surname, ' '),nl.
    
  process(2):-write("Введите месяц рождения - "),
  		     readint(Month),
    	     db_chains(vdb, Chain), 		         chain_terms(vdb,Chain,st,student(Name,Surname,date(_,Month,_),_),_),
    	     write(Surname,' ',Name), nl.       
    
  process(3):-write("Введите имя цепочки - "),
  		     readln(Name_chain),
  		     write("--------------------------------------------------\n"),
     		     chain_terms(vdb,Name_chain,st,student(Name,Surname,date(Day,Month,Year),Pol),_),
    	     write(Name,' ',Surname,"  ",Day,'.',Month,'.',Year,"   ",Pol),nl.
     
  process(4):-write("Введите имя цепочки - "),
  		     readln(Name_chain),
   		     write("Имя - "),     
   		     readln(Name),
   		     write("Фамилия - "), 
   		     readln(Surname),  
   		     write("Дата рождения:"), nl,    
   		     write("День - "), 
   		     readint(Day),    
   		     write("Месяц - "),
   		     readint(Month),    
    	     write("Год - "),
    	     readint(Year),    
   		     write("Пол (м/ж) - "),
   		     readln(Pol),
   		     upper_lower(Pol,Pol1), 
   		     chain_insertz(vdb,Name_chain,st,student(Name, Surname,date(Day, Month, Year), Pol1),_).
   	
  process(5):-write("Введите имя цепочки - "),
 		     readln(Name_chain),
    	     write("Введите фамилию - "),
    	     readln(Surname),
                 chain_terms(vdb,Name_chain, st, student(_,Surname,_,_),Ref),
    	     term_delete(vdb,Name_Chain,Ref),
    	     write(Surname," - удален"),nl.
   		    
 process(6):-db_chains(vdb,Chain),
   	  	   chain_terms(vdb,Chain,st,student(Name,Surname,_,_),_),
   	         str_len(Name,N),
   		   str_len(Surname,S), N>S,
   		   write(Name," ", Surname), nl.
   	
 process(7):-write("Работа закончена? (д/н)"),nl,
    	    readln(R),
    	    upper_lower(R,R),
    	    frontchar(R,'д',_),!. 
        
 process(X):-X<1,error;X>7,error.
     
 error:-write("Введенное число должно быть в диапазоне 1-7"),nl,
    	write("Нажмите любую кнопку!"),nl,nl,
    	readchar(_). %ожидание нажатия любой клавиши   

goal
  	  start,
  	  menu,
  	  db_close(vdb).










































/*
domains

db_selector = database1.
student = s(string, string, string, integer, integer, integer, string).

predicates

nondeterm res.
nondeterm menu.				
nondeterm process(integer).
nondeterm control_open_file(string).
nondeterm view_database.
nondeterm view_database2(ref).
nondeterm view_database3.
nondeterm add(integer).
nondeterm delete(integer).
nondeterm show(integer).
nondeterm show2(string).
nondeterm show3(integer).
nondeterm letter.
nondeterm check(string,string,char).

nondeterm rav(string,char,char).

clauses

res:- menu.

%меню программы
menu:- nl, write ("*******************"), nl,
write ("0. Выход"), nl, 
write ("1. Cоздать базу данных"), nl,
write ("2. Просмотреть базу данных"), nl, 
write ("3. Добавление элементов в базу данных"), nl,  
write ("4. Удаление базы данных"), nl, 
write ("5. Удаление элемента из базы данных"), nl, 
write ("6. Основное задание"), nl, 
write ("7. Индивидуальное задание - поиск фамилиий, которые содержат заданную букву"), nl,
write ("8. Просмотр цепочки"), nl,nl,
write ("*******************"), nl, 
write ("Введите пункт меню"), nl, readint (X), process(X), !.

process(0).
process(1):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), db_create(database1, FileAddress, in_file),  
db_close(database1), menu.

process(2):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), control_open_file(FileAddress), 
db_open(database1, FileAddress, in_file), view_database, db_close(database1), menu.

process(3):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), control_open_file(FileAddress), 
db_open(database1, FileAddress, in_file), add(1), db_close(database1), menu.

process(4):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), control_open_file(FileAddress), 
db_delete(FileAddress, in_file), nl, write("База данных удалена"), nl, menu.

process(5):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), control_open_file(FileAddress), db_open(database1, FileAddress, in_file),
db_statistics(database1, CountTerms, _, _, _), delete(CountTerms), db_close(database1), menu.

process(6):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), control_open_file(FileAddress), 
db_open(database1, FileAddress, in_file), nl, write("Работа с одной цепочкой(введи 1) / Работа с двумя цепочками(введи 2)"), nl, readint(Chain), nl,  show(Chain).

process(7):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), control_open_file(FileAddress), 
db_open(database1, FileAddress, in_file), nl, letter, db_close(database1), menu.

process(8):- nl, write("Введите имя базы данных"), nl, readln(FileAddress), control_open_file(FileAddress), 
db_open(database1, FileAddress, in_file), view_database3, db_close(database1), menu.

% работа с цепочками данных
show(0):- db_close(database1), menu.
show(1):- write("Выберите пол м/ж"), nl, readln(S), nl, show2(S),
write("Работа с одной цепочкой(введи 1) / работа с двумя цепочками(введи 2) или 0 для выхода"), nl, readint(Chain), show(Chain).
show(2):- write("Выберите месяц"), nl, readint(Month), nl, show3(Month),
write("Работа с одной цепочкой(введи 1) / работа с двумя цепочками(введи 2)  или 0 для выхода"), nl, readint(Chain), show(Chain).
show(_):- write("Ошибка"), nl, nl, write("Работа с одной цепочкой(введи 1) / работа с двумя цепочками(введи 2) или 0 для выхода"), nl, 
readint(Chain), nl, show(Chain).

show2(S):- chain_terms(database1, "gr215", student, s(F, I, O, Day, Month, Year, S), _), 
write("Фамилия: ", F), nl, write("Имя: ", I), nl, write("Отчество: ", O), nl, 
write("Дата рождения: ", Day,".", Month, ".", Year), nl, fail.
show2(_).

show3(Month):- db_chains(database1, Chain), chain_terms(database1, Chain, student, s(F, I, O, Day, Month, Year, _), _), 
write("Фамилия: ", F), nl, write("Имя: ", I), nl, write("Отчество: ", O), nl, 
write("Дата рождения: ", Day,".", Month, ".", Year), nl, nl, fail.
show3(_).

% проверка существования файла
control_open_file(FileAddress):- existfile(FileAddress).
control_open_file(FileAddress):- not(existfile(FileAddress)), nl, write("Ошибка. база данных не найдена"), nl, menu.

% просмотр базы данных
view_database:- db_statistics(database1, CountTerms, _, _, _), nl, write("Количество элементов базы данных - ", CountTerms), 
nl, nl, db_chains(database1, Chain), write(Chain), nl, chain_first(database1, Chain, Ref), view_database2(Ref).
view_database.

view_database2(Ref):- ref_term(database1, student, Ref, s(F, I, O, Day, Month, Year, _)), nl, 
write("Фамилия: ", F), nl, write("Имя: ", I), nl, write("Отчество: ", O), nl, 
write("Дата рождения: ", Day,".", Month, ".", Year), nl, nl, fail.
view_database2(Ref):- chain_next(database1, Ref, Next), view_database2(Next).

view_database3:- write("Введите название цепочки"),readln(Chain), nl, chain_first(database1, Chain, Ref), view_database2(Ref).
view_database3.

add(0).
add(1):- nl, write("Фамилия: "), readln(F), write("Имя: "), readln(I), write("Отчество: "), readln(O),  
write("Дата рождения"), nl, write("День: "), readint(Day), write("Месяц: "), readint(Month), write("Год: "), readint(Year), write("Пол: м/ж "), readln(S), nl, nl,

write("Цепочка "), readln(Chain), nl, chain_insertz(database1, Chain, student, s(F, I, O, Day, Month, Year, S), _), 
write("Ввести данные 0 - нет 1- да"), nl, readint(Ask), add(Ask).

delete(0):-  write("База данных пустая"), nl, menu.
delete(_):-  db_chains(database1, Chain), nl, write("Фамилия: "), readln(F), nl, 
chain_terms(database1, Chain, student, s(F, _, _, _, _, _, _), Ref), term_delete(database1, Chain, Ref), fail.
delete(_).

letter:- write("Введите букву - "),readchar(Letter1),write(Letter1),nl,upper_lower(Letter1,Letter),db_chains(database1, Chain),
		     chain_terms(database1,Chain,student,s(F,_,_,_,_,_,_),_),NF = F,check(F,NF,Letter).
		     
		     
letter.  
rav(F,Ch,Let):- Ch=Let, write(F), nl, fail, menu.
rav(_,C,L):-C<>L.
check(_,NF,_):-str_len(NF,N),N<0, write("Буква не встречается ни в одной из фамилий"),!, nl, fail, menu.	
check(F,NF,Letter):-str_len(NF,N),N>0,frontchar(NF,Char1,F1), upper_lower(Char1,Char),rav(F,Char,Letter), Char<>Letter, check(F,F1,Letter).



goal
res.
*/