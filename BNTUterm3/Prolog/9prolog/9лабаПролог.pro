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
    
    readln(Filename), %���������� �������� �����

    openwrite(datafile,Filename), %�������� ����� ��� ������
     
    writedevice(datafile), %������������� ���������� ������
        
    readin(String),%������� ������ � ����
    
    
    closefile(datafile), %�������� �����
    
    
    openread(datafile,Filename), %�������� ����� ��� ������
    
    readdevice(datafile), %������������� ���������� ������
    
    read_and_print,
    
    closefile(datafile). %�������� �����
    
readin(""):-!. %���� ������ �� �������


readin(String):-

    fronttoken(String,FirstChar,Ostatok), %�������� ������ �� ����� + ��������� ������
    
    concat("ITEM(",FirstChar,E), %�������� ������ ����(���
  
    concat(E,").\n",R), %�������� ������ ����(���) + ENTER
    
    write(R), %������ � ����
  
    readin(Ostatok). %����������� ������ � ���������� ������
    

read_and_print:-
    eof(datafile),!. %���� ���� ����������
    
read_and_print:-

    not(eof(datafile)), %���� �� ����� �����
    
    readln(String), %������ �� ����� 1�� ������
    
    write(String),nl, %���������� ����� �� �����
    
    writedevice (screen), %������������� ���������� ������ �� �����
    
    read_and_print. %����������� �����
    

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







