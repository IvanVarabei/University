/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3EINTF.PRO
 Purpose: WWW version of ESTA
 Written by:
 Comments:
******************************************************************************/

include "w3esta.inc"

CONSTANTS
  sw_hide =             0
  sw_shownormal =       1
  sw_normal =           1
  sw_showminimized =    2
  sw_showmaximized =    3
  sw_maximize =         3
  sw_shownoactivate =   4
  sw_show =             5
  sw_minimize =         6
  sw_showminnoactive =  7
  sw_showna =           8
  sw_restore =          9	
PREDICATES
 rmin(REAL,REAL,REAL)
 rmax(REAL,REAL,REAL)
 new_odds(REAL,REAL,REAL)
 power(REAL,REAL,REAL)
 numeric(REAL,REAL)
 number_real(EVALUE,REAL)
 number_int(EVALUE,INTEGER)
 func(ID,REAL,REAL)
  
 
CLAUSES
 number_real(int(X),Z)   :- trap(term_str(integer,X,S),_,fail),str_real(S,Z),!.
 number_real(float(X),X) :- !.
 
 number_int(int(X),X)    :- !.  
 number_int(float(X),Z)  :- str_real(S,X),trap(term_str(integer,Z,S),_,fail),!.

 
 rmin(R1,R2,R2):- R1>R2,!.
 rmin(R1,_,R1).
 
 rmax(R1,R2,R2):- R1<R2,!.
 rmax(R1,_,R1).
 

 power(X,Y,Z) :- 
    X > 0,!,
    Z=exp(Y*ln(X)).

 new_odds(E,CI,RESULT) :- 
    E >= 0.0 , CI >= 0.0 ,!, 
    RESULT =  CI + E*(1-CI). 
    
 new_odds(E,CI,RESULT) :- 
    E < 0.0 , CI < 0.0 ,!,
    numeric(E,NCR),numeric(CI,NCI),
    RESULT =  0.0 -  (NCI + NCR*(1-NCI)).          
    
 new_odds(E,CI,RESULT) :- 
    E * CI < 0.0 , 
    numeric(E,NCR),numeric(CI,NCI), 
    rmin(NCR,NCI,MIN),
    MIN_1 = 1-MIN,
    MIN_1 <> 0.0,
    RESULT = ( E + CI )/(MIN_1) .          

 numeric(R,R)  :- R>=0,!.
 numeric(R1,R2):- R2=0.0-R1. 


 func(sin,X,Y)    :- Y=sin(X),!.
 func(cos,X,Y)    :- Y=cos(X),!.
 func(tan,X,Y)    :- Y=tan(X),!.
 func(arctan,X,Y) :- Y=arctan(X),!.
 func(exp,X,Y)    :- Y=exp(X),!.
 func(ln,X,Y)     :- trap(Y = ln(X),_,fail),!.   % X > 0 
 func(log,X,Y)    :- trap(Y = log(X),_,fail),!.  % X > 0
 func(sqrt,X,Y)   :- trap(Y = sqrt(X),_,fail),!. % X >= 0
 func(not_cf,X,Y) :- Y=0-X,!.
 func(abs,X,Y) 	  :- Y=abs(X),!.

%--------------------------------------------------------------------------
% Support predicate for error messages in Proc and Func calls
%--------------------------------------------------------------------------
PREDICATES
 get_call_str(STRING,EVALUELIST,STRING)


CLAUSES 
 func_descr(sin,1,[number],number).
 func_descr(cos,1,[number],number).
 func_descr(tan,1,[number],number).
 func_descr(arctan,1,[number],number).
 func_descr(exp,1,[number],number).
 func_descr(ln,1,[number],number).
 func_descr(log,1,[number],number).
 func_descr(power,2,[number,number],number).
 func_descr(sqrt,1,[number],number).
 func_descr(sqr,1,[number],number).
 func_descr(int,1,[number],number).
 func_descr(abs,1,[number],number).
 func_descr(div,2,[number,number],number).
 func_descr(mod,2,[number,number],number).
 
 func_descr(trunc,1,[number],number).
 func_descr(round,1,[number],number).
 func_descr(frac,1,[number],number).
 
 func_descr(dec,1,[number],number).
 func_descr(inc,1,[number],number).
 
 func_descr(date,0,[],phrase).
 func_descr(time,0,[],phrase).
 
 func_descr(random,0,[],number).
 func_descr(randomint,1,[number],number).

 func_descr(ival,1,[phrase],number).
 func_descr(rval,1,[phrase],number). 

 func_descr(chr,1,[number],phrase). 
 func_descr(str,1,[number],phrase).
 func_descr(upcase,1,[phrase],phrase).
 func_descr(lowcase,1,[phrase],phrase).
 func_descr(concat,2,[phrase,phrase],phrase).
 func_descr(startstr,2,[number,phrase],phrase).
 func_descr(endstr,2,[number,phrase],phrase).
 func_descr(ending,2,[number,phrase],phrase).
 func_descr(strlen,1,[phrase],number).
 func_descr(copy,3,[phrase,number,number],phrase).
 func_descr(delete,3,[phrase,number,number],phrase).
 func_descr(pos,2,[phrase,phrase],number).
 
 func_descr(min,2,[number,number],number).
 func_descr(max,2,[number,number],number).
 
 func_descr(not_cf,1,[number],number).
 func_descr(calc_cf,2,[number,number],number).
 
 func_descr(known,1,[phrase],fact).

 func_descr(check_sum,3,[number,number,number],number).
 func_descr(dde_request_number,2,[number,phrase],number).
 func_descr(dde_request,2,[number,phrase],phrase).
 func_descr(dde_initiate,2,[phrase,phrase],number).


 proc_descr(clear_all,0,[]). 
 proc_descr(clear_value,1,[phrase]). 
 proc_descr(display,1,[phrase]). 
 proc_descr(system,1,[phrase]). 
 proc_descr(sound,2,[number,number]). 
 proc_descr(showpic,1,[phrase]).
 proc_descr(hyperadvice,2,[phrase,number]).
 proc_descr(save_values,1,[phrase]). 
 proc_descr(restore_values,1,[phrase]). 
 proc_descr(show_mdi_window,1,[phrase]). 
% proc_descr(use_example_dlg,1,[phrase]). 

 proc_descr(dde_install,0,[]):-!.
 proc_descr(dde_uninstall,0,[]):-!.
 
 proc_descr(dde_execute,2,[number,phrase]):-!.
 proc_descr(dde_poke_number,3,[number,phrase,number]):-!.
 proc_descr(dde_poke,3,[number,phrase,phrase]):-!.
 proc_descr(dde_terminate,1,[number]):-!.
 proc_descr(dde_terminate_all,0,[]):-!.

 proc_descr(my_msg,2,[phrase,phrase]):-!.

 
 /************** PROCEDURES NOT SUPPORTED BY THE WINDOWS VERSION ******/
  
 proc_descr(clear_dialog,0,[]). 
 proc_descr(clear_dialogue,0,[]). 
 proc_descr(set_colordef,2,[phrase,number]). 
 proc_descr(opengraph,0,[]). 
 proc_descr(pause,0,[]). 
 proc_descr(bgi_pic,1,[phrase]). 
 proc_descr(bgi_pic_x,1,[phrase]). 
 proc_descr(closegraph,0,[]). 


/*************** Auxiliary predicates for string functions ************/

PREDICATES
 strad(string,string)
 stripNL(STRING,STRING)
 chck_length(integer,string)
 frontstr_error(SID,integer,string)
 conv_x(REAL,REAL)
 skip_trailing_blancs(string, string) 
 get_datevalue(string,string,string,string,string)   

 
CLAUSES
  conv_x(X,X1) :- X < 0,!, X1 = X * (-1.0).
  conv_x(X,X).
 
  chck_length(I1,S2):-
    str_len(S2,L),
    Lr = L-I1, Lr >= 0.
 
  frontstr_error(SID,I1,S2):-
	txt(endstr_err,ES),
    	format(STR,ES,I1,S2),
    	error_msg(SID,STR).

 stripNL(IN,OUT):-
   searchchar(IN,'\r',P),!,
   PP=P-1,
   frontstr(PP,IN,OUT,_).
 stripNL(IN,IN):-!.

 strad(X,X):- str_len(X,2),!.
 strad(X,Y):- concat("0",X,Y).

 skip_trailing_blancs(S1, S3) :- 
    concat(S2, " ", S1),!,
    skip_trailing_blancs(S2, S3).
 skip_trailing_blancs(S, S).

 get_datevalue(_,MS,_,M,MS)   :- upper_lower("M",M),!.
 get_datevalue(_,MS,_,M,T11)  :- upper_lower("MM",M),strad(MS,T11),!.
 get_datevalue(_,_,DS,D,DS)   :- upper_lower("D",D),!.
 get_datevalue(_,_,DS,D,T11)  :- upper_lower("DD",D),!,strad(DS,T11).
 get_datevalue(YS,_,_,Y,T11)  :- upper_lower("YY",Y),frontstr(2,YS,_,T11),!.
 get_datevalue(YS,_,_,Y,YS)   :- upper_lower("YYYY",Y),!.
 
 /************** Evaluation of functions ******************************/
 
  eval_func(_,check_sum,[A,B,C],float(Result)):- 
   	number_real(A,A1),number_real(B,B1),number_real(C,C1),
   	Num = A1 + B1 * 2 + C1 * 3,
   	Num_int = cast(unsigned,Num),
   	Result =  Num_int mod 11,!.
 % FUNC(sin,cos,tan....
  eval_func(_,FUNCTNAME,[P],float(Y)) :- 
    	number_real(P,X),func(FUNCTNAME,X,Y),!.
 % POWER
  eval_func(_,power,[P1,P2],float(Z))     :- 
    	number_real(P1,X),number_real(P2,Y),power(X,Y,Z),!.
 % SQR
  eval_func(_,sqr,[P1],float(0.0)) :- 	
	number_real(P1,X), X = 0.0,!.
  eval_func(_,sqr,[P1],float(Z)) :- 
	number_real(P1,X),
	conv_x(X,X1),
	power(X1,2.0,Z),!.
 % CALC_CF
  eval_func(_,calc_cf,[P1,P2],float(Z))     :- 
    	number_real(P1,X),number_real(P2,Y),
    	new_odds(X,Y,Z),!.
/* Text functions */
  eval_func(_,upcase,[str(S)],str(SU)) :- upper_lower(SU,S),!.
  eval_func(_,lowcase,[str(S)],str(SL)):- upper_lower(S,SL),!.
  eval_func(_,chr,[N],str(CHAR)):-
	number_int(N,NVAL),
	trap(char_int(CH,NVAL),_,fail),
	trap(str_char(CHAR,CH),_,fail),!.
  eval_func(SID,str,[N],str(STRNUM)) :- str_numb(SID,STRNUM,N),!.
 % CONCAT
  eval_func(_,concat,[str(S1),str(S2)],str(S3))  :- 
 	trap(concat(S1,S2,S3),_,fail),!.
 % STARTSTR
  eval_func(_,startstr,[int(I1),str(S2)],str(S3)):- 
    	chck_length(I1,S2),!,
    	frontstr(I1,S2,S3,_).
  eval_func(SID,startstr,[int(I1),str(S2)],str("")):-     
    	frontstr_error(SID,I1,S2),!.
 % ENDSTR
  eval_func(_,endstr,[int(I1),str(S2)],str(S4))  :- 
    	chck_length(I1,S2),!,
    	frontstr(I1,S2,_,S4).
  eval_func(SID,endstr,[int(I1),str(S2)],str(""))  :-  % Error
    	frontstr_error(SID,I1,S2),!.
 % ENDING
  eval_func(SID,ending,[int(I1),str(S2)],S4)  :-  % The same as endstr
    	eval_func(SID,endstr,[int(I1),str(S2)],S4),!.
 % STRLEN						 
  eval_func(_,strlen,[str(S)],int(N)) :- trap(str_len(S,N),_,fail),!.						 
  eval_func(_,copy,[str(S),N,M],str(OUTSTR)):-
        number_int(N,NI),
        number_int(M,MI),
	trap(substring(S,NI,MI,OUTSTR),_,fail),!.
  eval_func(_,delete,[str(S),N,M],str(OUTSTR)):-
        number_int(N,NI),
        number_int(M,MI),
	trap(substring(S,NI,MI,_),_,fail), % check it is possible to delete
	Pos = NI - 1,
        frontstr(Pos,S,Start,STmp),      % Get first part of string
        frontstr(MI,STmp,_,End),         % Skip the delete part and get rest
        concat(Start,End,OUTSTR),!.      % Concat first and rest to result
  eval_func(_,pos,[str(S),str(S1)],int(POS)):-
        trap(searchstring(S1,S,POS),_,fail),!.
  eval_func(_,pos,_,int(0)):-!.             % If not found return 0
 /* Number functions */
  eval_func(_,int,[N],int(X)):-
        number_real(N,N1),
	Value = trunc(N1),       
	X = val(integer,Value),!.
 % MIN
  eval_func(_,min,[int(N1),int(N2)],int(N1) )       :- N1 < N2,!.
  eval_func(_,min,[int(N1),int(N2)],int(N2) )       :- N1 >= N2,!.
  eval_func(_,min,[P1,P2],float(N3) )   :- 
    	!,number_real(P1,R1),number_real(P2,R2),rmin(R1,R2,N3).
 % MAX
  eval_func(_,max,[int(N1),int(N2)],int(N2) )       :- N1 < N2,!.
  eval_func(_,max,[int(N1),int(N2)],int(N1) )       :- N1 >= N2,!.
  eval_func(_,max,[P1,P2],float(N3) )   :- 
    	!,number_real(P1,R1),number_real(P2,R2),rmax(R1,R2,N3).
  eval_func(_,random,[],float(X)):- 
	time(_,_,S,_),
	randominit(S),
	random(X),!.
  eval_func(_,randomint,[N],int(I)):-
	time(_,_,S,_),
	randominit(S),
	number_int(N,IVAL),
	random(IVAL,I),!.    
 % KNOWN
  eval_func(SID,known,[str(STRING)],true) :- 
    	evalue_(SID,ID,_,_),
    	upper_lower(ID,STRING),!.
  eval_func(_,known,[str(_)],false) :- !.
  eval_func(_,date,[],str(STR)):-
        date(Y,M,D),
        str_int(YS,Y),
	str_int(MS,M),
	str_int(DS,D),
	format(STR,"%/%/%",DS,MS,YS),!.
  eval_func(_,time,[],str(T)):-
	time(H,M,S,_),
	str_int(HS,H),
	str_int(MS,M),
	str_int(SS,S),
	strad(HS,H2),
	strad(MS,M2),
	strad(SS,S2),
	format(T,"%.%.%",H2,M2,S2),!.
  eval_func(_,ival,[str(S)],int(I)):-
	trap(term_str(integer,I,S),_,fail),!.
  eval_func(_,ival,_,int(0)):- !.          % default value = 0
  eval_func(_,rval,[str(S)],float(R)):-
        trap(str_real(S,R),_,fail),!.
  eval_func(_,rval,_,float(0)):-!.         % default value = 0
  eval_func(_,round,[N],int(X)):-
	number_real(N,N1),
	Value = round(N1),
	X = val(integer,Value),!.
  eval_func(_,trunc,[N],int(X)):-
	number_real(N,N1),
	N1 >= 0,
	Value = trunc(N1),       % positive numbers
	X = val(integer,Value),!.
  eval_func(_,trunc,[N],int(X)):-
	number_real(N,N1),
	N1 < 0,
	Value = round(N1),       % negative numbers
	X = val(integer,Value),!.
  eval_func(_,frac,[N],float(F)):-
        number_real(N,NR),
        NR >= 0,                 % positive numbers
        Trunc = trunc(NR),
        F = NR - Trunc,!.
  eval_func(_,frac,[N],float(F)):-
        number_real(N,NR),       % negative numbers
        NR < 0,
        R = round(NR),
        F = NR - R,!.
  eval_func(_,div,[N1,N2],int(X)):-
        number_int(N1,N1_I),
        number_int(N2,N2_I),
        X = N1_I div N2_I,!.
  eval_func(_,mod,[N1,N2],int(X)):-
        number_int(N1,N1_I),
        number_int(N2,N2_I),
        X = N1_I mod N2_I,!.
  eval_func(_,dec,[int(I)],int(I1))    :- I1 = I - 1,!.
  eval_func(_,dec,[float(R)],float(R1)):- R1 = R - 1,!.
  eval_func(_,inc,[int(I)],int(I1))    :- I1 = I + 1,!.
  eval_func(_,inc,[float(R)],float(R1)):- R1 = R + 1,!.
 % ERROR IN FUNCTION CALL
  eval_func(SID,FID,VL,str("")) :-
    	txt(func_error,F),
    	get_call_str(FID,VL,STR),
    	concat(F,STR,STR1),
    	error_msg(SID,STR1).

/******************* Evaluation of procedures *************************/

% Help predicates for the system procedure

PREDICATES
 winexec_succes(SID,string,WORD)

CLAUSES
 winexec_succes(_,_,Res):- Res >= 32,!.
 winexec_succes(SID,STR,Res):- 
    txt("system_error",SE),
    format(STR1,SE,STR,Res),
    error_msg(SID,STR1),fail.
 
 
/*** Old procedures not supported both by the Windows and WWW versions ***/
 eval_proc(_,clear_dialog,[])   :- !.
 eval_proc(_,clear_dialogue,[]) :- !.
 eval_proc(_,opengraph,[])      :- !.
 eval_proc(_,closegraph,[])     :- !.
 eval_proc(_,pause,[])          :- !.
 eval_proc(_,bgi_pic,[_])       :- !.
 eval_proc(_,bgi_pic_x,[_])     :- !.
 eval_proc(_,set_colordef,[_,_]):- !.

/************************************************************/
 % SYSTEM / WINEXEC
/*
 eval_proc(system,[str("")]) :- !,PrologWinExec("dosprmpt.pif",sw_normal).
 eval_proc(system,[str(STR)]):- !,PrologWinExec(STR,sw_normal).
 */
 % CLEAR VALUE 

  eval_proc(SID,clear_value,[str(STRING)]) :- 
	evalue_(SID,E,_,_),
    	upper_lower(E,STRING),
    	retractall(evalue(E,_,_)),
    	fail.
  eval_proc(_,clear_value,[str(_)]) :-  !.

 % CLEAR_ALL 
 
  eval_proc(SID,clear_all,[]) :-  retract(evalue_(SID,_,_,_)),fail.
  eval_proc(_,clear_all,[]) :-  !.
 
 % SOUND 
  eval_proc(_,sound,[P1,P2])   :-  
        number_int(P1,P11),
        number_int(P2,P22),
        sound(P11,P22),!.
 
 % DISPLAY
 eval_proc(SID,display,[str(FILE)]):-
 	app_path(APP_PATH),
 	filenamepath(FULL,APP_PATH,FILE), 
 	read_file_to_str(SID,FULL,STR),
        display_file_dlg(SID,STR,FILE),!.
 % SHOWPIC
                                          
 eval_proc(_,showpic,[str(_PIC)]):-!.   %     :-  add_pic_to_log(PIC),
                                 %         mdi_get_frame(Wnd),
                                 %         showstartpicture(Wnd,PIC),!.
 % SAVE_VALUES
 
 eval_proc(SID,save_values,[str(STR)]) :- save_values(SID,STR),!.
 
 % RESTORE_VALUES
 
 eval_proc(SID,restore_values,[str(STR)]) :- get_values(SID,STR),!.

 % HYPERADVICE
                                           
 %eval_proc(hyperadvice,[str(X),int(Y)]) :- !,
 %   vpi_ShowHelpContext (X,Y).

 % SHOW MDI WINDOW
 %eval_proc(show_mdi_window,[str(STR)]):- !,create_show_mdi_window(STR).

        
% eval_proc(use_example_dlg,[str(Dlg_Name)])  :- !,call_dlg(Dlg_Name). 

 eval_proc(SID,my_msg,[str(X),str(Y)]):-!,esta_Note (SID,X,Y).

 % ERROR IN PROCEDURE CALL
 
 eval_proc(SID,ID,VALUELIST)  :- 
    txt(proc_error,T),
    get_call_str(ID,VALUELIST,STR),
    concat(T,STR,STR1),
    error_msg(SID,STR1).

%------------------------------------------------------------------
%     converting EVALUE domain to STRING domain for nice printout...
%
%   	val_str(EVALUE,STRING)- (I,O)(O,I)		
% 	mk_val_str(ID,STRING) - (I,O)		
%
%EVALUE= true;false;unknown;unsolveable;int(INTEGER);float(REAL);str(STRING)
%---------------------------------------------------------------------------

PREDICATES
 get_option(STRING,OPTIONDEFS,STRING)
 find_option(RULES,STRING,STRING)
 get_evt_option(SID,STRING,STRING,STRING)
 
CLAUSES
  val_str(true,TXT)       :- txt(true,TXT1), TXT1 = TXT,!.
  val_str(false,TXT)      :- txt(false,TXT1), TXT1 = TXT,!.
  val_str(unknown,TXT)    :- txt(unknown,TXT1),TXT1 = TXT,!. 
  val_str(unsolveable,TXT):- txt(unsolveable,TXT1),TXT1 = TXT,!.
  val_str(float(REAL),STR):- str_real(STR,REAL),!.
  val_str(int(INTG),STR)  :- trap(str_int(STR,INTG),_,fail),!.
  val_str(int(INTG),STR)  :- str_real(STR,INTG),!.
  val_str(str(STR),STR1)  :- bound(STR),str_bin(STR,STR1,_),!.
  val_str(str(STR),STR1)  :- bound(STR1),str_bin(STR1,STR,_).
  
 mk_val_str(SID,VID1,S2) :-  
    evalue_(SID,VID,V,_),
    upper_lower(VID,VID1),
    val_str(V,S1),
    get_evt_option(SID,VID,S1,S2),!.
 mk_val_str(_,_," ? ").
 
 get_evt_option(SID,VID,S1,S2):-
    vars_(SID,_,VID,_,_,_,_,RULES,_),!, 
    find_option(RULES,S1,S2).
 get_evt_option(_,_,S,S).   
    
    
 find_option(category(DEFS,_),STR,OPT):- get_option(STR,DEFS,OPT),!.
 find_option(_,S,S). 

 get_option(X,[option(X1,OPT)|_],OPT):- X1=X,!.
 get_option(SYM,[_|OL],Option)	     :- get_option(SYM,OL,Option).

%---------------------------------------------------------------------------
%write error messages for illegal procedure and function calls:
%---------------------------------------------------------------------------

PREDICATES
 get_vall_str(EVALUELIST,string,string)

CLAUSES
 get_call_str(ID,VALL,STR1):-
    get_vall_str(VALL,"",STR),
    format(STR1,"\r\n%(%)",ID,STR).

 get_vall_str([],STR,STR).
 
 get_vall_str([Val],STR,RESULT):- !,
    val_str(Val,Sval), 
    concat(STR,Sval,RESULT). 

 get_vall_str([Val|Tail],STR,RESULT):-
    val_str(Val,Sval), 
    concat(STR,Sval,STR2), 
    concat(STR2,",",STR3),
    get_vall_str(Tail,STR3,RESULT).




