/*domains
%C:\Users\Asus\AppData\Local\Temp
%any name of file
    file=datafile
    list=string*

predicates

    nondeterm readin(string) 
    nondeterm create_a_file(string). 
    nondeterm read_and_print

clauses

create_a_file(String):-

    nl,write("Enter name of file:"),nl,
    
    readln(Filename), %считывание название файла

    openwrite(datafile,Filename), %открытие файла для записи
     
    writedevice(datafile), %переадресация устройства записи
        
    readin(String),%функция записи в файл
    
    
    closefile(datafile), %закрытие файла
    
    
    openread(datafile,Filename), %открытие файла для чтения
    
    readdevice(datafile), %переадресация устройства чтения
    
    read_and_print,
    
    closefile(datafile). %закрытие файла
    
readin(""):-!. %если ничего не введено


readin(String):-

    fronttoken(String,FirstChar,Ostatok), %разбиени строки на слово + остальная строка
    
    concat("ITEM(",FirstChar,E), %создание строки ИТЕМ(имя
  
    concat(E,").\n",R), %создание строки ИТЕМ(имя) + ENTER
    
    write(R), %запись в файл
  
    readin(Ostatok). %рекурсивная работа с оставшейся частью
    

read_and_print:-
    eof(datafile),!. %если файл закончился
    
read_and_print:-

    not(eof(datafile)), %если не конец файла
    
    readln(String), %чтение из файла 1ой строки
    
    write(String),nl, %построчный вывод на экран
    
    writedevice (screen), %переадресация устройства записи на экран
    
    read_and_print. %рекурсивный вызов
    

goal

write("Enter words with a space: "),nl,
readln(String),
create_a_file(String),nl.
*/

/*
%4.6
%the same path
%lab9f
domains
    file = datafile
predicates
    nondeterm read_file
    nondeterm number_str(integer)
clauses
read_file:-
    write("Enter file name : "),
    readln(Filename),
    write("Enter length: "),
    readint(L),
    openread(datafile,Filename),
    readdevice(datafile),
    number_str(L),
    closefile(datafile).
    
number_str(L):- 
    not(eof(datafile)),
    readln(Str),
    str_len(Str,Len),
    Len<L,
    write(Str),nl,
    number_str(L);
    not(eof(datafile)),
    number_str(L).
number_str(_):- eof(datafile).
                 
 
goal
read_file.
*/



%4.18
%the same path
%lab9f
domains
    file = datafile
predicates
    nondeterm read_file
    nondeterm number_str
clauses


read_file:-
    write("Enter file name : "),
    readln(Filename),
    openread(datafile,Filename),
    readdevice(datafile),
    number_str,
    closefile(datafile).
    
number_str:- 
    not(eof(datafile)),
    readln(Str),
    str_len(Str,Len),
    Len1=Len-1,
    frontstr(Len1, Str, _,R2),
    R2=".",
    write(Str),nl,
    number_str;
    not(eof(datafile)),
    number_str.
number_str:- eof(datafile).
                 
 
goal
read_file.







