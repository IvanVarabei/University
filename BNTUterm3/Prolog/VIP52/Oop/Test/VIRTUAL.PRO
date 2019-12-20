/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demo virtual predicates

 ModuleName:	OBJECT & CLASSES
 FileName:	VIRTUAL.PRO
 PURPOSE:	shows that predicates are virtual (by default)
 Writen By :	Compiler Group
******************************************************************************/

CLASS simple
  PREDICATES
    who_am_i()
ENDCLASS simple

CLASS son_1 : simple
  PREDICATES
    who_am_i()
ENDCLASS son_1

CLASS son_2 : simple
  PREDICATES
    who_am_i()
ENDCLASS son_2

IMPLEMENT simple
  CLAUSES
    who_am_i() :-
	write( "I'm simple" ), nl.
ENDCLASS simple

IMPLEMENT son_1
  CLAUSES
    who_am_i() :-
	write( "I'm son 1" ), nl.
ENDCLASS son_1

IMPLEMENT son_2
  CLAUSES
    who_am_i() :-
	write( "I'm son 2" ), nl.
ENDCLASS son_2

PREDICATES
  p( simple ) - (i)

CLAUSES
  p( S ) :-
	S:who_am_i().

GOAL
	O1 = son_1::new(),
	O2 = son_2::new(),
	O3 = simple::new(),
	p( O1 ),
	p( O2 ),
	p( O3 ),
	O1:delete(),
	O2:delete(),
	O3:delete().
