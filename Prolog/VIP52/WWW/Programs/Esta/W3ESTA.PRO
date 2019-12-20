/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3ESTA.PRO
 Purpose: ISAPI ESTA Engine
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "w3esta.inc"
include "w3ecfg.pre"		%  Load or create W3ESTA Definition file

include "htmlfun.pre"


include "argtools.pro"
%
%  Win32 API direct calls
%
GLOBAL PREDICATES
  DWORD GetModuleHandleA (string) - (i) language stdcall
  DWORD GetModuleFileNameA (DWORD, STRING, DWORD) - (i,i,i) language stdcall
CONSTANTS
  fnlen = 32184
PREDICATES
  do_Query (EXTENSION_CONTROL_BLOCK)
  dump_Query (EXTENSION_CONTROL_BLOCK)

/******************************************************
    ISAPI Mandatory Entry Points
******************************************************/
CLAUSES
  http_ExtensionVersion ("ISAPI ESTA Engine").

  http_ExtensionProc (ECB, hse_status_success) :-
  	html_CreatePage(ECB,"ESTA"),
  	%dump_Query(ECB),
  	do_Query (ECB),
  	html_EndPage(ECB),!.  	
  http_ExtensionProc (_, hse_status_success ).
  
  http_TerminateExtension(_Flags,b_true).

GOAL	% Do nothing
  true.
  
PREDICATES
  load_kbase (SID,string KB)
  restore_ESTA_state (SID,http_qa_list)
CLAUSES
  dump_Query (ECB) :-
  	get_Query_ArgList(ECB,QAL),
  	term_str(http_qa_list,QAL,QALS),
  	format(QQ,"<p>Query: %s</p>\n",QALS),
        http_Qa_member (Arg,QAL),
  	Arg=http_qa(Name,Value),
  	format (S,"<p>%s:%s\n",Name,Value),
  	http_WriteClientString (ECB,QQ,_),
  	http_WriteClientString (ECB,S,_),
  	fail.
  dump_Query(_).
  %
  %  parses and processes the current request
  %
  do_Query (ECB) :-
  	get_Query_ArgList(ECB,QAL),
  	http_qa_member(http_qa("ESTAcommand","EstaStartPage"),QAL), % went from start page
  	http_qa_member(http_qa("Load.x",_),QAL),
  	http_qa_member(http_qa("SessionID",SID),QAL),
  	http_qa_member(http_qa("KbSelection",KB),QAL),!,
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
  	retractall (app_path(_)),			% store APP_PATH
  	HANDLE = GetModuleHandleA ("W3ESTA.DLL"),
  	str_len (APP_FULL_PATH,fnlen),
  	GetModuleFileNameA (HANDLE,APP_FULL_PATH,fnlen),
  	filenamepath (APP_FULL_PATH,APP_PATH,_),
  	assert (app_path(APP_PATH)),
  	filenamepath (DEFFILE,APP_PATH,"W3ESTA.DEF"),
  	load_def_file(SID,DEFFILE,_Msg),		% load definitions
  	filenamepath (KBPATH,APP_PATH,KB),
  	load_kbase (SID,KBPATH).
  do_Query (ECB) :-					%  Begin Consultation
  	get_Query_ArgList(ECB,QAL),
        http_qa_member(http_qa("ESTAcommand","EstaStartPage"),QAL), 
  	http_qa_member(http_qa("BeginConsult.x",_),QAL),
    	http_qa_member(http_qa("SessionID",SID),QAL),!,
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
    	resetmachine(SID),
    	inferencemachine(SID,nill).
  do_Query (ECB) :-					%  Begin Consultation
  	get_Query_ArgList(ECB,QAL),
        http_qa_member(http_qa("ESTAcommand","TitlePage"),QAL), 
  	http_qa_member(http_qa("BeginConsult",_),QAL),
    	http_qa_member(http_qa("SessionID",SID),QAL),!,
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
    	resetmachine(SID),
    	inferencemachine(SID,nill).
  do_Query (ECB) :-						% ----- CONTINUE ----
  	get_Query_ArgList(ECB,QAL),
        http_qa_member(http_qa("ESTAcommand","CatQuestPage"),QAL),  %  Category
  	http_qa_member(http_qa("Continue",_),QAL),
  	http_qa_member(http_qa("Option",Value),QAL),
    	http_qa_member(http_qa("SessionID",SID),QAL),
    	http_qa_member(http_qa("sitems",SITEMS),QAL),!,
  	restore_ESTA_state(SID,QAL),
	term_str(slist,ITEMLIST,SITEMS),
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
	continue_catquest (SID,ITEMLIST,Value).
  do_Query (ECB) :-
  	get_Query_ArgList(ECB,QAL),
        http_qa_member(http_qa("ESTAcommand","StdQuestPage"),QAL),  %  Yes/No/Unknown
  	http_qa_member(http_qa("Continue",_),QAL),
  	http_qa_member(http_qa("StdQuestRadio",Value),QAL),
    	http_qa_member(http_qa("SessionID",SID),QAL),!,
    	restore_ESTA_state(SID,QAL),
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
	continue_stdquest (SID,Value).
  do_Query (ECB) :-
  	get_Query_ArgList(ECB,QAL),
        http_qa_member(http_qa("ESTAcommand","EditQuestPage"),QAL), %  Edit field
  	http_qa_member(http_qa("Continue",_),QAL),
  	http_qa_member(http_qa("Edit",Value),QAL),
    	http_qa_member(http_qa("SessionID",SID),QAL),!,
    	restore_ESTA_state(SID,QAL),
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
	continue_editquest (SID,Value).
  do_Query (ECB) :-					% --- Why ---------
  	get_Query_ArgList(ECB,QAL),
        http_qa_member(http_qa("ESTAcommand","AdvicePage"),QAL),%  why advice
  	http_qa_member(http_qa("Why",_),QAL),
    	http_qa_member(http_qa("SessionID",SID),QAL),!,
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
  	why_advice(SID).
  do_Query (ECB) :-			%  why question
  	get_Query_ArgList(ECB,QAL),		
        http_qa_member(http_qa("ESTAcommand",Page),QAL),
  	ve_member (Page,["CatQuestPage","StdQuestPage","EditQuestPage"]),
  	http_qa_member(http_qa("Why",_),QAL),
  	http_qa_member(http_qa("SessionID",SID),QAL),!,
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
  	why(SID).
  do_Query (ECB) :-			%  Explain question
  	get_Query_ArgList(ECB,QAL),
        http_qa_member(http_qa("ESTAcommand",Page),QAL),
  	ve_member (Page,["CatQuestPage","StdQuestPage","EditQuestPage"]),
  	http_qa_member(http_qa("Explain",_),QAL),
    	http_qa_member(http_qa("SessionID",SID),QAL),!,
  	retractall (ecb(SID,_)),			% store SID's ECB
  	assert (ecb(SID,ECB)),
  	explain_question(SID).
  do_Query (_).
  	
/******************************************************
   Load knowledge base
******************************************************/
CLAUSES
  load_kbase (SID,KBPATH) :-
  	open_file (SID,KBPATH),!.
  load_kbase (_,_).

  consult_present.		% always true in WWW
  
/******************************************************
  1. Retrive hidden User's answer path
  2. Restore ESTA Inference Engine Status.
     Replay consultation if needeed
******************************************************/
PREDICATES
  replay_consult (SID,SLIST,SLIST)
CLAUSES
  replay_consult (_SID,ANS_PATH,ANSWERS) :-	% same path
  	reverse (ANSWERS,ANS_REV),		% dont replay
  	ANS_PATH=ANS_REV,!.			%
  replay_consult (SID,ANS_PATH,_) :-		% replay
  	resetmachine(SID),
  	set_replay(SID,ANS_PATH),
  	retractall(inreplay(SID)),
  	assert(inreplay(SID)),
  	inferencemachine(SID,nill).
  	
  restore_ESTA_state (SID,QAL) :-
  	http_qa_member(http_qa("ans_path",ANS_STR),QAL),!,
  	term_str(slist,ANS_PATH,ANS_STR),
  	answers(SID,ANSWERS),!,
	replay_consult(SID,ANS_PATH,ANSWERS).
	
