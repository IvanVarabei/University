/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: PRO2C.PRO
 Purpose: 
 Written by: PDC
 Comments:
******************************************************************************/
%
%
project "pro2c"
%  /|\
%   |
% NOTE: to compile with the c-scanner, enable this as a project
%       and the corresponding constant below

code = 4000

CONSTANTS
% c_scanner = 1

scantokname = "tok"	% This name will trigger gen. of C-scanner initializers

GLOBAL DOMAINS
ifdef c_scanner
  CURSORTOK = t(TOK,CURSOR)
  TOKL = CURSORTOK*
enddef

  CURSOR = INTEGER
  PROCID = STRING

  NAME =  STRING

  CONSTDEF = constdef(STRING)
  BASISDOM = STRING
  FLOWPAT = SYMBOL
  FILE = out

ifdef c_scanner
  GLOBAL PREDICATES
  scanner(STRING,TOKL) - (i,o) language C
  nondeterm str_tok(STRING,TOK) - (i,o),(o,o) language pascal
enddef

GLOBAL DATABASE
  source(STRING)
  filename(STRING)
  error(STRING,CURSOR)

include "tdoms.pro"
include "tpreds.pro"
include "pro2c.dom"

/***************************************************************************
	Reserved variable names and C keywords
***************************************************************************/

DOMAINS
  RETDOM = retdom(NAME); none

DATABASE - resnames
  determ pro_resnames	% Flag indicating if reserved var names can occur

PREDICATES
  keyword(SYMBOL)

CLAUSES
  keyword("fno"):- pro_resnames.
  keyword("next"):- pro_resnames.  % Variable id's used in structs and unions
  keyword("refvar"):- pro_resnames.
 
  keyword("asm").  keyword("auto").  keyword("break").  keyword("case").
  keyword("cdecl").  keyword("char").  keyword("const").  keyword("continue").
  keyword("default").  keyword("do").  keyword("double").  keyword("else").
  keyword("enum").  keyword("extern").  keyword("far").  keyword("float").
  keyword("for").  keyword("goto").  keyword("huge").  keyword("if").
  keyword("int").  keyword("interrupt").  keyword("long").  keyword("near").
  keyword("pascal").  keyword("register").  keyword("return").  keyword("short").
  keyword("signed").  keyword("sizeof").  keyword("static").  keyword("struct").
  keyword("switch").  keyword("typedef").  keyword("union").  keyword("unsigned").
  keyword("void").  keyword("volatile").  keyword("while").


/***************************************************************************
	Assertion of domain declarations
***************************************************************************/

DATABASE - declarations
  nocopy dom(NAME,RIGHTHAND)
  nocopy refdom(NAME)
  nocopy cpred(RETDOM,STRING,PARMS,FLOWPATTERNS,LANGUAGE,EXTNAME)
  nocopy overloaded(STRING) % Multiple declarations
  nocopy const_decl(STRING,STRING)

PREDICATES
  assertdecls(PROLOGDECL)
  assertdecl(DECLSECTION)
  assertdomlist(DOMLIST)
  assert_const_decls(CONSTLIST)
  assertdomdecl(NAMELIST,REFERENCE,RIGHTHAND)
  check_assert_reference(NAME,REFERENCE)

  assert_external_decls(GLOBPREDLIST)
  assert_external_decl(GLOBPRED)

  check_multiple(STRING).

  % conversion from dbasedef to domain declaration
  convert_dbadef_to_domdef(DBALIST,D_ALTERNATIVES)
  convert_single(DBA,D_ALTERNATIVE)
  parml_doml(PARMLIST,DOmNAMELIST)


CLAUSES
  assertdecls([H|T]):-
	assertdecl(H),
	assertdecls(T).
  assertdecls([]).

  assertdecl(domdecl(_)):-!.
%  Note domains are asserted durign parsing because recognizing returndomains
%  requires a test to see if the identifier is actually a domain
%	assertdomlist(DOMLIST).
  assertdecl(dbadecl1(NAME,DBALIST)):-!,
	convert_dbadef_to_domdef(DBALIST,RIGHTHAND),
	assertdomdecl([NAME],none,alternatives(RIGHTHAND)).
  assertdecl(dbadecl(DBALIST)):-!,
	convert_dbadef_to_domdef(DBALIST,RIGHTHAND),
	assertdomdecl(["dbasedom"],none,alternatives(RIGHTHAND)).
  assertdecl(globpreddecl(GLOBPREDLIST)):-!,
	assert_external_decls(GLOBPREDLIST).
  assertdecl(constdecl(CONSTLIST)):-!,
	assert_const_decls(CONSTLIST).
  assertdecl(_):-beep.


  % ------ Assertion of domain declarations -------
  assertdomlist([dom(NAMELIST,REFERENCE,RIGHTHAND)|T]):-
	assertdomdecl(NAMELIST,REFERENCE,RIGHTHAND),
	assertdomlist(T).
  assertdomlist([]).

  assertdomdecl([NAME|T],REFERENCE,RIGHTHAND):-
	check_assert_reference(NAME,REFERENCE),
	upper_lower(NAME,LNAME),
	assert(dom(LNAME,RIGHTHAND)),
	assertdomdecl(T,REFERENCE,RIGHTHAND).
  assertdomdecl([],_,_).

  check_assert_reference(NAME,reference_):- !,
	upper_lower(NAME,LNAME),
	assert(refdom(LNAME)).
  check_assert_reference(_,_).


  % ------- Assertion of external predicate declaration -------
  assert_external_decls([H|T]):-
	assert_external_decl(H),
	assert_external_decls(T).
  assert_external_decls([]).

  assert_external_decl(pred(_,RETDOM,NAME,PARMS,FLOW,language_(LINGO),EXTNAME)):- !,
	check_multiple(NAME),
	assert(cpred(RETDOM,NAME,PARMS,FLOW,language_(LINGO),EXTNAME)).
  assert_external_decl(nullarg(_,RETDOM,NAME,language_(LINGO),EXTNAME)):-!,
	check_multiple(NAME),
	assert(cpred(RETDOM,NAME,none,[],language_(LINGO),EXTNAME)).
  assert_external_decl(_).

  check_multiple(NAME):-
	cpred(_,NAME,_,_,_,_),!,
	assert(overloaded(NAME)).
  check_multiple(_).


  % ------- Conversion between database declaration and domain definition -----
  convert_dbadef_to_domdef([H|T],[H1|T1]):-
	convert_single(H,H1),
	convert_dbadef_to_domdef(T,T1).
  convert_dbadef_to_domdef([],[]).

  convert_single(dba(_,PREDNAME,none),atom(FUNCNAME)):-
	FUNCNAME=PREDNAME.
  convert_single(dba(_,PREDNAME,parms(PARML)),cmp(FUNCNAME,DOML)):-
	FUNCNAME=PREDNAME,
	parml_doml(PARML,DOML).

  parml_doml([H|T],[H|T1]):-
	parml_doml(T,T1).
  parml_doml([],[]).


  assert_const_decls([constdef(Id,constdef(Val))|Rest]):-!,
	assert(const_decl(Id,Val)),
	assert_const_decls(Rest).
  assert_const_decls(_).


/***************************************************************************
	Generate implicitly defined reference domains
***************************************************************************/

PREDICATES
  gen_recursive_refdoms
  makereference(RIGHTHAND)
  makealtrefdoms(D_ALTERNATIVES)
  makenamelrefdom(DOMNAMELIST)
  gennewrefdom(NAME)
  get_dom(DOMNAME,NAME)

CLAUSES
  gen_recursive_refdoms:-
	refdom(NAME),
	dom(NAME,RIGHTHAND),
	makereference(RIGHTHAND),
	fail.
  gen_recursive_refdoms.

  makereference(listdom(NAME)):- gennewrefdom(NAME).
  makereference(alternatives(ALTL)):- makealtrefdoms(ALTL).
  makereference(basisdom(_)).

  makealtrefdoms([cmp(_,NAMELIST)|T]):- !,
	makenamelrefdom(NAMELIST),
	makealtrefdoms(T).
  makealtrefdoms([_|T]):-
	makealtrefdoms(T).
  makealtrefdoms([]).

  makenamelrefdom([NAME|T]):-
	get_dom(NAME,DOM),
	gennewrefdom(DOM),
	makenamelrefdom(T).
  makenamelrefdom([]).

  gennewrefdom(NAME):-refdom(NAME), !.
  gennewrefdom(NAME):-
	asserta(refdom(NAME)),
	dom(NAME,RIGHTHAND), !,
	makereference(RIGHTHAND).
  gennewrefdom(_).

  get_dom(id(DOM),DOM).
  get_dom(idc(_,DOM),DOM).



/***************************************************************************
	Generate a list of all domains that need to be declared 
	for the external predicates.
***************************************************************************/

DATABASE - referred_domains
  referred_dom(NAME)

PREDICATES
  gen_recursive_referreddoms
  reg_referred(NAME)
  recursivereferred(RIGHTHAND)
  altlreferred(D_ALTERNATIVES)
  namelreferred(DOMNAMELIST)
  retdomrefered(RETDOM)

  nondeterm member(DOMNAME,PARMLIST)

CLAUSES
  gen_recursive_referreddoms:-
	cpred(RETDOM,_,PARMS,_,_,_),
	retdomrefered(RETDOM),
	PARMS=parms(PARML),
	member(DOMNAME,PARML),
	get_dom(DOMNAME,NAME),
	reg_referred(NAME),
	fail.
  gen_recursive_referreddoms.

  recursivereferred(listdom(NAME)):- reg_referred(NAME).
  recursivereferred(basisdom(NAME)):- reg_referred(NAME).
  recursivereferred(alternatives(ALTL)):- altlreferred(ALTL).
  recursivereferred(struct_(ID,NAMELIST)):-
	altlreferred([cmp(ID,NAMELIST)]).
  recursivereferred(procdom(procdom(_,dom(NAMELIST),_,_))):-
	altlreferred([cmp("",NAMELIST)]).
  recursivereferred(procdom(fnsdom(_,DOMNAME,dom(NAMELIST),_,_))):-
	reg_referred(DOMNAME),
	altlreferred([cmp("",NAMELIST)]).
  recursivereferred(procdom(fnsdom(_,DOMNAME,none(),_,_))):-
	reg_referred(DOMNAME).

  altlreferred([cmp(_,NAMELIST)|T]):- !,
	namelreferred(NAMELIST),
	altlreferred(T).
  altlreferred([_|T]):-
	altlreferred(T).
  altlreferred([]).

  namelreferred([NAME|T]):-
	get_dom(NAME,DOM),
	reg_referred(DOM),
	namelreferred(T).
  namelreferred([]).

  retdomrefered(none).
  retdomrefered(retdom(DOM)):-
	reg_referred(DOM).

  reg_referred(NAME):-
	upper_lower(NAME,LNAME),
	referred_dom(LNAME), !.
  reg_referred(NAME):-
	upper_lower(NAME,LNAME),
	assert(referred_dom(LNAME)),
	dom(LNAME,RIGHTHAND), !,
	recursivereferred(RIGHTHAND).
  reg_referred(_).

  member(X,[X|_]).
  member(X,[_|L]):- member(X,L).


/***************************************************************************
	TEST Output of the domain database
***************************************************************************/
/*
PREDICATES
  writeref(NAME)
  writedom

CLAUSES
  writedom:-
	dom(NAME,RIGHTHAND),
	write("\n",NAME," = "),
	writeref(NAME),
	write("\n\t",RIGHTHAND),
	fail.
  writedom.

  writeref(NAME):-
	refdom(NAME), !,
	write("reference").
  writeref(_).
*/

/***************************************************************************
	Generate structure pointer
***************************************************************************/

PREDICATES
  genptrname(NAME,STRING)

CLAUSES
  genptrname(NAME,PTRNAME):-
	upper_lower(NAME,LNAME),
	concat(LNAME,"_struct",PTRNAME).


/***************************************************************************
			Generation of C types

 This group of predicates does the generation of C type declarations from
 the database dom(NAME,RIGHTHAND) and the description of reference domains
 refdom(NAME).

 As long as the database predicate referred_dom is called in genctypes,
 C type-definitions will not be generated for domains not used in the
 global predicates declared to be C procedures.

***************************************************************************/

DATABASE - known
  known(NAME)
  known_selector(NAME,INTEGER)
  known_globstruct(NAME,INTEGER)

PREDICATES
  genctypes
  genctype(NAME,RIGHTHAND)
  wtype(NAME)
  wstructref(NAME)
  gen_globstructname(NAME,NAME)
  gen_sel_no(NAME,INTEGER)
  wselector(NAME)
  wdoml(STRING,DOMNAMELIST)
  walt(D_ALTERNATIVE)
  waltlist(D_ALTERNATIVES)
  enumlist(D_ALTERNATIVES)
  asteriskneeded(NAME,RIGHTHAND)
  enum_functors(NAME,D_ALTERNATIVES)
  enum_functors1(NAME,D_ALTERNATIVES)
  get_func(D_ALTERNATIVE,STRING)
%  get_tabs(STRING,STRING)
  check_scanname(NAME,D_ALTERNATIVES)
  gen_initlist(D_ALTERNATIVES)
  comma_check(D_ALTERNATIVES)
  get_domsel(DOMNAME,NAME)
  condef(STRING,STRING)

CLAUSES

  condef(DOM,DEF):-
	referred_dom(DOM),!,
	upper_lower(UPPDOM,DOM),
	write("typedef ",DEF,' ',UPPDOM,";\n").
  condef(_,_).

  genctypes:-
	write("\n#define VARFNO\t\t0"),
	write("\n#define CONSTFNO\t1"),
	write("\n#define LISTFNO\t\t1"),
	write("\n#define NILLFNO\t\t2\n"),

	condef("integer","int"),
	condef("char","char"),
	condef("real","double"),
	condef("string","char*"),
	condef("symbol","char*"),
	condef("byte","unsigned char"),
	condef("short","short"),
	condef("ushort","unsigned short"),
	condef("word","unsigned short"),
	condef("unsigned","unsigned int"),
	condef("long","long"),
	condef("ulong","unsigned long"),
	condef("dword","unsigned long"),
	condef("ref","long"),
	condef("bt_selector","int"),
	fail.

  genctypes:-
	referred_dom("binary"),
	write("\ntypedef struct { unsigned Len; unsigned char Vals[1]; } *BINARY;"),
	fail.

  genctypes:-
	referred_dom("reg"),  % A less than ideal solution - should be AX,BX etc
	assert(dom("reg",alternatives([cmp("reg",
				[id("integer"),id("integer"),id("integer"),id("integer"),
				 id("integer"),id("integer"),id("integer"),id("integer")])]))),
	fail.

  genctypes:-
	referred_dom("file"),
	getbacktrack(TOP),
	retract(dom("file",alternatives(USERFILES))),
	assert(dom("file",alternatives(
		[atom("keyboard"),atom("screen"),atom("stdin"),atom("stdout"),
		 atom("stderr"),atom("com1"),atom("printer")|USERFILES]))),
	cutbacktrack(TOP),
	fail.

  genctypes:-
 	referred_dom("place"),
 	assert(dom("place",alternatives(
		[atom("in_memory"),atom("in_ems"),atom("in_file")]))),
	fail.

  genctypes:-
	referred_dom(NAME),
	dom(NAME,RIGHTHAND), RIGHTHAND=basisdom(_),
	nl,
	upper_lower(UNAME,NAME),
	genctype(UNAME,RIGHTHAND),
	assert(known(NAME)),
	fail.
  genctypes:-
	referred_dom(NAME),
	dom(NAME,RIGHTHAND), not(RIGHTHAND=basisdom(_)),
	nl,
	upper_lower(UNAME,NAME),
	genctype(UNAME,RIGHTHAND),
	assert(known(NAME)),
	fail.
  genctypes.


  genctype(_,_):- retractall(known_selector(_,_)), fail.

  genctype(NAME,basisdom(BASISDOM)):-
	upper_lower(NAME,LNAME),
	refdom(LNAME),!,
	gen_globstructname(BASISDOM,STRUCTNAME),
	upper_lower(UBASISDOM,BASISDOM),
	write("\ntypedef\n  struct ",STRUCTNAME," {"),
	write("\n\tunsigned char fno;"),
	write("\n\tunion {"),
	write("\n\t\t",UBASISDOM,' '),
	wselector(BASISDOM),
	write(";\n\t\tstruct ",STRUCTNAME," *refvar;"),
	write("\n\t} u;"),
	write("\n  } ",NAME,';').

  genctype(NAME,basisdom(BASISDOM)):-
	upper_lower(UBASISDOM,BASISDOM),
	write("\ntypedef ",UBASISDOM,'\t',NAME,';').

  genctype(NAME,listdom(REFDOM)):-
	genptrname(NAME,PTRNAME),
	write("\ntypedef\n  struct ",PTRNAME," {"),
	write("\n\tunsigned char fno;"),
	write("\n\t"),
	wtype(REFDOM), wselector(REFDOM), write(';'),
	write("\n\tstruct ",PTRNAME," *next;"),
	write("\n  } ",NAME,";").

  genctype(NAME,alternatives(ALTERNATIVES)):-
	enumlist(ALTERNATIVES), !,
	enum_functors(NAME,ALTERNATIVES),
	genptrname(NAME,PTRNAME),
	write("\ntypedef\n  struct ",PTRNAME," {"),
	write("\n\tunsigned char fno;"),
	write("\n  } ",NAME,";"),
	check_scanname(NAME,ALTERNATIVES).

  genctype(NAME,alternatives([cmp(FUNC,NAMELIST)])):- !,
	enum_functors(NAME,[cmp(FUNC,NAMELIST)]),
	genptrname(NAME,PTRNAME),
	write("\ntypedef\n  struct ",PTRNAME," {"),
	write("\n\tunsigned char fno;\n\t"),
	wdoml("\n\t",NAMELIST),
	write("\n  } ",NAME,';').

  genctype(NAME,struct_(_,NAMELIST)):-
	genptrname(NAME,PTRNAME),
	write("\ntypedef struct ",PTRNAME," {\n\t"),
	wdoml("\n\t",NAMELIST),
	write("\n\t} ",NAME,";").


  genctype(NAME,alternatives(ALTERNATIVES)):-
	enum_functors(NAME,ALTERNATIVES),
	genptrname(NAME,PTRNAME),
	write("\ntypedef\n  struct ",PTRNAME," {"),
	write("\n\tunsigned char fno;"),
	write("\n\tunion {"),
	waltlist(ALTERNATIVES),
	write("\n\t} u;"),
	write("\n  } ",NAME,";"),
	check_scanname(NAME,ALTERNATIVES).


  genctype(NAME,procdom(procdom(_,_,_,_))):-
	write("\ntypedef void (*",NAME,")(void);").
  genctype(NAME,procdom(fnsdom(_,_,_,_,_))):-
	write("\ntypedef void (*",NAME,")(void);").


  waltlist([H]):- walt(H), !.
  waltlist([H|T]):- walt(H), !, waltlist(T).
  waltlist([_|T]):- waltlist(T).
  waltlist([]).


  walt(_):- retractall(known_selector(_,_)), fail.
  walt(cmp(FUNC,[NAMETYPE])):- !,
  	write("\n\t\t"),
	get_dom(NAMETYPE,DOM),
	wtype(DOM),
	FUNC = NAME,
	wselector(NAME),
	write(';').
  walt(cmp(FUNC,NAMELIST)):-
	write("\n\t\tstruct {\n\t\t\t"),
	wdoml("\n\t\t\t",NAMELIST),
	write("\n\t\t} "),
	retractall(known_selector(_,_)),
	FUNC=NAME,
	wselector(NAME),
	write(';').


  wdoml(_,[NAME]):- !,
	get_dom(NAME,DOM),
	wtype(DOM),
	get_domsel(NAME,DOMSEL),
	wselector(DOMSEL),
	write(';').
  wdoml(INDENT,[NAME|T]):-
	get_dom(NAME,DOM),
	wtype(DOM),
	get_domsel(NAME,DOMSEL),
	wselector(DOMSEL),
	write(';'),
	write(INDENT),
	wdoml(INDENT,T).
  wdoml(_,[]).


  wtype(TYPE):-
	upper_lower(TYPE,DOM),
	dom(DOM,RIGHTHAND),
	asteriskneeded(DOM,RIGHTHAND),
	!,
	wstructref(DOM),
 	write(" *").
  wtype(TYPE):-
	upper_lower(U,TYPE),
	write(U,' ').


  wstructref(TYPE):-
	known(TYPE), !,
	upper_lower(U,TYPE),
	write(U).
  wstructref(TYPE):-
	upper_lower(TYPE,L),
	write("struct ",L,"_struct").

  asteriskneeded(DOM,_):-refdom(DOM), !.
  asteriskneeded(_,basisdom(_)):- !, fail.
  asteriskneeded(_,_).


  gen_globstructname(NAME,NAME1):-
  	retract(known_globstruct(NAME,N)), !,
  	format(NAME1,"%_ref_%",NAME,N),
  	NN=N+1,
  	assert(known_globstruct(NAME,NN)).
  gen_globstructname(NAME,NAME1):-
  	concat(NAME,"_ref",NAME1),
  	assert(known_globstruct(NAME,1)).


  gen_sel_no(SEL,N):-
	retract(known_selector(SEL,N)), !,
	N1=N+1,
	assert(known_selector(SEL,N1)).
  gen_sel_no(SEL,0):-
  	assert(known_selector(SEL,1)).


  wselector(SEL):-
  	known_selector(SEL,_), !,
  	gen_sel_no(SEL,N),
	write(SEL,'_',N).
  wselector(SEL):-
	upper_lower(SEL,L),
  	keyword(L), !,
  	gen_sel_no(SEL,N),
  	write(SEL,'_',N).
  wselector(SEL):-
  	assert(known_selector(SEL,0)),
  	write(SEL).


  enumlist([atom(_)|T]):- enumlist(T).
  enumlist([]).


  enum_functors(NAME,LIST):-
	upper_lower(NAME,LNAME),
	write("\ntypedef enum {\n"),
	write("\t",LNAME,"_unbound=0,\n"),
	enum_functors1(LNAME,LIST),
	write("} ",NAME,"_FNO;\n").

  enum_functors1(NAME,[H]):-!,
	get_func(H,FUNC),
	write("\t",NAME,'_',FUNC,"\n").
  enum_functors1(NAME,[H|T]):-
	get_func(H,FUNC),
	write("\t",NAME,'_',FUNC,",\n"),
	enum_functors1(NAME,T).
  enum_functors1(_,[]).


  get_func(cmp(FUNC,_),FUNC).
  get_func(atom(FUNC),FUNC).
/*
  get_tabs(LINE,TABS):-
	str_len(LINE,LEN),
	TABC = 3 - (LEN-9) div 8, TABC>0, !,
	frontstr(TABC,"\t\t\t",TABS,_).
  get_tabs(_,"\t").
*/

  get_domsel(idc(NAME,_),NAME).
  get_domsel(id(DOMNAME),NAME):-
	upper_lower(DOMNAME,L),
	frontchar(L,Ch,Rest),
	upper_lower(UCh,Ch),
	frontchar(NAME,UCh,Rest).


/*******************************************************************************
	Generate #defines from te Phrolog Constants
*******************************************************************************/

PREDICATES
  gencdefs

CLAUSES
  gencdefs:-
	const_decl(Name,Val),
	  write("#define ",Name,"\t",Val),nl,
	  fail.
  gencdefs:-nl.


/*******************************************************************************
		Generate tokenlist for C-scanner:
*******************************************************************************/

  check_scanname(NAME,ALTERNATIVES):-
  	upper_lower(NAME,scantokname), !,
  	write("\n\n\n"),
	write("struct {\n\tSTRING strtok;\n\tint fno;\n} tokens[] = {"),
	gen_initlist(ALTERNATIVES),
  	write("\n};\n").
  check_scanname(_,_).

  gen_initlist([H|T]):-
  	get_func(H,FUNC),
  	write("\n\t{\"\",",scantokname,'_',FUNC,'}'),
  	comma_check(T),
  	gen_initlist(T).
  gen_initlist([]).
  
  comma_check([]):- !.
  comma_check(_):- write(',').


/***************************************************************************
	Declare C procedure prototypes for the external predicates.
***************************************************************************/

DATABASE - count
  vercount(STRING,INTEGER)mm


PREDICATES
  gen_c_procedures
  gen_c_procedures1(RETDOM,STRING,PARMS,FLOWPATTERNS,LANGUAGE,EXTNAME)
  gen_c_procedures2(RETDOM,STRING,PARMS,FLOWPATTERNS,LANGUAGE,EXTNAME)

  writeparmlist(PARMLIST,FLOWPATLIST)
  writeparm(DOMNAME,FLOWPAT)
  wlang(LANGUAGE)
  write_name(STRING,EXTNAME)
  write_retdom(RETDOM)

CLAUSES
  gen_c_procedures:-
	cpred(RETDOM,NAME,PARMS,FLOWPATTERNS,LANGUAGE,EXTNAME),
	gen_c_procedures1(RETDOM,NAME,PARMS,FLOWPATTERNS,LANGUAGE,EXTNAME),
	fail.
  gen_c_procedures.
	
  gen_c_procedures1(RETDOM,NAME,none,_,LANGUAGE,EXTNAME):- !,
	write("\n\n"),
	write_retdom(RETDOM),
  	wlang(LANGUAGE),
  	write_name(NAME,EXTNAME),
  	write("();").
  gen_c_procedures1(RETDOM,NAME,PARMS,FLOWPATTERNS,LANGUAGE,EXTNAME):-
	gen_c_procedures2(RETDOM,NAME,PARMS,FLOWPATTERNS,LANGUAGE,EXTNAME).

  gen_c_procedures2(RETDOM,NAME,parms(PARMS),[flowpat(FLOWLIST)|T],
						LANGUAGE,EXTNAME):-
  	retractall(known_selector(_,_)),
	write("\n\n"),
	write_retdom(RETDOM),
  	wlang(LANGUAGE),
	write_name(NAME,EXTNAME),
	write('('),
	writeparmlist(PARMS,FLOWLIST),
	write(");"),
	gen_c_procedures2(RETDOM,NAME,parms(PARMS),T,LANGUAGE,EXTNAME).
  gen_c_procedures2(_,_,_,[],_,_).

  writeparmlist([PARM],[FLOWPAT]):- !,
	upper_lower(FLOWPAT,IO),
	writeparm(PARM,IO).
  writeparmlist([PARM|T1],[FLOWPAT|T2]):-
	upper_lower(FLOWPAT,IO),
	writeparm(PARM,IO),
	write(','),
	writeparmlist(T1,T2).
  writeparmlist([],_).

  write_retdom(none):-
	write("void ").
  write_retdom(retdom(DOM)):-
	wtype(DOM).

  writeparm(NAME,i):-
	get_dom(NAME,DOM),
	wtype(DOM),
	get_domsel(NAME,DOMSEL),
	wselector(DOMSEL).
  writeparm(NAME,o):-
	get_dom(NAME,DOM),
	wtype(DOM),
	write('*'),
	get_domsel(NAME,DOMSEL),
	wselector(DOMSEL).

  wlang(language_("pascal")):- write("pascal ").
  wlang(language_("c")):-!.

  write_name(NAME,none):-
	overloaded(NAME),
	retract(vercount(NAME,SUFFIX)),
	SUFFIX1 = SUFFIX+1,
	assert(vercount(NAME,SUFFIX1)),
	write(NAME,'_',SUFFIX1),!.
  write_name(NAME,none):-
	overloaded(NAME),
	assert(vercount(NAME,0)),
	write(NAME,"_0"),!.
  write_name(NAME,none):- write(NAME).
  write_name(_,extname(ENAME)):- write(ENAME).


/***************************************************************************
	Scanner & Parser environment
***************************************************************************/

ifndef c_scanner
  PREDICATES
  scan_error(STRING,CURSOR)

  include "pro2c.sca"
enddef

DOMAINS
  FLOWPATTERNS = FLOWPATTERN*

PREDICATES
  ed(STRING,CURSOR)
  change(DBASEDOM)
  nondeterm repparse
  process(STRING)
  better_error(CURSOR)
%  checkerror
  new_error(STRING,CURSOR)
  expect(CURSORTOK,TOKL,TOKL)
  syntax_error(STRING,TOKL)
  checkempty(TOKL)
  s_constdef(TOKL,TOKL,CONSTDEF)
  s_basisdom(TOKL,TOKL,BASISDOM)  s_flowpatterns(TOKL,TOKL,FLOWPATTERNS)
  s_flowpatterns1(TOKL,TOKL,FLOWPATTERNS)
  s_retdom(TOKL,TOKL,RETDOM)

include "pro2c.par"

PREDICATES
  is_basisdom(STRING)
  is_dom(STRING)

CLAUSES
/* User-defined production s_basisdom (from the grammar).
   If compound domains with functor-names identical to standard domain-names
   (eg string(string,integer) ) are avoided, 's_basisdom' won't have to
   check the following token ('NEXT') for this and may hence be speeded up
   somewhat by removal of the body of the clauses.
   
   Notice, by the way, how ridiculously easy it is to handle a multi-symbol
   lookahead grammar in Prolog.
*/

  is_basisdom("char").  is_basisdom("byte").  is_basisdom("short").
  is_basisdom("ushort").  is_basisdom("word").  is_basisdom("integer").
  is_basisdom("unsigned").  is_basisdom("long").  is_basisdom("ulong").
  is_basisdom("dword").  is_basisdom("real").  is_basisdom("ref").
  is_basisdom("binary").  is_basisdom("symbol").  is_basisdom("string").
  is_basisdom("dbasedom").  is_basisdom("bt_selector").  is_basisdom("db_selector").
  is_basisdom("place").  is_basisdom("file").  is_basisdom("reg").
  is_basisdom("bgi_ilist").


  is_dom(DOM) :- upper_lower(DOM,LDOM),is_basisdom(LDOM),!.
  is_dom(DOM) :- upper_lower(DOM,LDOM),dom(LDOM,_),!.


  s_constdef([t(id(STR),_)|TOKL],TOKL,constdef(STR)):-!.
  s_constdef([t(num(STR),_)|TOKL],TOKL,constdef(STR)):-!.
  s_constdef([t(TOK,_)|TOKL],TOKL,_):-
	beep,
	write("Constdef: TOK=",TOK),nl,fail.

  s_basisdom([t(id(ID),_),NEXT|LL],[NEXT|LL],ID):-
	upper_lower(ID,LID),
	is_basisdom(LID),
	not(NEXT=t(lpar,_)), not(NEXT=t(or_,_)),!.

  s_retdom([t(id(ID),_),NEXT|LL],[NEXT|LL],retdom(ID)):-
	is_dom(ID),!.
  s_retdom(LL,LL,none).


  s_flowpatterns(LL1,LL0,[FLOWPATTERN|FLOWPATTERNS]):-
	s_flowpattern(LL1,LL2,FLOWPATTERN),!,
	s_flowpatterns1(LL2,LL0,FLOWPATTERNS).
  s_flowpatterns(LL,LL,[]).

  s_flowpatterns1([t(comma,_)|LL1],LL2,FLOWPATTERNS):-!,
	s_flowpatterns(LL1,LL2,FLOWPATTERNS).
  s_flowpatterns1([t(lpar,POS)|LL1],LL2,FLOWPATTERNS):-!,
	s_flowpatterns([t(lpar,POS)|LL1],LL2,FLOWPATTERNS).
  s_flowpatterns1(LL,LL,[]).

  better_error(CURSOR):-
	error(_,OLDCURSOR), OLDCURSOR>=CURSOR, !, fail.
  better_error(_).

  new_error(MSG,CURSOR):-retractall(error(_,_)), assert(error(MSG,CURSOR)).

  expect(TOK,[TOK|L],L):- !.
  expect(t(id(_),_),[t(_,CURSOR)|_],_):- !,
  	better_error(CURSOR),
  	new_error("Identifier expected",CURSOR),
  	fail.
  expect(t(TOK,_),[t(_,CURSOR)|_],_):-
	better_error(CURSOR),
ifdef c_scanner
  	str_tok(STR,TOK1), TOK1=TOK, !,	% Avoid comp. flow
elsedef
  	str_tok(STR,TOK),
enddef
	concat(STR," expected",MSG),
	new_error(MSG,CURSOR),
  	fail.


  syntax_error(PROD,[t(_,CURSOR)|_]):-
	better_error(CURSOR),
	concat("Syntax error in ",PROD,MSG),
	new_error(MSG,CURSOR),fail.

ifndef c_scanner
  scan_error(MSG,CURSOR):- ed(MSG,CURSOR),fail.
enddef

  checkempty([]):- !.
  checkempty([t(_,CURSOR)|_]):-
	better_error(CURSOR),
	new_error("Syntax error",CURSOR).

/*
  ed(MSG,CURSOR):-
	source(TXT),
	edit(TXT,TXT1,"","",MSG,CURSOR,"",RET),
	RET><1,!,
	change(source(TXT1)).
*/
  ed(MSG,CURSOR):-
	beep,
	write(MSG,' ',CURSOR).
/*
  checkerror:-
	error(MSG,CURSOR),
	ed(MSG,CURSOR),
	!,fail.
  checkerror.
*/
  change(source(_)):-retractall(source(_)), fail.
  change(filename(_)):-retractall(filename(_)), fail.
  change(X):- assert(X).

  repparse.
  repparse:-
	error(MSG,CURSOR),
	nl,write(MSG),nl,
	writef("At position: % in source\n",CURSOR),
	write("Use GOTO POSITION in prolog system to locate place\n"),
%	readkey(_),
	fail.

  process(OUTPUTFILE):-
	retractall(known(_)),
	retractall(known_selector(_,_)),
	retractall(dom(_,_)),
	retractall(refdom(_)),
	retractall(cpred(_,_,_,_,_,_)),
	retractall(referred_dom(_)),
	retractall(known_globstruct(_,_)),
	repparse,
	retractall(error(_,_)),
	source(STR1),
	write("\n--->SCAN"),
ifdef c_scanner
	scanner(STR1,L),
elsedef
	tokl(1,STR1,L),
enddef
	write("\n--->PARSE"),
	s_prologdecl(L,L1,X),
	checkempty(L1),
	!,
%	checkerror,
	write("\n--->ASSERT"),
	assertdecls(X),
	save("dd.dat",declarations),
	gen_recursive_refdoms,
	gen_recursive_referreddoms,
	write("\n--->GEN C TYPES"),
	openwrite(out,OUTPUTFILE),
	writedevice(out),
	assert(pro_resnames),
	gencdefs,
	genctypes,
	retractall(pro_resnames),
	gen_c_procedures,
	nl,
	closefile(out),
	write("\n",OUTPUTFILE," Generated").
  process(_):-
	write(">> Parsing aborted"),nl,beep.

GOAL	
	comline(L),
	filenameext(FILENAME, L, ".PRO"),
	filenameext(OUTPUTFILE, L, ".C"),
	existfile(FILENAME),
	file_str(FILENAME,SOURCE),
	change(source(SOURCE)),
	process(OUTPUTFILE)
	;
	comline(L),
	write("File |",L,"| not found").


CLAUSES
  filename("work.pro").
  source("").
