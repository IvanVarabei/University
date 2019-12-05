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

load_from_file([ ]) :- eof(datafile), !. %���� ����� �����

load_from_file([H | T]) :- not (eof(datafile)),

    readln(H), load_from_file(T). %���� �� ����� �����, �� ����������� 1 ������

% ����� �� 1 ������
output([]).
output([H|T]):-
    write(H,"\n"),
    output(T).

% C��������� �����

sort([ ], [ ]).

sort([H | T], L) :- sort(T, S), insert(H, S, L).

%��������������� �������� - ������� �������� �� ��� �����

insert(X,[H | T],[H | T1]) :-

    Str_len(X,Len),
    
    Str_len(H,Len1),
    
    Len > Len1,!,
    
    insert(X, T, T1).
    
insert(X, T, [X | T]).

run :-

    write("������� ��� �����: \n"),
    
    readln(Filename),
    

    %���������� �� �����

    openread(datafile, Filename),

    readdevice(datafile), %��������� �� �����
    
    
    load_from_file(L), 
    
    
    closefile(datafile),nl,%�������� �����
    
    
    write("���������� �����:\n"),
    
    output(L), nl,
    
    
    sort(L, L2),
    
    write("��������������� ����:\n"),
    
    output(L2),nl,
    
    
    write("��� ���������� ������ ������� ����� �������..."),nl,
    
    readchar(_).


goal
    run.