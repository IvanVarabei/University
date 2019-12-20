/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  WEBESTA
 FileName: W3EDB.PRO
 Purpose: 
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "w3esta.inc"

CLAUSES
  store(SID,GLOBID,VALUE):-	
  	retractall(environment(SID,GLOBID,_)),
        assert(environment(SID,GLOBID,VALUE)).
 
 
  set_curfname(SID,_)     :-  retract(mem(SID,curfname,_)),fail.
  set_curfname(SID,FNAME) :-  assert(mem(SID,curfname,FNAME)).
 
  get_curfname(SID,FNAME) :-  mem(SID,curfname,FNAME),!.
  get_curfname(_,"").
  
  resetknow (SID) :- resetknow1(SID) ,fail.
  resetknow (SID) :- resetmachine (SID).
 
  resetknow1 (SID):- retractall(evalue_(SID,_,_,_)),
		     retractall(vars_(SID,_,_,_,_,_,_,_,_)),
		     retractall(paragraph_(SID,_,_,_,_)),
		     retractall(section_(SID,_,_,_)),
		     retractall(title_(SID,_)).
	
  resetmachine (SID) :- retractall(evalue_(SID,_,_,_)),
 		        retractall(session(SID,_)),
		        retractall(environment(SID,_,_)),
		        retractall(textposition(SID,_,_)),
		        retractall(checkerrorposition(SID,_,_,_)),
		        retract_cons_inf(SID),
		        clear_answer(SID),
		        clear_replay(SID),
		        clear_advice(SID).

  reset_definitions:-	%RESET ALL VALUES CONSULTED FROM ESTA.DEF
                retractall(_,definitions).


  resetDB(SID,1):- !,resetknow(SID).	%Reset when consulting new VDB 
  resetDB(_,3):- reset_definitions.

PREDICATES
  wr_status(SID,string,string,string,string)
  
CLAUSES
  wr_status(SID,TXT,ID,CANCEL,STR):-
        txt(TXT,TXT1),
        format(STR,TXT1,ID),
        concat(STR,CANCEL,STRCANCEL),
        report (SID,STRCANCEL).

/***************************************************************************/

  txt(S,T)   :-  txt1(S,T),!.
/*
  txt(S,"")  :-  txt1(main_symbmiss,MS),
                 format(STR,MS,S),
                 warning_msg (STR),!.
*/
  txt(_,"").              
  
  tok_str(T,S) :- tok_str1(T,S) ,!.
  tok_str(T,S) :- tok_keyw_str(T,S),!.
  tok_str(T,TS):- bound(T),txt("tok_error_str",TS).

  change_evalue(SID,VID,_,_) :- retract(evalue_(SID,VID,_,_)),fail.
  change_evalue(SID,VID,VAL,assign(SECT)) :- assertz(evalue_(SID,VID,VAL,assign(SECT))).

/*************************************************************/

  retrieve(SID,ID,VALUE):-  environment(SID,ID,VALUE),!.
  retrieve(_,_,nill).     

/*************************************************************
  Predicates to control consultation replaying
**************************************************************/
CLAUSES
  set_replay(SID,ANS_PATH) :- retractall(replay(SID,_)),assert(replay(SID,ANS_PATH)).

  clear_replay(SID) :- retractall(replay(SID,_)),assert(replay(SID,[])).
  
  add_answer_to_path(SID,Answer) :- 
  	retract(answers(SID,PrevAnswers)),!,
  	assert(answers(SID,[Answer|PrevAnswers])).
  
  clear_answer (SID) :- retractall(answers(SID,_)),assert(answers(SID,[])).
  	