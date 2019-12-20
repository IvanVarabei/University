/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3ETITLE.PRO
 Purpose: WWW version of ESTA (Title Handling)
 Written by: Oleg V. Erjomin
 Comments:
 	Auto page generation made 26.11.97
******************************************************************************/

include "w3esta.inc"

PREDICATES
  dlg_Picture_Start (SID,string)
  dlg_Text_Start (SID,string)
CLAUSES

  show_title(SID,STR,LOGFLAG):-
	fronttoken(STR,PIC_CODE1,REST),
	PIC_CODE1 = "*",                     % title is a picture
	fronttoken(REST,PIC,REST1),
	fronttoken(REST1,PIC_CODE2,_),
	PIC_CODE2 = "*",!,
	strip(PIC,PIC1),
	make_picture_file_name (PIC1,PICFILENAME),
	add_title_pic(SID,LOGFLAG,PICFILENAME),
	dlg_Picture_Start (SID,PICFILENAME).

  show_title(SID,STR,LOGFLAG):-                  % title is a text
	add_title_str(SID,LOGFLAG,STR),
	dlg_Text_Start (SID,Str).

  add_title_pic(SID,1,PIC1):-
	add_log_titl_pic(SID,PIC1),!.              % add title to log
  add_title_pic(_,_,_).

  add_title_str(SID,1,STR):-
	add_log_titl_str(SID,STR),!.               % add title to log
  add_title_str(_,_,_).
 
/**************************************************************************
	Creation and event handling for dialog: Picture Start Dialog
 **************************************************************************/
CLAUSES

  dlg_picture_start (SID,PicID) :-
  	get_esta_page_header (SID,Title),
  	Body = doc_body ([doc_att("background",lit("images/grytxtr5.jpg"))],
  		[par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		 hr([]),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 par([doc_att("ALIGN",atom("LEFT"))],[]),
  		 	 img  ([doc_att("SRC",lit(PicID))]),
  		 	 br,hr([]),
  		 	 input([doc_att("type",atom("submit")),
  		 	        doc_att("name",lit("BeginConsult")),
  		 	        doc_att("value",lit("Begin Consultation"))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	 	doc_att("name",lit("SessionID")),
  		 	 	doc_att("value",lit(SID))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("TitlePage"))])
  		 	]
  		     )
  		]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	set_cur_page (SID,"TitlePage"),
  	html_term (HTML,Doc),
  	report (SID,HTML).

  dlg_text_start (SID,Text) :-
  	get_esta_page_header (SID,Title),
  	Body = doc_body ([doc_att("background",lit("images/grytxtr5.jpg"))],
  		[par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		 hr([]),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 par([doc_att("ALIGN",atom("LEFT"))],[]),
  		 	 preformatted ([],[txt(Text)]),
  		 	 br,hr([]),
  		 	 input([doc_att("type",atom("submit")),
  		 	        doc_att("name",lit("BeginConsult")),
  		 	        doc_att("value",lit("Begin Consultation"))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	 	doc_att("name",lit("SessionID")),
  		 	 	doc_att("value",lit(SID))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("TitlePage"))])
  		 	]
  		     )
  		]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	set_cur_page (SID,"TitlePage"),
  	report (SID,HTML).
