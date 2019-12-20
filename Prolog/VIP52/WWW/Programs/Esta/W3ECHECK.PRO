/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3ECHECK.PRO
 Purpose: WWW version of ESTA
 Written by:
 Comments:
 14.12.97 Multiuser support
******************************************************************************/

include "w3esta.inc"

% 14.12.97 OE  All databases need to be separated into per session's subsets
DATABASE - echeck
  used_sect(SID,ID)  /* contains the used sections */
  used_parm(SID,ID)  /* and parameters detected (validated) */

  %INV_ID,CHARPOS,STRING
  undef_sect(SID,ID) /* contains the sections met, which is undefined */
		     /* they will cause a warning */
	
PREDICATES
 explist_shift(ID,EXPL,EXPL)
 exist_paragraph(SID,ID,PNO,EXP,ACTIONS) 
 
 remember_sect(SID,ID)
 remember_parm(SID,ID)
 exist_start(SID)
 exist_section(SID,ID)
 ex_section(SID,STRING,ID,EXPL)
 var_exist(SID,ID,VARTYPE) 

 parse_sectionlist(SID,SLIST,IDL,CHARPOS,PNO,ACTNO)
 checksectref(SID,ID,IDL)
 chksect(SID,ID,PNO,IDL) 
 chk_actions(SID,ID,PNO,ACTNO,ACTIONS,IDL)
 chk_action(SID,ID,PNO,ACTNO,ACTION,IDL)
 chk_rules(SID,ID,RULES,IDL)
 chk_si(SID,INV_ID,EXP,IDL)
 chk_stritem(SID,INV_ID,EXPL,IDL) 
 chk_crules(SID,INV_ID,CATRULES,IDL) 
 chk_crule(SID,INV_ID,CATRULE,IDL)
 chk_prules(SID,INV_ID,PHRASERULES,IDL)
 chk_prule(SID,INV_ID,PHRASERULE,IDL)

 chk_fnrules(SID,INV_ID,VARTYPE,FNRULES,IDL) 
 chk_fnrule(SID,INV_ID,VARTYPE,FNRULE,IDL)
 chk_var_atr(SID,ID,IDL)
 type_is_cat(SID,INV_ID,EXP,VARTYPE)
 chk_type(SID,INV_ID,EXP,VARTYPE,VARTYPE,VARTYPE )
 chk_catvar(SID,INV_ID,EXP,IDL)
 chk_var(SID,INV_ID,EXP,VARTYPE,VARTYPE,IDL) 
 chk_func_arg(SID,INV_ID,VARTYPELIST,EXPL,IDL)
 chk_func(SID,INV_ID,EXP,VARTYPE,VARTYPE,IDL)
 listlen_version2(EXPL,INTEGER)
 chk_arity(SID,INV_ID,CHARPOS,INTEGER,INTEGER)
 chk_exp(SID,INV_ID,EXP,VARTYPE,VARTYPE,IDL)
 chk_dyad(SID,INV_ID,EXP,EXP,VARTYPE,IDL)
 chck_exp_type1(VARTYPE,EVALUE)
   
/*--------- Diverse  --------*/
 trav_id_list(SID,IDL,STRING)
 trav_msg(SID,string,ID)
 store_position(SID,INV_ID,CHARPOS,STRING)
 chck_err(SID,STRING,INV_ID,CHARPOS) 
 no_correct_error(SID)

CLAUSES
  chck_err(SID,STR,ID,POSI) :-
	no_check_error(SID),
	txt(STR,TXT5),
	store_position(SID,ID,POSI,TXT5).
  
  no_check_error (SID):- retrieve(SID,chkerr,STATUS),not(STATUS=err1).

  no_correct_error(SID):- checkerrorposition(SID,_,_,_),!,fail.
  no_correct_error(_).
  
  store_position(SID,INV_ID,CHARPOS,STRING) :-
	no_check_error(SID),
	retractall(checkerrorposition(SID,INV_ID,CHARPOS,STRING)),
	store(SID,chkerr,err1),
	assertz(checkerrorposition(SID,INV_ID,CHARPOS,STRING)).

  remember_sect(SID,SecID):- 
  	used_sect(SID,SID1),
  	upper_lower(SecID,SID1),!; assertz(used_sect(SID,SecID)).
  remember_parm(SID,VID):- 
  	used_parm(SID,VID1),
  	upper_lower(VID1,VID),!; assertz(used_parm(SID,VID)).

  ex_section(SID,A,B1,C):- section_(SID,A,B,C),upper_lower(B,B1),!.

  exist_section(SID,S):- 
  	section_(SID,_,S1,_),
  	upper_lower(S,S1),!.
  exist_paragraph(SID,SecID,PNO,BEXP,ACTS):-
  	paragraph_(SID,SecID1,PNO,BEXP,ACTS),
  	upper_lower(SecID,SecID1),!.
  				      
  exist_start (SID) :- 
  	exist_section(SID,start),!;wrsymbtxt(SID,chck_snotfound).

PREDICATES  e1(SID,INTEGER)
CLAUSES	    e1(_SID,0):-!.e1(SID,_):-wrsymbtxt(SID,chck_impossible).%%%%%%%%,error_msg(N).

%=========================================================================
%
%	check knowledge
%
%=========================================================================

PREDICATES
  wr_chck_msg (SID)
  get_ok_msg(string,string)

CLAUSES
  wr_chck_msg (SID):-  
        flush_tmptxt(SID,STR),
        get_ok_msg(STR,STR1),
        txt("chckknow",CK),
        infomsg(SID,CK,STR1).

  get_ok_msg(STR,STR1):-
        strip(STR,STR0),
        STR0 = "",!,
        txt(main_checkok,STR1).
  get_ok_msg(STR,STR).      


PREDICATES
  checkknowledge(SID)

CLAUSES
  checkknowledge(SID):-
	%retract all used sections and used parameters
	retractall(used_sect(SID,_)),
  	retractall(used_parm(SID,_)),
  	retractall(undef_sect(SID,_)),
	retractall(checkerrorposition(SID,_,_,_)),
	store(SID,chkerr,nil),
        store(SID,exitstatus,nil),
	exist_start(SID),
        trap(checksectref(SID,start,[start]),E,e1(SID,E)), %do sections (trap overflow)
	no_check_error(SID),

	%...Check that all PARAMETERS are used....
        findall(VID,vars_(SID,_,VID,_,_,_,_,_,_),VIDL),
        trav_id_list(SID,VIDL,chck_pnotused), %see trav_id_list

	%....Check that all SECTIONS are used....
        findall(SecID,section_(SID,_,SecID,_),SecIDL),
        trav_id_list(SID,SecIDL,chck_snotused), %see trav_id_list

	%....Check that all SECTIONS in do_section_of are defined ....
        findall(SecID,undef_sect(SID,SecID),SecIDL_2),
        trav_id_list(SID,SecIDL_2,chck_sectudef), %see trav_id_list

        %....clear RAM.............
	%retract all used sections and used parameters.
	retractall(used_sect(SID,_)),
  	retractall(used_parm(SID,_)),
  	retractall(undef_sect(SID,_)),
	fail. %PRESERVE GSTAK

  checkknowledge(SID):-
        no_check_error(SID),
        store(SID,checkstatus,"ok"),
        no_correct_error(SID),!,
        wr_chck_msg(SID).
        
%  checkknowledge(_):-
%        wr_chck_msg,fail.

  checksectref(SID,SecID1,_):- used_sect(SID,SecID), upper_lower(SecID1,SecID),!. %checked already..
  checksectref(SID,SecID1,_):- undef_sect(SID,SecID),upper_lower(SecID1,SecID),!. %checked already.
  checksectref(SID,SecID,BEENBEFORE) :-
	no_check_error(SID),
	remember_sect(SID,SecID) ,
	ex_section(SID,_,SecID,DESCR),
	chk_stritem(SID,sect(SecID),DESCR,[]),
	chksect(SID,SecID,1,BEENBEFORE),fail.	%PRESERVE GSTACK
  checksectref(SID,_,_) :-no_check_error(SID).

  chksect(SID,SecID,PNO,BEENBEFORE):-
      no_check_error(SID),
      exist_section(SID,SecID),
      exist_paragraph(SID,SecID,PNO,BOOLEXP,ACTIONS),
      chk_exp(SID,sect(SecID),BOOLEXP,fact,_,[]), 
	no_check_error(SID),!,
	chk_actions(SID,SecID,PNO,1,ACTIONS,BEENBEFORE),
	PNO1 = PNO+1,
	chksect(SID,SecID,PNO1,BEENBEFORE).
  chksect(SID,_,_,_) :- no_check_error(SID),!.

  chk_actions(_,_,_,_,[],_):-!.
  chk_actions(SID,SecID,PNO,ANO,[H|T],BEENBEFORE):-
     	no_check_error(SID),
     	chk_action(SID,SecID,PNO,ANO,H,BEENBEFORE),
     	ANO1=ANO+1,
     	chk_actions(SID,SecID,PNO,ANO1,T,BEENBEFORE).

/* Reference to sections */

%Test of cyclic ref. Example.	section start
%				do et
%		     when checking 'et' BEENBEFORE = [start,et]
%
  chk_action(SID,SecID,_,_,refer(REFSID,POSI),BEENBEFORE):-
     	ve_member(REFSID,BEENBEFORE),
     	txt(chck_csect,TXT3), 
     	store_position(SID,sect(SecID),POSI,TXT3),!.
  chk_action(SID,_,_,_,refer(REFSID1,_),BEENBEFORE)   :-
    	section_(SID,_,REFSID,_),
    	upper_lower(REFSID,REFSID1),!,	%The section after 'do' must be declared.
    	checksectref(SID,REFSID,[REFSID|BEENBEFORE]). %DEPTH FIRST recursive call to check all sections.
  chk_action(SID,SecID,_,_,refer(SecID,_),_) :- %The section is part of a do_section_of and is undef.
        section_(SID,_,SecID1,_),not(upper_lower(SecID,SecID1)),
        assertz(undef_sect(SID,SecID)),!.
  chk_action(SID,SecID,_,_,refer(REF,POS),_)   :-
	assertz(undef_sect(SID,REF)),!,             %normal undefined section                    
	txt(chck_sectudef,MSG),
	store_position(SID,sect(SecID),POS,MSG).
/* Reference to parameter options = sections */
  chk_action(SID,SecID,PNO,ANO,refer_par(REF_PAR,POS),BEENBEFORE)   :-
      % Check parameter if exists and if type = category     
      % Get optionlist
      % For each option do : chk_action(OPTION,_,_refer(REFSID,?),BEENBEFORE.
        chk_catvar(SID,sect(SecID),c_var(REF_PAR,POS),[]),	
        get_var_optionlist(SID,REF_PAR,OL),
        parse_sectionlist(SID,OL,BEENBEFORE,POS,PNO,ANO),!.

  chk_action(SID,SecID,_,_,display(SIL),_)   :-
        chk_stritem(SID,sect(SecID),SIL,[]) ,!.

%chk_action(_,_,_,call(mapadvice,_,_),_) :- !.
%chk_action(_,_,_,call(mapmdi,_,_),_)    :- !.
%chk_action(_,_,_,call(mappreload,_,_),_):- !.

  chk_action(SID,SecID,_,_,call(FID1,CHARPOS,EXPL),_):- 
   	upper_lower (FID1,FID),
   	proc_descr(FID,ARITY,VTYLIST),
   	listlen_version2(EXPL,ELEN),
   	explist_shift(FID,EXPL,EXPL2),
   	chk_arity(SID,sect(SecID),CHARPOS,ELEN,ARITY),
   	chk_func_arg(SID,sect(SecID),VTYLIST,EXPL2,[]),!.
   
  chk_action(SID,SecID,_,_,assign(ID,POSI,EXP),_) :-
   	chk_var(SID,sect(SecID),c_var(ID,POSI),dummy,TY2,[]),
   	chk_exp(SID,sect(SecID),EXP,TY2,_,[]),!.
  chk_action(_,_,_,_,_,_).

  parse_sectionlist(_,[],_,_,_,_):-!.
  parse_sectionlist(SID,[SecID|R],BEENBEFORE,POS,PNO,ANO):-
   	chk_action(SID,SecID,PNO,ANO,refer(SecID,POS),BEENBEFORE),
   	parse_sectionlist(SID,R,BEENBEFORE,POS,PNO,ANO).

  listlen_version2([],0) :- !.
  listlen_version2([_|EL],N) :- listlen_version2(EL,N1),N=N1+1.

  explist_shift("clear_parameter",[c_var(ID,CH)],[c_str(ID,CH)]):-!.
  explist_shift("known",[c_var(ID,CH)],[c_str(ID,CH)]):-!.
  explist_shift(_,EL,EL).
              
/*---------- Checking of parameters and expression -------------*/
PREDICATES
  get_idoptionlist(optiondefs,slist)
CLAUSES
  get_idoptionlist([],[]).
  get_idoptionlist([option(SH,_)|T],[SH|ST]):-
	get_idoptionlist(T,ST).

  get_var_optionlist(SID,REF_PAR1,S_OL) :- 
	vars_(SID,_,REF_PAR,_,_,_,_,OL,_),
	upper_lower(REF_PAR1,REF_PAR),!,
	OL = category(OPTIONDEFS,[]),
        get_idoptionlist(OPTIONDEFS,S_OL).

  type_is_cat(_,_,_,category) :- !.
  type_is_cat(SID,INV_ID,c_var(_,POSI),_):-
	no_check_error(SID),
	txt1(chck_cattypeerror,TX),!,
	store_position(SID,INV_ID,POSI,TX).

  chk_catvar(SID,INV_ID,c_var(VID,POSI),PARMBEFORE) :-
        no_check_error(SID),
	ve_member(VID,PARMBEFORE),
	txt(chck_cparm,TXT3),
	store_position(SID,INV_ID,POSI,TXT3),!.
  chk_catvar(SID,INV_ID,c_var(VID,POSI),PARMBEFORE) :-
	no_check_error(SID),
	var_exist(SID,VID,VTY),
	type_is_cat(SID,INV_ID,c_var(VID,POSI),VTY),!,
	chk_var_atr(SID,VID,[VID|PARMBEFORE]),
	remember_parm(SID,VID),!.
  chk_catvar(SID,INV_ID,c_var(_,POSI),_) :- 
	no_check_error(SID),
	txt(chck_pnotdef,TXT5),
	store_position(SID,INV_ID,POSI,TXT5).

  chk_stritem(_,_,[],_) :- !.
  chk_stritem(SID,CURVID,[H|T],PARMBEFORE):-
       	chk_si(SID,CURVID,H,PARMBEFORE),
       	chk_stritem(SID,CURVID,T,PARMBEFORE). %Removing ! to enable tail.rec.elim.

  chk_si(SID,CURVID,c_var(VID,POSI),PARMBEFORE) :- 
       	chk_var(SID,CURVID,c_var(VID,POSI),dummy,_,PARMBEFORE),!.
  chk_si(SID,CURVID,c_func(F,P,E),PARMBEFORE):-
	chk_func(SID,CURVID,c_func(F,P,E),dummy,dummy,PARMBEFORE),!.
  chk_si(_,_,_,_).

  chk_crules(_,_,[],_).
  chk_crules(SID,CURVID,[H|T],PARMBEFORE) :- 
    	chk_crule(SID,CURVID,H,PARMBEFORE),
    	chk_crules(SID,CURVID,T,PARMBEFORE).
   
  chk_crule(_,_,opt(_),_) :- !.
  chk_crule(SID,CURVID,if_(_,BEXP2),PARMBEFORE) :-
    	chk_exp(SID,CURVID,BEXP2,fact,_,PARMBEFORE).

  chk_prules(_,_,[],_):-!.
  chk_prules(SID,CURVID,[H|T],PARMBEFORE) :- 
    	chk_prule(SID,CURVID,H,PARMBEFORE),
    	chk_prules(SID,CURVID,T,PARMBEFORE).	%Removing ! to enable tail.rec.elim

%Case selection on input parameter.
%..phrase-rules...
  chk_prule(SID,CURVID,if_(SI,BEXP),PARMBEFORE) :-
   	chk_exp(SID,CURVID,BEXP,fact,_,PARMBEFORE),
   	chk_stritem(SID,CURVID,SI,PARMBEFORE).
  chk_prule(SID,CURVID,str(SI),PATHL) :-
    	chk_stritem(SID,CURVID,SI,PATHL).

  chk_fnrules(_,_,_,[],_) :- !.
  chk_fnrules(SID,VID,VT,[H|T],PARMBEFORE) :- 
   	chk_fnrule(SID,VID,VT,H,PARMBEFORE),
   	chk_fnrules(SID,VID,VT,T,PARMBEFORE).	%Removing ! to enable tail.rec.elim.

%Case selection on input parameter.
  chk_fnrule(SID,CURVID,fact,boolexp(BEXP),PARMBEFORE):-
   	chk_exp(SID,CURVID,BEXP,fact,_,PARMBEFORE).
  chk_fnrule(_,_,fact,boolmenu(_),_):-!.		%8/4-91. Dont check for b.menu
  chk_fnrule(SID,CURVID,fact,boolfacts(FNRULES),PARMBEFORE):- 
   	chk_fnrules(SID,CURVID,fact,FNRULES,PARMBEFORE).
  chk_fnrule(SID,CURVID,number,exp(EXP),PARMBEFORE):-
   	chk_exp(SID,CURVID,EXP,number,_,PARMBEFORE).
  chk_fnrule(SID,CURVID,VT,if_(BEXP1,BEXP2),PARMBEFORE) :-
   	chk_exp(SID,CURVID,BEXP2,fact,_,PARMBEFORE),  
   	chk_exp(SID,CURVID,BEXP1,VT,_,PARMBEFORE).  

  chk_var_atr(SID,VID,_) :- used_parm(SID,VID),!.
  chk_var_atr(SID,VID1,PARMBEFORE):-
     	vars_(SID,_,VID,_,EXPL,ASK,_,RULE,_),
     	upper_lower(VID,VID1),!,
     	chk_stritem(SID,parm(VID),EXPL,PARMBEFORE),   
     	chk_stritem(SID,parm(VID),ASK,PARMBEFORE),   
     	chk_rules(SID,VID,RULE,PARMBEFORE).
 
  chk_rules(SID,VID,fact(FNRULES),PB)     :-chk_fnrules(SID,parm(VID),fact,FNRULES,PB).
  chk_rules(SID,VID,number(_,FNRULES),PB) :-chk_fnrules(SID,parm(VID),number,FNRULES,PB).
  chk_rules(SID,VID,category(_,CRULES),PB):-chk_crules(SID,parm(VID),CRULES,PB).
  chk_rules(SID,VID,phrase(PRULES),PB)    :-chk_prules(SID,parm(VID),PRULES,PB).
 
  var_exist(SID,VID1,TYPE):- 
  	vars_(SID,_,VID,_,_,_,TYPE,_,_),
  	upper_lower(VID,VID1),!.

  consult_type_error(SID):-
   	txt(chck_kb,CK),
   	txt(chck_typeerror,CT),
   	concat(CK,CT,CC),
   	error_msg(SID,CC).

  chck_exp_type(SID,ID,VAL) :-
   	var_exist(SID,ID,TYPE),
   	chck_exp_type1(TYPE,VAL),!.
  chck_exp_type(SID,_,_):-
   	consult_type_error(SID),fail.
   
  chck_exp_type1(phrase,str(_)):-!.
  chck_exp_type1(category,str(_)):-!.
  chck_exp_type1(number,int(_)):-!.
  chck_exp_type1(number,float(_)):-!.
  chck_exp_type1(fact,true):-!.
  chck_exp_type1(fact,false):-!.
  chck_exp_type1(fact,unknown):-!.

  chk_type(_,_,_,category,category,category ) :- !.
  chk_type(_,_,_,category,phrase  ,phrase   ) :- !.
  chk_type(_,_,_,phrase  ,category,phrase   ) :- !.
  chk_type(_,_,_,number  ,number  ,number   ) :- !.
  chk_type(_,_,_,fact    ,fact    ,fact     ) :- !.
  chk_type(_,_,_,phrase  ,phrase  ,phrase   ) :- !.
  chk_type(_,_,_,category,dummy   ,category ) :- !.
  chk_type(_,_,_,number  ,dummy   ,number   ) :- !.
  chk_type(_,_,_,fact    ,dummy   ,fact     ) :- !.
  chk_type(_,_,_,phrase  ,dummy   ,phrase   ) :- !.
  chk_type(_,_,_,_       ,dummy   ,dummy    ) :- !. 
  chk_type(SID,CURVID,c_var(_,POSI),_,_,dummy) :- 
	chck_err(SID,chck_typeerror,CURVID,POSI).

  chk_var(SID,CURVID,c_var(VID,POSI),_,dummy,PARMBEFORE) :-
	ve_member(VID,PARMBEFORE),!,
	chck_err(SID,chck_cparm,CURVID,POSI).
  chk_var(SID,CURVID,c_var(VID,POSI),TY1,TY2,PARMBEFORE) :-
	no_check_error(SID),
	var_exist(SID,VID,VTY),
	chk_type(SID,CURVID,c_var(VID,POSI),VTY,TY1,TY2),
	chk_var_atr(SID,VID,[VID|PARMBEFORE]),
	remember_parm(SID,VID),!.
  chk_var(SID,INV_ID,c_var(_,POSI),_,dummy,_) :- 
 	chck_err(SID,chck_pnotdef,INV_ID,POSI).

/* check function call */
  chk_arity(_,_,_,I,I) :- !.
  chk_arity(SID,CURVID,POSI,_,A) :- 
         no_check_error(SID),
         txt(chck_ill_arity,TXT5),
         str_int(S,A),
         concat(TXT5,S,T8),
         store_position(SID,CURVID,POSI,T8),!.

  chk_func_arg(_,_,[],[],_) :- !.
  chk_func_arg(SID,CURVID,[TY|TYL],[EXP|EXPL],PARMBEFORE) :- 
      	chk_exp(SID,CURVID,EXP,TY,_,PARMBEFORE),
      	chk_func_arg(SID,CURVID,TYL,EXPL,PARMBEFORE).

  chk_func(SID,CURVID,c_func(FID1,POSI,EXPL),TY1,TY2,PARMBEFORE) :-
      	no_check_error(SID),
      	upper_lower (FID1,FID),
      	func_descr(FID,ARITY,VTYLIST,VTY),
      	explist_shift(FID,EXPL,EXPL2),
      	listlen_version2(EXPL2,ELEN),
      	chk_arity(SID,CURVID,POSI,ELEN,ARITY),
      	no_check_error(SID),
      	chk_type(SID,CURVID,c_var(FID,POSI),VTY,TY1,TY2),
      	chk_func_arg(SID,CURVID,VTYLIST,EXPL2,PARMBEFORE),!.
  chk_func(SID,INV_ID,c_func(_,POSI,_),_,dummy,_) :- 
 	chck_err(SID,chck_fnotdef,INV_ID,POSI).

  chk_dyad(SID,CURVID,E1,E2,TYP,PARMBEFORE)  :- !,
	chk_exp(SID,CURVID,E1,TYP,_,PARMBEFORE),
	chk_exp(SID,CURVID,E2,TYP,_,PARMBEFORE).

  chk_exp(SID,CURVID,c_var(VID,POSI),TY1,TY2,PARMBEFORE)  :- 
	chk_var(SID,CURVID,c_var(VID,POSI),TY1,TY2,PARMBEFORE),!.
  chk_exp(SID,CURVID,c_func(FID,POSI,EXPL),TY1,TY2,PARMBEFORE)  :- !,
	chk_func(SID,CURVID,c_func(FID,POSI,EXPL),TY1,TY2,PARMBEFORE).
  chk_exp(SID,CURVID,plus(E1,E2),_,number,PARMBEFORE):- !,
	chk_dyad(SID,CURVID,E1,E2,number,PARMBEFORE).
  chk_exp(SID,CURVID,minus(E1,E2),_,number,PARMBEFORE):- !,
	chk_dyad(SID,CURVID,E1,E2,number,PARMBEFORE).
  chk_exp(SID,CURVID,mult(E1,E2),_,number,PARMBEFORE):- !,
	chk_dyad(SID,CURVID,E1,E2,number,PARMBEFORE).
  chk_exp(SID,CURVID,div(E1,E2),_,number,PARMBEFORE):- !,
	chk_dyad(SID,CURVID,E1,E2,number,PARMBEFORE).
  chk_exp(SID,CURVID,monmin(E),_,number,PARMBEFORE):- !,
	chk_exp(SID,CURVID,E,number,_,PARMBEFORE).
  chk_exp(_,_,c_int(_,_),number,number,_):-!. 
  chk_exp(_,_,c_int(_,_),dummy,number,_):-!.
  chk_exp(SID,ID,c_int(_,POSI),_,number,_):-!,chck_err(SID,chck_typeerror,ID,POSI).
  chk_exp(_,_,c_float(_,_),number,number,_):- !.
  chk_exp(_,_,c_float(_,_),dummy,number,_):-!.	
  chk_exp(SID,ID,c_float(_,POSI),_,number,_):-!,chck_err(SID,chck_typeerror,ID,POSI).
  chk_exp(_,_,c_bool(_,_),fact,fact,_):-!.	
  chk_exp(_,_,c_bool(_,_),dummy,fact,_):-!.
  chk_exp(SID,ID,c_bool(_,P),_,fact,_):-!,chck_err(SID,chck_typeerror,ID,P).
  chk_exp(_,_,c_str(_,_),phrase,phrase,_):-!. 
  chk_exp(_,_,c_str(_,_),category,category,_):-!.
  chk_exp(_,_,c_str(_,_),dummy,phrase,_):-!. 
  chk_exp(SID,_,nl,_,phrase,_):-  no_check_error(SID),!.
  chk_exp(SID,ID,c_str(_,P),_,phrase,_):-!,chck_err(SID,chck_typeerror,ID,P).
  chk_exp(SID,CURVID,or_(B1,B2),_,fact,PARMBEFORE):- !,
     	chk_dyad(SID,CURVID,B1,B2,fact,PARMBEFORE).
  chk_exp(SID,CURVID,and_(B1,B2),_,fact,PARMBEFORE):- !,
     	chk_dyad(SID,CURVID,B1,B2,fact,PARMBEFORE).
  chk_exp(SID,CURVID,not_(BOOL),_,fact,PARMBEFORE):- !,
     	chk_exp(SID,CURVID,BOOL,fact,_,PARMBEFORE).
  chk_exp(SID,CURVID,rel(E1,_,E2),_,fact,PARMBEFORE):- !,
     	chk_exp(SID,CURVID,E1,dummy,TY,PARMBEFORE),
     	chk_exp(SID,CURVID,E2,TY,_,PARMBEFORE).
  chk_exp(SID,_,_,_,dummy,_) :-  
     	no_check_error(SID),
     	store(SID,chkerr,err1).
  
  chck_relvalues(str(_),str(_)):- !.
  chck_relvalues(int(_),int(_)):- !.
  chck_relvalues(int(_),float(_)):- !.
  chck_relvalues(float(_),float(_)):- !.
  chck_relvalues(float(_),int(_)):- !.
  chck_relvalues(FACT1,FACT2):- 
   	chck_exp_type1(fact,FACT1),
   	chck_exp_type1(fact,FACT2),!.

/*---- check that all parameters is used -----*/

% 2.parm:CONSTANT = chck_pnotused for parameters
%		  = chck_snotused for sections

  trav_id_list(_,[],_).
  trav_id_list(SID,[H|T],chck_pnotused) :-
         used_parm(SID,H1),upper_lower(H,H1),!,
         trav_id_list(SID,T,chck_pnotused).
  trav_id_list(SID,[H|T],chck_snotused):-
	used_sect(SID,H1),upper_lower(H,H1),!,
	trav_id_list(SID,T,chck_snotused).
  trav_id_list(SID,[H|T],Constant) :-  % fejler 
        trav_msg(SID,Constant,H),
        trav_id_list(SID,T,Constant).

  trav_msg(SID,Constant,H)     :- 
  	txt(Constant,CT),
  	format(STR,"\r\n% \t: %",CT,H),
  	store_tmptxt(SID,STR).
%------------------------------------------------------------------------
%	CHECKING KNOWLEDGE BASE; PARSING AND REPORTING ERRORS
%------------------------------------------------------------------------
PREDICATES
  correcterror(SID,INV_ID,CHARPOS,STRING)
  inspect_warnings(SID)
CLAUSES
  checkknow (SID):-
	checkknowledge(SID),
        inspect_warnings(SID),!.

  checkknow (SID):-
        retractall(environment(SID,chkerr,_)),
        retractall(environment(SID,checkstatus,_)),
        checkerrorposition(SID,INV_ID,CHARPOS,STRING),!,
        correcterror(SID,INV_ID,CHARPOS,STRING).

  inspect_warnings(SID):-
	not(checkerrorposition(SID,_,_,_)),! %If no errors or warnings do nothing
	;
	retrieve(SID,checkstatus,STATUS),
	STATUS="ok",			% if OK, exept for WARNINGS
	checkerrorposition(SID,ID,P,S),!,	% AND there is a WARNING
	correcterror(SID,ID,P,S).
  inspect_warnings(_).

  correcterror(SID,parm(ID1),CHARPOS,FTEKST) :-
         vars_(SID,_STR,ID,_,_,_,_,_,_),upper_lower(ID,ID1),!,
         format (Err,"% in parameter [%s], position %d",FTEKST,ID,CHARPOS),
         error_msg (SID,Err).
         % esta_editor_chck(parameter,STR,ID,CHARPOS,FTEKST).

  correcterror(SID,sect(SecID1),CHARPOS,FTEKST) :-
         section(_STR,SecID,_),upper_lower(SecID1,SecID),!,
         format (Err,"%s in section [%s], position %d",FTEKST,SecID,CHARPOS),
         error_msg (SID,Err).
         % esta_editor_chck(section,STR,SID,CHARPOS,FTEKST).