/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demonstrates Static facts using

 ModuleName:	OBJECT & CLASSES
 FileName:	static.PRO
 PURPOSE:	static and non static facts
 Writen By :	Anna Bogdanova (Test Group)

******************************************************************************/
CLASS Count
STATIC FACTS - db1
  single countInstance( INTEGER )	%exists only one version for the class
FACTS - db2
  single eachInstance(STRING)		%generated for each instance 
PREDICATES
  procedure new(STRING)
  get_fact(INTEGER, STRING)	-	(o,o)
ENDCLASS

IMPLEMENT Count
CLAUSES
 countInstance( 0 ).
 eachInstance("Start string").

 new(S):-
	countInstance( Num ),
	NumNext = Num +1,
	assert( countInstance( NumNext ) ),
	write("Create instance number = ", NumNext),nl,
	assertz(eachInstance(S)).
	
 get_fact(Count, String):-
 	countInstance(Count),
 	eachInstance(String),!.
 get_fact(0,""):- write("No facts"),nl.
 
ENDCLASS

GOAL
  count::countInstance(I),		%An object need only for calling nonstatic class predicates or facts
  write("Start count value = ",I),nl,
  
  NewObject = count::new("Instance 1 string"),
  NewObject1 = count::new("Instance 2 string"),
  NewObject2 = count::new("Instance 3 string"),
  
  NewObject:get_fact(C,S),
  write("For NewObject:   countInstance fact = ",C,";   eachInstance fact = ",S),nl,
  NewObject1:get_fact(C1,S1),
  write("For NewObject1: countInstance fact = ",C1,";   eachInstance fact = ",S1),nl,
  NewObject2:get_fact(C2,S2),
  write("For NewObject2: countInstance fact = ",C2,";   eachInstance fact = ",S2),nl,

  NewObject2:delete,
  NewObject1:delete,
  NewObject:delete.
