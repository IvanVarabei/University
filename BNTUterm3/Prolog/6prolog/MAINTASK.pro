domains 
	list = integer*
	list2 = real*
predicates
	nondeterm sum(list,list2).
	nondeterm read_list(list)
	
clauses

	read_list([H|T]) :- readint(H),!,read_list(T).
	read_list([]).

	sum([],[]).
	sum([A,B,C|T],[Sum|T1]):-Sum = (A+B+C)/3,sum(T,T1).
	sum([A, B], [Sum]) :- Sum = (A+B)/3.
	sum([A], [Sum]) :- Sum = A/3.
goal
	write("Enter the list of numbers: "),nl,
	read_list(X),
	sum(X,R).
	%write("List at the beging: ", X),nl,
	%write("List at the end: ", R),nl.
