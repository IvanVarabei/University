domains

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
  
    concat(E,")\n",R), %создание строки ИТЕМ(имя) + ENTER
    
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