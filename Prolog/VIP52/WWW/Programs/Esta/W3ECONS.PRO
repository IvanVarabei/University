/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3ECONS.PRO
 Purpose: WWW version of ESTA. Inference machine
 Written by:
 Comments:
 
 13.12.97  OE  Add per session subsets
 
******************************************************************************/

include "w3esta.inc"

%%%% LOOK AT CONSHLP.PRO FOR AUXILIARY HLP TEST PREDICATES 
 
PREDICATES
  setrefsectpno(SID,ID,PNO) 
  getrefsectpno(SID,ID,PNO) 
 
  get_session(SID,PNODES) 
  retr_evalue(SID,ID)
  set_ppath(SID,PPATH)
  set_spath(SID,SPATH)
  
  /**************************************************************/
  /*	 	INFERENCE MECHANISM				*/
  /**************************************************************/

  inf_prules    (SID,ID,PHRASERULES,INTEGER,INTEGER,EVALUE)
  inf_prule     (SID,ID,PHRASERULE,EVALUE)
  inf_prules2   (SID,ID,EVALUE,INTEGER,INTEGER,PHRASERULES,EVALUE)
  inf_restprule (SID,ID,EVALUE,EXPL,EVALUE)

  inf_crules  (SID,ID,CATRULES,INTEGER,INTEGER,EVALUE)  
  inf_crules2 (SID,ID,EVALUE,INTEGER,INTEGER,CATRULES,EVALUE)  
  inf_crule   (SID,ID,CATRULE,EVALUE)  
  inf_restcat (ID,EVALUE,OPTION,EVALUE)  

  inf_fnrules  (SID,ID,FNRULES,INTEGER,INTEGER, EVALUE)  
  inf_fnrules2 (SID,ID,EVALUE,INTEGER,INTEGER, FNRULES, EVALUE) 
  inf_fnrule   (SID,ID,FNRULE, EVALUE) 
  inf_restif   (SID,ID,EVALUE,EXP,EVALUE)

% inf_rest(EVALUE,EVALUE) 
  inf_varx(SID,ID,EVALUE)
  inf_var(SID,ID,EVALUE)	           %- (I,O,I)

  str_stritem(SID,integer,STRING,EXPL)  %- (O,I,I)
  strl_stritem(SID,SLIST,EXPL)     %- (O,I,I)

  read_answer(SID,STRING,ID)
  menuvalg_value(INTEGER,EVALUE,STRING)
  get_fact(SID,STRING,ID,EVALUE)
  get_kategori(SID,STRING,ID,OPTIONDEFS,Slist,STRING)
  sel_op(INTEGER,OPTIONDEFS,EVALUE,STRING)

%str_numb(STRING,EVALUE)  
  get_number(SID,STRING,ID,RANGE,EVALUE)  
  nval_real(EVALUE,REAL) 
 
  within_range(SID,STRING,ID,EVALUE,RANGE,EVALUE)
 
  construct_askstring(SID,ID,EXPL,STRING)
 
        /* RULES angiver ogs† typen */ 
        
  calc_var(SID,ID,EVALUE,EXPL,RULES,UNI_METHOD)
                           /* rule number used */
 
  calc_var2(SID,ID,EVALUE,EVALUE,INTEGER,UNI_METHOD)
  mk_empty_rule(RULES,RULES)

  inf_callexplist(SID,ID,EXPL,EVALUELIST)	% MU
  inf_explist(SID,EXPL,EVALUELIST)		% MU
  inf_exp(SID,EXP,EVALUE)			% MU
  inf_dyadexp(SID,EXP,EXP,EVALUE,EVALUE)	% MU
  sum(EVALUE,EVALUE,EVALUE)
  minus(EVALUE,EVALUE,EVALUE)
  mult(EVALUE,EVALUE,EVALUE)
  div(SID,EVALUE,EVALUE,EVALUE)			% MU
  inf_andbool(SID,EVALUE,EXP,EVALUE)		% MU
  inf_orbool(SID,EVALUE,EXP,EVALUE)		% MU
  inf_not(EVALUE,EVALUE)
  inf_relat(TOKN,EVALUE,EVALUE,EVALUE)
  inf_rel(TOKN,EVALUE,EVALUE,EVALUE)
  negated(EVALUE,EVALUE)

  is_state_terminate(STRING)
 
  inferact(SID,STRING)
  infer(SID,ID,PNO,QUITED)
  infer2(SID,ID,PNO,EVALUE,ACTIONS,ANODES,QUITED) 
  find_var(SID,ID)
 
  do_actions(SID,ID,PNO,ACTNO,ACTIONS,QUITED,ANODES)	% MU
  do_action(SID,ID,PNO,ACTNO,ACTION,ANODE)		% MU
  eval_assign(SID,ID,ID,EXP) 				% MU
  get_optionlist(OPTIONDEFS,Slist)
  select_option(INTEGER,OPTIONDEFS,OPTIONDEF) 
  fail_if_end_consult   (SID)
  succes_if_end_consult (SID)
  wrnolonger(SID,EVALUE) 
  wrnoadv(SID,ANODES)
  wradvpnodes(SID,PNODES)
  check_cyclus(SID,ID,SPATHL)
 
CLAUSES

/**************************************************************/
/*	 	EXIT PREDICATE AFTER A MODELESS DIALOG        */
/**************************************************************/
%
%   Add session ID to each database clause
%   to define per session subsets
%
DATABASE - status
  sectpno(SID,ID,PNO)     % Section number and paragraph number
  refsectpno(SID,ID,PNO)  % Reference section and paragraph number
  cur_vid(SID,ID)         % Current parameter name
  boolcat(SID,string)   
  options(SID,optiondefs) 
  numb_range(SID,range)
  askstr(SID,string)
  answertype(SID,string)  
  p_list(SID,PPATHL)  
  s_list(SID,SPATHL)
  session_value(SID,ID,PNO,ID,PNO,EVALUE,ANODES) % Reference section,pno
  action_done(SID,ID,PNO,ID,PNO,INTEGER,ANODE)   % Reference section,pno
  chain_filename(SID,string)
  
DATABASE - prev_values
  prev_value(SID,ID,PNO,ID,PNO,EVALUE,ANODES) 

DATABASE - chain_filename
  chain_name(SID,STRING)
  
PREDICATES
  set_p_list(SID,PPATHL)
  set_s_list(SID,SPATHL)
  set_cur_vid(SID,ID)
  clear_cur_vid(SID)
  getsectpno(SID,ID,PNO)
  save_session_values(SID)
  add_anode(SID,ID,PNO,ANODE)
  add_pnode(SID,PNODE)
  get_chain_name(SID,STRING)
  set_chain_name(SID,STRING)
  
  add_p(PPATH,PPATHL,PPATHL)
  add_p(SPATH,SPATHL,SPATHL)
  add_p(PNODE,PNODES,PNODES)
  add_p(ANODE,ANODES,ANODES)
  memb_s(SPATH,SPATHL)
  memb_s(PPATH,PPATHL)
  memb_s(PNODE,PNODES)
  memb_s(ANODE,ANODES)
  
CLAUSES
  save_session_values (SID):-
    retractall(prev_value(SID,_,_,_,_,_,_)),
    retract(session_value(SID,RID,RPNO,ID,PNO,EVALUE,ANODES)),
  %   str_int(PNOS,PNO),                                
  %   format(STR,"S: % P: %",ID,PNOS),                                
  %   remarkmsg(STR),
  %    wranodes(ANODES),
      assert(prev_value(SID,RID,RPNO,ID,PNO,EVALUE,ANODES)),
    fail.
  save_session_values(_).
%
%  retractall session's database subset (as retractall(_,status))
%
  retract_cons_inf (SID) :- 
  	retractall(sectpno(SID,_,_)),
	retractall(refsectpno(SID,_,_)),
	retractall(cur_vid(SID,_)),
	retractall(boolcat(SID,_)),   
	retractall(options(SID,_)), 
	retractall(numb_range(SID,_)),
	retractall(askstr(SID,_)),
	retractall(answertype(SID,_)),  
	retractall(p_list(SID,_)),  
	retractall(s_list(SID,_)),
	retractall(session_value(SID,_,_,_,_,_,_)),
	retractall(action_done(SID,_,_,_,_,_,_)),
	retractall(chain_filename(SID,_)).
  
  memb_s(X,[X|_])   :- !.
  memb_s(X,[_|Rest]):- memb_s(X,Rest).
  
  set_s_list(SID,SL) :- retractall(s_list(SID,_)),assert(s_list(SID,SL)).
  set_p_list(SID,PL) :- retractall(p_list(SID,_)),assert(p_list(SID,PL)).

  set_ppath(SID,P) :- get_ppathl(SID,PL),add_p(P,PL,PL1),set_p_list(SID,PL1).
  get_ppathl(SID,PL):- p_list(SID,PL),!.
  get_ppathl(_,[]).
  
  set_spath(SID,P) :- get_spathl(SID,PL),add_p(P,PL,PL1),set_s_list(SID,PL1).
  get_spathl(SID,PL):- s_list(SID,PL),!.
  get_spathl(_,[]).

  add_p(X,L,L)  :- memb_s(X,L),!.
  add_p(X,L,[X|L]).
  
  add_anode(SID,ID,PNO,A):- 
     getrefsectpno(SID,RID,RPNO),
     session_value(SID,RID,RPNO,ID,PNO,VAL,ANODES), 
     add_p(A,ANODES,ANODES1),
     retractall(session_value(SID,RID,RPNO,ID,PNO,_,_)), 
     assert(session_value(SID,RID,RPNO,ID,PNO,VAL,ANODES1)),!.
  add_anode(_,_,_,_).

  add_pnode(SID,P):-
     get_session(SID,PS),
     add_p(P,PS,PS1),
     retractall(session(SID,_)),
     assert(session(SID,PS1)).
  
  get_chain_name(SID,C):- chain_name(SID,C),!.
  
  set_chain_name(SID,C):- retractall(chain_name(SID,_)),assert(chain_name(SID,C)).
  
/****************** Current Value Id ******************************/
% OE 13.12.97 session subsets
  get_cur_vid(SID,ID) :- cur_vid(SID,ID),!.
  get_cur_vid(_,"").

  set_cur_vid(SID,ID) :- retractall(cur_vid(SID,_)),assert(cur_vid(SID,ID)).
  
  ex_cur_vid(SID,ID) :- cur_vid(SID,ID),!.

  clear_cur_vid(SID) :- retractall(cur_vid(SID,_)).

/****************** Create consult status line *********************/
%  13.12.97  OE I haven't any ideas about status message in W3 version
  consult_statusmsg(_).
  /*  :-
    getsectpno(SectID,_),
    get_cur_vid(VID),
    txt(stline,SL),
    format(STR,SL,SectID,VID),
    statusmsg(STR).
  */
/******************* Boolean type for category ********************/
% 13.12.97 OE Per session subset
PREDICATES
  set_booltype(SID,string)
  get_booltype(SID,string)
CLAUSES
  set_booltype(SID,Type) :- retractall(boolcat(SID,_)),assert(boolcat(SID,Type)).   
  get_booltype(SID,Type) :- boolcat(SID,Type),!.  
  
/******************* Option definitions for category ***************/
% 13.12.97 OE Per session subset
PREDICATES
  set_optiondefs(SID,OPTIONDEFS)
  get_optiondefs(SID,OPTIONDEFS)
CLAUSES
  set_optiondefs(SID,OD) :- retractall(options(SID,_)),assert(options(SID,OD)).
  get_optiondefs(SID,OD) :- options(SID,OD),!.

/******************** Range used in reading numbers ****************/
% 13.12.97 OE Per session subset
PREDICATES
  set_range(SID,RANGE)
  get_range(SID,RANGE)
CLAUSES
  set_range(SID,RANGE) :- retractall(numb_range(SID,_)),assert(numb_range(SID,RANGE)).
  get_range(SID,RANGE) :- numb_range(SID,RANGE),!.

/******************* ASK QUESTION ***********************************/
% 13.12.97 OE Per session subset
PREDICATES
  set_askstr(SID,string)
  get_askstr(SID,string)
CLAUSES
  set_askstr(SID,Type) :- retractall(askstr(SID,_)),assert(askstr(SID,Type)).
  get_askstr(SID,Type) :- askstr(SID,Type),!.

/******************* Answer type ***********************************/
% 13.12.97 OE Per session subset
PREDICATES
  set_answertype(SID,string)
  get_answertype(SID,string)
CLAUSES
  set_answertype(SID,Type) :- retractall(answertype(SID,_)),assert(answertype(SID,Type)).
  get_answertype(SID,Type) :- answertype(SID,Type),!.
  
/**************** Modeless dialogs ************************/
% 13.12.97 OE Per session subset
PREDICATES
  store_dlg_value(SID,EVALUE)
  get_param_picture(SID,string,string)
  has_picture(SID,ID,string,string)
  call_modeless_dlg(SID,ID,STRING,Slist,STRING)
  get_sys_name (string SYSNAME)
  get_usr_name (string USRNAME)
CLAUSES
  store_dlg_value(SID,EVALUE):-
	get_cur_vid(SID,CURVID),
   	assert(evalue_(SID,CURVID,EVALUE,question)),
   	clear_cur_vid(SID).     % reset current parameter

  get_param_picture(SID,PIC,PIC1):-
  	picture_is_parameter(PIC,PARAM),
  	PARAM1 = PARAM,
  	evalue_(SID,PARAM2,PIC0,_),
  	upper_lower(PARAM1,PARAM2),
  	PIC0 = str(PIC1),!.
  get_param_picture(_,PIC,PIC).

  has_picture(SID,VID1,TYPE,CTRLTYPE):-
 	vars_(SID,_,VID,_,_,_,_,_,PIC), 
 	upper_lower(VID1,VID),
 	chng_picture(SID,PIC),                % For at rydde op i logfilen
 	not(PIC=""),!,
 	get_param_picture(SID,PIC,PIC1),
 	chng_picture(SID,PIC1),
 	concat("pic_",TYPE,CTRLTYPE).
  has_picture(_,_,TYPE,TYPE). 
 
  call_modeless_dlg(SID,CURVID,ASKSTR,LIST,QUEST_TYPE):-
    	set_cur_vid(SID,CURVID),
    	has_picture(SID,CURVID,QUEST_TYPE,CTRLTYPE),
    	consult_dlg(SID,CTRLTYPE,ASKSTR,LIST),
    	consult_statusmsg(SID),
    	store(SID,exitstatus,exit).
   
/**********************************************************/
% 13.12.97 OE Per session subset
  get_kategori(SID,ASKSTR,CURVID,OPTIONDEFS,LIST,TYPE):-
  	set_booltype(SID,TYPE),
    	set_optiondefs(SID,OPTIONDEFS),
    	term_str (slist,LIST,OPTSTR),
	get_sys_name(SYSNAME),
    	format (LogAsk,"%s: %s",SYSNAME,ASKSTR),
	add_log_questansw (SID,"question",LogAsk),
	add_log_questansw (SID,"question",OPTSTR),
	%format(M,"<br><b>Call dailog to establish the %s</b>",CURVID),
	%report(SID,M),
    	call_modeless_dlg(SID,CURVID,ASKSTR,LIST,"listbox").
    
 get_sys_name (SYSNAME) :- txt ("sys_name",SYSNAME),!.
 get_sys_name ("ESTA").
 
 get_usr_name (USRNAME) :- txt ("usr_name",USRNAME),!.
 get_usr_name ("USER").
/**************  Select and store option from category *******************/

%conversion table used for boolmenu only.

PREDICATES
  str_boolean(S,EVALUE)

CLAUSES
  str_boolean(S,true):-    tok_str(true,S2),    upper_lower(S,S2),!.
  str_boolean(S,false):-   tok_str(false,S2),   upper_lower(S,S2),!.
  str_boolean(S,unknown):- tok_str(unknown,S2), upper_lower(S,S2),!.

PREDICATES
  get_catvalue(SID,EVALUE,EVALUE)

CLAUSES
  store_cat(SID,CH):-
  	get_optiondefs(SID,OPTIONDEFS),
  	sel_op(CH,OPTIONDEFS,EVALUE,SVARSTR),
  	get_usr_name (USRNAME),
  	format (ANSWER,"%s: %s",USRNAME,SVARSTR),
  	add_log_questansw(SID,"answer",ANSWER),
  	get_catvalue(SID,EVALUE,EVALUE1),
  	store_dlg_value(SID,EVALUE1).

  store_cat_hotspot(SID,OPT):-
  	get_usr_name (USRNAME),
  	format (ANSWER,"%s: %s",USRNAME,OPT),
  	add_log_questansw(SID,"answer",ANSWER),
  	get_catvalue(SID,str(OPT),EVALUE1),
  	store_dlg_value(SID,EVALUE1).
 
  get_catvalue(SID,EVALUE,EVALUE1):-
  	get_booltype(SID,Type),Type = "bool_yes",!,
  	EVALUE = str(BOOLSTR),
  	str_boolean(BOOLSTR,EVALUE1).

  get_catvalue(_,EVALUE,EVALUE).

/*************** Select option *******************************************/

  sel_op(CH,OPDEFS,str(SY),SVARSTR):-                
       select_option(CH,OPDEFS,ODEF),	 	    
       ODEF=option(SY,SVARSTR),!.	    

  get_optionlist([],[]).
  get_optionlist([option(_,SH)|T],[SH|ST]):-
	get_optionlist(T,ST).

  select_option(1,[O|_],O) :- !.
  select_option(N,[_|L],OPTIONDEF)  :- 
       N >1 , N1=N-1,
       select_option(N1,L,OPTIONDEF).

PREDICATES
  find_option(OPTIONDEFS,string,string)

CLAUSES
  find_option([option(OPT,OPT1)|_],OPT,OPT1):- !.
  find_option([_|R],OPT,OPT1):- find_option(R,OPT,OPT1).

  get_listbox_option(SID,OPT,OPT1):-
       get_optiondefs(SID,OPDEFS),
       find_option(OPDEFS,OPT,OPT1),!.
       
/**************************************************************************/
% 13.12.97 OE Per session subset
  get_fact(SID,ASKSTR,CURVID,unsolveable) :- 
	get_sys_name (SYSNAME),
	format (LogAsk,"%s: %s",SYSNAME,ASKSTR),
	add_log_questansw (SID,"question",LogAsk),
	%format(M,"<br><b>Call dailog to establish the %s</b>",CURVID),
	%report(SID,M),
      	call_modeless_dlg(SID,CURVID,ASKSTR,[],"boolean").

  store_fact(SID,CH):-
      	menuvalg_value(CH,EVALUE,ASTR),
      	get_usr_name (USRNAME),
  	format (ANSWER,"%s: %s",USRNAME,ASTR),
      	add_log_questansw(SID,"answer",ANSWER),
      	store_dlg_value(SID,EVALUE).

  menuvalg_value(1,true,A)   :- txt("aux_yes",A),!.
  menuvalg_value(2,false,A)  :- txt("aux_no",A),!.
  menuvalg_value(3,unknown,A):- txt("aux_unknown",A).

/***************************************************************************/   
% 13.12.97 OE Per session subset
  read_answer(SID,ASKSTR,CURVID) :-
	get_sys_name (SYSNAME),
	format (LogAsk,"%s: %s",SYSNAME,ASKSTR),
	add_log_questansw (SID,"question",LogAsk),
	%format(M,"<br><b>Call dailog to establish the %s</b>",CURVID),
	%report(SID,M),
      	call_modeless_dlg(SID,CURVID,ASKSTR,[],"edit").

PREDICATES
  get_answer(SID,string,id,string,evalue)

CLAUSES
  store_answer(SID,STR) :-
	get_usr_name (USRNAME),
	format (ANSWER,"%s: %s",USRNAME,STR),
      	add_log_questansw(SID,"answer",ANSWER),
      	get_cur_vid(SID,VID),
      	get_answertype(SID,Type),
      	get_answer(SID,Type,VID,STR,EVALUE),
      	store_dlg_value(SID,EVALUE).

  get_answer(SID,"numb",_,EVALUE,EVALUE1):- !,str_numb(SID,EVALUE,EVALUE1).
  get_answer(SID,"numb_range",VID,EVALUE,EVALUE2):-!,
   	str_numb(SID,EVALUE,EVALUE1),
   	get_askstr(SID,ASK),
   	get_range(SID,RANGE),               
   	within_range(SID,ASK,VID,EVALUE1,RANGE,EVALUE2).
  get_answer(_,_,_,EVALUE,str(EVALUE)).
             
  get_number(SID,ASKSTR,VID,none,unsolveable) :- 
  	set_answertype(SID,"numb"),
     	read_answer(SID,ASKSTR,VID),
     	fail_if_end_consult(SID),!.
     
  get_number(SID,ASKSTR,VID,RANGE,unsolveable) :- 
     	fail_if_end_consult(SID),
     	set_range(SID,RANGE),
     	set_askstr(SID,ASKSTR),
     	set_answertype(SID,"numb_range"),
     	read_answer(SID,ASKSTR,VID),!.
     
  str_numb(_,STRTAL,int(NVAL))     :- str_int(STRTAL,NVAL),!.
  str_numb(_,STRTAL,float(NVAL)) :- str_real(STRTAL,NVAL),!.
  str_numb(SID,_,unsolveable)    :- symb_error_msg(SID,answ_intg_err),fail.
 
  nval_real(int(X),Z)   :- trap(term_str(integer,X,S),_,fail),str_real(S,Z),!.
  nval_real(float(X),X) :- !.

  within_range(_,_,_,int(IV),range(VMIN,VMAX),int(IV)) :-
      	nval_real(VMIN,MIN),nval_real(VMAX,MAX),
      	IV >= MIN, IV <= MAX,!.
  within_range(_,_,_,float(V),range(VMIN,VMAX),float(V)) :-
      	nval_real(VMIN,MIN),nval_real(VMAX,MAX),
      	V >= MIN, V <= MAX,!.
  within_range(SID,ASKSTR,VID,_,range(IMIN,IMAX),EVALUE) :-
     	val_str(IMIN,IMINS),
     	val_str(IMAX,IMAXS),
     	txt(cons_within,T1),txt(cons_to,T2),
     	format(S4,"\% % % %",T1,IMINS,T2,IMAXS),
     	remarkmsg(SID,S4),
     	get_number(SID,ASKSTR,VID,range(IMIN,IMAX),EVALUE),!.

  construct_askstring(SID,VID,ASK,ASK2) :-
    	set_ppath(SID,phrase(ASK)),    
    	str_stritem(SID,0,ASKSTR,ASK),
    	set_cur_vid(SID,VID),
    	strip(ASKSTR,L),
    	mk_askstring(SID,L,VID,ASK2).

  mk_askstring(SID,"",VID1,SD) :-
    	vars_(SID,_,VID,_,_,_,VTY,_,_),
    	upper_lower(VID,VID1),VTY=fact,!,
    	get_var_descr(SID,VID,DESCR),
    	txt(cons_isittrue,TXT),
    	format(SD,"% %? ",TXT,DESCR).
  mk_askstring(SID,"",VID,SD) :-
    	get_var_descr(SID,VID,DESCR),
    	txt(cons_whatis,TXT),
    	format(SD,"% %? ",TXT,DESCR),!.
  mk_askstring(_,ASK,_,ASK).

/*********************  Calculate Variable **********************************************/
% 13.12.97 OE Per session subset
  calc_var(SID,VID,EVALUE,ASK,fact([]),question):-!,
    	construct_askstring(SID,VID,ASK,ASKSTR),
    	get_fact(SID,ASKSTR,VID,EVALUE).
  calc_var(SID,VID,unsolveable,ASK,fact([boolmenu(OPTIONDEFS)]),question):-!,
    	fail_if_end_consult(SID),
    	get_optionlist(OPTIONDEFS,LIST),
    	construct_askstring(SID,VID,ASK,ASKSTR),
    	get_kategori(SID,ASKSTR,VID,OPTIONDEFS,LIST,"bool_yes"),!.
  calc_var(SID,VID,unsolveable,ASK,fact([boolmenu(OPTIONDEFS),boolfacts([])]),question):-!,
    	fail_if_end_consult(SID),
    	get_optionlist(OPTIONDEFS,LIST),
    	construct_askstring(SID,VID,ASK,ASKSTR),
    	get_kategori(SID,ASKSTR,VID,OPTIONDEFS,LIST,"bool_yes"),!.
  calc_var(SID,VID,BOOLVALUE,ASK,fact([boolmenu(_),boolfacts(FRULES)]),UNIMETHOD):-
    	not(FRULES = []),
    	calc_var(SID,VID,BOOLVALUE,ASK,fact(FRULES),UNIMETHOD),!.
  calc_var(SID,VID,VAL2,_,fact(FRULES),UNIMETHOD):-!,
    	fail_if_end_consult(SID),
    	inf_fnrules(SID,VID,FRULES,0,RNO,VAL1),
    	calc_var2(SID,VID,VAL1,VAL2,RNO,UNIMETHOD),!.
  calc_var(SID,VID,EVALUE,ASK,number(RANGE,[]),question):- !,
    	fail_if_end_consult(SID),
    	construct_askstring(SID,VID,ASK,ASKSTR),
    	get_number(SID,ASKSTR,VID,RANGE,EVALUE).
  calc_var(SID,VID,VAL2,_,number(_,NRULES),UNIMETHOD):-!,
    	fail_if_end_consult(SID),
    	inf_fnrules(SID,VID,NRULES,0,RNO,VAL1),
    	calc_var2(SID,VID,VAL1,VAL2,RNO,UNIMETHOD),!.
  calc_var(SID,VID,unsolveable,ASK,category(OPTIONDEFS,[]),question):-!,
    	fail_if_end_consult(SID),
    	get_optionlist(OPTIONDEFS,LIST),
    	construct_askstring(SID,VID,ASK,ASKSTR),
    	get_kategori(SID,ASKSTR,VID,OPTIONDEFS,LIST,"bool_no"),!.
  calc_var(SID,VID,VAL2,_,category(_,CRULES),UNIMETHOD):- !,
    	fail_if_end_consult(SID),
    	inf_crules(SID,VID,CRULES,0,RNO,VAL1),
    	calc_var2(SID,VID,VAL1,VAL2,RNO,UNIMETHOD),!.
  calc_var(SID,VID,unsolveable,ASK,phrase([]),question):-!,
    	construct_askstring(SID,VID,ASK,ASKSTR),
    	set_answertype(SID,"str"),
    	read_answer(SID,ASKSTR,VID),!.
  calc_var(SID,VID,VAL2,_,phrase(PRULES),UNIMETHOD):- !,
    	fail_if_end_consult(SID),
    	inf_prules(SID,VID,PRULES,0,RNO,EVALUE),
    	calc_var2(SID,VID,EVALUE,VAL2,RNO,UNIMETHOD),!.
            
  calc_var2(SID,VID1,unsolveable,EVALUE,_,UNIM) :- !,
     	fail_if_end_consult(SID),
     	set_cur_vid(SID,VID1),
     	vars_(SID,_,VID,_,_,ASK,_,RU,_),
     	upper_lower(VID,VID1),!,
     	mk_empty_rule(RU,ERU),
     	calc_var(SID,VID,EVALUE,ASK,ERU,UNIM).
  calc_var2(SID,_,VAL,VAL,RNO,rule(RNO)) :- fail_if_end_consult(SID),!.

  mk_empty_rule(number(RANGE,_),number(RANGE,[])) :- !.
  mk_empty_rule(fact([boolmenu(B),boolfacts(_)]),fact([boolmenu(B),boolfacts([])])):- !.
  mk_empty_rule(fact(_),fact([])) :- !.
  mk_empty_rule(category(OD,_),category(OD,[])) :- !.
  mk_empty_rule(phrase(_),phrase([])) :- !.

/**************************************************************************/
  inf_crules(SID,VID, [H|T] ,RNO1,RNO2,EVALUE) :- 
    	inf_crule(SID,VID,H,EVALUE1),
    	RNO3=RNO1+1,
    	inf_crules2(SID,VID,EVALUE1,RNO3,RNO2,T,EVALUE) ,!.
   
  inf_crules2(SID,VID,unsolveable,RNO1,RNO2,T,EVALUE)  :-
    	fail_if_end_consult(SID),
    	inf_crules(SID,VID,T,RNO1,RNO2,EVALUE),!.
  inf_crules2(SID,_,EVALUE,RNO,RNO,_,EVALUE) :- fail_if_end_consult(SID),!.

  inf_crule(SID,VID,if_(OPTION,BEXP2),EVALUE) :-
    	inf_exp(SID,BEXP2,VAL2),  
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,cond(BEXP2)),
    	inf_restcat(VID,VAL2,OPTION,EVALUE),!.
  inf_crule(_,_,opt(OPT),str(STR)) :- upper_lower(STR,OPT),!.

  inf_restcat(_,true,OPTID,str(STR)) :- upper_lower(STR,OPTID),!.
  inf_restcat(_,_,_,unsolveable).	

  inf_prules(SID,VID,[H|T],RNO1,RNO2,EVALUE) :- 
    	inf_prule(SID,VID,H,EVALUE1),
    	RNO3=RNO1+1,
    	inf_prules2(SID,VID,EVALUE1,RNO3,RNO2,T,EVALUE),!.
     
  inf_prules2(SID,VID,unsolveable,RNO1,RNO2,T,EVALUE) :-
    	fail_if_end_consult(SID),
    	inf_prules(SID,VID,T,RNO1,RNO2,EVALUE),!.
  inf_prules2(SID,_,EVALUE,RNO,RNO,_,EVALUE) :- fail_if_end_consult(SID),!.

  inf_prule(SID,VID,if_(SI,BEXP),EVALUE2) :-
    	inf_exp(SID,BEXP,VAL1),  
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,cond(BEXP)),
    	inf_restprule(SID,VID,VAL1,SI,EVALUE2),!.
  inf_prule(SID,VID,str(SI),str(STR)) :-
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,phrase(SI)),
    	str_stritem(SID,1,STR1,SI),
    	strip(STR1,STR),!.

  inf_restprule(SID,VID,true,SI,str(S)) :-
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,phrase(SI)),
    	str_stritem(SID,1,S1,SI),
    	strip(S1,S),!.
  inf_restprule(_,_,_,_,unsolveable). 

  inf_fnrules(SID,VID, [H|T] ,RNO1,RNO2,EVALUE) :- 
    	inf_fnrule(SID,VID,H,EVALUE1),
    	RNO3=RNO1+1,
    	inf_fnrules2(SID,VID,EVALUE1,RNO3,RNO2,T,EVALUE) ,!.
   
  inf_fnrules2(SID,VID,unsolveable,RNO1,RNO2,T,EVALUE)  :-
    	fail_if_end_consult(SID),
    	inf_fnrules(SID,VID,T,RNO1,RNO2,EVALUE),!.
	inf_fnrules2(SID,_,EVALUE,RNO,RNO,_,EVALUE) :- fail_if_end_consult(SID),!.

  inf_fnrule(SID,VID,exp(EXP),VAL)  :-
    	inf_exp(SID,EXP,VAL),
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,exp(EXP)),!.
    
  inf_fnrule(SID,VID,boolexp(BEXP),VAL)  :-
    	inf_exp(SID,BEXP,VAL),
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,cond(BEXP)),!.
      
  inf_fnrule(SID,VID,if_(BEXP1,BEXP2),EVALUE) :-
    	inf_exp(SID,BEXP2,VAL2),  
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,cond(BEXP2)),
    	inf_restif(SID,VID,VAL2,BEXP1,EVALUE),!.
    
  inf_restif(SID,VID,true,BEXP1,EVALUE) :-
    	inf_exp(SID,BEXP1,EVALUE),
    	set_ppath(SID,parm(VID)),
    	set_ppath(SID,cond(BEXP1)),!.
  inf_restif(_,_,_,_,unsolveable). 

/******************** Inference Variables ************************************/
% 13.12.97 OE Per session subset
  inf_var(SID,VID,EVALUE) :- 
     	fail_if_end_consult(SID),
     	set_cur_vid(SID,VID),
     	inf_varx(SID,VID,EVALUE).

  inf_varx(SID,VID1,EVALUE):- evalue_(SID,VID,EVALUE,_),upper_lower(VID,VID1),!.
  inf_varx(SID,VID1,EVALUE) :-
    	find_var(SID,VID1),
    	vars_(SID,_,VID,_,_,ASK,_,RULES,_),
    	upper_lower(VID1,VID),!,
    	calc_var(SID,VID,EVALUE,ASK,RULES,UNI_METHOD),
    	fail_if_end_consult(SID),
    	retr_evalue(SID,VID1),
    	assert(evalue_(SID,VID,EVALUE,UNI_METHOD)).

  retr_evalue(SID,VID):-
    	evalue_(SID,VID1,_,_),
    	upper_lower(VID,VID1),
    	retractall(evalue_(SID,VID1,_,_)),!.
  retr_evalue(_,_).

 inf_dyadexp(SID,E1,E2,V1,V2) :-
     inf_exp(SID,E1,V1),
     inf_exp(SID,E2,V2).
 
PREDICATES
  str_item(SID,integer,STRING,EXP) 
CLAUSES
  str_stritem(_,_,"",[]) :-  !.
  str_stritem(SID,TYPE,STR,[H|T]):-
     str_item(SID,TYPE,STR1,H),
     fail_if_end_consult(SID),
     str_stritem(SID,TYPE,STR2,T),
     concat(STR1,STR2,STR).

  strl_stritem(_,[],[]) :-  !.
  strl_stritem(SID,[STR1|STR2],[H|T]):-
     str_item(SID,0,STR1,H),
     fail_if_end_consult(SID),
     strl_stritem(SID,STR2,T).

  str_item(_,_,"\r\n",nl).
  str_item(_,_,STR1,c_str(STR,_)):- str_bin(STR,STR1,_),!.
  str_item(_,_,STR1,c_pic(c_str(STR,_))):- concat("pic",STR,STR1).
  str_item(SID,0,STR,c_var(VID,_)):-
     	inf_var(SID,VID,_), 
     	mk_val_str(SID,VID,STR).
  str_item(SID,1,STR,c_var(VID,_)):-
     	inf_var(SID,VID,_), 
     	evalue_(SID,VID,VAL,_),!,
     	val_str(VAL,STR).
  str_item(SID,_,STR,c_func(FID,_,EXPLIST)):-
     	inf_explist(SID,EXPLIST,EVALUELIST),
    	eval_func(SID,FID,EVALUELIST,EVALUE),
     	val_str(EVALUE,STR).
      
  inf_explist(_,[],[]) :- !.
  inf_explist(SID,[E|EL],[V|VL]) :-
     	fail_if_end_consult(SID),
     	inf_exp(SID,E,V),
     	inf_explist(SID,EL,VL).
 
  inf_exp(SID,c_func(FID,_,[c_var(PID,_)]),EVALUE) :-  
     	FID="known",
     	STRPID=PID,!,
     	eval_func(SID,FID,[str(STRPID)],EVALUE).
  inf_exp(SID,c_func(FID,_,EXPLIST),EVALUE) :-
     	inf_explist(SID,EXPLIST,EVALUELIST),
     	eval_func(SID,FID,EVALUELIST,EVALUE),!.
  inf_exp(SID,c_var(VID,_),EVALUE)     :- !,inf_var(SID,VID,EVALUE).
  inf_exp(_,c_int(INTG,_),int(INTG))   :- !.
  inf_exp(_,c_float(I,_),float(R))     :- !,R=I.
  inf_exp(_,nl,str("\r\n"))	       :- !.
  inf_exp(_,c_str(STR,_),str(STR))     :- !.
  inf_exp(_,c_bool(true,_),true)       :- !.
  inf_exp(_,c_bool(false,_),false)     :- !.
  inf_exp(_,c_bool(unknown,_),unknown) :- !.
  inf_exp(SID,monmin(E),EVALUE) :-  
        inf_exp(SID,E,V),
        minus(int(0),V,EVALUE),!.
  inf_exp(SID,plus(E1,E2),EVALUE)  :- 
        inf_dyadexp(SID,E1,E2,V1,V2),
        sum(V1,V2,EVALUE),!.
  inf_exp(SID,minus(E1,E2),EVALUE) :- 
        inf_dyadexp(SID,E1,E2,V1,V2),
        minus(V1,V2,EVALUE),!.
  inf_exp(SID,mult(E1,E2),EVALUE)  :- 
        inf_dyadexp(SID,E1,E2,V1,V2),
        mult(V1,V2,EVALUE),!.
  inf_exp(SID,div(E1,E2),EVALUE)  :-  
        inf_dyadexp(SID,E1,E2,V1,V2),
        div(SID,V1,V2,EVALUE),!.
  inf_exp(SID,or_(B1,B2),EVALUE) :- 
	inf_exp(SID,B1,VAL1),
	inf_orbool(SID,VAL1,B2,EVALUE),!.
  inf_exp(SID,and_(B1,B2),EVALUE):- 
	inf_exp(SID,B1,VAL1),
	inf_andbool(SID,VAL1,B2,EVALUE),!.
  inf_exp(SID,not_(BOOL),EVALUE) :- 
	inf_exp(SID,BOOL,VAL),
	inf_not(VAL,EVALUE),!.
  inf_exp(SID,rel(E1,RKIND,E2),EVALUE):- 
        inf_dyadexp(SID,E1,E2,V1,V2),
	inf_relat(RKIND,V1,V2,EVALUE),!.
  inf_exp(_SID,_,_):- consult_present,!,fail. 
                                  % if evalue not known, it's not an error
                                  % if we are in a consultation
  inf_exp(SID,_,_):- consult_type_error(SID),fail.
 
  sum(int(X),int(Y),int(Z))  :-  trap(Z=X+Y,_,fail),!.
  sum(PX,PY,float(Z))        :-  nval_real(PX,X),nval_real(PY,Y),Z=X+Y.

  minus(int(X),int(Y),int(Z)):-  trap(Z=X-Y,_,fail),!.
  minus(PX,PY,float(Z))      :-  nval_real(PX,X),nval_real(PY,Y),Z=X-Y.

  mult(int(X),int(Y),int(Z)) :-  trap(Z=X*Y,_,fail),!.
  mult(PX,PY,float(Z))       :-  nval_real(PX,X),nval_real(PY,Y),Z=X*Y.

% div(int(X),int(Y),int(Z)) :- Y <> 0 , !, Z=X div Y.
% div(int(_),int(_),int(0)) :- symb_error_msg("div_zero_err"),!.
 
  div(_,PX, PY ,float(Z))    :-  nval_real(PX,X),nval_real(PY,Y),
                                Y <> 0.0,!,Z=X/Y.
  div(SID,_,_ ,float(0.0))   :-  symb_error_msg(SID,"div_zero_err").


 inf_orbool(_,true,_,true)   :- !.
 inf_orbool(SID,_,B2,EVALUE) :- inf_exp(SID,B2,EVALUE),!.
  
 inf_andbool(_,false,_,false)   :- !.
 inf_andbool(_,unknown,_,false) :- !.
 inf_andbool(SID,_,B2,EVALUE)   :- inf_exp(SID,B2,EVALUE).
 
 inf_not(true,false).
 inf_not(false,true).
 inf_not(unknown,unknown).

 inf_relat(RKIND,V1,V2,EVALUE) :- !,
   chck_relvalues(V1,V2),
   inf_rel(RKIND,V1,V2,EVALUE).

 inf_rel(eq,LV,LV,true) :- !.
 inf_rel(eq,str(S),str(S1),true) :- upper_lower(S,S1),!.
 inf_rel(eq,float(FL),int(FL),true):- !.
 inf_rel(eq,int(FL),float(FL),true):- !.
 inf_rel(eq,_,_,false)  :- !.

 inf_rel(ne,LV,RV,NEGATED)   :- inf_rel(eq,LV,RV,RESULT),
	!,negated(RESULT,NEGATED).

 inf_rel(gt,str(LV),str(RV),true)        :- LV > RV,!.
 inf_rel(gt,int(LV),int(RV),true)        :- LV > RV,!.
 inf_rel(gt,float(LV),float(RV),true)    :- LV > RV,!.
 inf_rel(gt,int(LV),float(RV),true)      :- LV > RV,!.
 inf_rel(gt,float(LV),int(RV),true)      :- LV > RV,!.
 inf_rel(gt,true,false,true)             :- !.
 inf_rel(gt,true,unknown,true)           :- !.
 inf_rel(gt,false,unknown,true)          :- !.
 inf_rel(gt,_,_,false)                   :- !.
 inf_rel(lt,LV,RV,RESULT)     :- inf_rel(gt,RV,LV,RESULT),!.
 inf_rel(ge,LV,RV,NEGATED)    :- inf_rel(gt,RV,LV,RESULT),!,
                                 negated(RESULT,NEGATED).
 inf_rel(le,LV,RV,NEGATED)    :- inf_rel(gt,LV,RV,RESULT),!,
                                 negated(RESULT,NEGATED).
 negated(true,false)  :- !.
 negated(_,true).


PREDICATES
  select_paragraph(SID,ID,PNO,EXP,ACTIONS) 
  find_sect(SID,ID) 
  setsectpno(SID,ID,PNO)  
 
CLAUSES 
  select_paragraph(SID,SecID,PNO,BEXP,ACTS):-	
     	paragraph_(SID,SID1,PNO,BEXP,ACTS),
     	upper_lower(SID1,SecID),!.

  find_sect(SID,SecID):- section_(SID,_,SID1,_),upper_lower(SecID,SID1),!.  
  find_sect(SID,SecID):- 
   	txt(chck_sectudef,CS),
   	txt(cons_inferfail,CI),
   	format(STR,"% %\r\n%",CS,SecID,CI),
   	error_msg(SID,STR),fail.

  find_var(SID,VID):- vars_(SID,_,VID1,_,_,_,_,_,_),upper_lower(VID1,VID),!.
  find_var(SID,VID):-
   	txt(chck_pnotdef,CS),
   	txt(cons_inferfail,CI),
   	format(STR,"% %\r\n%",CS,VID,CI),
   	error_msg(SID,STR),fail.
   
  setsectpno(SID,S,P):- retractall(sectpno(SID,_,_)),assert(sectpno(SID,S,P)).
  getsectpno(SID,S,P):- sectpno(SID,S,P),!.
  getsectpno(_,start,1).
 
  setrefsectpno(SID,S,P):- retractall(refsectpno(SID,_,_)),assert(refsectpno(SID,S,P)).
  getrefsectpno(SID,S,P):- refsectpno(SID,S,P),!.
  getrefsectpno(_,start,1).
 
PREDICATES
  add_action_done(SID,ID,PNO,INTEGER,ANODE)
  is_action_done(SID,ID,PNO,INTEGER,WRITTEN,ANODE)
  init_inference(SID,SYMBOL)
  store_session(SID,PNODES)
  esta_begin_page(SID,integer)
  esta_end_page(SID,integer)
CLAUSES
  add_action_done(SID,ID,PNO,ACTNO,ANODE):- 
   	getrefsectpno(SID,RID,RPNO),
   	retractall(action_done(SID,RID,RPNO,ID,PNO,ACTNO,_)),
   	assert(action_done(SID,RID,RPNO,ID,PNO,ACTNO,ANODE)).
 
  is_action_done(SID,ID,PNO,ACTNO,is_written,A):- 
        getrefsectpno(SID,RID,RPNO),
        action_done(SID,RID,RPNO,ID,PNO,ACTNO,A),!.
  is_action_done(_,_,_,_,not_written,none).
 
  init_inference(SID,nill):-       !,
  	retract_cons_inf(SID),				% initialize
  	retractall(prev_value(SID,_,_,_,_,_,_)),	% forget previous session values
        store_session(SID,[]).        			% reset session
  init_inference(SID,pmt_change):- !, 
        save_session_values(SID),			% remember previous session values
  	retract_cons_inf(SID),				% initialize
        store_session(SID,[]),!.			% reset session  
  init_inference(_,_).

/****************************************************************************/
/*          INFERENCEMACHINE                                                */
/****************************************************************************/

% Pnodes stored in session. Paths stored dynamically
CLAUSES
 store_session(SID,PNODES):- retractall(session(SID,_)), assert(session(SID,PNODES)).
 
 get_session(SID,PNODES) :- session(SID,PNODES),!.
 get_session(_,[]).

 inferencemachine(SID,STARTCOND) :-  % STARTCOND = nill, change or pmt_change
      store(SID,exitstatus,STARTCOND),
      init_inference(SID,STARTCOND),
      repeat,
	  retrieve(SID,exitstatus,SYMB),
	  retractall(environment(SID,_,_)),% ryd op i "environmentet" f›rst
	  esta_begin_page(SID,NeedEND),
	  %report(SID,"<HTML><BODY BACKGROUND=\"images/grytxtr5.jpg\">\n"),
	  inferact(SID,SYMB),
   	  esta_end_page(SID,NeedEND),
   	  %report(SID,"\n</BODY></HTML>\n"),
	  retrieve(SID,exitstatus,SYMB2),
      is_state_terminate(SYMB2),!.
      
 is_state_terminate(nill):- !.
 is_state_terminate(exit).
 
 esta_begin_page (SID,1) :-
 	replay(SID,ANS_PATH),
 	ANS_PATH=[],!,
 	report(SID,"<HTML><BODY BACKGROUND=\"images/grytxtr5.jpg\">\n").
 esta_begin_page (_,0).
 
 esta_end_page (SID,1) :- !,
	  report(SID,"\n</BODY></HTML>\n").
 esta_end_page (_,0).

/****************************************************************************/
/*          CHAIN MANAGEMENT                                                */
/****************************************************************************/
PREDICATES
  chain_is_not_ok(SID,STRING)
  chain_err_msg(SID,STRING)
  get_chain(SID,STRING)

CLAUSES
  chain_err_msg(SID,F):-
        txt(main_errfn2,T), 
        format(S,"\r\n% (%)",T,F),
        error_msg(SID,S).
 
  chain_is_not_ok(_,"") :-!,fail.
  chain_is_not_ok(SID,F) :-  
 	txt(main_fileext,Extension), %".KB" or ".VDB"
 	filenameext (F2,F,Extension),
        app_path (APP_PATH),
  	filenamepath (KBPATH,APP_PATH,F2),
	not(existfile(KBPATH)),!,
        chain_err_msg(SID,F).
 
  get_chain(SID,"") :- 
	retractall(evalue_(SID,_,_,_)), %CREATE A LOOP...............
	store_session(SID,[]),!.
  get_chain(SID,F)  :- 
	txt(main_fileext,EXTENSION),
	filenameext(F2,F,EXTENSION),
        resetknow1(SID),
        app_path (APP_PATH),
  	filenamepath (KBPATH,APP_PATH,F2),
  	open_file (SID,KBPATH),!,
        store_session(SID,[]).
  get_chain(SID,F) :-
        chain_err_msg(SID,F),fail.

/****************************************************************************/
/*          INFERACT ACTION                                                    */
/****************************************************************************/
  inferact(_,exit):-  !.  
  inferact(SID,chain):- !,              % if chain:
	get_chain_name(SID,F),                
        get_chain(SID,F),
        init_inference(SID,nill),     % start all over again
        setrefsectpno(SID,start,1), 	
        infer(SID,start,1,noquit).
  inferact(SID,_):- !,
        setrefsectpno(SID,start,1), 	
	infer(SID,start,1,noquit).
/****************************************************************************/
/*          INFER                                                           */
/****************************************************************************/
% 13.12.97 OE Per session subset
PREDICATES
  do_exp(SID,ID,PNO,EXP,EVALUE)
  do_action_or_not(SID,WRITTEN,ID,PNO,ACTNO,ACTION,ANODE,ANODE)
  ass_val(SID,ID,PNO,EVALUE)
  get_anodes(SID,ID,PNO,ANODES)
CLAUSES
  ass_val(SID,SecID,PNO,VAL):-
  	getrefsectpno(SID,RID,RPNO),
  	retract(session_value(SID,RID,RPNO,SecID,PNO,_,ANODES)),!,
  	assert(session_value(SID,RID,RPNO,SecID,PNO,VAL,ANODES)).
  ass_val(SID,SecID,PNO,VAL):-
  	getrefsectpno(SID,RID,RPNO),
  	assert(session_value(SID,RID,RPNO,SecID,PNO,VAL,[])).
  
%ass_anodes(SID,PNO,VAL,ANODES):-
%  retractall(session_value(SID,PNO,_,_)),
%  assert(session_value(SID,PNO,VAL,ANODES)).
    
  get_anodes(SID,SecID,PNO,ANODES):- 
  	getrefsectpno(SID,RID,RPNO),
  	prev_value(SID,RID,RPNO,SecID,PNO,_,ANODES),!.
  get_anodes(_,_,_,[]).  
    
% If value already is found in the same session use it else find it
 
 do_exp(SID,SecID,PNO,_,VAL):- 
	getrefsectpno(SID,RID,RNO),
 	session_value(SID,RID,RNO,SecID,PNO,VAL,_),!.      
 
 do_exp(SID,SecID,PNO,EXP,VAL):- 
        inf_exp(SID,EXP,VAL),
        fail_if_end_consult(SID),
        set_ppath(SID,nextnode(SecID,PNO)),
        set_ppath(SID,cond(EXP)),
        ass_val(SID,SecID,PNO,VAL).

/*****************************************************************/
/*             INFER                                             */
/*****************************************************************/
/*
The inference machine saves the values during a session. It always 
starts from the start section, whether a new session is started 
or a value is needed for a parameter or a parameter value is changed.
In the latter case it compares to the previous values to see, if a 
value has changed. If so, it writes the previous advice which is no 
longer valid. This counts for an expression or a an action.
*/
% 13.12.97 OE Per session subset
  infer(SID,_,_,_):- succes_if_end_consult(SID),!.
  infer(SID,SecID,PNO,noquit):-
  	find_sect(SID,SecID),
     	select_paragraph(SID,SecID,PNO,EXP,ACTIONS), 
     	setsectpno(SID,SecID,PNO),
     	do_exp(SID,SecID,PNO,EXP,VAL),
     	infer2(SID,SecID,PNO,VAL,ACTIONS,ANODES,QUITED),!,
     	add_pnode(SID,pnode(PNO,VAL,ANODES)),
     	PNO1 = PNO + 1,
     	infer(SID,SecID,PNO1,QUITED).
  infer(_,_,_,_).

% After evaluating expression, action has to be done,
% if value is true

  infer2(SID,SecID,PNO,true,ACTIONS,ANODES,QUITED) :- !,   
     	do_actions(SID,SecID,PNO,1,ACTIONS,QUITED,ANODES),
     	fail_if_end_consult(SID).
% If value is false/unknown, get old value if any    
  infer2(SID,SecID,PNO,_,_,[],noquit):-     
     	getrefsectpno(SID,RID,RPNO), 
     	prev_value(SID,RID,RPNO,SecID,PNO,OLDVAL,_),!,
     	wrnolonger(SID,OLDVAL).	                % TRUE - TIL - FALSE
     						% hvis change parameter
% If expression false don't do the actions      						
  infer2(_,_,_,_,_,[],noquit) :- !.     						
     						
/****************     Actions    *****************************************/

% STOP IF END OF CONSULTATION
  do_actions(SID,_,_,_,_,noquit,[]):- succes_if_end_consult(SID),!. %HHJ ANODES,ANODES
% EMPTY ACTIONLISTE
  do_actions(SID,_,_,_,[],noquit,[]):- !,fail_if_end_consult(SID).
% EXIT
  do_actions(SID,_,_,_,[exit|_],quit,[]):-!,fail_if_end_consult(SID),
	store(SID,exitstatus,exit).
% STOP 
  do_actions(SID,_,_,_,[quit|_],quit,[]):-!,fail_if_end_consult(SID). 
% CHAIN
  do_actions(SID,_,_,_,[chain(F)|_],quit,[]) :- 
  	chain_is_not_ok(SID,F),!,store(SID,exitstatus,exit).
  do_actions(SID,_,_,_,[chain(F)|_],quit,[]) :- !,
  	set_chain_name(SID,F),
  	store(SID,exitstatus,chain),
  	fail_if_end_consult(SID).
% DO ACTIONLIST
  do_actions(SID,SecID,PNO,ANO,[H|T],QUITED,[A|ANDTAIL]) :- 
  	fail_if_end_consult(SID),
  	is_action_done(SID,SecID,PNO,ANO,WRITTEN,ANODE_DONE),
  	do_action_or_not(SID,WRITTEN,SecID,PNO,ANO,H,ANODE_DONE,A),
  	add_anode(SID,SecID,PNO,A),
  	ANO1=ANO+1,
  	do_actions(SID,SecID,PNO,ANO1,T,QUITED,ANDTAIL).

  do_action_or_not(_,is_written,_,_,_,_,A,A):-!. % Use old action node
  do_action_or_not(SID,_,SecID,PNO,ANO,H,_,A):-
  	do_action(SID,SecID,PNO,ANO,H,A),  % OLDANODE = none
  	fail_if_end_consult(SID),
  	add_action_done(SID,SecID,PNO,ANO,A).

/**********************  DO ACTION **************************************/
% 13.12.97 OE Per session subset
% REFER SECTION
  do_action(SID,SecID,P,A,refer(REFSID,_),snode(REFSID,[])):- %%% PNODES
  	set_spath(SID,refer(SecID,P,A,REFSID)),
  	setrefsectpno(SID,SecID,P),
  	infer(SID,REFSID,1,noquit),!,
  	setsectpno(SID,SecID,P). 
% REFER TO PARAMETER SECTION
  do_action(SID,SecID,P,A,refer_par(REFPAR,_),snode(REFSID,[])):- %%%% PNODES
  	inf_var(SID,REFPAR,EVALUE), 
  	EVALUE = str(STR),
  	REFSID = STR,
  	set_spath(SID,refer(SecID,P,A,REFSID)),  
  	setrefsectpno(SID,SecID,P),
  	infer(SID,REFSID,1,noquit),
  	setsectpno(SID,SecID,P),!. 
% DISPLAY ADVICE
  do_action(SID,S,P,A,display(TEXT),advice(STRL)):-
   	strl_stritem(SID,STRL,TEXT),
   	set_ppath(SID,phrase(TEXT)),
   	set_spath(SID,last_advice(S,P,A)), 
   	store_advice(SID,STRL),
   	wradvice1(SID,"log").   
% CALL PROCEDURE
  do_action(SID,_,_,_,call(FID,_,EL),call(FID,VL)):-
   	inf_callexplist(SID,FID,EL,VL),
   	eval_proc(SID,FID,VL),!.   
% ASSIGN VALUE   
  do_action(SID,S,_,_,assign(ID,_,EXP),assign(ID,EXP)):-
   	eval_assign(SID,S,ID,EXP),!.
   
/***************************************************************************/
  check_cyclus(_,_,[]):- !.
  check_cyclus(SID,SecID,[refer(SecID,_,_,_)|_]):-   % cyclical reference fail !
  	txt("chck_kb",CKB),
    	txt("chck_csect",CS),
    	format(STR,"%s%s:\r\n%s",CKB,CS,SecID),
    	error_msg(SID,STR),!,fail.  % 
  check_cyclus(SID,REFSID,[_|SPATHL]):- check_cyclus(SID,REFSID,SPATHL).

  eval_assign(SID,SECT,ID,EXP) :-
  	set_ppath(SID,assign(ID,EXP)),        
   	inf_exp(SID,EXP,VAL),  
   	fail_if_end_consult(SID),
   	chck_exp_type(SID,ID,VAL),
   	change_evalue(SID,ID,VAL,assign(SECT)).

  inf_callexplist(_,FID,[c_var(PID,_)],[str(STRPID)]) :- 
   	FID="clear_value",!,PID=STRPID.
  inf_callexplist(SID,_,EL,VL) :- inf_explist(SID,EL,VL).

/******************** ADVICE HANDLING ***********************************/
% 13.12.97 OE Per session subset
PREDICATES
  prev_anodes(SID)
CLAUSES
  prev_anodes(SID) :-
  	retract(prev_value(SID,_,_,_,_,_,ANODES)),
  	wrnoadv(SID,ANODES),
  	fail.
  prev_anodes(_).

  wrnolonger(SID,true) :-!,
  	txt(cons_nolong1,C1),
	format(C11,"\r\n%",C1),
	store_advice(SID,[C11]),           
  	prev_anodes(SID),
  	txt(cons_nolong2,C2),
  	format(C22,"\r\n%",C2),
  	store_advice(SID,[C22]),           
  	wradvice1(SID,"log").
  wrnolonger(_,_).

  wrnoadv(_,[]):- !.
  wrnoadv(SID,[advice(STRL)|REST]):-
	STRL2 = ["\r\n"|STRL],
	store_advice(SID,STRL2),!,
	wrnoadv(SID,REST).
  wrnoadv(SID,[call(_,_)|REST])   :-!,wrnoadv(SID,REST).
  wrnoadv(SID,[snode(_,PNODES)|R]):-!,wradvpnodes(SID,PNODES),wrnoadv(SID,R).
  wrnoadv(SID,[assign(_,_)|REST]) :-!,wrnoadv(SID,REST).
                    
  wradvpnodes(_,[]) :- !.
  wradvpnodes(SID,[pnode(_,_,ANODES)|REST]) :-
      wrnoadv(SID,ANODES),!,wradvpnodes(SID,REST).

  recap_advices (SID):- 
      get_session(SID,OLDPNODES),
      wrnoadv(SID,[snode(start,OLDPNODES)]),
      wradvice1(SID,"nolog").

/*************************FAIL OR SUCCES**********************************/
% EXIT bliver sat, n†r modeless dialog kaldes.
  fail_if_end_consult(SID):-
      	retrieve(SID,exitstatus,STAT),
      	not(STAT=change),
      	not(STAT=chain),
      	not(STAT=exit).   

 succes_if_end_consult(SID):- 
      	retrieve(SID,exitstatus,STAT), STAT=change,!; 
      	retrieve(SID,exitstatus,STAT), STAT=chain,!;
      	retrieve(SID,exitstatus,STAT), STAT=exit,!.

/******************** CHANGE PARAMETER ***********************************/
PREDICATES
  chngparm(SID,ID,ID) 
  chnparm(SID,ID)
  not_rule_determ(SID,VARTYPE,RULES)
  si_instantieret(SID,EXPL)
  s_instantieret(SID,EXP)
  ok_var(SID,ID,UNI_METHOD)
  ok_value(SID,UNI_METHOD)
CLAUSES
/*
  volunteer_parameter :-
    get_cur_vid(CURVID),  
    laesparmnavn("volunteer_parameter_input__parameter_menu_","",VID), %EMAINC
    get_current_parameter(P0),
    chngparm(CURVID,VID,PATHS),%No change of SECTION during ControlMnu
    setstatusparm(P0).
*/
  change_parameter (_):-!.
  /*
     get_cur_vid(CURVID),  
     laesvalueparm_norule("what_if_parameter_changes_its_value__parameter_menu_",VID),
     chngparm(CURVID,VID).
*/
%  chngparm(VID,VID)  :- wrsymbtxt(cons2_iddiff),!.
  chngparm(SID,_,VID) :- assert(res_str(SID,"p_change")),% winedlg.pro,winedecl.pro
  		chnparm(SID,VID),fail.
  chngparm(SID,_,_) :- retractall(res_str(SID,_)).  
 	
  chnparm(SID,VID1) :- % The parameter has already an value
     	evalue_(SID,VID,_,UNI),
     	upper_lower(VID,VID1),!,
     	ok_var(SID,VID,UNI),
     	retractall(evalue_(SID,VID,_,_)),
     	retractall(evalue_(SID,_,_,rule(_))),  % retractall rule determined values
     	set_ppath(SID,vol(VID)),     
     	inf_var(SID,VID,_).
              
  chnparm(SID,VID1) :-  
     	vars_(SID,_,VID,_,_,ASK,TYPE,RULE,_), 
     	upper_lower(VID,VID1),!,
     	not_rule_determ(SID,TYPE,RULE),
     	str_stritem(SID,0,_,ASK),
     	set_ppath(SID,vol(VID)),     
     	inf_var(SID,VID,_).

  ok_var(SID,_,alien) :- symb_error_msg(SID,alien_val),!,fail.

  ok_var(SID,VID,UNI):-
     	vars_(SID,_,VID1,_,_,ASK,_,_,_), 
     	upper_lower(VID,VID1),
     	si_instantieret(SID,ASK),!,
     	ok_value(SID,UNI).
  ok_var(SID,_,_):- symb_error_msg(SID,si_notinst),fail.

  ok_value(_,question):- !.
  ok_value(SID,alien) :- symb_error_msg(SID,alien_val),!,fail.
  ok_value(SID,_) :- symb_error_msg(SID,quest_only),fail.
  
  not_rule_determ(SID,fact,fact([boolmenu(_),boolfacts(FR)])):- 
	not(FR=[]),symb_error_msg(SID,no_rule_determ),!,fail.
  not_rule_determ(_,fact,fact([boolmenu(_)])):-!.       
  not_rule_determ(SID,fact,fact(FR)) :- not(FR=[]),symb_error_msg(SID,no_rule_determ),!,fail.
  not_rule_determ(SID,number,number(_,NR)) :- not(NR=[]),symb_error_msg(SID,no_rule_determ),!,fail.
  not_rule_determ(SID,phrase,phrase(PR)) :- not(PR=[]),symb_error_msg(SID,no_rule_determ),!,fail.
  not_rule_determ(SID,category,category(_,R)):- not(R=[]),symb_error_msg(SID,no_rule_determ),!,fail.
  not_rule_determ(_,_,_).

  si_instantieret(_,[]):- !.
  si_instantieret(SID,[H|T]):- s_instantieret(SID,H),si_instantieret(SID,T).

  s_instantieret(_,nl).
  s_instantieret(_,c_str(_,_)). 
  s_instantieret(SID,c_var(VID1,_)):- evalue_(SID,VID,_,_),upper_lower(VID,VID1),!.
