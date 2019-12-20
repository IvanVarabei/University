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
		write(" 1:> ������� ��"),nl,
		write(" 2:> ������� ��"),nl,
		write(" 3:> ����������� ������"),nl,
		write(" 4:> �������� ������"),nl,
		write(" 5:> ������� �����"),nl,
		write(" 6:> �������� ����������� �+ ������"),nl,
		write(" 7:> ����� ������� ��������� � ������� ����������� ������� �������� ������"),nl,
		write(" 8:> ����� ������� ��������� � ���������� �������"),nl,
		write(" 9:> ����� ������� ��������� � ������� �������� �������� �����"),nl,
		write(" 10:>������� �� ���� ������ �������, ��������������� �� �������� �����"),nl,
		write(" 0:> �����"),nl,
		write(">>--------------------------------------<<"),nl,
		write("---> "),readint(Choice),Choice<11,Choice>=0,process(Choice),Choice=0,!.
	
	%����� �� ���������	
	process(0):-db_close(data_file),
                    write("Press any key to exit."),
                    readChar(_),
                    exit.
                    
	%�������� ��
	process(1):-write("������� ��� ����������� �� > "),
                    readln(Name),
                    concat(Name,".dba",File), %���������� � ����������� dba
                    createDB(File). %�������� ��
                    
	%������� ��
	process(2):-db_close(data_file), %�������� ������� ��
                    write("������� ��� �� > "),
                    readln(Name),
                    concat(Name,".dba",File), %���������� � ����������� dba
                    openDB(File). %�������� ��
                    
	%������ ������
	process(3):-write("-------------->������ 10701118<--------------\n"), 
		    write(" ����� ������� ;  ������� ; ������� ���� \n"),
					print_first.
	
	%�������� ������
	process(4):-addNew,
                    write("���������� ��������� "),nl.
	
	%������� ������
	process(5):-write("������� ������ ��� ��������\n"),
                    write("������� :> "),readln(F),
                    delete_term(stdinfo(_,F,_));
                    write("�������!\n").
	
	%�������� ����� ����� ������
	process(6):-write("�������� ������ (1,2,3) :> "),
                    readint(Ch),
                    looktree(Ch).
	
	%������� ����������� �������
	process(7):-bt_open(data_file,"CardNumber",Bt_Num), %�������� ����� ������� �������
                    key_first(data_file,Bt_Num,_), %��������� ��������� �� ������ �������
                    up_number(Bt_Num),
                    bt_close(data_file, Bt_Num). %�������� �����
	
	%�� ��������
	process(8):-bt_open(data_file,"Fam",Bt_Fam), %�������� ����� �������
                    key_first(data_file,Bt_Fam,_), %��������� ��������� �� ������ �������
                    up_number(Bt_Fam),
                    bt_close(data_file, Bt_Fam). %�������� �����
	
	%�������� �������� �����
	process(9):-bt_open(data_file,"Average",Bt_Av), %�������� ����� ������
                    key_last(data_file,Bt_Av,_), %��������� ��������� �� ��������� �������
                    down_average(Bt_Av),
                    bt_close(data_file, Bt_Av).
	
	%����� ��������� ��� ������� ���������� �� �����.�����
	process(10):-write("������� ����� :> "),
                    readchar(Char),write(Char),nl,
                    db_chains(data_file,Chain), %���������� ��������� �hain � ������ ������ ���� ������
                    chain_first(data_file,Chain,Ref), %��������� �� 1�� �����
                    search(Char,Ref).
	
	
	%�������� ����� ������	
	open(Bt_Num,Bt_Fam,Bt_Av):-bt_open(data_file,"CardNumber",Bt_Num),%�������� ���� �������
                                  bt_open(data_file,"Fam",Bt_Fam), %�������� ���� �������
                                  bt_open(data_file,"Average",Bt_Av). %�������� ���� �������� �����
        %�������� ����� ������                          
	close(Bt_Num,Bt_Fam,Bt_Av):-bt_close(data_file,Bt_Num),
                                    bt_close(data_file,Bt_Fam),
                                    bt_close(data_file,Bt_Av).
	
	
	%�������� ����
	createDB(File):-existfile(File),
                        write("���� � ����� ������ ��� ����������!\n"),
                        readchar(_),!.
	createDB(File):-db_create(data_file,File,in_file),
			bt_create(data_file,"CardNumber",Bt_Num,10,2),
			bt_create(data_file,"Fam",Bt_Fam,10,2),
			bt_create(data_file,"Average",Bt_Av,10,2),
			close(Bt_Num,Bt_Fam,Bt_Av),
			write("����� ���� ������ ������� � ������� ��� ������\n"),
			readchar(_).
	
	%�������� ����
	openDB(File):-existfile(File),
                      db_open(data_file,File,in_file),
                      write("���� �������.\n"),
                      readchar(_),!.
	openDB(_):-write("���� �� ����������!\n"),
                   readchar(_).
        
        
        %������ ������
	print_first:-chain_terms(data_file,gr10701118,student,stdinfo(N,F,Av),_),%���������������� �������� �������
                     write(N," ",F," ",Av),nl,fail;true.
	
	
	           
        
         %�������� ����������� �����                                                         	
	looktree(1):-bt_open(data_file,"CardNumber",Bt_Num), %�������� �����
                     show_bt(Bt_num), %����������� �����
                     bt_close(data_file,Bt_num). %�������� �����
                     
	looktree(2):-bt_open(data_file,"Fam",Bt_fam),
                     show_bt(Bt_fam),
                     bt_close(data_file,Bt_fam).
                     
	looktree(3):-bt_open(data_file,"Average",Bt_av),
                     show_bt(Bt_av),
                     bt_close(data_file,Bt_av).
                     
                     
        %����� ����            
        show_bt(Bt):-
		key_current(data_file,Bt,Key,_),
          	write(Key),nl,fail.
      	show_bt(Bt):-
         	key_next(data_file,Bt,_),
          	show_bt(Bt).
        show_bt(_).
                   
        
        %���������� �� �����������/��������
	up_number(Bt):-
          	key_current(data_file,Bt,_,Ref),%���������� ���� � ���������� �� ������� �������
          	ref_term(data_file,student,Ref,stdinfo(Num,Fam,Av)), %��������� Ref c stdinfo
          	write(Num," ",Fam," ",Av),nl,fail.
      	up_number(Bt):-
          	key_next(data_file,Bt,_),%������� ��������� �� ��������� �������
          	up_number(Bt).
        up_number(_).
	
	
	%���������� �� �������� (���������� ���������� ���������� �� �����������)
	down_average(Bt):-
          	key_current(data_file,Bt,_,Ref),
          	ref_term(data_file,student,Ref,stdinfo(Num,Fam,Av)),
          	write(Num," ",Fam," ",Av),nl,fail.
      	down_average(Bt):-
          	key_prev(data_file,Bt,_),
          	down_average(Bt).
        down_average(_).
          	
          	
        %���������� ��������
	addNew:-write("___________________________________________\n"),
		write("����� ������� > "),readint(N),
		write("������� �������� > "),readln(F),
		write("������� ���� > "),readint(Av),
		chain_insertz(data_file,gr10701118,student,stdinfo(N,F,Av),Ref), %������ ��������
		open(Bt_Num,Bt_Fam,Bt_Av),
			str_int(Name,N),key_insert(data_file,Bt_Num,Name,Ref), %���������� � ������
			key_insert(data_file,Bt_Fam,F,Ref), %���������� � ������
			str_int(Aver,Av),key_insert(data_file,Bt_Av,Aver,Ref), %���������� � ������
		close(Bt_Num,Bt_Fam,Bt_Av).
        
        
        %�������� �������� �� ������                            
        delete_term(stdinfo(N,F,Av)):-chain_terms(data_file,gr10701118,student,stdinfo(N,F,Av),Ref), %���������������� ������ �� ������
                                      open(Bt_Num,Bt_Fam,Bt_Av),%�������� �����. ����
                                      str_int(Name,N),%�������� ����� �� �����
                                      key_delete(data_file,Bt_Num,Name,Ref), %������� �� ���� �������
                                      key_delete(data_file,Bt_Fam,F,Ref), %������� �� ���� �������
                                      str_int(Aver,Av),%����� �������� �����
                                      key_delete(data_file,Bt_Av,Aver,Ref), %������� �� ���� �������� �����
                                      close(Bt_Num,Bt_Fam,Bt_Av), %�������� ����
                                      term_delete(data_file,gr10701118,Ref),fail. %������� �� ����                                        
                                      	         
	
      	%����� ���������� ������ ����� ������� � ��������� �����	
      	search(Char,Ref):-ref_term(data_file,student,Ref,stdinfo(N,F,Av)), %��������� Ref c stdinfo
                          %frontchar(F,NeedChar,_), %�������� ������ ������ �������
                           lastsym(F,NeedChar), %�������� ������ ������ �������
                           str_char(C1,Char),
                          NeedChar = C1,
			  writef("����� �������: %d\n�������: %s\n������� ����: %d\n",N,F,Av),fail.
	search(Char,Ref):-chain_next(data_file,Ref,Next),%������� �� ��������� �����
                          search(Char,Next).
                                  

goal
	main_menu.
