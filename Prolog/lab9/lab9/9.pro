domains

    file = datafile
    str_list = string*

predicates

    nondeterm run
    nondeterm load_from_file(str_list) %(0)
    nondeterm output(str_list) %(i)
    nondeterm sort(str_list, str_list) %(i,0)
    nondeterm insert(string, str_list, str_list) %(i,i,0)

clauses

load_from_file([ ]) :- eof(datafile), !. %если конец файла

load_from_file([H | T]) :- not (eof(datafile)),

    readln(H), load_from_file(T). %если не конец фалйа, то считывается 1 строка

% вывод по 1 строке
output([]).
output([H|T]):-
    write(H,"\n"),
    output(T).

% Cортировка строк

sort([ ], [ ]).

sort([H | T], L) :- sort(T, S), insert(H, S, L).

%Вспомогательный предикат - вставка элемента на своё место

insert(X,[H | T],[H | T1]) :-

    Str_len(X,Len),
    
    Str_len(H,Len1),
    
    Len > Len1,!,
    
    insert(X, T, T1).
    
insert(X, T, [X | T]).

run :-

    write("Введите имя файла: \n"),
    
    readln(Filename),
    

    %считывание из файла

    openread(datafile, Filename),

    readdevice(datafile), %счітываніе із файла
    
    
    load_from_file(L), 
    
    
    closefile(datafile),nl,%закрытие файла
    
    
    write("Содержимое файла:\n"),
    
    output(L), nl,
    
    
    sort(L, L2),
    
    write("Отсортированный файл:\n"),
    
    output(L2),nl,
    
    
    write("Для завершения работы нажмите любую клавишу..."),nl,
    
    readchar(_).


goal
    run.