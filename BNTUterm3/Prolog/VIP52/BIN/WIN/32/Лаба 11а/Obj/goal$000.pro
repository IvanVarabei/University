domains
	file = f1
	list = string*
predicates
	nondeterm result
	nondeterm vybor_chet(list,list)
	nondeterm sort(list,list)
	nondeterm insert(string,list,list)
	nondeterm concaten(list,list,list)
	nondeterm convert(string,list)
	nondeterm convert1(list,string)
	nondeterm search(string,integer)
clauses
	convert("",[]).
	convert(Str,[H|T]):-fronttoken(Str,H,Ost),convert(Ost,T).
	
	sort([],[]).
	sort([H|T],Lr):- sort(T,Tr), insert(H,Tr,Lr).
	
	insert(E,[],[E]).
	insert(E,[H|T],[E,H|T]):-frontchar(E,C1,_),frontchar(H,C2,_),C1<=C2.
	insert(E,[H|T],[H|T1]):-frontchar(E,C1,_),frontchar(H,C2,_),C1>C2,insert(E,T,T1).
	
	concaten([],L,L).
	concaten([H|T],L2,[H|T2]):-concaten(T,L2,T2).
	
	search("",0).
	search(S,K):-frontchar(S,H,STail),frontchar(STail,H,_),!,search(STail,K1),K = K1 +1.
	search(S,K):-frontchar(S,_,STail),search(STail,K).
                              
	vybor_chet([],[]).
	vybor_chet([H|T],[H|T1]):- str_len(H,N),N mod 2 = 0,vybor_chet(T,T1).
	vybor_chet([H|T],T1):- str_len(H,N),N mod 2 <> 0,vybor_chet(T,T1).
	
	convert1([],"").
	convert1([H|T],Str):- convert1(T,Str1),concat(H," ",H1),fronttoken(Str,H1,Str1).
	
	result:-
		write("Enter the name of file"),nl,readln(Filename),
		openread(f1,Filename),readdevice(f1),
		readln(_),readln(S2),readln(S3),
		file_str(Filename,Str),
		closefile(f1),
		convert(S2,L1),vybor_chet(L1,L11),
		convert(S3,L2),vybor_chet(L2,L21),
		concaten(L11,L21,Lres1),
		sort(Lres1,Lsortres1),
		convert1(Lsortres1,Str1),
		write("Your file: "),nl,write(Str),nl,
		write("The result of variant 10: Слова с четным количеством символов."),nl,write(Str1),nl.
		
goal
	result.