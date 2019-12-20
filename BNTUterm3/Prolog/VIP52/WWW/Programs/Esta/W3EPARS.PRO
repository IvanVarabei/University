/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3EPARS
 FileName: W3EPARS.PRO
 Purpose: ESTA Parser
 Written by:
 Comments:
    10.12.97 OE Parser error handling is changed to simply display error (not edit)
    15.12.97 OE Multiuser support.
******************************************************************************/
include "w3esta.inc"

DATABASE - space_comment
  start_str(SID,STRING)
  start_pos(SID,CHARPOS)

PREDICATES
  get_relkind(TOKN) 

/*************************************************************************/
/*             SCANNING AND PARSING OF EXPRESSIONS                       */
/*************************************************************************/
  chck_str(integer,integer,string,string)
  tokl(SID,STRING,TOKL,CHARPOS)  /* Scanning */
  skip_space_and_comments(SID,STRING,STRING,CHARPOS,CHARPOS,CHARPOS)
  chtyp(CHAR,CHTYP)         
  cnt_skips(STRING,CHARPOS,CHARPOS)
  skipspace(STRING,STRING,CHARPOS)
  chck_comment(SID,STRING,CHARPOS)
  begin_comment(STRING,STRING,CHARPOS,CHARPOS)
  end_comment(SID,STRING,STRING,CHARPOS,CHARPOS,CHARPOS)
  skip_comment(SID,STRING,STRING,CHARPOS,CHARPOS,CHARPOS)

  get_str(SID,STRING,STRING,STRING,STRING,CHARPOS,CHARPOS)
  fronttok(SID,STRING,STRING,STRING,CHARPOS,CHARPOS,CHARPOS)

  make_tok(SID,STRING,TOKN,STRING,STRING,INTEGER,INTEGER)
  get_token(STRING,STRING,STRING,CHARPOS)
 
  opt_expect(SID,TOKN,TOKL,TOKL)
  expect_err(SID,TOKN,TOKL,TOKL,STRING) % o,i,o,i
  tok_oneoff_err(SID,TOKNL,TOKL,STRING)
  tok_member(TOKN,TOKNL)
  tok_alright(TOKN,TOKN)
  skip(TOKN,TOKL,TOKL)
 
  mk_paral(ACTION,ACTIONS,ACTIONS)

  s_section(SID,STRING,TOKL,TOKL,DBASEDOM,DBALIST)
  s_section_descr(STRING,CHARPOS,TOKL,TOKL)
 
  s_paragraphs(SID,ID,PNO,TOKL,TOKL,DBALIST)
  s_paragraph(SID,ID,PNO,TOKL,TOKL,DBASEDOM)
  ss_actions(SID,TOKL,TOKL,ACTIONS)
  s_actions(SID,TOKL,TOKL,ACTIONS)
  s_acts(SID,TOKL,TOKL,ACTIONS)
  s_action(SID,TOKL,TOKL,ACTION)
  s_parm(SID,STRING,TOKL,TOKL,DBASEDOM)

  s_parm_descr(SID,STRING,TOKL,TOKL) 
  s_ruleentry(SID,VARTYPE,TOKL,TOKL,RULES)
  s_range(SID,TOKL,TOKL,RANGE)
  s_range1(SID,TOKL,TOKL,RANGE)
  fronttal(SID,EVALUE,TOKL,TOKL)
  testnext(SID,TOKL)
  s_expl(SID,TOKL,TOKL,EXPL)
  s_optiondefs(SID,INTEGER,TOKL,TOKL,OPTIONDEFS)
  s_factrules(SID,TOKL,TOKL,FNRULES)
  s_factrule(SID,TOKL,TOKL,FNRULE)
  s_factrule1(SID,TOKL,TOKL,EXP,FNRULE)
  s_numbrules(SID,TOKL,TOKL,FNRULES)
  s_numbrule(SID,TOKL,TOKL,FNRULE)
  s_numbrule1(SID,TOKL,TOKL,EXP,FNRULE)
 
  s_phraserules(SID,TOKL,TOKL,PHRASERULES)
  s_phraserule(SID,TOKL,TOKL,PHRASERULE)
  s_phraserule1(SID,TOKL,TOKL,EXPL,PHRASERULE)
  s_catrules(SID,TOKL,TOKL,CATRULES)
  s_catrule(SID,TOKL,TOKL,CATRULE)
  s_catrule1(SID,TOKL,TOKL,OPTION,CATRULE)
  ss_factrules(SID,TOKL,TOKL,FNRULES)
  ss_optiondefs(SID,INTEGER,TOKL,TOKL,OPTIONDEFS)
  ss_catrules(SID,TOKL,TOKL,CATRULES)
  ss_numbrules(SID,TOKL,TOKL,FNRULES)
  ss_phraserules(SID,TOKL,TOKL,PHRASERULES)
  s_type(TOKL,TOKL,VARTYPE)
  s_ask(SID,TOKL,TOKL,EXPL)
  s_pic(SID,TOKL,TOKL,STRING)
  s_text(SID,TOKL,TOKL,EXPL)
  s_asktext(SID,TOKL,TOKL,EXPL)
  s_asktext1(SID,TOKL,TOKL,EXPL)
  s_text1(SID,TOKL,TOKL,EXPL)
  s_or(SID,TOKL,TOKL,EXP)
  s_or1(SID,TOKL,TOKL,EXP,EXP)
  s_and(SID,TOKL,TOKL,EXP)
  s_and1(SID,TOKL,TOKL,EXP,EXP)
 
  s_rel_exp(SID,TOKL,TOKL,EXP)
  s_rel_exp1(SID,TOKL,TOKL,EXP,EXP)

  s_exp(SID,TOKL,TOKL,EXP)
  s_mult(SID,TOKL,TOKL,EXP)
  s_mult1(SID,TOKL,TOKL,EXP,EXP)
  s_plus(SID,TOKL,TOKL,EXP)
  s_plus1(SID,TOKL,TOKL,EXP,EXP)
  s_elmexp(SID,TOKL,TOKL,EXP)
  s_elmexp1(SID,TOKL,TOKL,EXP,STRING)

  func_name(SID,SYMBOL,STRING,CHARPOS) 
  proc_name(SID,SYMBOL,STRING,CHARPOS) 

  s_explist(SID,TOKL,TOKL,EXPL)
  s_explist1(SID,TOKL,TOKL,EXPL)
 
  ass_paragraphs(DBALIST)
 
  fail_if_parse_error(SID)
  store_position(SID,CHARPOS,STRING) 
  store_position_symb(SID,CHARPOS,STRING) 

CLAUSES
  store_position(SID,POS,FTEKST) :- 
	retractall(textposition(SID,_,_)),
	assertz(textposition(SID,POS,FTEKST)),
	store(SID,parserr,err1).

  store_position_symb(SID,POS,FTEKST) :- 
        txt(FTEKST,ERR),
        store_position(SID,POS,ERR).

  fail_if_parse_error(SID) :- not(environment(SID,parserr,err1)).

  chtyp(CH,digit(CH))	:- CH >= '0' , CH <= '9' ,!.
  chtyp(CH,letter(CH))	:- str_char(SCH,CH) , isname(SCH),!.
  chtyp('\10',space(' '))	:- !. % newline
  chtyp('\13',space(' '))	:- !. % soft newline, carriage return
  chtyp('\9',space(' '))	:- !.
  chtyp('\26',space(' '))	:- !. % eof mark
  chtyp(' ',space(' '))	:- !. 
  %chtyp(CH,letter(CH))    :- b_true = IsCharAlpha(CH),!.
  chtyp(CH,other(CH)).

/*************** SKIP SPACES AND COMMENTS **************************/

  skipspace(STR,STR2,NO) :- % Skip space characters 
	cnt_skips(STR,0,NO),
	frontstr(NO,STR,_,STR2).

  cnt_skips(S,NO,RES):-
	frontchar(S,CH,S1),
	chtyp(CH,CHTYP),
	CHTYP  = space(_),!, 
	NO1    = NO + 1,
	cnt_skips(S1,NO1,RES).
  cnt_skips(_,NO,NO).

  chck_comment(SID,STR,POS):-
	searchstring(STR,"/*",_),!,
        store_position_symb(SID,POS,pars_comm).  % Nested comments not allowed
  chck_comment(_,_,_).


  begin_comment(STR,STR1,NO,NO2):-  
	frontstr(2,STR,CO,STR1),CO = "/*",
	NO2 = NO + 2,!.
  
  end_comment(SID,STR,STR1,NO,NO1,STARTPOS):-
	searchstring(STR,"*/",POS),!,
	POS1 = POS + 1,
	frontstr(POS1,STR,COM_STR,STR1),
	chck_comment(SID,COM_STR,STARTPOS),
	NO1 = NO + POS1,!.  
  end_comment(SID,_,_,_,_,STARTPOS):-  
	store_position_symb(SID,STARTPOS,pars_comm_end),fail.
  
  skip_comment(SID,STR,STR2,INPOS,OUTPOS,CUR_POS):-
	begin_comment(STR,STR1,INPOS,INPOS2),
	end_comment(SID,STR1,STR2,INPOS2,OUTPOS,CUR_POS),!.  
  skip_comment(_,STR,STR,POS,POS,_).

/* SKIP BLANKS AND COMMENTS */

  skip_space_and_comments(SID,STR1,RES_STR,INPOS,POS_NO,OUTPOS):-
	skipspace(STR1,STR2,POS1),
	NEW_CURPOS = INPOS + POS_NO + POS1,
	skip_comment(SID,STR2,STR3,POS1,POS,NEW_CURPOS),
	POS_NO1 = POS + POS_NO,
  	retractall(start_str(SID,_)),
  	retractall(start_pos(SID,_)),
	assert(start_str(SID,STR3)),
	assert(start_pos(SID,POS_NO1)),
	not(POS1 = POS),!,
	skip_space_and_comments(SID,STR3,RES_STR,INPOS,POS_NO1,OUTPOS).
 skip_space_and_comments(SID,_,STR,_,_,POS):-
        retract(start_str(SID,STR)),
        retract(start_pos(SID,POS)),!.

/*******************************************************************/
/* Fronttok :- skip spaces and comments and read a token           */
/* String in, Rest string out, Token out, TokLength out, Beginning */
/* position of token out, Current position of parsing in           */
/*******************************************************************/

  fronttok(_,"","","",0,0,_) :-!.
  fronttok(SID,STR1,STR3,TOK,LEN,POS,INPOS) :-  
	fail_if_parse_error(SID),
	skip_space_and_comments(SID,STR1,STR2,INPOS,0,POS),
	get_token(STR2,STR3,TOK,LEN).
/*
get_token(STR,STR1,TOK,LEN):-
        myANSItoOEM(STR,OEM_STR),
	trap(fronttoken(OEM_STR,OEM_TOK,OEM_STR1),_,fail),!,    
	myOEMtoANSI(OEM_TOK,TOK),
        myOEMtoANSI(OEM_STR1,STR1),	  
	str_len(TOK,LEN).
*/
  get_token(STR,STR1,TOK,LEN):-
	trap(fronttoken(STR,TOK,STR1),_,fail),!,    
	str_len(TOK,LEN).
  get_token(STR,STR,"",0).

/******************  Make token list *********************************/

  tokl(SID,STR,[t(TOKEN,TOKPOS)|TOKL],POSI) :-
	fail_if_parse_error(SID),
	fronttok(SID,STR,STR1,TOK,L,P,POSI),
	TOKPOS=POSI+P,
	make_tok(SID,TOK,TOKEN,STR1,STR2,L2,TOKPOS),!,
	POSI2=TOKPOS + L + L2,
	tokl(SID,STR2,TOKL,POSI2).
  tokl(_,_,[t(eof,POSI)],POSI).

  make_tok(_,".",dotdot,STR1,STR2,1,_):-frontchar(STR1,'.',STR2),!.
  make_tok(SID,"<",le    ,STR1,STR2,1,P):-fronttok(SID,STR1,STR2,TOK,_,_,P),TOK= "=",!.
  make_tok(SID,"<",ne    ,STR1,STR2,1,P):-fronttok(SID,STR1,STR2,TOK,_,_,P),TOK= ">",!.
  make_tok(SID,">",ge    ,STR1,STR2,1,P):-fronttok(SID,STR1,STR2,TOK,_,_,P),TOK= "=",!.
  make_tok(SID,">",ne    ,STR1,STR2,1,P):-fronttok(SID,STR1,STR2,TOK,_,_,P),TOK= "<",!.
  make_tok(_,S,T,STR,STR,0,_)         :- tok_keyw_str(T,S1),
				     upper_lower(S,S1),!.
  make_tok(_,ID,id(ID),STR,STR,0,_)   :-  isname(ID),!.	
  make_tok(_,NUMB,int(INTEGER),STR,STR,0,_) :- 
	trap(term_str(integer,INTEGER,NUMB),_,fail),!.
  make_tok(_,NUMB,float(RVAL),STR,STR,0,_) :- str_real(NUMB,RVAL),!.	
  make_tok(SID,"\"",s(STR),STR1,STR2,L,CUR_POS):-
	get_str(SID,"\"",STR1,STR2,STR,L,CUR_POS),!.
  make_tok(SID,"'",s(STR),STR1,STR2,L,CUR_POS):-
        get_str(SID,"'",STR1,STR2,STR,L,CUR_POS),!.
  make_tok(SID,STOK,_,STR,STR,0,POSI) :- 
	fail_if_parse_error(SID),
	frontstr(1,STOK,S1,_),
	txt(pars_illchar,TXT),
	format(S3,"%s%s",TXT,S1),
	store_position(SID,POSI,S3),
	fail.

/**************************** GET END OF STR **************************/
/*  Search_end_str, instr,outstr,str,length_str,current_pos           */
  get_str(_,Search,STR1,STR2,STR,L,_):-
	searchstring(STR1,Search,POS),!,    % Look for end of string
	POS1 = POS - 1, 
	frontstr(POS1,STR1,STR,STR_TMP),    % Get the string
	frontchar(STR_TMP,_,STR2),          % Skip the end of string char
	str_len(STR,L1),                    % and get rest of string
	L = L1 + 1.                         % Remember the end character
%	cnt_skips(STR_A,0,NO),
%	chck_str(NO,L1,STR_A,STR).          % Special form for strip               
  get_str(SID,Search,S,S,"",0,CUR_POS):-
        txt(pars_strerr,PS), 
	format(STR,PS,Search),
	store_position(SID,CUR_POS,STR).
  
  chck_str(L,L,_,""):- !.   % String empty
  chck_str(_,_,STR,STR).  
  
/***********************************************************************/
PREDICATES
  fail_store_err_msg(SID,CHARPOS,STRING)
CLAUSES
  fail_store_err_msg(SID,POS,MSG):-
	fail_if_parse_error(SID),
	txt(pars_illexpect,FTXT),
	txt(MSG,MSG1),
	format(S3,"%s%s",MSG1,FTXT),   
    	store_position(SID,POS,S3),
    	fail.

  opt_expect(SID,TOK,[t(TOK,_)|L],L) :- fail_if_parse_error(SID).

  expect_err(SID,TOK,[t(TOK,_)|L],L,_):- !,fail_if_parse_error(SID).
  expect_err(SID,_,[t(_,POS)|L],L,ERR_MSG):- fail_store_err_msg(SID,POS,ERR_MSG),fail.
/***********************************************************************/        
  tok_oneoff_err(SID,TOKL,[t(TOK,_)|_],_) :- 
	fail_if_parse_error(SID),
	tok_member(TOK,TOKL),!.
  tok_oneoff_err(SID,_,[t(_,POS)|_],ERR_MSG) :- fail_store_err_msg(SID,POS,ERR_MSG),fail.

  tok_member(TOK1,[TOK2|_]):- tok_alright(TOK1,TOK2),!.
  tok_member(TOK,[_|TL])   :- tok_member(TOK,TL).

  tok_alright( id(_),   id(_)   ):- !.
  tok_alright( s(_) ,   s(_)    ):- !.
  tok_alright( float(_),float(_)):- !.
  tok_alright( int(_),  int(_)  ):- !.
  tok_alright( T,T              ).
/******************* Section parsing ***********************************/
PREDICATES
  is_bool_exp(SID,CHARPOS,EXP)
  is_bool_exp(SID,EXP)
  getpos(EXP,CHARPOS)
  expect_bool_exp(SID,TOKL,TOKL,EXP)
CLAUSES
  expect_bool_exp(SID,IL,IL1,BOOL):-
        s_exp(SID,IL,IL1,BOOL),
        IL1=[t(_,Pos)|_],
        is_bool_exp(SID,Pos,BOOL).

CONSTANTS
  s_keyw_list   = [if_,lpar,advice,reference,reference_par,assign,call,chain,quit,exit ]
  bool_keyw_list= [true,false,unknown,not_,lpar,minus,id(""),int(0),float(0),s("")]
  if_keyw_list  = [lpar,advice,reference,reference_par,assign,call,chain,quit,exit]
  act_keyw_list = [advice,reference,reference_par,assign,call,chain,quit,exit]
  act_eof_keyw_list = [advice,reference,reference_par,assign,call,chain,quit,exit,rpar,eof]

CLAUSES
  s_section(SID,TEXT,IL,OL,section_(SID,TEXT,ID,[c_str(STR,POS)]),PARALIST):-
        expect_err(SID,section,IL,IL1,pars_s),
        expect_err(SID,id(ID),IL1,IL2,pars_sectname),skip(colon,IL2,IL3), 
        s_section_descr(STR,POS,IL3,IL4),
        tok_oneoff_err(SID,s_keyw_list,IL4,pars_a),
        s_paragraphs(SID,ID,1,IL4,OL,PARALIST).

  s_section_descr(STR,POS,[t(s(STR),POS)|L],L) :- !.
  s_section_descr("",0,L,L).

  s_paragraphs(SID,_,_,IL1,IL2,[]) :- opt_expect(SID,eof,IL1,IL2),!.
  s_paragraphs(SID,SecID,PNO,IL,OL,[PARA|REST]):-
        tok_oneoff_err(SID,s_keyw_list,IL,pars_a),
        s_paragraph(SID,SecID,PNO,IL,OL1,PARA),
	not(IL=OL1),!,
        PNO1=PNO+1,
        s_paragraphs(SID,SecID,PNO1,OL1,OL,REST).
  s_paragraphs(SID,_,_,IL,IL,[]) :- fail_if_parse_error(SID).

/* IF - ACTION, if boolean_exp action */
  s_paragraph(SID,SecID,PNO,IL,OL,paragraph_(SID,SecID,PNO,BOOL,ACTIONS)) :- 
        opt_expect(SID,if_,IL,IL1),
        tok_oneoff_err(SID,bool_keyw_list,IL1,pars_be),
        expect_bool_exp(SID,IL1,IL2,BOOL),!,
        tok_oneoff_err(SID,if_keyw_list,IL2,pars_a1),
        ss_actions(SID,IL2,OL,ACTIONS).
  s_paragraph(SID,SecID,PNO,IL,OL,paragraph_(SID,SecID,PNO,c_bool(true,0),ACTIONS)):-
        ss_actions(SID,IL,OL,ACTIONS).

  ss_actions(SID,IL2,OL,ACTIONS) :-
        fail_if_parse_error(SID),
        opt_expect(SID,lpar,IL2,IL3),!,  % LEFT PARANTHES
        s_actions(SID,IL3,OL,ACTIONS).
  ss_actions(SID,IL2,OL,[ ACTION ]) :-
        fail_if_parse_error(SID),!,
        s_action(SID,IL2,OL,ACTION).
  s_actions(SID,IL,OL,PLIST) :-            % ACTION(S) RIGHT PARANTHES
        tok_oneoff_err(SID,act_keyw_list,IL,pars_a),
        s_acts(SID,IL,OL1,PLIST),
        expect_err(SID,rpar,OL1,OL,pars_rpar).
        
  s_acts(SID,IL,OL,PARALIST):-
        tok_oneoff_err(SID,act_eof_keyw_list,IL,pars_a),
        s_action(SID,IL,OL1,ACTION),!,
        tok_oneoff_err(SID,[comma,period,rpar],OL1,pars_sep),
        skip(comma,OL1,OL2),
        s_acts(SID,OL2,OL,REST),
        mk_paral(ACTION,REST,PARALIST).
  s_acts(SID,IL,IL,[]) :- fail_if_parse_error(SID).

/********************* ACTIONS ********************************/

  s_action(SID,IL,IL2,refer(SecID,POS)):-
        opt_expect(SID,reference,IL,IL1),!,
        expect_err(SID,id(SecID),IL1,IL2,pars_sectname),
        IL1 = [t(_,POS)|_].
  s_action(SID,IL,IL2,refer_par(SecID,POS)):-
        opt_expect(SID,reference_par,IL,IL1),!,
        expect_err(SID,id(SecID),IL1,IL2,pars_cat),
        IL1 = [t(_,POS)|_].
  s_action(SID,IL,IL1,quit):- opt_expect(SID,quit,IL,IL1),!.
  s_action(SID,IL,IL1,exit):- opt_expect(SID,exit,IL,IL1),!.
  s_action(SID,IL,OL,display(TEXT)):-	
	opt_expect(SID,advice,IL,IL1),!,
	s_text(SID,IL1,OL,TEXT).
  s_action(SID,IL,OL,chain(FILE)):- 
     	opt_expect(SID,chain,IL,IL1),!,
        expect_err(SID,s(FILE),IL1,OL,pars_filename).
  s_action(SID,IL,OL,assign(ID,POS,EXP)) :- 
	opt_expect(SID,assign,IL,IL1),!,
	expect_err(SID,id(ID),IL1,IL2,pars_parname),
        IL1 = [t(_,POS)|_],
        expect_err(SID,colon,IL2,IL3,pars_colon),
        expect_err(SID,eq,IL3,IL4,pars_equal),
        s_exp(SID,IL4,OL,EXP).
  s_action(SID,IL,OL,call(FID,POS,EXPL))    :- 
      	opt_expect(SID,call,IL,IL1),!,
      	expect_err(SID,id(ID),IL1,OL2,pars_procname),
      	IL1 = [t(_,POS)|_],
      	expect_err(SID,lpar,OL2,OL3,pars_lpar),
      	s_explist(SID,OL3,OL,EXPL),
      	proc_name(SID,FID,ID,POS).	           % FID=VID.SID=ID,

  proc_name(_,SYMB,STR,_):- procedure_name(SYMB,STR1),upper_lower(STR1,STR),!.
  proc_name(_,X,X1,_) :- X = X1/*AnsiLower(X1)*/,proc_descr(X,_,_),!.
  proc_name(SID,_,X,POS):-
	txt(proc_name_error,PE), 
	format(STR,PE,X),
	store_position(SID,POS,STR),
	fail.

  mk_paral(display(T),R,[display(T)|R]):-not(T=[]),!.
  mk_paral(display([]),R,R):-!.
  mk_paral(A,R,[A|R]).

/***************** PARAMETER PARSING ******************************/
CONSTANTS
  typename_list = [fact,category,number,phrase]
  p2_list       = [explanation,rule,options,range,askable,image,eof]
  p3_list       = [rule,options,range,askable,image,eof]
  p_list        = [askable,image,eof]
  p1_list       = [image,eof]

PREDICATES
  p_end_expect(SID,VARTYPE,TOKL,TOKL)
  str_type(TOKN,VARTYPE)

CLAUSES
  p_end_expect(SID,_,[t(eof,_)|L],L):- !,fail_if_parse_error(SID). % end of parameter definition
  p_end_expect(SID,_,[t(_,POS)|_],_):- 
	fail_if_parse_error(SID),
	store_position_symb(SID,POS,pars_p_end),
	fail.               % explanation,rule,askable,image

  s_parm(SID,TXT,IL,OL15,vars_(SID,TXT,ID,STR,EXPL,ASK,TYPE,RULE,PIC)):-
        expect_err(SID,parameter,IL,IL1,pars_p),             % parameter  
        expect_err(SID,id(ID),IL1,IL2,pars_parname),         % name
        skip(colon,IL2,IL3),                             % colon  
        s_parm_descr(SID,STR,IL3,IL4),                       % description
        expect_err(SID,type,IL4,IL6,pars_t),                 % type
        tok_oneoff_err(SID,typename_list,IL6,pars_type),     % type name
        s_type(IL6,OL1,TYPE),		                 
 %       get_p_err(TYPE,P_ERR),
        tok_oneoff_err(SID,p2_list,OL1,pars_p_field),                         
        s_expl(SID,OL1,OL2,EXPL),		                 % explanation
        tok_oneoff_err(SID,p3_list,OL2,pars_p_field),
        fail_if_parse_error(SID),
        s_ruleentry(SID,TYPE,OL2,OL3,RULE),                  % rules field
        tok_oneoff_err(SID,p_list,OL3,pars_qpfield),
        s_ask(SID,OL3,OL4,ASK),		                 % question field
        tok_oneoff_err(SID,p1_list,OL4,pars_picfield),
        s_pic(SID,OL4,OL,PIC),                               % image field
        p_end_expect(SID,TYPE,OL,OL15).                      % end of definition

  s_parm_descr(SID,STR,OL1,OL2) :- opt_expect(SID,s(STR1),OL1,OL2),strip(STR1,STR),!.
  s_parm_descr(_,"",L,L).
  
CLAUSES
  str_type(fact,fact).
  str_type(category,category).
  str_type(number,number).
  str_type(phrase,phrase).

  s_type([t(T,_)|IL],IL,TYP):- str_type(T,TYP).

  s_expl(SID,IL,OL,EXPL):- opt_expect(SID,explanation,IL,IL1),!,
  	s_text(SID,IL1,OL,EXPL).
  s_expl(_,IL,IL,[]).

  s_ruleentry(SID,fact,IL,OL,fact(FACT)):- ss_factrules(SID,IL,OL,FACT),!.
  s_ruleentry(SID,fact,IL,OL,fact(FACT)):-     
        ss_optiondefs(SID,1,IL,IL1,BOOLEANS),%1st param = 1,as parsing boolean menu.
        ss_factrules(SID,IL1,OL,FACTRULES),
        FACT=[boolmenu(BOOLEANS),boolfacts(FACTRULES)],!.
  s_ruleentry(SID,category,IL,OL,category(OPTIONDEF,CATRULES)):- !,
        expect_err(SID,options,IL,_,pars_o),
        ss_optiondefs(SID,0,IL,OL1,OPTIONDEF),%1st param=0, as parsing normal menu.
        ss_catrules(SID,OL1,OL,CATRULES).
  s_ruleentry(SID,number,IL,OL,number(RANGE,NUMBRULES)):- !,
        ss_numbrules(SID,IL,OL1,NUMBRULES),
        s_range(SID,OL1,OL,RANGE).
  s_ruleentry(SID,phrase,IL,OL,phrase(PHRASE)):- 
  	ss_phraserules(SID,IL,OL,PHRASE).

/************************* RANGE in number parameter *****************/
  s_range(SID,IL,IL6,RANGE):- 
        fail_if_parse_error(SID),
        opt_expect(SID,range,IL,IL1),!,
        s_range1(SID,IL1,IL6,RANGE).
  s_range(_,IL,IL,none).

  s_range1(SID,IL1,IL4,range(T1,T2)):- 
        tok_oneoff_err(SID,[minus,int(0),float(0)],IL1,pars_number),
        fronttal(SID,T1,IL1,IL3),
        fail_if_parse_error(SID),
        tok_oneoff_err(SID,[minus,int(0),float(0)],IL3,pars_number),
        fronttal(SID,T2,IL3,IL4),!.

  fronttal(SID,int(TAL),IL1,IL2) :- opt_expect(SID,int(TAL),IL1,IL2),!.
  fronttal(SID,int(TAL1),IL1,IL3):-
        opt_expect(SID,minus,IL1,IL2),
        tok_oneoff_err(SID,[int(0),float(0)],IL2,pars_number), % After minus, number required
        opt_expect(SID,int(TAL2),IL2,IL3),TAL1 = 0-TAL2,!.
  fronttal(SID,float(TAL),IL1,IL2) :- opt_expect(SID,float(TAL),IL1,IL2),!.
  fronttal(SID,float(TAL1),IL1,IL3):-
        opt_expect(SID,minus,IL1,IL2),
        opt_expect(SID,float(TAL2),IL2,IL3),TAL1 = 0-TAL2,!.

/************************************************************************/
  ss_factrules(SID,[t(rule,_)|IL],OL2,FACT):- !,
        s_factrules(SID,IL,OL1,FACT),
        expect_err(SID,period,OL1,OL2,pars_period).
  ss_factrules(_,[t(options,_)|IL],IL,_):- !,fail.%enable boolean menu....
  ss_factrules(_,IL,IL,[]).

  ss_optiondefs(SID,KIND,[t(options,_)|IL],OL2,OPTIONDEF):-!,
	s_optiondefs(SID,KIND,IL,OL1,OPTIONDEF),
	expect_err(SID,period,OL1,OL2,pars_period).
  ss_optiondefs(_,_,IL,IL,[]).

  ss_catrules(SID,[t(rule,_)|IL],OL2,CAT):-!,
	s_catrules(SID,IL,OL1,CAT),
	expect_err(SID,period,OL1,OL2,pars_period).
  ss_catrules(_,IL,IL,[]).

  ss_numbrules(SID,[t(rule,_)|IL],OL2,NUMB) :- !,
        s_numbrules(SID,IL,OL1,NUMB),
        expect_err(SID,period,OL1,OL2,pars_period).
  ss_numbrules(_,IL,IL,[]).

  ss_phraserules(SID,[t(rule,_)|IL],OL2,PHRASE):-!,
        s_phraserules(SID,IL,OL1,PHRASE),
        expect_err(SID,period,OL1,OL2,pars_period).
  ss_phraserules(_,IL,IL,[]).

% ----------------------------------------------------------------------
% This table allow boolean options to look like normal Category options
% The map from STRINGs back to boolean values is performed in ECONS.PRO.
% ----------------------------------------------------------------------
PREDICATES
  as_string(TOKN,STRING)
  if_boolean_chk(SID,INTEGER,TOK)

CLAUSES
  as_string(id(ID),ID).
  as_string(true,S)   :-tok_keyw_str(true,S),!.
  as_string(false,S)  :-tok_keyw_str(false,S),!.
  as_string(unknown,S):-tok_keyw_str(unknown,S),!.

  if_boolean_chk(SID,0,TOK):- %if normal "category" parameter
	tok_oneoff_err(SID,[id(""),period],[TOK],pars_optfield).
  if_boolean_chk(SID,1,TOK):- %ensure only boolean values in boolean menu.
	tok_oneoff_err(SID,[true,false,unknown,period],[TOK],pars_boolfield).

% KIND = 1 if Boolean Menu is parsed
% KIND = 0 if normal Menu is parsed

  s_optiondefs(SID,KIND,[t(TOKEN,POS),t(minus,_),t(s(STR),_)|IL],OL,[option(ID,STR)|REST]):-
	%---If boolean menu it must be a boolean TOKEN
	if_boolean_chk(SID,KIND,t(TOKEN,POS)), 
	%---Deal with boolean 'options' just as strings in the OPTIONSMENU.
        as_string(TOKEN,ID), %Notice. It fails if TOKEN=period
        !,skip(comma,IL,OL1),
        s_optiondefs(SID,KIND,OL1,OL,REST).
  s_optiondefs(SID,KIND,[t(TOKEN,POS)|IL],OL,[option(ID,ID)|REST]):-
	if_boolean_chk(SID,KIND,t(TOKEN,POS)),
	%---- Deal with boolean 'options' just as strings. And notice:
	%---- It fails if TOKEN=period
        as_string(TOKEN,ID),
        !,skip(comma,IL,OL1),
        s_optiondefs(SID,KIND,OL1,OL,REST).
  s_optiondefs(SID,_,IL,IL,[]):- fail_if_parse_error(SID).

  s_factrules(SID,IL,OL,[FACTRULE|REST]):-
        s_factrule(SID,IL,OL1,FACTRULE),!,
        tok_oneoff_err(SID,[comma,period],OL1,pars_cp),
        skip(comma,OL1,OL2),
        s_factrules(SID,OL2,OL,REST).
  s_factrules(SID,IL,IL,[]) :- fail_if_parse_error(SID).

CLAUSES
  is_bool_exp(SID,POS,Exp):-
	fail_if_parse_error(SID),
	not(is_bool_exp(SID,EXP)),
	store_position_symb(SID,POS,pars_bool),!,
	fail.
  is_bool_exp(_,_,_).

  is_bool_exp(_,c_var(_,_)).
  is_bool_exp(_,c_bool(_,_)).
  is_bool_exp(SID,or_(E1,E2)):-  getpos(E1,Pos1),is_bool_exp(SID,Pos1,E1),
   		           getpos(E2,Pos2),is_bool_exp(SID,Pos2,E2).
  is_bool_exp(SID,and_(E1,E2)):- getpos(E1,Pos1),is_bool_exp(SID,Pos1,E1),
    		           getpos(E2,Pos2),is_bool_exp(SID,Pos2,E2).
  is_bool_exp(SID,not_(E1)):-    getpos(E1,Pos1),is_bool_exp(SID,Pos1,E1).
  is_bool_exp(_,rel(_,_,_)).
  is_bool_exp(_,c_func(_,_,_)).

  getpos(c_var(_,P),  P).
  getpos(c_int(_,P),  P).
  getpos(c_float(_,P),P).
  getpos(c_str(_,P), P).
  getpos(c_bool(_,P), P). 
  getpos(or_(EXP,_),  P) :- getpos(EXP,P).
  getpos(and_(EXP,_), P) :- getpos(EXP,P).
  getpos(not_(EXP),   P) :- getpos(EXP,P).
  getpos(rel(EXP,_,_),P) :- getpos(EXP,P).
  getpos(plus(EXP,_), P) :- getpos(EXP,P).
  getpos(minus(EXP,_),P) :- getpos(EXP,P).
  getpos(div(EXP,_), P)  :- getpos(EXP,P).
  getpos(monmin(EXP), P) :- getpos(EXP,P).
  getpos(c_func(_,P,_),P).

  s_factrule(SID,IL,OL,FACTRULE):-
        expect_bool_exp(SID,IL,OL1,BOOL),
        s_factrule1(SID,OL1,OL,BOOL,FACTRULE).

  s_factrule1(SID,[t(if_,_)|IL],OL,BOOL1,if_(BOOL1,BOOL2)):-!,
        expect_bool_exp(SID,IL,OL,BOOL2).
  s_factrule1(_,IL,IL,BOOLEXP,boolexp(BOOLEXP)).

  s_numbrules(SID,IL,OL,[NUMBRULE|REST]):-
        s_numbrule(SID,IL,OL1,NUMBRULE),!,
        tok_oneoff_err(SID,[comma,period],OL1,pars_cp),
        skip(comma,OL1,OL2),
        s_numbrules(SID,OL2,OL,REST).
  s_numbrules(SID,IL,IL,[]) :- fail_if_parse_error(SID).

  s_numbrule(SID,IL,OL,NUMBRULE):-
        s_exp(SID,IL,OL1,EXP),
        s_numbrule1(SID,OL1,OL,EXP,NUMBRULE).

  s_numbrule1(SID,[t(if_,_)|IL],OL,EXP,if_(EXP,BOOLEXP)):-!,
        expect_bool_exp(SID,IL,OL,BOOLEXP).
  s_numbrule1(_,IL,IL,EXP,exp(EXP)).

  s_phraserules(SID,IL,OL,[PHRASERULE|REST]):-
        s_phraserule(SID,IL,OL1,PHRASERULE),!,
        tok_oneoff_err(SID,[comma,period],OL1,pars_cp),
        skip(comma,OL1,OL2),
        s_phraserules(SID,OL2,OL,REST).
  s_phraserules(SID,IL,IL,[]) :- fail_if_parse_error(SID).

  s_phraserule(SID,IL,OL,PHRASERULE):-
        fail_if_parse_error(SID),
        s_text(SID,IL,OL1,EXPR),
        not(EXPR=[]),
        s_phraserule1(SID,OL1,OL,EXPR,PHRASERULE),!.

  s_phraserule1(SID,[t(if_,_)|IL],OL,STRING,if_(STRING,BOOL)):-!,
        expect_bool_exp(SID,IL,OL,BOOL).
  s_phraserule1(_,IL,IL,STRING,str(STRING)).

  s_catrules(SID,IL,OL,[CATRULE|REST]):-
        s_catrule(SID,IL,OL1,CATRULE),!,
        tok_oneoff_err(SID,[comma,period],OL1,pars_cp),
        skip(comma,OL1,OL2),
        s_catrules(SID,OL2,OL,REST).
  s_catrules(SID,IL,IL,[]) :- fail_if_parse_error(SID).

  s_catrule(SID,[t(id(ID),_)|IL],OL,CATRULE):-!,
        OPTION=ID,
        s_catrule1(SID,IL,OL,OPTION,CATRULE).
        
  s_catrule1(SID,[t(if_,_)|IL],OL,OPTION,if_(OPTION,BOOLEXP)):-!,
        expect_bool_exp(SID,IL,OL,BOOLEXP).
  s_catrule1(_,IL,IL,OPTION,opt(OPTION)).

  s_pic(SID,IL,OL,PIC1) :- 
        opt_expect(SID,image,IL,IL2),!,
        s_text(SID,IL2,OL,PICL),
        expl_str_stritem(PIC,PICL),
        strip(PIC,PIC1).
  s_pic(SID,IL,IL,"") :- fail_if_parse_error(SID).

  s_ask(SID,IL,OL,ASK) :- 
        opt_expect(SID,askable,IL,IL2),!,
        s_asktext(SID,IL2,OL,ASK).
  s_ask(SID,IL,IL,[]) :- fail_if_parse_error(SID).

  s_asktext(SID,IL,OL,SIL) :- 
        tok_oneoff_err(SID,[s(""),andsign,id(""),dotdot,period],IL,pars_text),
        s_asktext1(SID,IL,OL,SIL),!.

  s_text(SID,IL,OL,SIL) :- 
        tok_oneoff_err(SID,[s(""),andsign,id(""),dotdot,period,image],IL,pars_text),
        s_text1(SID,IL,OL,SIL),!.

  s_asktext1(SID,[t(dotdot,_)|IL],OL,REST):-!,
  	s_asktext1(SID,IL,OL,REST).
  s_asktext1(SID,[t(andsign,_)|IL],OL,[nl|REST]):-!,
  	s_asktext1(SID,IL,OL,REST).
  s_asktext1(SID,[t(s(S),POS)|IL],OL,[c_str(S,POS)|REST]):-!,
  	s_asktext1(SID,IL,OL,REST).
  s_asktext1(SID,I,O,[ITEM|REST]):-
  	opt_expect(SID,id(_),I,_),!,
   	s_elmexp1(SID,I,I2,ITEM,pars_text),
  /*ITEM=c_var(ID,POS) or c_func(ID,POS,EXPL) */   
  	s_asktext1(SID,I2,O,REST).
  s_asktext1(_,IL,IL,[]).

  s_text1(SID,[t(dotdot,_)|IL],OL,REST):-!,
  	s_text1(SID,IL,OL,REST).
  s_text1(SID,[t(andsign,_)|IL],OL,[nl|REST]):-!,
  	s_text1(SID,IL,OL,REST).
  s_text1(SID,[t(image,X)|IL],OL,[ITEM|REST]):-!,
  	s_elmexp1(SID,[t(image,X)|IL],I2,ITEM,pars_argpic),
	s_text1(SID,I2,OL,REST).
  s_text1(SID,[t(s(S),POS)|IL],OL,[c_str(S,POS)|REST]):-!,
  	s_text1(SID,IL,OL,REST).
  s_text1(SID,I,O,[ITEM|REST]):-
  	opt_expect(SID,id(_),I,_),!,
	s_elmexp1(SID,I,I2,ITEM,pars_text),
  /*ITEM=c_var(ID,POS) or c_func(ID,POS,EXPL) */   
  	s_text1(SID,I2,O,REST).
  s_text1(_,IL,IL,[]).

%s_text1([t(id(ID),POS)|IL],OL,[c_var(ID,POS)|REST]):- !,s_text1(IL,OL,REST).

  skip(TOK,[t(TOK,_)|L],L):-!.
  skip(_,L,L).

  s_exp(SID,IL,OL,EXP)  :-  s_or(SID,IL,OL,EXP).
  s_or(SID,IL,OL,EXP2)  :-  s_and(SID,IL,OL1,EXP1),
                        s_or1(SID,OL1,OL,EXP1,EXP2).

  s_or1(SID,IL,OL,EXP1,EXP3) :- 
	opt_expect(SID,or_,IL,IL1),!,
	s_and(SID,IL1,OL1,EXP2),
	s_or1(SID,OL1,OL,or_(EXP1,EXP2),EXP3).
  s_or1(_,IL,IL,EXP,EXP).

  s_and(SID,IL,OL,EXP2) :-
	s_rel_exp(SID,IL,OL1,EXP1),
	s_and1(SID,OL1,OL,EXP1,EXP2).
                                    
  s_and1(SID,IL,OL,EXP1,EXP3) :- 
	opt_expect(SID,and_,IL,IL1),!,
	s_rel_exp(SID,IL1,OL1,EXP2),
	s_and1(SID,OL1,OL,and_(EXP1,EXP2),EXP3).
  s_and1(_,IL,IL,EXP,EXP).

  s_rel_exp(SID,IL,OL,EXP2) :-
	s_plus(SID,IL,OL1,EXP1),
	s_rel_exp1(SID,OL1,OL,EXP1,EXP2).
                                    
  s_rel_exp1(SID,IL,OL,EXP1,EXP3) :- 
	opt_expect(SID,RELOP,IL,IL1),
	get_relkind(RELOP),!,
	s_plus(SID,IL1,OL1,EXP2),
	s_rel_exp1(SID,OL1,OL,rel(EXP1,RELOP,EXP2),EXP3).
  s_rel_exp1(_,IL,IL,EXP,EXP).

  get_relkind(lt).
  get_relkind(gt).
  get_relkind(eq).
  get_relkind(ne).
  get_relkind(ge).
  get_relkind(le).

CONSTANTS
  keyw_exp = [true,false,unknown,not_,lpar,minus,id(""),int(0),float(0),s("")]

CLAUSES
  testnext(SID,IL):- tok_oneoff_err(SID,keyw_exp,IL,pars_exp).

  s_plus(SID,IL,OL,EXP2) :-  
	s_mult(SID,IL,OL1,EXP1),
        s_plus1(SID,OL1,OL,EXP1,EXP2).
                                    
  s_plus1(SID,IL,OL,EXP1,EXP3) :- 
	opt_expect(SID,plus,IL,IL1),!,   
   	testnext(SID,IL1),
	s_mult(SID,IL1,OL1,EXP2),
   	s_plus1(SID,OL1,OL,plus(EXP1,EXP2),EXP3).
  s_plus1(SID,IL,OL,EXP1,EXP3) :- 
	opt_expect(SID,minus,IL,IL1),!,
  	testnext(SID,IL1),
  	s_mult(SID,IL1,OL1,EXP2),
	s_plus1(SID,OL1,OL,minus(EXP1,EXP2),EXP3).
  s_plus1(_,IL,IL,EXP,EXP).

  s_mult(SID,IL,OL,EXP2) :- 
  	s_elmexp(SID,IL,OL1,EXP1), % Skal fejle uden fejmeddelelelse
  	s_mult1(SID,OL1,OL,EXP1,EXP2).
 
  s_mult1(SID,IL,OL,EXP1,EXP3) :- 
     	opt_expect(SID,mult,IL,IL1),!,
     	testnext(SID,IL1),
     	s_elmexp(SID,IL1,OL1,EXP2),
     	s_mult1(SID,OL1,OL,mult(EXP1,EXP2),EXP3).
  s_mult1(SID,IL,OL,EXP1,EXP3) :- 
     	opt_expect(SID,div,IL,IL1),!,
     	testnext(SID,IL1),
     	s_elmexp(SID,IL1,OL1,EXP2),
     	s_mult1(SID,OL1,OL,div(EXP1,EXP2),EXP3).
  s_mult1(_,IL,IL,EXP,EXP).

  s_elmexp(SID,IL,OL,EXP) :-
      	tok_oneoff_err(SID,[image,comma,period,lpar,minus,id(""),int(0),true,false,unknown,reference_par,
   	float(0),s(""),not_,exit,quit,advice,assign,call,reference,if_],IL,pars_a2),
      	fail_if_parse_error(SID),
      	s_elmexp1(SID,IL,OL,EXP,"No_err").

  s_elmexp1(SID,IL,OL,not_(EXP),_) :-
      	opt_expect(SID,not_,IL,IL1),!,
      	s_elmexp1(SID,IL1,OL,EXP,pars_argnot).
  s_elmexp1(SID,IL,OL,c_pic(EXP),_) :-
        opt_expect(SID,image,IL,IL1),!,
        s_elmexp1(SID,IL1,OL,EXP,pars_argpic).
  s_elmexp1(SID,IL,OL,monmin(EXP),_) :-
        opt_expect(SID,minus,IL,IL1),!,
        s_elmexp1(SID,IL1,OL,EXP,pars_argminus).
  s_elmexp1(SID,IL,OL,EXP,_):- 
      	opt_expect(SID,lpar,IL,IL1),!,        
      	s_exp(SID,IL1,OL1,EXP),
      	expect_err(SID,rpar,OL1,OL,pars_rpar).
  s_elmexp1(_,[t(int(INTG),POSI)|IL],IL,c_int(INTG,POSI),_)     :- !.
  s_elmexp1(_,[t(float(REEL),POSI)|IL],IL,c_float(REEL,POSI),_) :- !.
  s_elmexp1(_,[t(s(S),POSI)|IL],IL,c_str(S,POSI),_)             :- !.
  s_elmexp1(_,[t(true,POSI)|IL],IL,c_bool(true,POSI),_)         :- !.
  s_elmexp1(_,[t(false,POSI)|IL],IL,c_bool(false,POSI),_)       :- !.
  s_elmexp1(_,[t(unknown,POSI)|IL],IL,c_bool(unknown,POSI),_)   :- !.
  s_elmexp1(SID,IL,IL3,c_func(FID,POS,EXPL),_):- 
        opt_expect(SID,id(ID),IL,IL1),
        IL = [t(_,POS)|_],
        opt_expect(SID,lpar,IL1,IL2),
        s_explist(SID,IL2,IL3,EXPL),        % SID=ID, f›r ! her.
        func_name(SID,FID,ID,POS),!.	% FID=VID.
  s_elmexp1(_,[t(id(ID),POSI)|IL],IL,c_var(ID,POSI),_):-!.%ID=STRING.
  s_elmexp1(_,_,_,_,"No_err"):- !,fail.  % Is part of recursion, no error.
  s_elmexp1(SID,[t(_,POS)|_],_,_,ERR):- fail_store_err_msg(SID,POS,ERR),fail.

  func_name(_,SYMB,STR,_)   :- function_name(SYMB,STR1),upper_lower(STR1,STR),!.
  func_name(_,FNAME,FNAME1,_):- FNAME = FNAME1/*AnsiLower(FNAME1)*/,func_descr(FNAME,_,_,_),!.
  func_name(SID,_,FNAME,POS):- 
	txt(func_name_error,FE), 
	format(STR,FE,FNAME),
	store_position(SID,POS,STR),
	fail.

  s_explist(SID,IL,OL,[]) :- opt_expect(SID,rpar,IL,OL),!.
  s_explist(SID,IL,OL2,[E|EL]) :- 
	fail_if_parse_error(SID),
	s_exp(SID,IL,IL1,E),
	s_explist1(SID,IL1,OL2,EL).

  s_explist1(SID,IL,OL,[])  :- opt_expect(SID,rpar,IL,OL),!.
  s_explist1(SID,IL,OL,[E|EL]) :- 
	fail_if_parse_error(SID),
	expect_err(SID,comma,IL,IL1,pars_comma),
	s_exp(SID,IL1,IL2,E),
	s_explist1(SID,IL2,OL,EL).
  
PREDICATES
  del_prev_parm(SID,string)
  del_prev_sect(SID,string)
  del_prev_par(SID,string)

  parseparm(SID,STRING,STRING)	
  parsesect(SID,STRING,STRING)	

CLAUSES
  del_prev_parm(SID,VID):-
	vars_(SID,_,VID1,_,_,_,_,_,_),
	upper_lower(VID,VID1),
	retractall(vars_(SID,_,VID1,_,_,_,_,_,_)),!.
  del_prev_parm(_,_).	

  del_prev_sect(SID,SecID):-
	section_(SID,_,SecID1,_),
	upper_lower(SecID,SecID1),
	retractall(section_(SID,_,SecID1,_)),!.
  del_prev_sect(_,_).		

  del_prev_par(SID,SecID):-
	paragraph_(SID,SecID1,_,_,_),
	upper_lower(SecID,SecID1),
	retractall(paragraph_(SID,SecID1,_,_,_)),!.
  del_prev_par(_,_).		

  parseparm(SID,STR,VID):-
        tokl(SID,STR,TOKL,0),
	s_parm(SID,STR,TOKL,REST,PARM),REST=[],
	PARM=vars_(SID,_,VID,_,_,_,_,_,_),
	del_prev_parm(SID,VID),
	asserta(PARM),!.
  parseparm(_,_,"").

  parsesect(SID,STR,SecID):-
        tokl(SID,STR,TOKL,0),
        s_section(SID,STR,TOKL,REST,SECDEF,PARAGRAPHS),REST=[],
        SECDEF=section_(SID,_,SecID,_),
        del_prev_sect(SID,SecID), 
        del_prev_par(SID,SecID),
        asserta(SECDEF),                      % assert new
        ass_paragraphs(PARAGRAPHS),!.
  parsesect(_,_,"").

  ass_paragraphs([])   :- !.
  ass_paragraphs([H|T]):- assert(H), ass_paragraphs(T).
       
       
PREDICATES
  succes_or_not(SID,SYMBOL,SYMBOL)
  pp(SID,STRING,STRING,STRING)       
  parseloop2(SID,STRING,SYMBOL,STRING,STRING)

CLAUSES
  succes_or_not(_,err1,notsucces):- !.
  succes_or_not(SID,_,succes)      :- store(SID,checkstatus,"notok").  

  pp(SID,parameter,STR,PID) :- !,parseparm(SID,STR,PID).

  pp(SID,section,STR,SecID)   :- parsesect(SID,STR,SecID).
  				

  parseloop(SID,"title",STR,"") :- !,
        retractall(title_(SID,_)),
        assert(title_(SID,STR)),
        show_title(SID,STR,0).
  parseloop(SID,PARSERTYPE,STR,ID) :- !,
        store(SID,parserr,nill),
        pp(SID,PARSERTYPE,STR,ID),
        retrieve(SID,parserr,SYMB),
        succes_or_not(SID,SYMB,SUCCES),
        parseloop2(SID,PARSERTYPE,SUCCES,STR,ID).
            
  parseloop2(SID,P,succes,STR,""):- !, 
  	store_position_symb(SID,0,pars_error),
        parseloop2(SID,P,notsucces,STR,"").
  parseloop2(_,_,succes,_,_):-!.                             
       
  parseloop2(SID,PARSER,notsucces,STR,ID) :- 
        retrieve(SID,parserr,SYMB),
        SYMB=err1,
        textposition(SID,POS,FTEKST),!,
        store(SID,parserr,nill),
        format (ErrMsg,"ESTA PARSER ERROR:%s %s %d %s %s",PARSER,STR,POS,FTEKST,ID), 
        error_msg (SID,ErrMsg),
        fail.
               