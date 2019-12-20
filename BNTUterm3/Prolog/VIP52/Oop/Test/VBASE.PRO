/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Virtual base class example

 ModuleName:	OBJECT & CLASSES
 FileName:	vbase.PRO
 PURPOSE:	virtual base class
 Writen By :	Compiler Group

******************************************************************************/
CLASS Safe
  PREDICATES
    put(STRING)
    STRING get()
ENDCLASS Safe

CLASS Put : Safe
  PREDICATES
    putStr(String)
ENDCLASS Put

CLASS Get : Safe
  PREDICATES
    getStr(String) - (o)
ENDCLASS Get

CLASS Change : Put, Get
  PREDICATES
    set_and_check(String)
ENDCLASS Change

IMPLEMENT Safe
FACTS
  s(STRING)
CLAUSES
  put(S):-
	assert(s(S)).
  get(S):-
	s(S),!.
  get("Empty, virtual base classes are not supported yet").
ENDCLASS Safe

IMPLEMENT Put
CLAUSES
   putStr(String):-
	safe::put(String),
	writef( "Put string <%s>\n", String ).
ENDCLASS Put

IMPLEMENT Get
CLAUSES
   getStr(Str):-
	Str = safe::get().
ENDCLASS Get

IMPLEMENT Change
CLAUSES
   set_and_check(Str):-
	put::putStr(Str),
	get::getStr(GetStr),
	writef( "Get string <%s>\n", GetStr ).
ENDCLASS Change

GOAL
  Obj = change::new,
  Obj:set_and_check("TEST STRING"),
  Obj:delete.
