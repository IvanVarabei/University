%C:\Users\Asus\AppData\Local\Temp
%floss
domains
	db_selector = data_file
	student=stdinfo(integer,string,integer)
predicates
	nondeterm lastsym(string,string)
	nondeterm repeat
	nondeterm main_menu
	nondeterm process(integer) %(i)
	print_first
	nondeterm looktree(integer) %(i)
	addNew
	open(bt_selector,bt_selector,bt_selector) %(0,0,0)
	close(bt_selector,bt_selector,bt_selector) %(i,i,i)
	nondeterm delete_term(student) %(i)
	nondeterm createDB(string) %(i)
	nondeterm openDB(string) %(i)
	nondeterm show_bt(bt_selector) %(i)
	nondeterm up_number(bt_selector) %(i)
	nondeterm down_average(bt_selector) %(i)
	nondeterm search(char,ref) %(i,i)
clauses
	lastsym(S,C):-frontstr(1,S,C,R), R="",!.
	lastsym(S,C):-frontstr(1,S,_,Q), lastsym(Q,C).
	repeat.
	repeat:-repeat.
	main_menu:-repeat,
		write(">>--------------------------------------<<"),nl,
		write(" 1:> Создать БД"),nl,
		write(" 2:> Открыть БД"),nl,
		write(" 3:> Просмотреть список"),nl,
		write(" 4:> Добавить запись"),nl,
		write(" 5:> Удалить зпись"),nl,
		write(" 6:> Просмотр содержимого В+ дерева"),nl,
		write(" 7:> Вывод фамилий студентов в порядке возрастания номеров зачетной книжки"),nl,
		write(" 8:> Вывод фамилий студентов в алфавитном порядке"),nl,
		write(" 9:> Вывод фамилий студентов в порядке убывания среднего балла"),nl,
		write(" 10:>Выбрать из базы данных фамилии, заканчивающиеся на заданную букву"),nl,
		write(" 0:> Выход"),nl,
		write(">>--------------------------------------<<"),nl,
		write("---> "),readint(Choice),Choice<11,Choice>=0,process(Choice),Choice=0,!.
	
	%выход из программы	
	process(0):-db_close(data_file),
                    write("Press any key to exit."),
                    readChar(_),
                    exit.
                    
	%создание БД
	process(1):-write("Введите имя создающейся БД > "),
                    readln(Name),
                    concat(Name,".dba",File), %соединение с расширением dba
                    createDB(File). %создание БД
                    
	%открыть БД
	process(2):-db_close(data_file), %закрытие текущей БД
                    write("Введите имя БД > "),
                    readln(Name),
                    concat(Name,".dba",File), %соединение с расширением dba
                    openDB(File). %открытие БД
                    
	%печать списка
	process(3):-write("-------------->Группа 10701118<--------------\n"), 
		    write(" Номер зачетки ;  Фамилия ; Средния балл \n"),
					print_first.
	
	%добавить запись
	process(4):-addNew,
                    write("Информация добавлена "),nl.
	
	%удалить запись
	process(5):-write("Введите данные для удаления\n"),
                    write("Фамилия :> "),readln(F),
                    delete_term(stdinfo(_,F,_));
                    write("Удалено!\n").
	
	%просмотр одной части дерева
	process(6):-write("Выберите дерево (1,2,3) :> "),
                    readint(Ch),
                    looktree(Ch).
	
	%порядок возрастания зачеток
	process(7):-bt_open(data_file,"CardNumber",Bt_Num), %открытие ветви номеров зачеток
                    key_first(data_file,Bt_Num,_), %установка указателя на первый элемент
                    up_number(Bt_Num),
                    bt_close(data_file, Bt_Num). %закрытие ветви
	
	%по алфавиту
	process(8):-bt_open(data_file,"Fam",Bt_Fam), %открытие ветви фамилий
                    key_first(data_file,Bt_Fam,_), %установка указателя на первый элемент
                    up_number(Bt_Fam),
                    bt_close(data_file, Bt_Fam). %закрытие ветви
	
	%убывание среднего балла
	process(9):-bt_open(data_file,"Average",Bt_Av), %открытие ветви оценок
                    key_last(data_file,Bt_Av,_), %установка указателя на последний элемент
                    down_average(Bt_Av),
                    bt_close(data_file, Bt_Av).
	
	%вывод студентов чья фамилия начинается на опред.букву
	process(10):-write("Введите букву :> "),
                    readchar(Char),write(Char),nl,
                    db_chains(data_file,Chain), %поочередно свзяываем Сhain с іменамі цепочкі базы данных
                    chain_first(data_file,Chain,Ref), %установка на 1ую ветвь
                    search(Char,Ref).
	
	
	%открытие цепей дерева	
	open(Bt_Num,Bt_Fam,Bt_Av):-bt_open(data_file,"CardNumber",Bt_Num),%открытие цепи зачетки
                                  bt_open(data_file,"Fam",Bt_Fam), %открытие цепи фамилий
                                  bt_open(data_file,"Average",Bt_Av). %открытие цепи среднего балла
        %закрытие цепей дерева                          
	close(Bt_Num,Bt_Fam,Bt_Av):-bt_close(data_file,Bt_Num),
                                    bt_close(data_file,Bt_Fam),
                                    bt_close(data_file,Bt_Av).
	
	
	%создание Базы
	createDB(File):-existfile(File),
                        write("Файл с таким именем уже существует!\n"),
                        readchar(_),!.
	createDB(File):-db_create(data_file,File,in_file),
			bt_create(data_file,"CardNumber",Bt_Num,10,2),
			bt_create(data_file,"Fam",Bt_Fam,10,2),
			bt_create(data_file,"Average",Bt_Av,10,2),
			close(Bt_Num,Bt_Fam,Bt_Av),
			write("Новая база данных создана и открыта для записи\n"),
			readchar(_).
	
	%открытие Базы
	openDB(File):-existfile(File),
                      db_open(data_file,File,in_file),
                      write("База открыта.\n"),
                      readchar(_),!.
	openDB(_):-write("Файл не существует!\n"),
                   readchar(_).
        
        
        %печать списка
	print_first:-chain_terms(data_file,gr10701118,student,stdinfo(N,F,Av),_),%последовательный просмотр цепочки
                     write(N," ",F," ",Av),nl,fail;true.
	
	
	           
        
         %просмотр определнной ветки                                                         	
	looktree(1):-bt_open(data_file,"CardNumber",Bt_Num), %открытие ветки
                     show_bt(Bt_num), %отображение ветки
                     bt_close(data_file,Bt_num). %закрытие ветки
                     
	looktree(2):-bt_open(data_file,"Fam",Bt_fam),
                     show_bt(Bt_fam),
                     bt_close(data_file,Bt_fam).
                     
	looktree(3):-bt_open(data_file,"Average",Bt_av),
                     show_bt(Bt_av),
                     bt_close(data_file,Bt_av).
                     
                     
        %вывод ветві            
        show_bt(Bt):-
		key_current(data_file,Bt,Key,_),
          	write(Key),nl,fail.
      	show_bt(Bt):-
         	key_next(data_file,Bt,_),
          	show_bt(Bt).
        show_bt(_).
                   
        
        %сортировка по возрастанию/алфавиту
	up_number(Bt):-
          	key_current(data_file,Bt,_,Ref),%возвращает ключ с указателем на текущий элемент
          	ref_term(data_file,student,Ref,stdinfo(Num,Fam,Av)), %связывает Ref c stdinfo
          	write(Num," ",Fam," ",Av),nl,fail.
      	up_number(Bt):-
          	key_next(data_file,Bt,_),%перевод указателя на следующий элемент
          	up_number(Bt).
        up_number(_).
	
	
	%сортировка по убыванию (функционал аналогичен сортировке по возрастанию)
	down_average(Bt):-
          	key_current(data_file,Bt,_,Ref),
          	ref_term(data_file,student,Ref,stdinfo(Num,Fam,Av)),
          	write(Num," ",Fam," ",Av),nl,fail.
      	down_average(Bt):-
          	key_prev(data_file,Bt,_),
          	down_average(Bt).
        down_average(_).
          	
          	
        %добавление элемента
	addNew:-write("___________________________________________\n"),
		write("Номер зачетки > "),readint(N),
		write("Фамилия студента > "),readln(F),
		write("Средний балл > "),readint(Av),
		chain_insertz(data_file,gr10701118,student,stdinfo(N,F,Av),Ref), %запись элемента
		open(Bt_Num,Bt_Fam,Bt_Av),
			str_int(Name,N),key_insert(data_file,Bt_Num,Name,Ref), %добавление в дерево
			key_insert(data_file,Bt_Fam,F,Ref), %добавление в дерево
			str_int(Aver,Av),key_insert(data_file,Bt_Av,Aver,Ref), %добавление в дерево
		close(Bt_Num,Bt_Fam,Bt_Av).
        
        
        %удаление элемента из дерева                            
        delete_term(stdinfo(N,F,Av)):-chain_terms(data_file,gr10701118,student,stdinfo(N,F,Av),Ref), %последовательный проход по дереву
                                      open(Bt_Num,Bt_Fam,Bt_Av),%открытие опред. цепи
                                      str_int(Name,N),%получаем номер от имени
                                      key_delete(data_file,Bt_Num,Name,Ref), %удаляем из цепи зачеток
                                      key_delete(data_file,Bt_Fam,F,Ref), %удаляем из цепи фамилий
                                      str_int(Aver,Av),%номер среднего балла
                                      key_delete(data_file,Bt_Av,Aver,Ref), %удаляем из цепи среднего балла
                                      close(Bt_Num,Bt_Fam,Bt_Av), %закрытие цепи
                                      term_delete(data_file,gr10701118,Ref),fail. %удалчем из базы                                        
                                      	         
	
      	%поиск совпадений первой буквы фамилии и введенной буквы	
      	search(Char,Ref):-ref_term(data_file,student,Ref,stdinfo(N,F,Av)), %связывает Ref c stdinfo
                          %frontchar(F,NeedChar,_), %выделяем первый символ фамилии
                           lastsym(F,NeedChar), %выделяем первый символ фамилии
                           str_char(C1,Char),
                          NeedChar = C1,
			  writef("Номер зачетки: %d\nФамилия: %s\nСредний балл: %d\n",N,F,Av),fail.
	search(Char,Ref):-chain_next(data_file,Ref,Next),%переход на следующую запісь
                          search(Char,Next).
                                  

goal
	main_menu.
