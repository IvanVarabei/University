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
    
        write("���������� ������: ",H),nl,
        
        write("������� �� ����� ������ ��������: "),
        
        readln(S),
        
        H1 = S,
        
        edit_file(T,T1).
        
    
    
    write_file([]):-!.
    
    write_file([H|T]):-
    
        write(H,"\n"),
        
        write_file(T).
    
    
    
    result:-
    
        menu_show,
        
        write("\n������� ����� �������...\n"),
        
        readchar(_).
    
    repeat.
    
    repeat:-repeat.
    
    
    
    menu_show:-
    
        repeat,nl,
        
        write("\n1)������� ����\n"),
        
        write("2)���������� ����\n"),
        
        write("3)�������������� �����\n"),
        
        write("4)�������� �����\n"),
        
        write("5)�������� �����\n"),
        
        write("6)����� �� ����\n"),
        
        write("(1-6):"),
        
        readInt(N),
        
        N<7, N>0,
        
        process(N),
        
        N=6,!.
        
        
    
    process(1):-
    
        write("������� ��� ������ �����: "),
        
        readln(Name),
        
        write("������� ���������� ������� ���� ��������� � ����: "),
        
        readln(S),
        
        file_str(Name,S),
        
        write("���� ������, ������ ��������. ������� �. �������\n"),
        
        readchar(_).
        
    
    process(2):-
    
        write("��������� ������������ ����:\n "),
        
        write("������� ��� �����: "),
        
        readln(Name),
        
        existfile(Name),
        
        file_str(Name,TempStr),
        
        write("������� ������ ��� ����������:"),
        
        readln(AddStr),
        
        concat(TempStr,"\n",S_new),
        
        concat(S_new,AddStr,SfileWrite),
        
        file_str(Name,SfileWrite),
        
        write("������ ������� �������! ������� ����� ������� "),
        
        readchar(_),!.
        
    
    process(2):-
    
        write("\n ���� �� ������. ������� ����� �������"),
        
        readchar(_),!.
    
    
    process(3):-
    
        write("\n �������������� �����\n "),
        
        write("������� ��� �����: "),
        
        readln(Name),
        
        existfile(Name),
        
        write("���������� �����:\n "),
        
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
        
        write("���� ��������������! ������� ����� �������:\n "),
        
        readchar(_),!.
    
    
    process(4):-
    
        write("\n�������� ����������� �����"),
        
        write("\n������� ��� �����: "),
        
        readln(Name),
        
        existfile(Name),
        
        file_str(Name,TempStr),
        
        write(TempStr),nl,
        
        write("������� ����� ��������: "),
        
        readchar(_),!.
    
    process(4):-
    
        write("\n���� �� �������! ������� ����� �������"),
        
        readchar(_),!.
    
    
    process(5):-
    
        write("\n�������� �����"),
        
        write("\n������� ��� ����� ��� ��������: "),
        
        readln(Name),
        
        existfile(Name),
        
        deletefile(Name),
        
        write("���� ������� �����. ������� ����� �������"),
        
        readchar(_),!.
    
    process(5):-
    
        write("\n���� �� ������! ������� ����� �������"),
        
        readchar(_),!.
        
    
    process(6):-
    
        write("\n����� �� ����\n").
  
goal
    result.
