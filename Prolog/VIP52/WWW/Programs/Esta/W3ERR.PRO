/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3ERR.PRO
 Purpose: WWW version of ESTA Error Handling
 Written by:
 Comments:
******************************************************************************/


include "w3esta.inc"
include "w3ecfg.pre"

CONSTANTS

 error_file = "esta.err"

DATABASE - errfile
 determ error_filename(string)
 
PREDICATES
 my_file_str(string,string) 

 
CLAUSES
 del_bakfile(FILE):-
   filenamepath(FILE,PATH,NAME),
   filenameext(NAME,NAME1,_),
   concat(PATH,NAME1,PATHNAME), 
   concat(PATHNAME,".bak",BAKNAME),
   trap(deletefile(BAKNAME),_,fail),!.
 del_bakfile(_).                        
  
 my_file_str(FILE,STR):-
    file_str(FILE,STR),
    del_bakfile(FILE).
 
CLAUSES 
  
 store_err_file :-
    retractall(_,errfile),
    filenamepath(FullName,"",error_file),
    assert(error_filename(FullName)).

PREDICATES
 get_errortxt(string)
 
CLAUSES
 get_errortxt(E):- txt1("error",E),!. % esta.def exists
 get_errortxt("ESTA").

 symb_error_msg(SID,STR):- txt(STR,STR1), error_msg(SID,STR1).
  
 error_msg(SID,STR):- 
   	get_errortxt(ETXT),
     	get_esta_page_header (SID,Title),
  	Body = doc_body([],
  		    [par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		     par([doc_att("ALIGN",atom("LEFT"))],
  		         [font(1,[doc_att("SIZE",num(5)),doc_att("COLOR",lit("#FF0000"))]),
  		          txt(ETXT),
  		          font(0,[])
  		         ]),
  		     hr([]),
  		     par([],[font(1,[doc_att("SIZE",num(3)),doc_att("COLOR",lit("#FF0000"))]),
  		     	     txt(Str),
  		     	     font(0,[])
  		     	    ]
  		     	 )]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	report (SID,HTML).

 warning_msg(SID,STR):- 
   	get_errortxt(ETXT),
     	get_esta_page_header (SID,Title),
  	Body = doc_body([],
  		    [par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		     par([doc_att("ALIGN",atom("LEFT"))],
  		         [font(1,[doc_att("SIZE",num(5)),doc_att("COLOR",lit("#00FF00"))]),
  		          txt(ETXT),
  		          font(0,[])
  		         ]),
  		     hr([]),
  		     par([],[font(1,[doc_att("SIZE",num(3)),doc_att("COLOR",lit("#00FF00"))]),
  		     	     txt(Str),
  		     	     font(0,[])
  		     	    ]
  		     	 )]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	report (SID,HTML).
   
 dbcpy_err(SID,E):-
   error_filename(F),
   errormsg(F,E,Msg,_),
   error_msg(SID,Msg),!.
 dbcpy_err(_,_).  


% HandleConsultError(FNAME,INTEGER,INTEGER)-(i,i)
% Use: 	DB_TYPE=1,	1 for consulting VDB's. 
%			2 for consulting SCREEN-HANDLER
%			3 for consult DEF files.
%	
%	trap(consult(VDB_file),ErrCode,handleConsultError(DB_TYPE,ErrCode),


PREDICATES
  exit_yes(string,integer)
% reconsult(string,integer)
  get_error_pos(string,string,integer,integer)


CLAUSES
  exit_yes("winesta.def",E):-  !,exit(E).
  exit_yes("winestar.def",E):- !,exit(E).
  exit_yes(_,_).
/*
  reconsult(_SID,File,3):- !, consult_def_file(File).
  reconsult(SID,File,NO):- !,
    trap(consult(File),Ecode,HandleConsultError(SID,File,Ecode,NO)).
%    save_filetime(File,NO).
  reconsult(_,_,_).
*/
  get_error_pos(STR,Line,LinePos,ErrPos):-
    searchstring(STR,Line,FoundPos),
    ErrPos = FoundPos + LinePos,!. 
    
  get_error_pos(_,_,_,0):- beep.   
    
DATABASE - err
net_error(unsigned)

CLAUSES
net_error(1101).
net_error(7005).

%  HandleConsultError(_,E,_):- str_int(SE,E),error_msg(SE),!.
  
  /*
  HandleConsultError(File,E,Type):-        % Access denied
    net_error(E),!,
    reconsult(File,Type).    
*/
  handleConsultError(SID,File,ErrorCode,Type):- % type = 1 -> knowledge reset
    resetDB(SID,Type),
    consulterror(Line,LinePos,_),
    errormsg("PROLOG.ERR",ErrorCode,Msg,_),
    file_str(File,FSTR),
    str_bin(FSTR,FSTR1,_),
    get_error_pos(FSTR1,Line,LinePos,ErrPos),    
    format(STR,"Errorcode:%,In file:%, Pos:% Msg:%",ErrorCode,File,ErrPos,Msg),
    error_msg(SID,STR),!.
	
  handleConsultError(_,File,ErrorCode,_):-
    exit_yes(File,ErrorCode).

  trap_file_error(SID,F,E):-
    error_filename(Error_file),
    errormsg(Error_file,E,ErrorMsg,ExtraHelpMsg),
    format(STR,"%\n%\n%",F,ErrorMsg,ExtraHelpMsg),
    error_msg(SID,STR),
    exit_yes(F,E),!.
    
PREDICATES
%  check_error(string,unsigned)

CLAUSES
  check_error(SID,F,E):-
    net_error(E),!,
    trap_file_error(SID,F,E).
  check_error(SID,F,E):-trap_file_error(SID,F,E),fail.

  netopenwrite(SID,SYMFILE,FILENAME):-
    not(trap(openwrite(SYMFILE,FILENAME),E,fail)),!,
    check_error(SID,FILENAME,E),
    netopenwrite(SID,SYMFILE,FILENAME).
  netopenwrite(_,_,_).

  
  netfilestr(SID,FILENAME,STR):-
    not(trap(my_file_str(FILENAME,STR),E,fail)),!,
    check_error(SID,FILENAME,E),
    netfilestr(SID,FILENAME,STR).
  netfilestr(_,_,_).
  

