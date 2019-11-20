/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3EFILE.PRO
 Purpose: File Handling
 Written by:	
 Comments:
 	WWW version of ESTA.
 	excluded:  definition file handling
 	           pictures database handling
 	           text kbases
 	           any saving
******************************************************************************/

include "w3esta.inc"	% common declarations

/***************************************************************************/
/*         MISC PREDICATES FOR FILE HANDLING                               */
/***************************************************************************/
CLAUSES
  my_existfile(SID,File):- trap(fileattrib(File,_),E,trap_file_error(SID,File,E)),!.
  my_existfile(_,_):- fail.

  get_filename(FILE,NAME):- filenamepath(FILE,_,NAME).%,NAME1 = AnsiLower(NAME).

/**************** Misc. auxiliary predicates for open and ... *******/

PREDICATES
  get_header(string,string)
  open_misc(SID,string,string)
  open_kb(SID,string,string)

CLAUSES
  get_header(NAME,C):-
   	txt("headtitle",Title),
   	format(C,"% - %",Title,NAME).

  open_misc(SID,MSG,FILE):-
   	get_filename(FILE,NAME1),
   	get_header(NAME1,HEAD),
   	store_esta_page_header (SID,HEAD),
   	txt(MSG,STR),
   	format(STR1,"% %",STR,NAME1),
   	chng_menustr(STR1).

  open_kb(SID,FILE,MSG):-
   	store(SID,checkstatus,"notok"),
   	open_misc(SID,MSG,FILE),
   	title_(SID,T),
   	show_title(SID,T,1),      % add to log 
   	fail.	  
  open_kb(_SID,_FILE,_MSG).
   	
/************** OPEN FILE ***********************************************/
DATABASE - txt_oem_ansi
  determ no_conv_to_ansi

PREDICATES
  read_file_to_str1(SID,string,file,string)
  conv_or_not(string,string)
  init_read(file)
  end_read(file)
  init_write(file)
  end_write(file)
CLAUSES
  init_read(OLD):- 
   	txt("read",WR),
   	chng_menustr(WR),
   	readdevice(OLD).   
       
  end_read(OLD) :- 
  	closefile(textfile),
   	readdevice(OLD),
   	txt("init_stat",ST),
   	chng_menustr(ST).
   
  init_write(OLD):- 
   	writedevice(OLD),
   	txt("write",WR),
   	chng_menustr(WR).
   
  end_write(OLD) :- 
   	closefile(textfile),
   	writedevice(OLD),
   	txt("init_stat",ST),
   	chng_menustr(ST).
   
  conv_or_not(STR,STR):- retract(no_conv_to_ansi),!.
  conv_or_not(STR,STR1):- STR1=oem2ansi(STR).

  read_file_to_str(SID,FILE,STR) :- 
   	init_read(OLD),
   	retractall(no_conv_to_ansi),
   	assert(no_conv_to_ansi),   
   	read_file_to_str1(SID,FILE,OLD,STR).
	
  read_file_to_str1(SID,FILE,OLD,STR1):- 
   	trap(file_str(FILE,STR),E,trap_file_error(SID,FILE,E)),!,
   	conv_or_not(STR,ASTR),
   	str_bin(ASTR,STR1,_),
   	end_read(OLD).
  read_file_to_str1(_,_,OLD,_):- 
   	retractall(no_conv_to_ansi),
   	end_read(OLD),fail. 

PREDICATES
  load_text_file(SID,string)
  load_file(string SID,string,string)
CLAUSES

  open_file(SID,FNEW):-
   	filenameext(FNEW,_,EXT),
   	upper_lower (UEXT,EXT),
   	load_file(SID,FNEW,UEXT),
   	!.

  open_file(_,_):-
   	txt("open",O),
   	txt("cancel",C),
   	concat(O,C,OC),
   	chng_menustr(OC).
   	
  load_file(SID,FNEW,EXT):- 
   	ve_member(EXT,[".KB",".VB"]),
    	resetknow(SID),				% clears ESTA engine
   	consult_kb(SID,FNEW),!,
   	open_kb(SID,FNEW,"kb_loaded").  

  load_file(SID,FNEW,EXT):-
   	ve_member(EXT,[".KBT",".VBT"]),
   	resetknow(SID),
   	load_text_file(SID,FNEW),!,
   	open_kb(SID,FNEW,"kb_loaded").  

  load_file (SID,FNEW,_) :- !,
  	txt("cantopenfile",TMPL),
  	format (Err,TMPL,FNEW),
  	report (SID,Err).
  	  			  		
%-------------------------------------------------------------------------
%	LOAD KNOWLEDGE BASE FROM KB FILE
%-------------------------------------------------------------------------
 
DATABASE -v
  tmp_var(dbasedom)

PREDICATES
  make_session_KB(SID)
CLAUSES
  consult_kb(SID,KB):-
   	trap(consult(KB),Ecode,handleConsultError(SID,KB,Ecode,1)),!,
   	make_session_KB(SID).
  consult_kb(_,_):-
   	fail.
  %
  %  make session's KB copy
  %
  make_session_KB (SID) :-
   	vars(P,P1,P2,P3,P4,P5,P6,P7),
     	str_bin(P,P0,_),
     	str_bin(P2,P22,_),
     	assert(tmp_var(vars_(SID,P0,P1,P22,P3,P4,P5,P6,P7))),
   	fail.
  make_session_KB (SID) :-
   	paragraph(ID,PNO,EXP,ACTIONS),
     	assert(tmp_var(paragraph_(SID,ID,PNO,EXP,ACTIONS))),
   	fail.
  make_session_KB (SID) :-
   	section(S,S1,S2),
     	str_bin(S,S0,_),
     	assert(tmp_var(section_(SID,S0,S1,S2))),
  	fail.
  make_session_KB (SID) :-
   	title(T),
     	str_bin(T,T1,_),
     	assert(tmp_var(title_(SID,T1))),
   	fail.
  make_session_KB (_) :-
     	retractall(section(_,_,_)),
     	retractall(title(_)),
     	retractall(vars(_,_,_,_,_,_,_,_)),
     	retractall(paragraph(_,_,_,_)),
     	retract(tmp_var(T)),
       	assert(T),
     	fail.    
  make_session_KB (_SID).
  	
%-------------------------------------------------------------------------
%	LOAD KNOWLEDGE BASE FROM TEXT FILE
%
%-------------------------------------------------------------------------

PREDICATES 
  pparm(SID,STRING,SYMBOL)
  psect(SID,STRING,SYMBOL)
  ptitle(SID,STRING,SYMBOL)
  readl2(STRING,INTEGER)
  stopkrit(INTEGER,SYMBOL)
  readlines(SID,SYMBOL)
  readblok(SID,SYMBOL,STRING,INTEGER)
  readblok2(SID,STRING,INTEGER)
  readblok3(INTEGER,STRING,STRING)
  parsblok(SID,SYMBOL,STRING,SYMBOL)
  determine_bloktype(INTEGER,STRING,STRING,SYMBOL)
  load_text_file1(SID,string,file)

CLAUSES
  load_text_file(SID,FNEW):- init_read(OLD),load_text_file1(SID,FNEW,OLD).

  load_text_file1(SID,FNEW,OLD):-
   	trap(openread(textfile,FNEW),E,trap_file_error(SID,FNEW,E)),
   	readdevice(textfile),
   	readlines(SID,STATUS),not(STATUS = notsucces),!,
   	end_read(OLD).
 	load_text_file1(SID,_,OLD):- 
   	end_read(OLD),
   	txt("read_fail",RF),
   	error_msg(SID,RF),
   	fail.   

  readlines(SID,SUCCES):-
   	repeat,
     		readblok(SID,PS,BLOK,READSTATUS),
     		parsblok(SID,PS,BLOK,SUCCES),
   		stopkrit(READSTATUS,SUCCES),!.

  stopkrit(_,_):- eof(textfile),!.
  stopkrit(2,_):- !.
  stopkrit(_,notsucces).

  readblok(SID,BLOKTYP,BLOK2,READSTATUS)  :-  
  	readblok2(SID,BLOK,READSTATUS),
   	determine_bloktype(READSTATUS,BLOK,BLOK2,BLOKTYP),!.

PREDICATES
  chng(DBASEDOM)
  get_cur_blok(SID,STRING)
  until_readblok2(INTEGER,STRING)
  compare_first_line_and_strip(STRING,STRING,STRING) 
  search_nl(string,unsigned)

CLAUSES
  search_nl(LINE,POS):-
   	searchchar(LINE,'\n',POS),!.
   
  search_nl(LINE,POS):-
   	searchchar(LINE,'\13',POS).
   
  compare_first_line_and_strip(T,BL,BL2) :-
   	str_len(T,L),L>0,
   	frontstr(L,BL,T2,BL1),
   	T=T2,
   	search_nl(BL1,L1),
   	frontstr(L1,BL1,_,BL2).

  determine_bloktype(2,_,"",nothing):- !.
  determine_bloktype(1,BL,BL2,parm) :- 
   	txt1(main_parmfront,T),compare_first_line_and_strip(T,BL,BL2),!.
  determine_bloktype(1,BL,BL2,sekt) :-
   	txt1(main_sektfront,T),compare_first_line_and_strip(T,BL,BL2),!.
  determine_bloktype(1,BL,BL2,title) :- 
   	txt1(main_titlfront,T),compare_first_line_and_strip(T,BL,BL2),!.
  determine_bloktype(1,BL,BL,parm):- 
   	tok_keyw_str(parameter,WORD),
   	fronttoken(BL,FirstWord,_),upper_lower(FirstWord,Word),!.
  determine_bloktype(1,BL,BL,sekt):- 
   	tok_keyw_str(section,WORD),
   	fronttoken(BL,FirstWord,_),upper_lower(FirstWord,Word),!.
  determine_bloktype(1,BL,BL,title):-!.
  determine_bloktype(1,_,"",other).

  chng(mem(SID,ID,_)):- retract(mem(SID,ID,_)),fail. 
  chng(D):- assert(D).

  get_cur_blok(SID,STR) :- mem(SID,block,STR),!.

CONSTANTS
  more_to_read	= 1
  end_of_file	= 2


CLAUSES
  readl2(S,more_to_read):- readln(S),!.
  readl2("",end_of_file).

  readblok2(SID,BLOK6,READSTATUS) :-
   	chng(mem(SID,block,"")),
   	repeat,
     		get_cur_blok(SID,BLOCKSTR),      
     		readl2(S1,READSTATUS),
     		readblok3(READSTATUS,S1,S3),
     		concat(BLOCKSTR,S3,BLOK4),
     		chng(mem(SID,block,BLOK4)),
   	until_readblok2(READSTATUS,S1),
   	get_cur_blok(SID,BLOK6),!.
%--------------------------------------------------------------------
%	readblok3(READSTATUS,LineJustReadByReadl2,NewString,NewString)
%
% The not(eof()) condition is needed to get last character in 
% textfiles. Otherwise it stops as soon as the eof() flag is set.
%--------------------------------------------------------------------
  readblok3(RS,S1,""):- 
   	not(eof(textfile)), 
   	until_readblok2(RS,S1),!. 
   
  readblok3(_,S1,S3) :- 
   	char_int(LFCH,13),str_char(LF13,LFCH),      % nl   
   	char_int(LFCH1,10),str_char(LF10,LFCH1),      % nl   
   	concat(S1,LF13,S2),
   	concat(S2,LF10,S3).
%--------------------------------------------------------------------
%	read_blok2(READSTATUS,STRING)
% Stops (succeds) when either the eofflag is set, or when #p, #s, #t
% or ## is met. ## is not used any more when writing textfiles.
%--------------------------------------------------------------------
  until_readblok2(_,_) :-  eof(textfile),!.
 
  until_readblok2(_,S1):- 
   	frontstr(2,S1,S8,_),
   	txt("main_parmfront",P),
   	txt("main_sektfront",S),
   	txt("main_titlfront",T),
   	ve_member(S8,[P,S,T,"##"]),!.
  until_readblok2(end_of_file,_).
 
  parsblok(_,other,_,notsucces):-  !.
  parsblok(_,nothing,_,succes):-  !.
  parsblok(SID,parm,BLOK,SUCCES):-  pparm(SID,BLOK,SUCCES),readdevice(textfile),!.
  parsblok(SID,sekt,BLOK,SUCCES):-  psect(SID,BLOK,SUCCES),readdevice(textfile),!.
  parsblok(SID,title,BLOK,SUCCES):- ptitle(SID,BLOK,SUCCES),readdevice(textfile),!.

  pparm(SID,STR,succes) :-
   	readdevice(keyboard),
   	parseloop(SID,parameter,STR,_),
   	readdevice(textfile),
   	retrieve(SID,parserr,SYMB),
   	SYMB=nill,!.
  pparm(_,_,notsucces).

  psect(SID,STR,succes) :-
   	readdevice(keyboard),
   	parseloop(SID,section,STR,_), 
   	readdevice(textfile),
   	retrieve(SID,parserr,SYMB),
   	SYMB=nill,!.
  psect(_,_,notsucces).            

  ptitle(SID,BLOK,succes) :- retractall(title_(SID,_)),assert(title_(SID,BLOK)).

/************************** Used in wininterf.pro ****************/
PREDICATES
  sv_values (SID)
  save_values1(SID,string,file)

CLAUSES
  save_values(SID,F) :- init_write(OLD), save_values1(SID,F,OLD).
  
  save_values1(SID,F,OLD) :-
	%   netopenwrite(textfile,F),!,
	app_path(APP_PATH),
	filenamepath(F,_,NAME),
	filenamepath(FULL,APP_PATH,NAME),
   	trap(openwrite(textfile,FULL),E,trap_file_error(SID,FULL,E)),!,
   	writedevice(textfile),
   	sv_values(SID),
   	end_write(OLD).
	%   save_filetime(F,5).
  save_values1(_,_,OLD) :-  
   	end_write(OLD),
   	fail.

  sv_values (SID) :-
   	evalue_(SID,P1,P2,P3),
   	D = evalue(P1,P2,P3),write(D),nl,
   	fail.
  sv_values (SID) :-
   	mem(SID,curfname,CF),                 % save current knowledge base name
   	E = mem(SID,curfname,CF),write(E),nl,
   	fail.
  sv_values (_).  

DATABASE - tmpevalue
  tmp_evalue(SID,ID,EVALUE,UNI_METHOD)
  tmp1_evalue(SID,ID,EVALUE,UNI_METHOD)
  
PREDICATES
  retr_tmp_evalue(SID,ID)
  save_cur_evalues(SID)
  reset_cur_evalues(SID)
  chng_consulted_evalues(SID,string,string)
 
CLAUSES
  retr_tmp_evalue(SID,ID):-
        tmp_evalue(SID,ID1,_,_),
        upper_lower(ID,ID1),!,
        retractall(tmp_evalue(SID,ID1,_,_)).
  retr_tmp_evalue(_,_).
 
  save_cur_evalues (SID) :-
        retract(evalue_(SID,P1,P2,P3)),
          assert(tmp_evalue(SID,P1,P2,P3)),
        fail.  
  save_cur_evalues(_).
 
  reset_cur_evalues (SID):-    % Keep new evalue 
 	evalue_(SID,P1,_,_),
 	  retr_tmp_evalue(SID,P1),
        fail.
  reset_cur_evalues (SID) :-
        tmp_evalue(SID,P1,P2,P3),         % Assert rest of evalues
          assert(evalue_(SID,P1,P2,P3)),
        fail.  
  reset_cur_evalues (SID) :- retractall(tmp_evalue(SID,_,_,_)).
 
  chng_consulted_evalues(_,KB,KB):- !. % Same kb : do nothing
  chng_consulted_evalues(SID,_,_):-      % Different kb, mark evalues as alien
        retract(evalue_(SID,P1,P2,_)),
          assert(tmp1_evalue(SID,P1,P2,alien)),
        fail.
  chng_consulted_evalues(SID,_,_):-
        retract(tmp1_evalue(SID,P1,P2,P3)),
          assert(evalue_(SID,P1,P2,P3)),
        fail.
  chng_consulted_evalues(_,_,_).      
 
  get_values(SID,F) :- 
   	retractall(_,tmpevalue),
   	my_existfile(SID,F),
   	get_curfname(SID,CURKB),         % get current kb name
   	retractall(mem(SID,curfname,_)), % retract current kb name
   	save_cur_evalues(SID),            % save current evalues temporarily
   	app_path(APP_PATH),
	filenamepath(F,_,NAME),
	filenamepath(FULL,APP_PATH,NAME),
   	trap(consult(FULL),Ecode,handleConsultError(SID,FULL,Ecode,1)),% consult evalues
   	get_curfname(SID,SVKB),          % get consulted kb name
   	chng_consulted_evalues(SID,CURKB,SVKB), % change consulted evalues
   	reset_cur_evalues(SID),           % reset current evalues
   	set_curfname(SID,CURKB),!.       % set current kb name
   	%save_filetime(F,1),!.
 	get_values(_,_).
 