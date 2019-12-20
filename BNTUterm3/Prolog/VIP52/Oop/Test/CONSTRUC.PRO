/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demonstrates simple Constructor and Destructor

 ModuleName:	OBJECT & CLASSES
 FileName:	CONSTRUC.PRO
 PURPOSE:	test constructor and destructor
 Writen By :	Compiler Group

******************************************************************************/

CLASS test
  STATIC PREDICATES
  procedure new( String )
	
  PREDICATES
  procedure  delete()
    writestring
ENDCLASS test

IMPLEMENT test
CLAUSES
  new( Str ) :-
	write( Str ).

   delete() :-
	writef( "Simple destructor\n" ).

   writestring:-
	write( "Hello world from Object Oriented Visual Prolog\n" ).
ENDCLASS test

GOAL
  NewObject = test::new( "Simple constructor\n"),
  NewObject:Writestring,
  NewObject:delete.
