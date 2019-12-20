/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3MISC.PRO
 Purpose:  Some all purposes predicates
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "w3esta.inc"

GLOBAL PREDICATES
  movemem(ulong,ulong,unsigned) - (i,i,i) language c as "_MEM_MovMem"
  CONV_TextBin(string,string,unsigned,unsigned) - (i,i,i,i) language C as "_CONV_TextBin"


/* Transformation of textmode newlines to windows newlines */
PREDICATES
  no_of_newlines(string,unsigned,unsigned)

CLAUSES
  no_of_newlines("",IN,IN):-!.
  no_of_newlines(STR,IN,NONL):-
    	searchstring(STR,"\n",Pos),
    	frontstr(Pos,STR,_,STR2),
    	OUT = IN + 1,!,
    	no_of_newlines(STR2,OUT,NONL).
  no_of_newlines(_,IN,IN):-!.

  str_bin(IN,OUT,NONL):-
    	no_of_newlines(IN,0,NONL),
    	str_dosstr(IN,OUT).

  oem2ansi (Str,Str).
  ansi2oem (Str,Str) .

/******************************************************
 *   WARNING !!!  NONPORTABLE CODE                    *
 *                                                    *
 *   Type convertion macros through binary            *
 *   representation                                   *
 *      MAKELONG(WORD,WORD)                           *
 *      WORD HIWORD (DWORD)                           *
 *      WORD LOWORD (DWORD)                           *
 *      BYTE LOBYTE (WORD)                            *
 *      BYTE HIBYTE (WORD)                            *
 ******************************************************/

   MAKELONG (LOWORD,HIWORD,DOUBLE) :-
   	Bin = makebinary (4),
   	setwordentry (Bin,0,LOWORD),
   	setwordentry (Bin,1,HIWORD),
   	DOUBLE = getdwordentry (Bin,0).
   	
   HIWORD (DOUBLE, HIWORD) :-
   	Bin = makebinary (4),
   	setdwordentry (Bin,0,DOUBLE),
   	HIWORD = getwordentry (Bin,1).
   		
   LOWORD (DOUBLE, LOWORD) :-
   	Bin = makebinary (4),
   	setdwordentry (Bin,0,DOUBLE),
   	LOWORD = getwordentry (Bin,0).
   		

/******************************************************
 *  Clears 0x0D from input string                     *
 ******************************************************/
 PREDICATES
    str2list(string,slist)
    list2str(slist,string)
    calc_len(slist,integer,integer)
    concat_strings(slist,ushort,unsigned)
   
 CLAUSES

   clear_0D (In,Out):-
   	str2list(In,Lst),
  	list2str(Lst,Out).
   
   str2list(In,[Front|Lst]):-
  	searchchar (In,0x0D,Pos),
  	Pos1 = Pos - 1, 
  	frontstr (Pos1,In,Front,Rest),
  	frontchar (Rest,_,Rest2),!,
  	str2list(Rest2,Lst).
   str2list(Str,[Str]).
   
   list2str(Lst,Str) :-
   	calc_len(Lst,0,Len),
   	Len1=Len+1,
   	str_len(Str,Len1),
   	ptr_dword(Str,SEG,OFF),
   	concat_strings(Lst,SEG,OFF).
   	
   calc_len ([],L,L).
   calc_len ([H|T],L,Len):-
   	str_len(H,L0),
   	L1=L+L0,!,
   	calc_len(T,L1,Len).
   	
   concat_strings([],SEG,OFF):-
   	Pos=OFF+1,
   	membyte(SEG,Pos,0).
   concat_strings([H|T],SEG,OFF):-
   	str_len(H,Len),
   	Src=cast(ulong,H),
   	ptr_dword(PNew,SEG,OFF),
   	Dest=cast(ulong,PNew),
	movemem(Src,Dest,Len),
	OFF1=OFF+Len,
	concat_strings(T,SEG,OFF1).

/******************************************************
 *   Safely gets first N characters or all the string *
 ******************************************************/
 safe_frontstr (N,In,First,Rest) :-
 	frontstr (N,In,First,Rest),!.
 safe_frontstr (_,In,In,"").	
 
/******************************************************
 *   Show Error                                       *
 ******************************************************/
 err_Report (SID,ErrorNo) :-
	errormsg("prolog.err",ErrorNo,ErrorMsg,ExtraHelpMsg),!,
	report (SID,ErrorMsg),
	report (SID,ExtraHelpMsg).
 err_Report (SID,ErrorNo) :-
 	format (Msg,"An error %d was occured while execution of W3ESTA<BR>PROLOG.ERR not found",Errorno),
 	report (SID,Msg).
 	
 report (SID,Str) :-
 	ecb(SID,ECB),!,
 	http_WriteClientString (ECB,Str,_).
 	
 chng_menustr (_Str).   % dont' know yet

/******************************************************
    ESTA page header handling
         appears at the each page as "Window Title"
******************************************************/
 store_esta_page_header (SID,Str) :-
 	retractall (esta_page_header(SID,_)),
 	assert (esta_page_header(SID,Str)).
 get_esta_page_header (SID,Str) :-
 	esta_page_header(SID,Str),!.
 get_esta_page_header (_,"").
 	
 esta_Note (SID,Head,Note) :-
  	get_esta_page_header (SID,Title),
  	Body = doc_body([doc_att("background",lit("images/grytxtr5.jpg"))],
  		    [par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		     par([doc_att("ALIGN",atom("LEFT"))],[font(1,[doc_att("SIZE",num(5))]),txt(Head),font(0,[])]),
  		     hr([]),
  		     par([],[txt(Note)])]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	report (SID,HTML).
/******************************************************
   Assert status message fact for display at the page
   bottom
 ******************************************************/
  statusmsg (SID,TXT) :- retractall (page_status(SID,_)),assert(page_status(SID,TXT)).
/******************************************************
   Some kind of messages
******************************************************/
DATABASE - tmp_txt
  tmptxt(SID,string)
  tmptxt1(SID,string)
PREDICATES
  ass_tmptxt(SID,string)
  flush_tmptxt1(SID,string) 
  text_error(SID,integer)
  is_blank (char)
  skip_blanks (string,string)
  break_text_1 (string,string,string)
  count_right_blank(string STR,integer Pos,integer PosOut)  
CLAUSES
  remarkmsg (SID,TXT) :-
  	txt ("headtitle",Str),
  	get_esta_page_header (SID,Title),
  	break_text (TXT,BTXT),
  	Body = doc_body([doc_att("background",lit("images/grytxtr5.jpg"))],
  		    [par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		     par([doc_att("ALIGN",atom("LEFT"))],[font(1,[doc_att("SIZE",num(5))]),txt(Str),font(0,[])]),
  		     hr([]),
  		     par([],[txt(BTxt)])]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	report (SID,HTML).
  	
  infomsg (SID,TXT1,TXT2) :-
  	get_esta_page_header (SID,Title),
  	break_text (TXT2,BTxt),
  	Body = doc_body([doc_att("background",lit("images/grytxtr5.jpg"))],
  		    [par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		     par([doc_att("ALIGN",atom("LEFT"))],[font(1,[doc_att("SIZE",num(5))]),txt(Txt1),font(0,[])]),
  		     hr([]),
  		     par([],[txt(BTxt)])]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	report (SID,HTML).
  	
  wrsymbtxt(SID,S) :- txt(S,T),remarkmsg(SID,T).
  
  store_tmptxt(SID,S)  :- assert(tmptxt(SID,S)).

  flush_tmptxt(SID,STR):- 
     	retractall(tmptxt1(SID,_)),
     	assert(tmptxt1(SID,"")),
     	trap(flush_tmptxt1(SID,STR),E,text_error(SID,E)).

  text_error(SID,_):- !,txt(text_to_big_err,TE), error_msg(SID,TE).
     
  ass_tmptxt(SID,S):-
     	retract(tmptxt1(SID,S0)),!,
     	concat(S0,S,S1),
     	assert(tmptxt1(SID,S1)).

  flush_tmptxt1(SID,_):-
     	retract(tmptxt(SID,S)),
      		ass_tmptxt(SID,S),
     	fail. 
  flush_tmptxt1(SID,S) :- tmptxt1(SID,S),!.
  
  break_text (Txt,Breaked) :-
  	skip_blanks (Txt,Txt1),
  	break_text_1 (Txt1,"",Breaked).
  	
  break_text_1 ("",Txt,Txt) :- !.
  break_text_1 (TXT,Buff,Breaked) :-
  	searchchar (TXT,'\n',POS),
  	frontstr (POS,TXT,FRONT,REST),
  	format (Buff1,"%s%s<br>",Buff,FRONT),
  	skip_blanks (REST,REST1),!,
  	break_text_1 (REST1,Buff1,Breaked).
  break_text_1 (REST,Buff,Breaked) :-
  	concat (Buff,Rest,Breaked).

  skip_blanks (STR,STR1) :-
  	frontchar (STR,C,REST),
  	is_blank (C),!,
  	skip_blanks (REST,STR1).
  skip_blanks (STR,STR).
  
  is_blank (' '). is_blank ('\n'). is_blank ('\r'). is_blank ('\t').
  %
  %  Trim from right
  %
  trim_right(STR,STR1):-
  	str_len(STR,L),
  	count_right_blank(STR,L,LOUT),
  	frontstr(LOUT,STR,STR1,_).
  	
  count_right_blank(STR,Pos,PosOut):-
  	subchar(Str,Pos,CHR),
  	is_blank(CHR),
  	Pos>1,
  	Pos1=Pos-1,!,
  	count_right_blank(STR,Pos1,PosOut).
  count_right_blank(_,Pos,Pos).
  %
  %  Trim the srings in a list
  %	
  trim_slist([H|T],[H1|T1]):-
  	trim_right(H,H1),
  	trim_slist(T,T1).
  trim_slist([],[]).

/******************************************************
    Make Picture File Name and Image Field
    
    Win/VPI versions of ESTA stored pictures in special
    external database. Those pictures identified by names
    It is more suitable for WWW to keep pictures in separate
    files (GIF or JPEG)
    
    First : Try to find specific pictures in current dir
    Second : .... in ./images
    
    If the desired picture is not found return ""
******************************************************/
PREDICATES
  check_if_picture_exists (string)
CLAUSES
  make_picture_file_name (PIC,PIC) :-
  	filenameext (PIC,_,EXT),
  	upper_lower (EXT,LEXT),
  	ve_member (LEXT,[".gif",".jpg",".jpeg"]),!.
  make_picture_file_name (PIC,FULL) :-
  	filenameext (FULL,PIC,".gif"),
  	check_if_picture_exists (FULL),!.
  make_picture_file_name (PIC,FULL) :-
  	filenameext (FULL,PIC,".jpg"),
  	check_if_picture_exists (FULL),!.
  make_picture_file_name (PIC,FULL) :-
  	filenameext (FULL,PIC,".jpeg"),
  	check_if_picture_exists (FULL),!.
  make_picture_file_name (PIC,FULL) :-
  	concat ("images/",PIC,PIC_1),
  	concat ("images\\",PIC,PIC_2),
  	filenameext (FULL,PIC_1,".gif"),
  	filenameext (CHECK,PIC_2,".gif"),
  	check_if_picture_exists (CHECK),!.
  make_picture_file_name (PIC,FULL) :-
  	concat ("images/",PIC,PIC_1),
  	concat ("images\\",PIC,PIC_2),
  	filenameext (FULL,PIC_1,".jpg"),
  	filenameext (CHECK,PIC_2,".jpg"),
  	check_if_picture_exists (CHECK),!.
  make_picture_file_name (PIC,FULL) :-
  	concat ("images/",PIC,PIC_1),
  	concat ("images\\",PIC,PIC_2),
  	filenameext (FULL,PIC_1,".jpeg"),
  	filenameext (CHECK,PIC_2,".jpeg"),
  	check_if_picture_exists (CHECK),!.
  make_picture_file_name (_,"").
  
  make_image_field ("",""):-!.
  make_image_field (PIC,IMG) :-
  	format (IMG,"<IMG SRC=\"%s\">",PIC).
  	
  check_if_picture_exists (PIC) :-
  	app_path (APP_PATH),
  	filenamepath (FULL,APP_PATH,PIC),
  	existfile (FULL).

/******************************************************
      Set the fact about current page displayed
******************************************************/
CLAUSES
  set_cur_page (SID,Str) :- retractall (cur_page(SID,_)),assert(cur_page(SID,Str)).

PREDICATES

  decode_char(char,integer)
  isalnum(char)
  
  decode_url_str(long,long,long)
  encode_url_str(long,long,long)
  
  decode_url_char(char,char,long,integer)
  encode_url_char(char,long,integer)
  
  count_spec(long,long,integer,integer)
  
CLAUSES

  str_to_url(URL,Str) :-
  	PSTR=cast(long,Str),
  	str_len(Str,Len),
  	PEND=PSTR+Len,
  	count_spec(PSTR,PEND,0,Count),
  	NewLen=Len+Count+Count,
  	str_len(URL,NewLen),
  	PURL=cast(long,URL),
  	encode_url_str(PSTR,PURL,PEND).
  	  	
  url_to_str(URL,OutStr) :-
  	str_len(URL,Len),
  	str_len(Str,Len),
  	PURL=cast(long,URL),
  	PSTR=cast(long,Str),
  	PEND=PURL+Len,
  	decode_url_str(PURL,PSTR,PEND),
  	concat(Str,"",OutStr).
  	
%  decode_url_str (PEND,PSTR,PEND):-!,
%  	Cur=cast(string,PSTR),
%  	membyte(Cur,'\0').
  decode_url_str (PURL,PSTR,_):-
  	CurURL=cast(string,PURL),
  	CurStr=cast(string,PSTR),
  	membyte(CurURL,CH),CH='\0',!,
  	membyte(CurStr,CH).
  decode_url_str (PURL,PSTR,PEND) :-
  	CurURL=cast(string,PURL),
  	membyte(CurURL,URL_CH),
  	decode_url_char(URL_CH,STR_CH,PURL,Shift),
  	CurStr=cast(string,PSTR),
  	membyte(CurStr,STR_CH),
  	NextPURL=PURL+Shift,
  	NextPSTR=PSTR+1,!,
  	decode_url_str(NextPURL,NextPSTR,PEND).
/*  	
  encode_url_str (PEND,PURL,PEND):-!,
  	Cur=cast(string,PURL),
  	membyte(Cur,'\0').
*/
  encode_url_str (PSTR,PURL,_PEND):-
  	CurURL=cast(string,PURL),
  	CurStr=cast(string,PSTR),
  	membyte(CurStr,CH),CH='\0',!,
  	membyte(CurURL,CH).
  encode_url_str (PSTR,PURL,PEND) :-
  	CurStr=cast(string,PSTR),
  	membyte(CurStr,STR_CH),
  	encode_url_char(STR_CH,PURL,Shift),
  	NextPSTR=PSTR+1,!,
  	NextPURL=PURL+Shift,
  	encode_url_str(NextPSTR,NextPURL,PEND).
  	
  decode_url_char('+',' ',_PURL,1):-!.
  decode_url_char('%',NextCH,PURL,3):-
  	PURL1=PURL+1,
  	PURL2=PURL+2,
  	CurURL1=cast(string,PURL1),
  	CurURL2=cast(string,PURL2),
  	membyte(CurURL1,CH1),
  	membyte(CurURL2,CH2),
  	decode_char(CH1,HighQu),
        decode_char(CH2,LowQu),
        AsciiCode = HighQu*16 + LowQu,
        char_int(NextCH,AsciiCode),!.
  decode_url_char(CH,CH,_PURL,1):-!.
  
  encode_url_char(' ',PURL,1) :-!,
  	CurURL=cast(string,PURL),
  	membyte(CurURL,'+').
  encode_url_char(CH,PURL,3) :-
  	not(isalnum(CH)),!,
  	format(Hex,"%x",CH),
  	PHex=cast(long,Hex),
  	PHex1=PHex+1,
  	Hex1=cast(string,PHex1),
  	membyte(Hex,CH0),
  	membyte(Hex1,CH1),
  	PURL1=PURL+1,
  	PURL2=PURL+2,
  	CurURL=cast(string,PURL),
  	CurURL1=cast(string,PURL1),
  	CurURL2=cast(string,PURL2),
  	membyte(CurURL,'%'),
  	membyte(CurURL1,CH0),
  	membyte(CurURL2,CH1).
  encode_url_char(CH,PURL,1) :-!,
  	CurURL=cast(string,PURL),
  	membyte(CurURL,CH).
  
  % Primitive char_to_hex convertion
  decode_char(C,HV) :-
        '0' <= C , C <= '9' ,!,
                HV = C - '0' .
  decode_char(C,HV) :-
        'A' <= C , C <= 'F' ,!,
                HV = C - 'A' + 10.
  decode_char(C,HV) :-
        'a' <= C , C <= 'f' ,!,
                HV = C - 'a' + 10.

  isalnum(C) :- '0' <= C , C <= '9' ,!.
  isalnum(C) :- 'A' <= C , C <= 'Z' ,!.
  isalnum(C) :- 'a' <= C , C <= 'z'.

  count_spec(PSTR,PSTR,Count,Count):-!.
  count_spec(PSTR,PEND,B,Count):-
  	CurStr=cast(string,PSTR),
  	membyte(CurStr,CH),
  	not(isalnum(CH)),
  	B1=B+1,
  	PNext=PSTR+1,!,
  	count_spec(PNext,PEND,B1,Count).
  count_spec(PSTR,PEND,B,Count):-
  	PNext=PSTR+1,!,
  	count_spec(PNext,PEND,B,Count).
  	
    	