/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3ESTA
 FileName: W3EADV.PRO
 Purpose: WWW version of ESTA
 Written by:
 Comments:
 14.12.97  Add multiuser support (Per session's subsets defined)
******************************************************************************/
include "w3esta.inc"

DOMAINS
   OBJECT = strobject(string); picobject(string PicName)

DATABASE - adv
   multiobject(SID,OBJECT)
   adv_par (SID,doc_flow_element)

/******************* Create the multidialog window   *****************/    

PREDICATES
   multiadv_dlg(SID)
   send_log_inf(SID,OBJECT,string)
   make_adv_par(SID,OBJECT)
   adv_header (SID,doc_Flow)
CLAUSES
  multiadv_dlg (SID):-
  	retractall (adv_par(SID,_)),
     	multiobject(SID,OBJ),
     		send_log_inf(SID,OBJ,"log"),
     		make_adv_par(SID,OBJ),
     	fail.
  multiadv_dlg (SID):-
  	inreplay(SID),!,	% dont show advices
  	clear_advice(SID).	% while in replay mode
  multiadv_dlg (SID):-
     	adv_Header (SID,AdvHeader),
	findall(P,adv_par(SID,P),PAR_LIST),
  	Flow =	[div([],AdvHeader),
  		 form(
  		      [doc_att("ACTION",lit("W3ESTA.DLL")),doc_att("METHOD",atom("POST"))],
  		 	[
  		 	 div([],PAR_LIST),
  		 	 br,hr([]),
  		 	 %input([doc_att("type",atom("submit")),doc_att("name",atom("Continue")),doc_att("value",atom("Continue"))]),
  		 	 input([doc_att("type",atom("submit")),doc_att("name",atom("Why")),doc_att("value",atom("Why"))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("SessionID")),
  		 	        doc_att("value",lit(SID))]),
  		 	 input([doc_att("type",atom("hidden")),
  		 	        doc_att("name",lit("ESTAcommand")),
  		 	        doc_att("value",lit("AdvicePage"))])
  		 	]
  		     )
  		],
  	html_Flow("",Flow,"",HTML),
  	report (SID,HTML),
  	set_cur_page (SID,"AdvicePage"),
  	clear_advice(SID).
  	
  clear_advice(SID) :- 
  	retractall(multiobject(SID,_)),
   	retractall(adv_par(SID,_)).
  
  adv_header (SID,[]) :- cur_Page(SID,"AdvicePage"),!.
  adv_Header (SID,AdvHeader) :-
       	get_esta_page_header (SID,Title),
     	txt("adv",ADV),
  	AdvHeader = [par([doc_att("ALIGN",atom("RIGHT"))],[cite(1),txt(Title),cite(0)]),
  		     par([doc_att("ALIGN",atom("LEFT"))],[font(1,[doc_att("SIZE",num(5))]),txt(ADV),font(0,[])]),
  		     hr([])].
     
  send_log_inf(SID,picobject(PIC),"log"):- add_log_adv_pic(SID,PIC),!.
  send_log_inf(SID,strobject(STR),"log")  :- 
  	txt("adv_name",ADVNAME),
  	format (ADVICE,"%s: %s",ADVNAME,STR),
  	add_log_adv_str(SID,ADVICE),!.
  send_log_inf(SID,strobject(STR),"log")  :- 
  	add_log_adv_str(SID,STR),!.
  send_log_inf(_,_,_).
  
  make_adv_par (SID,strobject(STR)) :-
  	break_text (STR,BSTR),
  	PAR = par([doc_att("ALIGN",atom("LEFT"))],[txt(BSTR)]),
  	assert(adv_par(SID,PAR)).
  	%make_adv_text_par (STR).
  make_adv_par (SID,picobject(STR)) :-
  	PAR = img([doc_att("SRC",lit(STR))]),
  	assert(adv_par(SID,PAR)).
  %
  %  break text object into paragraphs
  %
  /*
  make_adv_text_par ("") :-!.
  make_adv_text_par (STR) :-
  	searchchar (STR,'\n',POS),
  	frontstr (POS,STR,FRONT,REST),
  	PAR = par([doc_att("ALIGN",atom("LEFT"))],[txt(FRONT)]),
  	assert(adv_par(PAR)),
  	skip_blanks (REST,REST1),!,
  	make_adv_text_par (REST1).
  make_adv_text_par (STR) :-
  	PAR = par([doc_att("ALIGN",atom("LEFT"))],[txt(STR)]),
  	assert(adv_par(PAR)).
  */
 DATABASE - advstr
   advice_strl(SID,slist) % The total advice
   tmp_str(SID,string)    % Used to store temporary strings

PREDICATES
   add_to_multiadv(SID,LOGOBJECT)    
   wr_advice2(SID,SLIST)
   assert_advice(SID,string)
   collect_txt(SID)
CLAUSES
   wradvice1(SID,_) :-
     	retractall(tmp_str(SID,_)),
     	retract(advice_strl(SID,SL)),
         	wr_advice2(SID,SL),
     	fail.
   wradvice1(SID,_LOG) :-
     	collect_txt(SID),
     	multiadv_dlg(SID).

   wr_advice2(_,[])     :- !.
   wr_advice2(SID,[F|R])  :- assert_advice(SID,F),wr_advice2(SID,R).
     
   assert_advice(_,"")  :- !.  
   assert_advice(SID,STR):- 
     	trap(frontstr(3,STR,PIC,NAME),_,fail),PIC = "pic",
     	collect_txt(SID),
     	add_to_multiadv(SID,pic(NAME)),!.
   assert_advice(SID,STR):- 
     	assert(tmp_str(SID,STR)).

   collect_txt (SID):-
     	findall(STR,tmp_str(SID,STR),STRL),
     	not(STRL = []),!,
     	strl_str(STRL,STR1),
     	add_to_multiadv(SID,str(STR1)),
     	retractall(tmp_str(SID,_)).
   collect_txt(_).   
    
   store_advice(SID,STRL):- assert(advice_strl(SID,STRL)).

/* Add text to multidialog window */

   add_to_multiadv(_,str("")) :- !. % nothing to add
   add_to_multiadv(SID,str(STR)):- !, % string object
     	assert(multiobject(SID,strobject(STR))).
   add_to_multiadv(SID,pic(PIC)):- !, % picture object
     	make_picture_file_name(PIC,PICNAME),
     	assert(multiobject(SID,picobject(PICNAME))).
   add_to_multiadv(_,_).

