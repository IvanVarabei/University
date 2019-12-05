domains

    file = datafile
    str_list = string*

predicates

    nondeterm run
    nondeterm load_from_file(str_list) %(0)

clauses

load_from_file([ ]) :- eof(datafile), !.

load_from_file([H | T]) :- not (eof(datafile)),

    readln(H), load_from_file(T).

run :-

    write("Введите имя файла: \n"),
    
    readln(Filename),

    %считывание из файла

    openread(datafile, Filename),

    readdevice(datafile),
    
    load_from_file(L),
    
    closefile(datafile),nl,
    
    write("Содержимое файла:\n"),
    
    write(L),nl.
    
goal
    run.