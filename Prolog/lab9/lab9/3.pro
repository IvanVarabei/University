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
  
    concat(E,")\n",R), %�������� ������ ����(���) + ENTER
    
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