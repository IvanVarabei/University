/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3EDLG.PRO
 Purpose: ISAPI ESTA Engine  (Consultation Dialogs)
 Written by: Oleg V. Erjomin
 Comments:
 14.12.97	Add multiuser support
******************************************************************************/

include "w3esta.inc"

DATABASE - tmp_pic
  dlg_picture(SID,STRING)

PREDICATES
  get_dlg_picture(SID,STRING)

CLAUSES
  chng_picture(SID,P) :- retractall(dlg_picture(SID,_)),assert(dlg_picture(SID,P)).
   
  get_dlg_picture(SID,A) :- dlg_picture(SID,A),!.

/**************************************************************************
 *   CONSULT DIALOGS                                                      *
 **************************************************************************/
PREDICATES
  create_consult_dlg (SID,string ID, string Ask, SLIST)
  replay_dlg         (SID,string ID, SLIST, string Answer)
  dlg_cat_quest_txt  (SID,string ASKSTR,slist ITEMLIST)
  dlg_cat_quest_pic  (SID,string ASKSTR,slist ITEMLIST)
  dlg_std_quest_txt  (SID,string ASKSTR)
  dlg_std_quest_pic  (SID,string ASKSTR)
  dlg_edit_quest_txt (SID,string ASKSTR)
  dlg_edit_quest_pic (SID,string ASKSTR)

CLAUSES
 
  create_consult_dlg(SID,"listbox",ASKSTR,ITEMLIST):-  !,
	dlg_cat_quest_txt (SID,ASKSTR,ITEMLIST).

  create_consult_dlg(SID,"pic_listbox",ASKSTR,ITEMLIST):-  !,
	dlg_cat_quest_pic (SID,ASKSTR,ITEMLIST).

  create_consult_dlg(SID,"boolean",ASKSTR,_ITEMLIST):- !,  
	dlg_std_quest_txt (SID,ASKSTR).

  create_consult_dlg(SID,"pic_boolean",ASKSTR,_ITEMLIST):- !,  
	dlg_std_quest_pic (SID,ASKSTR).

  create_consult_dlg(SID,"edit",ASKSTR,_ITEMLIST):-  !,
   	dlg_edit_quest_txt (SID,ASKSTR).

  create_consult_dlg(SID,"pic_edit",ASKSTR,_ITEMLIST):-  !,
   	dlg_edit_quest_pic (SID,ASKSTR).
   	
  replay_dlg(SID,"listbox",ITEMLIST,ANSWER) :- !,
  	continue_catquest (SID,ITEMLIST,ANSWER).
  replay_dlg(SID,"pic_listbox",ITEMLIST,ANSWER) :- !,
  	continue_catquest (SID,ITEMLIST,ANSWER).
  replay_dlg(SID,"boolean",_ITEMLIST,ANSWER) :- !,
  	continue_stdquest (SID,ANSWER).
  replay_dlg(SID,"pic_boolean",_ITEMLIST,ANSWER) :- !,
  	continue_stdquest (SID,ANSWER).
  replay_dlg(SID,"edit",_ITEMLIST,ANSWER) :- !,
  	continue_editquest (SID,ANSWER).
  replay_dlg(SID,"pic_edit",_ITEMLIST,ANSWER) :- !,
  	continue_editquest (SID,ANSWER).

  consult_dlg(SID,DLG_ID,_ASKSTR,ITEMLIST):-
  	replay(SID,ANS_PATH),
  	not(ANS_PATH = []),!,
  	ANS_PATH = [LASTANSWER|REST],
  	retractall(replay(SID,_)),
  	assert(replay(SID,REST)),
  	retractall(inreplay(SID)),
  	assert(inreplay(SID)),
  	replay_dlg(SID,DLG_ID,ITEMLIST,LASTANSWER).
  consult_dlg(SID,_,_,_) :-
  	retract(inreplay(SID)),!.		% dont show last success dialog
  consult_dlg(SID,DLG_ID,ASKSTR,ITEMLIST):-!,
     	clear_0D (ASKSTR,ASKSTR1),
     	create_consult_dlg(SID,DLG_ID,ASKSTR1,ITEMLIST).

/******************************************************
   Consultation HTML pages generator
 ******************************************************/
PREDICATES
  consult_buttons   (doc_flow)
  std_quest_buttons (doc_flow)
  select_control    (slist,doc_flow_element)
  make_option_list  (slist,option_list,option_list)
  picture_field     (SID,doc_flow)
  dlg_Head          (SID,doc_flow)
  page_hidden_fields(SID,doc_flow)
CLAUSES
  %
  %  Generate controls common for all dialogs
  %
  consult_buttons (BUTTONS) :-
  	txt("explain",Explain),
  	txt("why",Why),
  	txt("continue",Continue),
  	BUTTONS = [hr([]),
  		input([doc_att("type",atom("submit")),doc_att("name",atom("Explain")),doc_att("value",lit(Explain))]),
  		input([doc_att("type",atom("submit")),doc_att("name",atom("Why")),doc_att("value",lit(Why))]),
  		input([doc_att("type",atom("submit")),doc_att("name",atom("Continue")),doc_att("value",lit(Continue))])
  		   ].
  		   
  select_control (ITEMLIST,SELECT) :-
  	listlen (ITEMLIST,LISTLEN),
  	ve_min (LISTLEN,10,CTRLLEN),
  	make_option_list (ITEMLIST,[],OPT_LIST),
  	SELECT = select ([doc_att("name",atom("Option")),doc_att("size",num(CtrlLen))],OPT_LIST).
  	
  make_option_list ([],OPTS,REVOPTS_2) :- !,
  	reverse (OPTS,REVOPTS_1),
  	REVOPTS_1=[doc_option(_,H)|T],
  	REVOPTS_2=[doc_option([doc_att("selected",nill)],H)|T].
  make_option_list ([H|T],BUFF,OPTS) :-	make_option_list (T,[doc_option([],H)|BUFF],OPTS).
  
  std_quest_buttons (BUTTONS) :-
  	txt("aux_yes",Yes),
  	txt("aux_no",No),
  	txt("aux_unknown",Unknown),
  	BUTTONS = [
  		par([],[input([doc_att("type",atom("radio")),
  		               doc_att("name",atom("StdQuestRadio")),
  		               doc_att("value",atom("1")),
  		               doc_att("checked",nill)]),txt(Yes)]),
  		par([],[input([doc_att("type",atom("radio")),
  		               doc_att("name",atom("StdQuestRadio")),
  		               doc_att("value",atom("2"))]),txt(No)]),
  		par([],[input([doc_att("type",atom("radio")),
  		               doc_att("name",atom("StdQuestRadio")),
  		               doc_att("value",atom("3"))]),txt(Unknown)])
  		   ].
  
  picture_field (SID,[PIC]) :-
  	get_dlg_picture (SID,PICNAME),
  	make_picture_file_name (PICNAME,PICFILENAME),
  	PICFILENAME <> "",!,
  	PIC = img([doc_att("src",lit(PICFILENAME))]).
  picture_field (_,[]).
  
  dlg_Head (SID,Head) :-
  	Quest = "Question",
  	cur_page (SID,"AdvicePage"),!,
  	Head = [par([doc_att("ALIGN",atom("LEFT"))],[font(1,[doc_att("SIZE",num(5))]),txt(Quest),font(0,[])]),
  	        hr([])].
  dlg_Head (SID,Head) :-
  	Quest = "Question",
  	get_esta_page_header (SID,Title),
	Head = [par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		par([doc_att("ALIGN",atom("LEFT"))],[font(1,[doc_att("SIZE",num(5))]),txt(Quest),font(0,[])]),
  		hr([])].
  		
  page_hidden_fields (SID,Hidden) :-
  	answers (SID,ANSWERS),!,
  	reverse(ANSWERS,ANS_PATH),
  	term_str(slist,ANS_PATH,ANS_STR),
  	str_to_url(URL_ANS_STR,ANS_STR),
  	Hidden =
  		[ 
 	 	  input([doc_att("type",atom("hidden")),
  		 	 doc_att("name",lit("SessionID")),
  		 	 doc_att("value",lit(SID))]),
  		  input([doc_att("type",atom("hidden")),
  		 	 doc_att("name",lit("ans_path")),
  		 	 doc_att("value",lit(URL_ANS_STR))])
  		 ].
  		         
  %----------------  CATEGORY ------------------------------------------
  %
  %  Category question dialog without picture
  %
  dlg_cat_quest_txt (SID,ASKSTR,ITEMLIST0) :-
  	trim_slist(ITEMLIST0,ITEMLIST),
  	select_control (ITEMLIST,SELECT),
  	term_str(slist,ITEMLIST,SITEMS),
  	consult_buttons (BUTTONS),
  	dlg_Head (SID,Head),
	str_to_url(URL_SITEMS,SITEMS),
  	page_hidden_fields(SID,Hidden),
  	Flow =	[div ([],Head),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 table([doc_att("BORDER",nill)],caption([],[]),
  		 	   [trow([],[td([],[txt(ASKSTR)])]),	% Prompt
  		 	    trow([],[td([doc_att("align",atom("top")),doc_att("valign",atom("left"))],
  		 	                [SELECT|BUTTONS])])	% control area
  		 	   ] 
  		 	 ),
  		 	 par([],Hidden),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("sitems")),
  		 	        doc_att("value",lit(URL_SITEMS))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("CatQuestPage"))])
  		 	]
  		     )
  		],
  	html_Flow("",Flow,"",HTML),
  	set_cur_page (SID,"CatQuestPage"),
  	report (SID,HTML).
  %
  %  Category question dialog with picture
  %
  dlg_cat_quest_pic (SID,ASKSTR,ITEMLIST0) :-
  	trim_slist(ITEMLIST0,ITEMLIST),
  	select_control (ITEMLIST,SELECT),
  	term_str(slist,ITEMLIST,SITEMS),
  	consult_buttons (BUTTONS),
  	picture_field (SID,PICFIELD),
	str_to_url(URL_SITEMS,SITEMS),
  	page_hidden_fields(SID,Hidden),
  	dlg_Head (SID,Head),
  	Flow =	[div([],Head),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 table([doc_att("BORDER",nill)],caption([],[]),
  		 	   [trow([],[td([],[txt(ASKSTR)]),	% Prompt
  		 	             td([doc_att("rowspan",num(2))],PICFIELD)
  		 	            ]),	
  		 	    trow([],[td([doc_att("align",atom("top")),doc_att("valign",atom("left"))],
  		 	                [SELECT|BUTTONS])])	% control area
  		 	   ] 
  		 	 ),
  		 	 par([],Hidden),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("sitems")),
  		 	        doc_att("value",lit(URL_SITEMS))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("CatQuestPage"))])
  		 	]
  		     )
  		],
  	html_Flow("",Flow,"",HTML),
  	set_cur_page (SID,"CatQuestPage"),
  	report (SID,HTML).
  %--------------------- EDIT ----------------------------------	
  %
  %  Edit question dialog without picture
  %
  dlg_edit_quest_txt (SID,ASKSTR) :-
  	EDIT = input([doc_att("type",atom("text")),
  	              doc_att("name",atom("Edit")),
  	              doc_att("value",lit("")),
  	              doc_att("tabindex",lit("1"))]),
  	consult_buttons (BUTTONS),
  	dlg_Head (SID,Head),
  	page_hidden_fields(SID,Hidden),
  	Flow =	[div([],Head),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 table([doc_att("BORDER",nill)],caption([],[]),
  		 	   [trow([],[td([],[txt(ASKSTR)])]),	% Prompt
  		 	    trow([],[td([doc_att("align",atom("top")),doc_att("valign",atom("left"))],
  		 	                [EDIT|BUTTONS])])	% control area
  		 	   ] 
  		 	 ),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("EditQuestPage"))]),
  		 	 par([],Hidden)
  		 	]
  		     )
  		],
  	html_Flow("",Flow,"",HTML),
  	set_cur_page (SID,"EditQuestPage"),
  	report (SID,HTML).
  %
  %  Edit question dialog with picture
  %
  dlg_edit_quest_pic (SID,ASKSTR) :-
  	EDIT = input([doc_att("type",atom("text")),doc_att("name",atom("Edit")),doc_att("value",lit(""))]),
  	consult_buttons (BUTTONS),
  	picture_field (SID,PICFIELD),
  	page_hidden_fields(SID,Hidden),
  	dlg_Head(SID,Head),
  	Flow =	[div([],Head),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 table([doc_att("BORDER",nill)],caption([],[]),
  		 	   [trow([],[td([],[txt(ASKSTR)]),	% Prompt
  		 	             td([doc_att("rowspan",num(2))],PICFIELD)
  		 	            ]),	
  		 	    trow([],[td([doc_att("align",atom("top")),doc_att("valign",atom("left"))],
  		 	                [EDIT|BUTTONS])])	% control area
  		 	   ] 
  		 	 ),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("EditQuestPage"))]),
  		 	 par([],Hidden)
  		 	]
  		     )
  		],
  	html_Flow("",Flow,"",HTML),
  	set_cur_page (SID,"EditQuestPage"),
  	report (SID,HTML).
  	
  %----------------  STANDARD ------------------------------------------
  %
  %  Standard question dialog without picture
  %
  dlg_std_quest_txt (SID,ASKSTR) :-
  	std_quest_buttons (StdButtons),
  	consult_buttons (BUTTONS),
  	append (StdButtons,Buttons,AllControls),!,
  	page_hidden_fields(SID,Hidden),
  	dlg_Head(SID,Head),
  	Flow =	[div([],Head),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 table([doc_att("BORDER",nill)],caption([],[]),
  		 	   [trow([],[td([],[txt(ASKSTR)])]),	% Prompt
  		 	    trow([],[td([doc_att("align",atom("top")),doc_att("valign",atom("left"))],
  		 	                AllControls)])		% control area
  		 	   ] 
  		 	 ),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("StdQuestPage"))]),
  		 	 par([],Hidden)
  		 	]
  		     )
  		],
  	html_Flow("",Flow,"",HTML),
  	set_cur_page (SID,"StdQuestPage"),
  	report (SID,HTML).
  %
  %  Standard question dialog with picture
  %
  dlg_std_quest_pic (SID,ASKSTR) :-
  	std_quest_buttons (StdButtons),
  	consult_buttons (BUTTONS),
  	append (StdButtons,Buttons,AllControls),!,
  	picture_field (SID,PICFIELD),
  	page_hidden_fields(SID,Hidden),
  	dlg_Head (SID,Head),
  	Flow =	[div([],Head),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 table([doc_att("BORDER",nill)],caption([],[]),
  		 	   [trow([],[td([],[txt(ASKSTR)]),	% Prompt
  		 	             td([doc_att("rowspan",num(2))],PICFIELD)
  		 	            ]),	
  		 	    trow([],[td([doc_att("align",atom("top")),doc_att("valign",atom("left"))],
  		 	                AllControls)])		% control area
  		 	   ] 
  		 	 ),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("StdQuestPage"))]),
  		 	 par([],Hidden)
  		 	]
  		     )
  		],
  	html_Flow("",Flow,"",HTML),
  	set_cur_page (SID,"StdQuestPage"),
  	report (SID,HTML).
  	
/******************************************************
    CONSULT DIALOG's ACTIONS
******************************************************/
CLAUSES
  continue_catquest (SID,ITEMLIST,Answer) :-
  	add_answer_to_path (SID,Answer),
  	list_get_index (Answer,ITEMLIST,Idx),
  	store_cat (SID,Idx),
  	inferencemachine (SID,change).
  
  continue_stdquest (SID,Answer) :-
  	add_answer_to_path (SID,Answer),
  	str_int (Answer,Fact),
  	store_fact (SID,Fact),
  	inferencemachine (SID,change).
  
  continue_editquest (SID,Answer) :-
  	add_answer_to_path (SID,Answer),
  	store_answer (SID,Answer),
  	inferencemachine (SID,change).
  	
  display_file_dlg (SID,Text,FN) :-
  	get_esta_page_header (SID,Title),
  	Body = doc_body ([doc_att("background",lit("images/grytxtr5.jpg"))],
  		[par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		 par([doc_att("ALIGN",atom("LEFT"))],[b(1),txt(FN),b(0)]),
  		 hr([]),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	par([doc_att("ALIGN",atom("LEFT"))],[]),
  		 	preformatted ([],[txt(Text)]),
  		 	br,hr([]),
  		 	input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("SessionID")),
  		 	        doc_att("value",lit(SID))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("DisplayPage"))])
  		 	]
  		     )
  		]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	set_cur_page (SID,"StdQuestPage"),
  	report (SID,HTML).
  	
  	
  	
