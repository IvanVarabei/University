/******************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

			    Very simple example

 ModuleName:	OBJECT & CLASSES
 FileName:	HELLO.PRO
 PURPOSE:	very simple test, one class, one object, one predicate
 Writen By :	Compiler Group
******************************************************************************/

CLASS test
  PREDICATES
    WriteString
ENDCLASS

IMPLEMENT test
CLAUSES
  WriteString :-
	write( "Hello world from Object Oriented Visual Prolog\n" ).
ENDCLASS test

GOAL
  NewObject = test::new,
  NewObject:WriteString,
  NewObject:delete.
