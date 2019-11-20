/******************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

		     Demonstrates Parent and Son Classes

 ModuleName:	OBJECT & CLASSES
 FileName:	INHERIT.PRO
 PURPOSE:	one parent and one son
 Writen By :	Compiler Group

******************************************************************************/

CLASS Parent
  FACTS
    strDB( STRING )
ENDCLASS Parent

IMPLEMENT Parent
ENDCLASS Parent

CLASS Son : Parent
  PREDICATES
    set_parent( STRING )
    check_parent()
ENDCLASS Son

IMPLEMENT Son
CLAUSES
  set_parent( STRING ):-
	assert(strDB(STRING)).
  check_parent():-
	strDB(STR),!,
	writef( "CLASS SON: String from parent <%s>\n", Str ).
ENDCLASS Son

/* Main Goal */
GOAL
  Son = son::new,
  Son:set_parent( "Helen" ),
  Son:check_parent(),
  Son:delete.
