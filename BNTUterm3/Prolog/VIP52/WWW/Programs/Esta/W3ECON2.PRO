/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  WEBESTA
 FileName: W3ECON2.PRO
 Purpose: 
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "w3esta.inc"

CONSTANTS
% help - contexts

how_hlp = "how_was_the_parameter_value_established__parameter_menu_"

 
PREDICATES 
 txttilwhy(VARTYPE,STRING)
 wr_explain(SID,STRING)
 wr_sect_dir_text(SID,IDL)  
 wr_status_text(SID,IDL)
 showparmdef(SID,ID)
 %showsectdef(ID)
 actwhy(SID,ID,INTEGER,PPATHL)
 wrunimethod(SID,ID,UNI_METHOD)
 wrunityp(SID,ID,VARTYPE,RULES,UNI_METHOD)
 wrcrule(SID,CATRULE)
 wrprule(SID,PHRASERULE)
 wrfnrule(SID,FNRULE)
  
 acthowparm(SID,ID)
 
 wrch(SID,CHAR)
 writeMULT(SID,EXP)
 writeMINUS(SID,EXP)
 writeDIV(SID,EXP)
 writePAR(SID,EXP)
 wrpath(SID,PPATH)
 wrpathl(SID,PPATHL)
 
 wrpathnextnode(SID,ACTION)

 writeexplist(SID,EXPL)
 writeexp(SID,EXP)
 writestr(SID,STRING)

 wrspathl(SID,SPATHL)
 wrspathl2(SID,SPATHL)
 wrspath(SID,SPATH,SPATHL) 
 wrand(SID,SPATHL)

 store_txt(SID,string)

CLAUSES
  store_txt(SID,TXT):- txt(TXT,TXT1),store_tmptxt(SID,TXT1).
 	
  why (SID):- 
  	ex_cur_vid(SID,ID), 
  	get_ppathl(SID,PATHS),!,
  	actwhy(SID,ID,0,PATHS).
                        
  why_advice (SID) :- 
 	get_spathl(SID,SPATHL),!,
 	wrspathl(SID,SPATHL).

  show_cur_parm (SID) :- 
  	ex_cur_vid(SID,ID),!,
  	showparmdef(SID,ID).
 
  explain_question_exists (SID) :- 
	ex_cur_vid(SID,ID),
	vars_(SID,_,ID1,_,EXPL,_,_,_,_),
	upper_lower(ID,ID1),!,
	expl_str_stritem(S,EXPL),
	strip(S,S1),
	S1 <> "".
 
 explain_question (SID):-
	ex_cur_vid(SID,ID),
	vars_(SID,_,ID1,_,EXPL,_,_,_,_),
	upper_lower(ID,ID1),!,
	expl_str_stritem(S,EXPL),
	strip(S,S1),
	wr_explain(SID,S1).
 
 how_parm_established :-!.
 /*
        laesvalueparm(how_hlp,VIDOUT),
        acthowparm(VIDOUT),
        txt(cons_how_parm,HP),
        format(HEAD,HP,VIDOUT),
        flush_tmptxt(STR),
        infomsg(HEAD,STR).
 */
PREDICATES
  get_val_str(SID,ID,EVALUE,STRING)
CLAUSES 
  get_val_str(SID,VID1,_,V_TEXT):-
     	vars_(SID,_,VID,_,_,_,_,_,_),
     	upper_lower(VID,VID1),!,
     	mk_val_str(SID,VID,V_TEXT).
  get_val_str(_,_,EVALUE,V_TEXT):-
     	val_str(EVALUE,V_TEXT).
         
  acthowparm(SID,VIDOUT1) :-
        evalue_(SID,VIDOUT,EVALUE,UNIMETHOD),        
        upper_lower(VIDOUT1,VIDOUT),
        get_val_str(SID,VIDOUT,EVALUE,V_TEXT),
        %store_tmptxt("\r\n"),
        txt(cons_parm,C),
        concat(C," ",C1),
        store_tmptxt(SID,C1),
	store_tmptxt(SID,VIDOUT), 
	store_txt(SID,cons2_gotvalue),
        store_tmptxt(SID,V_TEXT),
        wrunimethod(SID,VIDOUT,UNIMETHOD),!.

  wrunimethod(SID,VID1,question) :- 
        vars_(SID,_,VID,_,_,ASK,_,_,_),
        upper_lower(VID,VID1),
        store_txt(SID,cons2_rule1),
        expl_str_stritem(STR,ASK),
        strip(STR,STR0),
        mk_askstring(SID,STR0,VID,STR1),
        store_tmptxt(SID,STR1),!.
  wrunimethod(SID,VID1,rule(UNI)) :- 
        vars_(SID,_,VID,_,_,_,VARTYPE,RULES,_),
        upper_lower(VID,VID1),
        wrunityp(SID,VID,VARTYPE,RULES,rule(UNI)),!.
  wrunimethod(SID,_,assign(S)) :- 
        store_txt(SID,cons2_uniassign),
        store_tmptxt(SID,S),!.
  wrunimethod(SID,_,alien) :- !,
        store_txt(SID,cons2_alien).

  wrunityp(SID,_,fact,fact([boolmenu(_),boolfacts(FRULES)]),rule(RNO)) :- !,
        index(RNO,FRULES,FRULE),
        wrfnrule(SID,FRULE).                 
  wrunityp(SID,_,fact,fact(FRULES),rule(RNO)) :-
	index(RNO,FRULES,FRULE),
        wrfnrule(SID,FRULE).                 
  wrunityp(SID,_,number,number(_,NRULES),rule(RNO)) :-
        index(RNO,NRULES,NRULE),
        wrfnrule(SID,NRULE).                 
  wrunityp(SID,_,category,category(_,CRULES),rule(RNO)) :-
        index(RNO,CRULES,CRULE),
        wrcrule(SID,CRULE).                 
  wrunityp(SID,_,phrase,phrase(PRULES),rule(RNO)) :-
        index(RNO,PRULES,PRULE),
        wrprule(SID,PRULE).                 

  wrfnrule(SID,exp(EXP)) :-
	store_txt(SID,cons2_rudtryk),
	writeexp(SID,EXP).
  wrfnrule(SID,boolexp(BEXP)) :-
	store_txt(SID,cons2_rudtryk),
	writeexp(SID,BEXP).
  wrfnrule(SID,if_(BEXP1,BEXP2)) :-
	store_txt(SID,cons2_rfolwrule),
	writeexp(SID,BEXP1) ,
	store_txt(SID,cons2_rif),
	writeexp(SID,BEXP2).
     
  wrprule(SID,str(SI)) :-
	store_txt(SID,cons2_rsiexp),
	writeexplist(SID,SI).
  wrprule(SID,if_(SI,BEXP2)) :-
        store_txt(SID,cons2_rfolwrule),
        writeexplist(SID,SI),
        store_txt(SID,cons2_rif),
        writeexp(SID,BEXP2).
  wrcrule(SID,opt(O)) :-
        store_txt(SID,cons2_ropt),
        S=O,
        store_tmptxt(SID,S).
  wrcrule(SID,if_(OPT,BEXP2)) :-
        store_txt(SID,cons2_rfolwrule),
        S=OPT,
        store_tmptxt(SID,S),
        store_tmptxt(SID," "),
        store_txt(SID,cons2_rif),
        writeexp(SID,BEXP2).

  showparmdef(SID,VID1) :- 
        vars_(SID,TXT,VID,_,_,_,_,_,_),
        upper_lower(VID,VID1),
        txt(cons_parmdef,PD),
        format(HEAD,PD,VID),
        infomsg(SID,HEAD,TXT),!.
  
  showparmdef(SID,_) :-
        symb_error_msg(SID,parmnotfound),!.
 /*
 showsectdef(SID) :-
        section(TXT,SID1,_),
        upper_lower(SID1,SID),
        txt(cons_sectdef,SD),
        format(HEAD,SD,SID),
        infomsg(HEAD,TXT),!.
 */      
  actwhy(SID,VID1,0,PPATHL) :- 
      	vars_(SID,_,VID,_,_,_,TYP,_,_),
      	upper_lower(VID,VID1),!,
      	get_var_descr(SID,VID,TXT),
      	txttilwhy(TYP,WTXT),
      	format(TXT4,"\n\r%s%s",WTXT,TXT),   % \n\r
      	store_tmptxt(SID,TXT4),
      	wrpathl(SID,PPATHL),
      	flush_tmptxt(SID,STR),
      	txt("whyquest",WQ),
        str_bin(STR,STR1,_),      	
      	infomsg(SID,WQ,STR1).

  txttilwhy(fact,WTXT) :- !,txt(cons2_whyl,WTXT).
  txttilwhy(_,WTXT)    :- !,txt(cons2_whyn,WTXT).

  wr_explain(SID,"") :- 
	wrsymbtxt(SID,cons2_noexpl),!.
  wr_explain(SID,STR) :- 
	format(STRNL,"%\n\r",STR),
        txt("cons_explain",E),
        str_bin(STRNL,STRNL1,_),
        infomsg(SID,E,STRNL1).

DATABASE - l
determ len_id(integer)

PREDICATES
init_len
store_len(string)
get_max_len_of_id(integer)

CLAUSES
init_len:-
  retractall(_,l),
  assert(len_id(0)).

get_max_len_of_id(I):- len_id(I),!.
get_max_len_of_id(32).

store_len(STR):-
  str_len(STR,L),
  len_id(L0),
  L0 < L,!,
  retract(len_id(_)),
  assert(len_id(L)).
store_len(_).

PREDICATES
  store_with_nl(SID,string)
  wr_sects(SID,IDL)
  wr_parms(SID,IDL)
CLAUSES
  wr_sects(_,[]):-!.
  wr_sects(SID,[F|R]):-
   	section_(SID,S,F,_),!,
   	store_with_nl(SID,S),
   	wr_sects(SID,R).
   	
  wr_parms(_,[]):-!.
  wr_parms(SID,[F|R]):-
     	vars_(SID,P,F,_,_,_,_,_,_),!,
   	store_with_nl(SID,P),
   	wr_parms(SID,R).

  store_with_nl(SID,STR):- 
    	concat(STR,"<p>",STRNL),   % \n\r
    	store_tmptxt(SID,STRNL).

  kb_dir(SID,_,_) :- 
    	txt(cons_title,CT),
    	store_with_nl(SID,CT),
    	title_(SID,T),
      	  store_with_nl(SID,T),
    	fail.
  kb_dir(SID,_,_) :- 
    	txt(cons_sects,CS),
    	store_with_nl(SID,CS),
    	findall(I,section_(SID,_,I,_),IDL),
    	sort_idl(IDL,IDL1),
	wr_sects(SID,IDL1),
	fail.    	
  kb_dir(SID,_,_) :- 
    	txt(cons_parms,CP),
    	store_with_nl(SID,CP),
    	findall(P,vars_(SID,_,P,_,_,_,_,_,_),PL),
    	sort_idl(PL,PL1),
    	wr_parms(SID,PL1),
    	fail.
  kb_dir(SID,STR,10) :-
    	flush_tmptxt(SID,STR),!. 

PREDICATES 
  get_vid_text(SID,ID,STRING)
  wr_parm_value_body(SID,IDL,STRING,INTEGER)
CLAUSES
  parm_dir(SID,STR,MAXLEN) :-
        init_len,
        findall(VID,vars_(SID,_,VID,_,_,_,_,_,_),VIDL),
	wr_parm_value_body(SID,VIDL,STR,MAXLEN),!.

  value_dir(SID,STR,MAXLEN):-
        init_len,
        findall(VID,evalue_(SID,VID,_,_),VIDL),
	wr_parm_value_body(SID,VIDL,STR,MAXLEN),!.

  wr_parm_value_body(SID,VIDL,STR,MAXLEN):-	
        sort_idl(VIDL,VIDL2),
        wr_status_text(SID,VIDL2),
        flush_tmptxt(SID,STR),
        get_max_len_of_id(MAXLEN).

  get_vid_text(SID,VID1,TableStr):-
     	vars_(SID,_,VID,DESCR,_,_,_,_,_),
     	upper_lower(VID,VID1),!,
     	store_len(VID), 
     	mk_val_str(SID,VID,V_TEXT),
     	format(TableStr,"%\t: %(%)\n\r",VID,DESCR,V_TEXT).
  get_vid_text(SID,VID1,TableStr):-
     	evalue_(SID,VID,EVALUE,_),
     	upper_lower(VID,VID1),
     	store_len(VID),
     	val_str(EVALUE,STR),
     	txt("alien_val",AV),
     	format(TableStr,"%\t: %(%)\n\r",VID,AV,STR),!.        
  get_vid_text(_,_,"").

  wr_status_text(_,[])  :- !.
  wr_status_text(SID,[VID|VIDL]) :-  
        get_vid_text(SID,VID,TableStr),
        store_tmptxt(SID,TableStr),
        wr_status_text(SID,VIDL).

  sect_dir(SID,STR,MAXLEN) :-
        init_len,
        findall(SecID,section_(SID,_,SecID,_),SecIDL),
        sort_idl(SecIDL,SecIDL2),
        wr_sect_dir_text(SID,SecIDL2) , 
        flush_tmptxt(SID,STR),
        get_max_len_of_id(MAXLEN).

  wr_sect_dir_text(_,[])  :- !.
  wr_sect_dir_text(SID,[SecID|SecIDL]) :-  
      	section_(SID,_,SecID,DESCR),!,
      	store_len(SecID),
        expl_str_stritem(STR,DESCR), 
        strip(STR,STR1),
	format(TableStr,"%\t: %\n\r",SecID,STR1),
	store_tmptxt(SID,TableStr),
        wr_sect_dir_text(SID,SecIDL).
 
 /* -- write predicates ----*/

CLAUSES
  get_var_descr(SID,VID1,DESCR):-
        vars_(SID,_,VID,DESCR,_,_,_,_,_),
        upper_lower(VID,VID1),not(DESCR = ""),!.
  get_var_descr(_,VID,VID).       

  writestr(_,"") :- !.
  writestr(SID,STR) :- 
    	frontchar(STR,CH,REST),
    	wrch(SID,CH),
    	writestr(SID,REST).

  wrch(SID,'\'') :- store_tmptxt(SID,"''"),!.
  wrch(SID,CH) :- str_char(SCH,CH),store_tmptxt(SID,SCH).
    
  writeexplist(_,[]) :- !.
  writeexplist(SID,[EXP]):- writeexp(SID,EXP),!.
  writeexplist(SID,[EXP|EXPLIST]) :-
    	writeexp(SID,EXP),
    	store_tmptxt(SID,","),	%use to seperate 2 or more EXP's
    	writeexplist(SID,EXPLIST).
  
  writeexp(SID,rel(c_var(NAME,_),eq,c_str(STR,_))):- 
      get_var_descr(SID,NAME,DESCR),!,
%??   vars(_,NAME,DESCR,_,_,_,CATRULES),
%??   CATRULES=category(OPTIONDEFS,_),
%??   get_option(STR,OPTIONDEFS,STR2),
      store_tmptxt(SID,DESCR),
      txt(cons2_eq,T),
      store_tmptxt(SID,T),
      store_tmptxt(SID,STR).
  writeexp(SID,c_var(NAME,_)) :- get_var_descr(SID,NAME,DESCR),!,store_tmptxt(SID,DESCR).
  writeexp(SID,nl) :- store_tmptxt(SID," & ").
  writeexp(SID,c_func(FID,_,EL)):-store_tmptxt(SID,FID),store_tmptxt(SID,"("),writeexplist(SID,EL),store_tmptxt(SID,")").
  writeexp(SID,c_int(INT,_)) :- str_int(INTSTR,INT),store_tmptxt(SID,INTSTR).
  writeexp(SID,c_float(R,_)) :- str_real(RSTR,R),store_tmptxt(SID,RSTR).
  writeexp(SID,c_str(STR,_)) :- writestr(SID,STR).
  writeexp(SID,c_bool(true,_)) :- store_txt(SID,true).
  writeexp(SID,c_bool(false,_)):- store_txt(SID,false).
  writeexp(SID,or_(B1,B2)) :- writeexp(SID,B1),store_txt(SID,or_),writeexp(SID,B2).
  writeexp(SID,and_(B1,B2)) :- writeexp(SID,B1),store_txt(SID,and_),writeexp(SID,B2).
  writeexp(SID,not_(BOOL)) :- store_txt(SID,not_),writeexp(SID,BOOL).
  writeexp(SID,rel(E1,REL,E2)) :- writeexp(SID,E1),tok_str(REL,STR),store_tmptxt(SID,STR),writeexp(SID,E2).
  writeexp(SID,monmin(EXP2)) :- store_tmptxt(SID,"-"),writeMULT(SID,EXP2).
  writeexp(SID,plus(EXP1,EXP2)):- writeexp(SID,EXP1),store_tmptxt(SID,"+"),writeexp(SID,EXP2).
  writeexp(SID,minus(E1,E2)) :- writeexp(SID,E1),store_tmptxt(SID,"-"),writeMULT(SID,E2).
  writeexp(SID,mult(EXP1,EXP2)):- writeMULT(SID,EXP1),store_tmptxt(SID,"*"),writeMULT(SID,EXP2).
  writeexp(SID,div(EXP1,EXP2)) :- writeMULT(SID,EXP1),store_tmptxt(SID,"/"),writeDIV(SID,EXP2).

  writeDIV(SID,mult(X,Y)) :-!,writepar(SID,mult(X,Y)).
  writeDIV(SID,X) :- writeMULT(SID,X).

  writeMULT(SID,minus(X,Y)) :-!,writepar(SID,minus(X,Y)).
  writeMULT(SID,X) :- writeMINUS(SID,X).

  writeMINUS(SID,plus(X,Y)) :-!,writepar(SID,plus(X,Y)).
  writeMINUS(SID,X) :- writeexp(SID,X).

  writePAR(SID,EXP) :- store_tmptxt(SID,"("),writeexp(SID,EXP),store_tmptxt(SID,")").

  wrspathl(SID,[]) :- wrsymbtxt(SID,cons2_curstartsect),!.
  wrspathl(SID,[last_advice(S,P,_)]) :- 
        paragraph_(SID,S1,P,c_bool(true,_),_),
        upper_lower(S,S1),!,
        wrsymbtxt(SID,cons2_always). % NL
  wrspathl(SID,[refer(S1,P,A,S2)|L]) :- !,
        txt(cons2_cursect,C),
        store_tmptxt(SID,C),
        wrspathl2(SID,[refer(S1,P,A,S2)|L]),
        flush_tmptxt(SID,STR),
        txt(whyadv,WA),
        infomsg(SID,WA,STR).
  wrspathl(SID,L) :- 
 	wrspathl2(SID,L),
        flush_tmptxt(SID,STR),
        txt(whyadv,WA),
        infomsg(SID,WA,STR).
 
  wrspathl2(_,[]) :- !.
  wrspathl2(SID,[H|T]):- wrspath(SID,H,T),!,wrspathl2(SID,T).
  wrspathl2(_,_) :-  !.

  wrspath(SID,last_advice(S,P,_),_) :- 
        paragraph_(SID,S1,P,c_bool(true,_),_),
        upper_lower(S,S1),!,
        store_txt(SID,cons2_always2),
        store_tmptxt(SID,"\n\r").
  wrspath(SID,last_advice(S,P,_),_):-
        paragraph_(SID,S1,P,BEXP,_),
        upper_lower(S,S1),!,
        store_txt(SID,cons2_cause_adv),
        writeexp(SID,BEXP),
        store_tmptxt(SID,"\n\r").
  wrspath(SID,refer(SFROM,P,_, /* STO */_ ),_):- 
        paragraph_(SID,SFROM1,P,c_bool(true,_),_),
        upper_lower(SFROM,SFROM1),!,
        store_tmptxt(SID,"\n\r").
  wrspath(SID,refer(SFROM,P,_, _ /*STO*/ ),T) :- 
        paragraph_(SID,SFROM1,P,BEXP,_),
        upper_lower(SFROM,SFROM1),!,
        writeexp(SID,BEXP),
        wrand(SID,T).

  wrand(_,[]):- !.
  wrand(SID,_) :- store_txt(SID,and_). /* AND nl */
 
  wrpathl(_,[]):- !. 
  wrpathl(SID,[H|T]):- wrpath(SID,H),!,wrpathl(SID,T).
  wrpathl(_,_).
 
  wrpath(SID,cond(BEXP)) :-
        store_txt(SID,wrex_cond),
        store_tmptxt(SID,"<B>"),
        writeexp(SID,BEXP),
        store_tmptxt(SID,"</B>").
  wrpath(SID,parm(VID1))  :-  
        vars_(SID,_,VID,_,_,_,VARTY,_,_),
        upper_lower(VID,VID1),VARTY=fact,!,
        get_var_descr(SID,VID,TXT),
        store_txt(SID,wrex_parml),
        store_tmptxt(SID,"<I>"),
        store_tmptxt(SID,TXT),
        store_tmptxt(SID,"</I>").
  wrpath(SID,parm(VID)):- !,
        get_var_descr(SID,VID,TXT),       
        store_txt(SID,wrex_parmn),
        store_tmptxt(SID,"<B>"),
        store_tmptxt(SID,TXT),
        store_tmptxt(SID,"</B>").
  wrpath(SID,vol(VID)) :- !,
        get_var_descr(SID,VID,TXT),       
        store_txt(SID,wrex_vol),
        store_tmptxt(SID,"<B>"),
	store_tmptxt(SID,TXT),
        store_tmptxt(SID,"</B>").
  wrpath(SID,exp(EXP)) :-
       	store_txt(SID,wrex_exp),
       	store_tmptxt(SID,"<B>"),
       	writeexp(SID,EXP),
       	store_tmptxt(SID,"</B>").
  wrpath(SID,phrase(SI)):-  
       	expl_str_stritem(TXT,SI),
       	strip(TXT,TXT1),
       	store_txt(SID,wrex_nextdisplay),
       	store_tmptxt(SID,"<I>"),
       	store_tmptxt(SID,TXT1),
       	store_tmptxt(SID,"</I>").
  wrpath(SID,assign(ID,EXP)) :-
        store_txt(SID,wrex_ass1),
        store_tmptxt(SID,"<B>"),
        store_tmptxt(SID,ID),
        store_tmptxt(SID,"</B>"),
        store_txt(SID,wrex_ass2),
        writeexp(SID,EXP).
  wrpath(SID,nextnode(SecID,PNO)) :- 
      	paragraph_(SID,SecID1,PNO,_,[ACT|_]),
      	upper_lower(SecID,SecID1),!,
      	wrpathnextnode(SID,ACT).
      
  wrpathnextnode(SID,display(SI)):-
      	expl_str_stritem(TXT,SI),
      	strip(TXT,TXT1),
      	store_txt(SID,wrex_nextdisplay),
        store_tmptxt(SID,"<I>"),
      	store_tmptxt(SID,TXT1),
      	store_tmptxt(SID,"</I>").
  wrpathnextnode(SID,refer(SecID,_)) :-
      	section_(SID,_,SecID1,[c_str(STR,_)]),
      	upper_lower(SecID,SecID1),!,
      	store_txt(SID,wrex_nextrefer),
      	store_tmptxt(SID,"<B>"),
      	store_tmptxt(SID,SecID),
      	store_tmptxt(SID,"</B>"),
      	store_tmptxt(SID,"("),
      	store_tmptxt(SID,"<I>"),
      	store_tmptxt(SID,STR),
      	store_tmptxt(SID,"</I>"),
      	store_tmptxt(SID,")").
  wrpathnextnode(SID,quit) :- 
      	store_txt(SID,wrex_nextquit).
  wrpathnextnode(SID,exit) :- 
      	store_txt(SID,wrex_nextexit).
  wrpathnextnode(SID,call(FID,CP,EXPL)) :- 
      	store_txt(SID,wrex_nextcall),
      	writeexp(SID,c_func(FID,CP,EXPL)).
