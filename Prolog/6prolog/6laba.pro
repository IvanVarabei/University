/*domains 
list = integer*
list2 = real*
predicates
nondeterm sum(list,list2)
%sum(x,y)(integer*,real*):(i,o)
nondeterm read_list(list)
%read_list(x)(integer*):(i)
clauses
read_list([H|T]) :- readint(H),!,read_list(T).
read_list([]).
sum([],[]).
sum([A,B,C|T],[Sum|T1]):-Sum = (A+B+C)/3,sum(T,T1).
sum([A, B], [Sum]) :- Sum = (A+B)/3.
sum([A], [Sum]) :- Sum = A/3.
goal
write("Enter elements of list, empty string to stop : "),nl,
read_list(X),
sum(X,R).*/

%4.4
%4.13

domains
list=real*
predicates
nondeterm read_list(integer,list)
%read_list(x,r)(integer,real*):(i,o)
positive_elements(list,integer,list)
%positive_elements(real*,integer,real*):(i,i,o)
nondeterm result
clauses
read_list(0,[]).
read_list(N,[H|T]):-readreal(H),N1=N-1,read_list(N1,T).

positive_elements(_,0,[]):-!.
positive_elements([Head|Tail],N1,[Head|TailPositive]):-
Head > 0,N=N1-1,positive_elements(Tail,N, TailPositive),!.
positive_elements([_Head|Tail],N1, TailPositive):-
positive_elements(Tail,N1, TailPositive).

result:-write("Enter number of elements"),
write("N="),readint(N),
write("Enter instances of list:"),nl,
read_list(N,L),
write("Enter number of first positev elements"),
write("N1="),readint(N1),
write("Vergin list L="),
write(L),nl,
write("Positive list L1="),
positive_elements(L,N1,L1),
write(L1),nl.
goal
result.

/*domains
list=real*
predicates
nondeterm read_list(integer,list)
%read_list(x,r)(integer,real*):(i,o)
sdvig(list, list)
%sdvig(x,r)(real*,real*):(i,o)
conc(list, list, list)
%conc(x,r)(real*,real*,real*):(i,i,o)
nondeterm result
clauses
read_list(0,[]).
read_list(N,[H|T]):-readreal(H),N1=N-1,read_list(N1,T).

conc([],List,List).
conc([X|L1],List2,[X|L3]):-conc(L1,List2,L3).

sdvig( [X|L1],List2) :-conc(L1,[X], List2).

result:-write("Enter number of elements"),
write("N="),readint(N),
write("Enter instances of list:"),nl,
read_list(N,L),
write("Vergin list L="),
write(L),nl,
write("New list L1="),
sdvig( L ,L1),
write(L1),nl.
goal
result.*/


/*domains
list=real*
predicates
nondeterm read_list(integer,list)
nondeterm new_list(list,list)
nondeterm result
clauses
read_list(0,[]).
read_list(N,[H|T]):-readreal(H),N1=N-1,read_list(N1,T).
new_list([],[]).
new_list([H1|T1],[H2|T2]):-H2=H1*2,new_list(T1,T2).
result:-write("Enter number of elements"),nl,
write("N="),readint(N),nl,
write("Enter instances of list"),nl,
read_list(N,L),
new_list(L,L1),
write("Vergin list L="),
write(L),nl,nl,
write("New list L1="),
write(L1),nl.
goal
result.*/