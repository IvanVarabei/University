/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: TPREDS.PRO
 Purpose: Basic Utility Predicates for menu, screen and other tools
 Written by: PDC
 Comments:
******************************************************************************/

ifndef tpreds_in
CONSTANTS
  tpreds_in = 1

/****************************************************************/
/*		repeat						*/
/****************************************************************/
/*
PREDICATES
  nondeterm repeat

CLAUSES
  repeat.
  repeat:-repeat.
*/

/****************************************************************/
/*		miscellaneous					*/
/****************************************************************/

PREDICATES
%  maxlen(STRINGLIST,COL,COL)		/* The length of the longest string */
%  listlen(STRINGLIST,ROW)		/* The length of a list		    */
%  listlen(STRINGLIST,ROW,ROW)
%  writelist(ROW,COL,STRINGLIST)		/* used in the menu predicates	    */
%  min(INTEGER,INTEGER,INTEGER)
%  max(INTEGER,INTEGER,INTEGER)

CLAUSES
/*  maxlen([H|T],MAX,MAX1) :-
	str_len(H,LENGTH),
	LENGTH>MAX,!,
	maxlen(T,LENGTH,MAX1).
  maxlen([_|T],MAX,MAX1) :- 
	 !,maxlen(T,MAX,MAX1).
  maxlen([],LENGTH,LENGTH).

  listlen(List, Length) :- listlen(List, 0, Length).

  listlen([], Len, Len).
  listlen([_|T], N, Len):-
	N2=N+1,
	listlen(T, N2, Len).

  min(X,Y,X):-X<=Y,!.
  min(_,X,X).

  max(X,Y,X):-X>=Y,!.
  max(_,X,X).
*/
enddef
