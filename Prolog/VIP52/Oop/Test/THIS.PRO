/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demo this keyword using

 ModuleName:	OBJECT & CLASSES
 FileName:	THIS.PRO
 PURPOSE:	this keyword
 Writen By :	Compiler Group

******************************************************************************/

CLASS XString
  PREDICATES
    writeSomething
    writeString
ENDCLASS

IMPLEMENT XString
CLAUSES
  writeString :-
	write( "Hello world from Object Oriented Visual Prolog\n" ).

  writeSomething :-
	this( ObjectByThis ),  % Normally used to call Parent Class
	ObjectByThis:WriteString.
ENDCLASS XString

GOAL
  NewObject = XString::new,
  NewObject:WriteSomething,
  NewObject:delete.
