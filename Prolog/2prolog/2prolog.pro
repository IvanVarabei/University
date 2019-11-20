predicates
	nondeterm roditel(string,string)
clauses
roditel("Ivan","Nina").
roditel("Ivan","Oleg").
roditel("Anna","Nina").
roditel("Anna","Oleg").
roditel("Oleg","Alla").
roditel("Oleg","Lara").
roditel("Vera","Lara").
roditel("Vera","Alla").
roditel("Lara","Nata").
roditel("Vik","Nata").
goal
	%roditel("Ivan","Nina").
	%roditel("Ivan","Alla").
	%roditel(Z,"Lara").
	%roditel("Oleg",X).
	%roditel(X,Y),roditel(Y,"Nata"). 
	%roditel(Y,X).
	%roditel(X,"Oleg"),roditel(X,"Nina").
	%roditel("Ivan",X),roditel(Y,X).
	roditel(X,Y),roditel("Anna",X).
	%roditel(X,"Lara"),roditel(X,Y).
	