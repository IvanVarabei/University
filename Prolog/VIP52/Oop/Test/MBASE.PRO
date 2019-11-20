/******************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

		         Demonstrates multiply base classes

 ModuleName:	OBJECT & CLASSES
 FileName:	mbase.PRO
 PURPOSE:	multiply base classes
 Writen By :	Compiler Group

******************************************************************************/

CLASS Mother
  PREDICATES
    motherspeak
ENDCLASS Mother

CLASS Father
  PREDICATES
    fatherspeak
ENDCLASS Father

CLASS Son : Father, Mother
  PREDICATES
    sonanswer
ENDCLASS Son

IMPLEMENT Mother
CLAUSES
  motherspeak:-
	write( "I'am mother.\n" ).
ENDCLASS Mother

IMPLEMENT Father
CLAUSES
  fatherspeak:-
	write( "I'am father.\n" ).
ENDCLASS Father

IMPLEMENT Son
CLAUSES
  sonanswer:-
	write( "I'am son.\n" ).
ENDCLASS Son

GOAL
  SonObj = Son::new,
  SonObj:FatherSpeak,
  SonObj:MotherSpeak,
  SonObj:SonAnswer,
  SonObj:delete.
  
