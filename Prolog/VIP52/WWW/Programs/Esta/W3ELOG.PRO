/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3ELOG.PRO
 Purpose: WWW version of ESTA
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "w3esta.inc"

DOMAINS

  OBJECT = strobject(string OWHER,string Text);
           picobject(string OWNER,string Pic)

DATABASE - log
  multiobject(SID,OBJECT)
  logitem(SID,li)

PREDICATES
  add_to_multilog(SID,string WHO,LOGOBJECT)

CLAUSES
%  close_log (_SID) :- retractall(_,log).

  show_log (SID) :-
  	multiobject(SID,OBJECT),
  		OBJECT = strobject(WHO,STR),
  		assert (logitem(SID,dt([],[b(1),txt(WHO),b(0)]))),
  		assert (logitem(SID,dd([],[txt(STR)]))),
  	fail.
  show_log (SID):-
  	findall (LI,logitem(SID,LI),LI_LIST),
  	get_esta_page_header (SID,Title),
  	txt("cons_logfile",LOG),
  	Body = doc_body ([doc_att("background",lit("images/grytxtr5.jpg"))],
  		[par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		 par([doc_att("ALIGN",atom("LEFT"))],[font(1,[doc_att("SIZE",num(4))]),txt(LOG),font(0,[])]),
  		 hr([]),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 dl([],lh([],[]),LI_LIST),
  		 	 br,hr([]),
  		 	 input([doc_att("type",atom("submit")),doc_att("name",atom("Continue")),doc_att("value",atom("Continue"))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("SessionID")),
  		 	        doc_att("name",lit(SID))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("LogPage"))])
  		 	]
  		     )
  		]),
  	Doc = doc ("",[doc_title(Title)],Body),
  	html_term (HTML,Doc),
  	report (SID,HTML).

  
  /* Add text to dialog window */

  add_log_questansw(SID,WHO,STR):- add_to_multilog(SID,WHO,str(STR)).

  add_log_pic(SID,PIC) :- add_to_multilog(SID,"",pic(PIC)).

  add_log_adv_pic(SID,PIC) :- add_to_multilog(SID,"",pic(PIC)).

  add_log_adv_str(SID,STR) :- add_to_multilog(SID,"advice",str(STR)).

  add_log_titl_str(SID,STR) :- add_to_multilog(SID,"",str(STR)).

  add_log_titl_pic(SID,PIC) :- add_to_multilog(SID,"",pic(PIC)).

  /* Add text to multidialog window */

  add_to_multilog(_,_,str("")):-!. % nothing to add
  /*
  add_to_multilog(WHO,str(STR)):-
	searchchar (STR,'\n',POS),
	P1 = POS-1,
	frontstr (P1,STR,FRONT,REST0),
	frontstr (1,REST0,_,REST),!,
	assert(multiobject(strobject(WHO,FRONT))),
	add_to_multilog(WHO,str(REST)).
*/
  add_to_multilog(SID,WHO,str(STR)):- !,
  	assert(multiobject(SID,strobject(WHO,STR))).
/*  
add_to_multilog(pic(PIC)):-
  getpic(log_ext,PIC,PICTYPE,_,_,_),!,
  assert(multiobject(picobject(PIC,PICTYPE))),upd_log.
  
add_to_multilog(pic(PIC)):-
  concat(PIC,"\r\n",PICNL),
  assert(multiobject(strobject(PICNL))),!,upd_log.
*/  
  add_to_multilog(_,_,_).

