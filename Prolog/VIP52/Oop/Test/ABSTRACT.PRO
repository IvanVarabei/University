/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demonstrates Abstract class

 ModuleName:	OBJECT & CLASSES
 FileName:	ABSTRACT.PRO
 PURPOSE:	abstract class
 Writen By :	Anna Bogdanova (Test Group)

******************************************************************************/

ABSTRACT CLASS A
  PREDICATES
    writeString
    getString(STRING)	-	(o)
ENDCLASS A


CLASS B : A
  PREDICATES
    writeString
    getString(STRING)	-	(o)
ENDCLASS B

IMPLEMENT B
CLAUSES
  writeString:-
	write( "Class B is the son of Abstract class.\n" ).
  getString("Class B String").
ENDCLASS B

CLASS C : A
  PREDICATES
    writeString
    getString(STRING)	-	(o)
ENDCLASS C

IMPLEMENT C
CLAUSES
  writeString:-
	write( "Class C is the son of Abstract class.\n" ).
  getString("Class C String").
ENDCLASS C

CLASS D : A
  PREDICATES
    writeString
    getString(STRING)	-	(o)
ENDCLASS D

IMPLEMENT D
CLAUSES
  writeString:-
	write( "Class D is the son of Abstract class.\n" ).
  getString("Class D String").
ENDCLASS D

PREDICATES
  p1(A)
  p2(A)
 
CLAUSES
  p1(O):-
  	O:writeString.

  p2(O):-
  	O:getString(S),
  	write("Get String = ", S),nl.

GOAL
  ObjB = B::new,
  ObjC = C::new,
  p1(ObjB),
  p2(ObjB),
  p1(ObjC),
  p2(ObjC),
  ObjB:delete,
  ObjC:delete,
  ObjD = D::new,
  p2(ObjD),
  ObjD:delete,
  write("End of test.").
