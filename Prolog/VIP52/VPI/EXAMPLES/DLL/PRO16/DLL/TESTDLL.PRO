/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			VISUAL Prolog
			
 Project:  TESTDLL
 FileName: TESTDLL.PRO
 Purpose: Demonstrates DLL text
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "testdll.inc"

GLOBAL PREDICATES
  procedure dll_mark_gstack(STACKMARK)     - (o) language Pascal
  procedure dll_release_gstack(STACKMARK) - (i) language Pascal
  procedure setInteger(integer In ) - (i) language Pascal
  procedure getInteger(integer Out) - (o) language Pascal
  procedure setReal(real In ) - (i) language Pascal
  procedure getReal(real Out ) - (o) language Pascal
  procedure setString(string In) - (i) language Pascal
  procedure getString(string Out) - (o) language Pascal

DATABASE - dll_database
  single i(integer)
  single r(real)
  single s(string)

CLAUSES
  i(0).
  r(0.0).
  s("Empty").

  dll_mark_gstack(STACKMARK):- STACKMARK=mem_MarkGStack().
  dll_release_gstack(STACKMARK):-mem_ReleaseGStack(STACKMARK).

  setInteger(In ):-
  	assert(i(In)).
  getInteger(Out):-
  	i(Out).
  
  setReal(In ):-
  	assert(r(In)).
  getReal(Out ):-
  	r(Out).

  setString(In):-
  	assert(s(In)).

/*
  Important note:
  getString should be surrounded in calling program in following way:
  dll_mark_gstack(Stack)
  getString(String)
  [saving String in variable of calling program]
  dll_release_gstack(Stack)
*/
  getString(Out):-
  	s(Out).

GOAL 
	true.
