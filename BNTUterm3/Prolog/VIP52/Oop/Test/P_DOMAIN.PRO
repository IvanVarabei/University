/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demonstrates using of predicate pointers

 ModuleName:	OBJECT & CLASSES
 FileName:	P_DOMAIN.PRO
 PURPOSE:	Using of predicate pointers
 Writen By :	Anna Bogdanova (Test Group)

******************************************************************************/

constants
%  use_fact = 1
%  use_object = 2
%  not_use_object = 3

domains
	slist = string*
	callback = procedure slist (integer) -(i)

class fred
predicates
	procedure new
static predicates
	cb:callback
endclass fred

implement fred
clauses
	new.
clauses
	cb(1,["a1","b1"]):-!.
	cb(2,["a2","b2"]):-!.
	cb(_, []).
endclass fred
%-----------------------------------
facts-local
	determ	dbo_fred(callback)
predicates
	start
	finish
	test(callback)
clauses
	start:-
		FRED=fred::new,
	        CB=FRED:cb,
		assert(dbo_fred(CB)).
		
	finish:-
		dbo_fred(CB_p),
		CB_list = CB_p(1),
		CB_list = [A,B],
		format(S,"A = % , B = %",A,B),
		write(S).
	
	test(CB):-
		L = CB(1),
		write(L),nl.

goal
ifdef use_fact
    start,
    finish.
elsedef	
  ifdef use_object
    O = fred::new,
    CB = O:cb,
    test(CB),
    O:delete.
  elsedef	
    ifdef not_use_object
    test(fred::cb).
    elsedef
        write("No one constants is declared.").
    enddef
 enddef   
enddef

