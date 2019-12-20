/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demonstrates derived classes

 ModuleName:	OBJECT & CLASSES
 FileName:	Minherit.PRO
 PURPOSE:	derived classes grandfather -> father -> son -> child
 Writen By :	Compiler Group

******************************************************************************/

CLASS GrandFather
  PREDICATES
  procedure    new()
  procedure    delete()
ENDCLASS GrandFather

CLASS Father : GrandFather
  PREDICATES
  procedure    new()
  procedure    delete()
ENDCLASS Father

CLASS Son : Father
  PREDICATES
  procedure    new()
  procedure    delete()
ENDCLASS Son

CLASS Child : Son
  PREDICATES
  procedure    new()
  procedure    delete()
ENDCLASS Child

IMPLEMENT GrandFather
CLAUSES
   new():-
	write( "New:Grandfather\n" ).
   delete():-
	write( "Delete:Grandfather\n" ).
ENDCLASS GrandFather

IMPLEMENT Father
CLAUSES
   new():-
	grandFather::new(),
	write( "New:Father\n" ).
   delete():-
	grandFather::delete(),
	write( "Delete:Father\n" ).
ENDCLASS Father

IMPLEMENT Son
CLAUSES
   new():-
	father::new(),
	write( "New:Son\n" ).
   delete():-
	father::delete(),
	write( "Delete:Son\n" ).
ENDCLASS Son

IMPLEMENT Child
CLAUSES
   new():-
	son::new(),
	write( "New:Child\n" ).
   delete():-
	son::delete(),
	write( "Delete:Child\n" ).
ENDCLASS Child

Goal
  ChildObj = Child::new( ),
  ChildObj:delete.
