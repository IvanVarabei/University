/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demonstrates Static facts using

 ModuleName:	OBJECT & CLASSES
 FileName:	static.PRO
 PURPOSE:	static and non static facts and derived class
 Writen By :	Anna Bogdanova (Test Group)

******************************************************************************/
CLASS Count
STATIC FACTS - db1
  countInstance( INTEGER )	%exists only one version for the class
FACTS - db2
  eachInstance(STRING)		%generated for each instance 
PREDICATES
  procedure new(STRING)
  get_fact(INTEGER, STRING)	-	(o,o)
ENDCLASS

IMPLEMENT Count
CLAUSES
 countInstance( 0 ).

 new(S):-
	countInstance( Num ),!,
	NumNext = Num +1,
	asserta( countInstance( NumNext ) ),
	write("Create instance number = ", NumNext),nl,
	assert( eachInstance(S) ).
 new(_S):-
 	write("Impossible get the start count value"),nl.
	
 get_fact(Count, String):-
 	countInstance(Count),
 	eachInstance(String),!.
 get_fact(0,""):- write("No facts"),nl.

ENDCLASS

 
CLASS son_class : Count
PREDICATES
  procedure new(STRING)
  get_inherit_fact(INTEGER, STRING)	-	(o,o)
ENDCLASS

IMPLEMENT son_class
CLAUSES
  new(S):-
	assert( eachInstance(S) ).

  get_inherit_fact(Count,String):-
  	countInstance(Count),
 	eachInstance(String),!.
  get_inherit_fact(0,""):- write("No facts"),nl.
ENDCLASS

PREDICATES
  goal_1
  
CLAUSES
  goal_1:-

  NewObject = count::new("Instance 1 string"),
  NewObject1 = count::new("Instance 2 string"),
  NewObject2 = count::new("Instance 3 string"),
  
  NewObject:get_fact(C,S),
  write("NewObject:  countInstance fact = ",C,"   eachInstance fact = ",S),nl,
  NewObject1:get_fact(C1,S1),
  write("NewObject1: countInstance fact = ",C1,"   eachInstance fact = ",S1),nl,
  NewObject2:get_fact(C2,S2),
  write("NewObject2: countInstance fact = ",C2,"   eachInstance fact = ",S2),nl,

  	O1 = son_class::new("Son class, Object1."),
	O2 = son_class::new("Son class, Object2."),
	O1:get_inherit_fact(I1,SS1),
	write("Derived class Object1: countInstance fact = ", I1, "  eachInstance fact = ", SS1),nl,
	O2:get_inherit_fact(I2,SS2),
	write("Derived class Object2: countInstance fact = ", I2, "  eachInstance fact = ", SS2),nl,
	O1:delete,
	O2:delete,

  NewObject2:delete,
  NewObject1:delete,
  NewObject:delete.


GOAL
  goal_1.