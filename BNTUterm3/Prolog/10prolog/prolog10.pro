%C:\Users\Asus\AppData\Local\Temp
%canas1
domains

    file = datafile
    li = string*

predicates

    nondeterm process(integer) %(i)
    nondeterm convert_file(li) %(0)
    nondeterm edit_file(li,li) %(i,0)
    nondeterm write_file(li) %(i)
    nondeterm menu_show
    nondeterm result
    nondeterm repeat

clauses

    convert_file([]):-eof(datafile),!.
    
    convert_file([H|T]):-
    
        not(eof(datafile)),
        
        readln(H),
    
        convert_file(T).
        
    
    
    edit_file([],[]):-!.
    
    edit_file([H|T],[H1|T1]):-
    
        write("Изменяемая строка: ",H),nl,
        
        write("Введите на какую строку заменить: "),
        
        readln(S),
        
        H1 = S,
        
        edit_file(T,T1).
        
    
    
    write_file([]):-!.
    
    write_file([H|T]):-
    
        write(H,"\n"),
        
        write_file(T).
    
    
    
    result:-
    
        menu_show,
        
        write("\nНажмите любую клавишу...\n"),
        
        readchar(_).
    
    repeat.
    
    repeat:-repeat.
    
    
    
    menu_show:-
    
        repeat,nl,
        
        write("\n1)Создать файл\n"),
        
        write("2)Дополонить файл\n"),
        
        write("3)Редактирование файла\n"),
        
        write("4)Просмотр файла\n"),
        
        write("5)Удаление файла\n"),
        
        write("6)Выход из меню\n"),
        
        write("(1-6):"),
        
        readInt(N),
        
        N<7, N>0,
        
        process(N),
        
        N=6,!.
        
        
    
    process(1):-
    
        write("Введите имя нового файла: "),
        
        readln(Name),
        
        write("Введите информацию которую надо сохранить в файл: "),
        
        readln(S),
        
        file_str(Name,S),
        
        write("Файл создан, данные записаны. Нажмите л. клавишу\n"),
        
        readchar(_).
        
    
    process(2):-
    
        write("Дополнить существующий файл:\n "),
        
        write("Введите имя файла: "),
        
        readln(Name),
        
        existfile(Name),
        
        file_str(Name,TempStr),
        
        write("Введите данные для добавления:"),
        
        readln(AddStr),
        
        concat(TempStr,"\n",S_new),
        
        concat(S_new,AddStr,SfileWrite),
        
        file_str(Name,SfileWrite),
        
        write("Данные успещно внесены! Нажмите любую клавишу "),
        
        readchar(_),!.
        
    
    process(2):-
    
        write("\n Файл не найден. Нажмите любую клавишу"),
        
        readchar(_),!.
    
    
    process(3):-
    
        write("\n Редактирование файла\n "),
        
        write("Введите имя файла: "),
        
        readln(Name),
        
        existfile(Name),
        
        write("Содержимое файла:\n "),
        
        file_str(Name,S),
        
        write(S),nl,
        
        openread(datafile,Name),
        
        readdevice(datafile),
        
        convert_file(L),
        
        readdevice(keyboard),
        
        closefile(datafile),
        
        openwrite(datafile,Name),
        
        edit_file(L,L1),
        
        writedevice(datafile),
        
        write_file(L1),
        
        closefile(datafile),
        
        writedevice(screen),
        
        write("Файл отредактирован! Нажмите любую калвишу:\n "),
        
        readchar(_),!.
    
    
    process(4):-
    
        write("\nПросмотр содержимого файла"),
        
        write("\nВведите имя файла: "),
        
        readln(Name),
        
        existfile(Name),
        
        file_str(Name,TempStr),
        
        write(TempStr),nl,
        
        write("Нажмите любую кклавишу: "),
        
        readchar(_),!.
    
    process(4):-
    
        write("\nФайл не неайден! Нажмите любую калвишу"),
        
        readchar(_),!.
    
    
    process(5):-
    
        write("\nУдаление файла"),
        
        write("\nВведите имя файла для удаления: "),
        
        readln(Name),
        
        existfile(Name),
        
        deletefile(Name),
        
        write("Файл успешно удалён. Нажмите любую клавишу"),
        
        readchar(_),!.
    
    process(5):-
    
        write("\nФайл не найден! Нажмите любую клавишу"),
        
        readchar(_),!.
        
    
    process(6):-
    
        write("\nВыход из меню\n").
  
goal
    result.
