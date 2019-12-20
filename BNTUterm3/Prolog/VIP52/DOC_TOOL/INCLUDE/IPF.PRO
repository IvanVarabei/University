/******************************************************************************

                 Copyright (C) 1984 - 2000 Prolog Development Center A/S

				VISUAL PROLOG

 File name: IPF.PRO
 PURPOSE  : IPF to/from Prolog converter

 COMMENTS:  Implements ipf_term (o,i) (i,i) (o,o)

 Written by Oleg V. Erjomin

******************************************************************************/
ifndef ipf_Pre_Included
 #Error : file ipf.pre must be included
enddef

constants ipf_pro_included = 1

GLOBAL PREDICATES
  procedure ipf_movemem(ulong,ulong,unsigned) - (i,i,i) language c as "_MEM_MovMem"    

DATABASE - ipf_cur_format_internal
  determ ipf_bold
  determ ipf_italic
  determ ipf_underline
  determ ipf_cur_hp (integer)
  determ ipf_in_List
  determ ipf_intbl
  determ ipf_font (string)

DATABASE - ipf_doc_info
   ipf_doc_source (string)
   ipf_doc_units (string)

PREDICATES
  procedure ipf_reset_Wrap   (integer)
  procedure ipf_need_Wrap    (string, string)
  determ    ipf_att_member   (doc_att,doc_attlist)
  determ    ipf_lcase_member (string,cdatalist)
  determ    ipf_str_val      (doc_attval,string)
  procedure ipf_att_exclude  (string, doc_attlist, doc_attlist)
  procedure ipf_list_cat (doc_attlist,doc_attlist,doc_attlist)
  procedure ipf_list_cat (trow_list,trow_list,trow_list)
  procedure ipf_maxint       (integer,integer,integer)  
PREDICATES
  procedure ipf_make_Head (doc_head,string,string)
  procedure ipf_head_Txt  (doc_headelem,string)

  procedure ipf_make_AttTag     (string Key, doc_attlist, string Buff, string Tag)
  procedure ipf_make_BoolTag    (string Key, bool Val, string Tag)
  procedure ipf_close_Tag       (string Tag, string Txt)
  procedure ipf_make_OpenBlock  (string Key, doc_attlist, doc_flow, string Txt)
  procedure ipf_make_CloseBlock (string Key, doc_attlist, doc_flow, string Txt)
  

CLAUSES
  %
  %  ipf_term (o,i)
  %
  make_ipf_doc (IPF,DOC) :- 
	Doc = doc (_Doctype,Head,Body),
	retractall (_,ipf_doc_info),
	assert (ipf_doc_source("IPF")),
	assert (ipf_doc_units("CHAR")),
	ipf_ApplyDocInfo (Head),
	ipf_make_Head (Head,"",DocHead),
	ipf_reset_Wrap (0),
	retractall (_,ipf_cur_format_internal),
	Body = doc_body(_Attlist,Flow),
	ipf_Flow (Flow,"",DocBody),
	format (IPF,":userdoc.\n%s%s\n:euserdoc.",DocHead,DocBody).
  %
  %  ipf_term (i,i)
  %
  unify_ipf_doc (HTML,DOC) :-
	ipf_term (HTML,DOC_1),
	DOC = DOC_1.
  %
  %  ipf_term (o,o)
  %
  gen_ipf_doc (HTML,DOC) :-
	DOC = doc("",[],doc_body([],[])),
	make_ipf_doc (HTML,DOC).
  %
  %  Apply Document meta information (source,units)
  %
  ipf_ApplyDocInfo ([]).
  ipf_ApplyDocInfo ([H|T]) :-
  	H=doc_meta(Attlist),
  	ipf_att_member (doc_att("name",A1),Attlist),
  	A1=lit(N),
  	upper_lower(N,"source"),
  	ipf_att_member (doc_att("content",A2),Attlist),
  	A2=lit(C),
  	upper_lower (USOURCE,C),
  	retractall (ipf_doc_source(_)),
  	assert (ipf_doc_source(USOURCE)),!,
  	ipf_ApplyDocInfo (T).
  ipf_ApplyDocInfo ([H|T]) :-
  	H=doc_meta(Attlist),
  	ipf_att_member (doc_att("name",A1),Attlist),
  	A1=lit(N),
  	upper_lower(N,"units"),
  	ipf_att_member (doc_att("content",A2),Attlist),
  	A2=lit(C),
  	upper_lower (UUNITS,C),
  	retractall (ipf_doc_source(_)),
  	assert (ipf_doc_source(UUNITS)),!,
  	ipf_ApplyDocInfo (T).
  ipf_ApplyDocInfo ([_|T]) :- !,
  	ipf_ApplyDocInfo (T).
  %
  %  ipf_make_Head/3 - Constructs the document's head
  %
  ipf_make_Head ([],DocHead,DocHead).
  ipf_make_Head ([H|T],Buff,DocHead) :-
	ipf_head_Txt (H,Txt),
	concat (Buff,Txt,Buff_1),
	ipf_make_Head (T,Buff_1,DocHead).
/******************************************************
 *   Predicates to convert head elements into the     *
 *   IPF strings                                      *
 ******************************************************/
CLAUSES
  ipf_head_Txt (doc_title(Str),Txt) :- !,
	format (Txt,":title.%s\n",Str).
  ipf_head_Txt (Other,Txt) :-
  	term_str (doc_headelem,Other,TxtTag),
  	format (Txt,"\n.* %s\n",TxtTag).
  	
/******************************************************
 *  Predicates to convert body elements into the      *
 *  IPF string                                        *
 ******************************************************/
PREDICATES
  procedure ipf_flow_Txt (doc_flow_element,string Txt)
  procedure hp (string,string)
  procedure ehp (string,string)
  procedure ipf_makeNote      (doc_attlist,doc_flow,string Txt)
  procedure ipf_make_List     (string Key, doc_attlist, lh ,li_List, string Txt)
  procedure ipf_make_Table    (doc_attlist,caption,trow_List,string Txt)
  procedure ipf_make_Link     (doc_attlist,doc_flow,string Txt)
  procedure ipf_make_Artwork  (doc_attlist,string Txt)
  procedure ipf_make_Artlink  (area_list,string Txt)
  procedure ipf_make_FontTag  (doc_attlist,string Txt)
  procedure ipf_make_ColorTag (doc_attlist,string Txt)

  procedure ipf_flow_slist(doc_flow,slist)

  procedure ipf_slist_string(slist,string)
  procedure ipf_calc_slist_len(slist,integer,integer)
  procedure ipf_concat_strings(slist,ushort,unsigned)
  procedure ipf_get_thead_rows(thead_list Theads,trow_list Buff,trow_list Rows)
  procedure ipf_get_tfoot_rows(tfoot_list Tfoots,trow_list Buff,trow_list Rows)
  procedure ipf_get_tbody_rows(tbody_list Tbodies,trow_list Buff,trow_list Rows)

CLAUSES
  %
  %  ipf_Flow/4 - loop to convert text flow into HTML string
  %
  ipf_Flow (Flow,_,FlowTxt):-
  	ipf_flow_slist(Flow,SL),
  	ipf_slist_string(SL,FlowTxt).

  ipf_flow_slist([],[]).
  ipf_flow_slist([H|T],[HTxt|Tail]):-
  	ipf_flow_Txt(H,HTxt),
  	ipf_flow_slist(T,Tail).
  %
  %  C-like slist to string conversion
  %  Avoids concat/3's gstack eating 
  %
  ipf_slist_string(SL,Txt):-  	
  	ipf_calc_slist_len(SL,0,Len),
  	Len1=Len+1,
  	str_len(Txt,Len1),
  	ptr_dword(Txt,SEG,OFF),
  	ipf_concat_strings(SL,SEG,OFF).

  ipf_calc_slist_len ([],L,L).
  ipf_calc_slist_len ([H|T],L,Len):-
   	str_len(H,L0),
   	L1=L+L0,!,
   	ipf_calc_slist_len(T,L1,Len).
   	
  ipf_concat_strings([],SEG,OFF):-
   	Pos=OFF+1,
   	membyte(SEG,Pos,0).
  ipf_concat_strings([H|T],SEG,OFF):-
   	str_len(H,Len),
   	Src=cast(ulong,H),
   	ptr_dword(PNew,SEG,OFF),
   	Dest=cast(ulong,PNew),
	ipf_movemem(Src,Dest,Len),
	OFF1=OFF+Len,
	ipf_concat_strings(T,SEG,OFF1).	  
  %
  %  ipf_Flow_Txt/2 - converts the flow_element into the string
  %
  ipf_flow_Txt (txt(Str),Txt) :- !, ipf_need_wrap (Str,Txt).
  %  inline elements  
  ipf_flow_Txt (b(1),Txt):- !,hp("B",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (u(1),Txt):- !,hp("U",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (i(1),Txt):- !,hp("I",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (em(1),Txt):- !,hp("I",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (strong(1),Txt):- !,hp("B",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (b(0),Txt):- !,ehp("B",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (u(0),Txt):- !,ehp("U",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (i(0),Txt):- !,ehp("I",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (em(0),Txt):- !,ehp("I",Tag),ipf_need_Wrap (Tag,Txt).
  ipf_flow_Txt (strong(0),Txt):- !,ehp("B",Tag),ipf_need_Wrap (Tag,Txt).
  %
  %  font handling. If we are in table then :font. have not written
  %
  ipf_flow_Txt (font(1,Attlist),ColorTag) :- 
  	ipf_intbl,!,
  	ipf_make_FontTag (Attlist,FontTag),
  	ipf_make_ColorTag (Attlist,ColorTag),
  	retractall (ipf_font(_)),
  	assert (ipf_font(FontTag)).
  ipf_flow_Txt (font(1,Attlist),Txt) :- !,
  	ipf_make_FontTag (Attlist,FontTag),
  	ipf_make_ColorTag (Attlist,ColorTag),
  	concat (FontTag,ColorTag,Txt),
  	retractall (ipf_font(_)),
  	assert (ipf_font(FontTag)).
  ipf_flow_Txt (font(0,_Attlist),ColorTag) :-
  	ipf_intbl,!,
  	FontTag=":font facename=default.",
  	ColorTag=":color fc=default bc=default.",
  	retractall (ipf_font(_)),
  	assert (ipf_font(FontTag)).
  ipf_flow_Txt (font(0,_Attlist),Txt) :-!,
  	FontTag=":font facename=default.",
  	ColorTag=":color fc=default bc=default.",
  	concat (FontTag,ColorTag,Txt),
  	retractall (ipf_font(_)),
  	assert (ipf_font(FontTag)).
  %  Line break
  ipf_flow_Txt (br,"\n.br\n") :- !,ipf_reset_Wrap(0).
  ipf_flow_Txt (tab(_Attlist),Txt) :- !, ipf_need_Wrap (" ",Txt).
  %  Headings
  ipf_flow_Txt (heading(Level,Attlist,Flow),Txt) :- 
  	Flow=[a(AAttlist,AFlow)|Other],!,
  	str_int (SLevel,Level),
  	concat ("h",Slevel,Tag),
  	ipf_list_cat (Attlist,AAttlist,AAAttlist),
  	ipf_make_AttTag (Tag,AAAttlist,"",TagTxt),
  	ipf_Flow (AFlow,"",FlowTxt1),
  	ipf_Flow (Other,"",FlowTxt2),
  	format (Txt,"\n%s%s\n%s\n",TagTxt,FlowTxt1,FlowTxt2),
  	ipf_reset_Wrap(0).
  ipf_flow_Txt (heading(Level,Attlist,Flow),Txt) :- !,
  	str_int (SLevel,Level),
  	concat ("h",Slevel,Tag),
  	ipf_make_AttTag (Tag,Attlist,"",TagTxt),
  	ipf_Flow (Flow,"",FlowTxt),
  	format (Txt,"\n%s%s\n",TagTxt,FlowTxt),
        ipf_reset_Wrap(0).
  
  %  Block elements
  %  Paragraphs without any attributes
  ipf_flow_Txt (par(_Attlist,Flow),Txt) :- 
  	ipf_in_List,!,
	ipf_make_OpenBlock ("lp",[],Flow,Txt0),
  	ipf_need_Wrap (Txt0,Txt).
  ipf_flow_Txt (par(_Attlist,Flow),Txt) :- !,
	ipf_make_OpenBlock ("p",[],Flow,Txt0),
        ipf_need_Wrap (Txt0,Txt).
  ipf_flow_Txt (span(_Attlist,Flow),Txt):- !,
  	ipf_Flow (Flow,"",Txt0),
  	ipf_Need_Wrap(Txt0,Txt).
  ipf_flow_Txt (ins(_Attlist,Flow),Txt):- !,
  	ipf_Flow (Flow,"",Txt0),
  	ipf_Need_Wrap(Txt0,Txt).
  ipf_flow_Txt (del(_Attlist,Flow),Txt):- !,
  	ipf_Flow (Flow,"",Txt0),
  	ipf_Need_Wrap(Txt0,Txt).
  ipf_flow_Txt (note(Attlist,Flow),Txt) :- !,
  	ipf_MakeNote (Attlist,Flow,Txt).
  ipf_flow_Txt (preformatted(Attlist,Flow),Txt) :-!,
  	ipf_make_CloseBlock ("cgraphic",Attlist,Flow,Txt).
  %  Lists
  ipf_flow_Txt (ul(Attlist,LH,Li_list),Txt) :- 
  	ipf_att_member (doc_att("class",Val),Attlist),
	ipf_str_val (Val,"simple"),!,  	
  	ipf_att_exclude ("class",Attlist,NewAttlist),
  	ipf_make_List ("sl",NewAttlist,LH,Li_List,Txt).
  ipf_flow_Txt (ul(Attlist,LH,Li_list),Txt) :- !,
  	ipf_make_List ("ul",Attlist,LH,Li_List,Txt).
  ipf_flow_Txt (ol(Attlist,LH,Li_list),Txt) :- !,
  	ipf_make_List ("ol",Attlist,LH,Li_List,Txt).
  ipf_flow_Txt (dl(Attlist,LH,Li_list),Txt) :- 
   	ipf_att_member (doc_att("class",Val),Attlist),
	ipf_str_val (Val,"parml"),!,  	
  	ipf_att_exclude ("class",Attlist,NewAttlist),
  	ipf_make_List ("parml",NewAttlist,LH,Li_List,Txt).
  ipf_flow_Txt (dl(Attlist,LH,Li_list),Txt) :- !,
  	ipf_make_List ("dl",Attlist,LH,Li_List,Txt).
  %  Tables Footnotes Images
  ipf_flow_Txt (table4(Attlist,Caption,_Colgroups,Theads,Tfoots,Tbodies),Txt) :- !,
  	ipf_get_thead_rows(Theads,[],Rows1),
  	ipf_get_tfoot_rows(Tfoots,Rows1,Rows2),
  	ipf_get_tbody_rows(Tbodies,Rows2,RowList),
  	ipf_make_Table (Attlist,Caption,RowList,Txt).
  ipf_flow_Txt (table(Attlist,Caption,RowList),Txt) :- !,
  	ipf_make_Table (Attlist,Caption,RowList,Txt).
  ipf_flow_Txt (fn(Attlist,Flow),Txt) :- !,
  	ipf_make_CloseBlock ("fn",Attlist,Flow,Txt).
  ipf_flow_Txt (a(Attlist,Flow),Txt) :- !,
  	ipf_make_Link (Attlist,Flow,Txt).
  ipf_flow_Txt (img(Attlist),Txt) :- !,
        ipf_make_Artwork (Attlist,Txt).
 ipf_flow_Txt (map(_Attlist,AreaList),Txt) :- !,
  	ipf_make_Artlink (AreaList,Txt).
  
  %  Elements from wich only text flows are rendered if IPF
  ipf_flow_Txt (div(_Attlist,Flow),Txt) :-!,ipf_Flow (Flow,"",Txt).
  ipf_flow_Txt (applet(_Attlist,_Params,Flow),Txt) :-!,ipf_Flow (Flow,"",Txt).
  ipf_flow_Txt (address(_Attlist,Flow),Txt) :-!,ipf_Flow (Flow,"",Txt).
  ipf_flow_Txt (form(_Attlist,Flow),Txt) :-!,ipf_Flow (Flow,"",Txt).
  ipf_flow_Txt (blockquote(_Attlist,Flow),Txt) :-!,ipf_Flow (Flow,"",Txt).
  %
  %  Unsupported tags
  %
  ipf_flow_Txt (tag(Name,1,Attlist),Txt) :-
  	ipf_lcase_member (Name,["rm","lm","i1","i2","icmd","isyn",
                                "color","ctrl","ctrldef","ddf",
                                "docprof","hide","pbutton"]),!,
        ipf_make_AttTag (Name,Attlist,"",TagTxt),
        ipf_need_Wrap (TagTxt,Txt).
  ipf_flow_Txt (tag(Name,0,_Attlist),Txt) :-
  	ipf_lcase_member (Name,["ctrldef","hide"]),!,
        ipf_close_Tag (Name,TagTxt),
        ipf_need_Wrap (TagTxt,Txt).
  
  
  ipf_flow_Txt (Other,Txt) :- 
  	term_str (doc_flow_element,Other,Tag),
  	format (Txt,"\n.* %s\n",Tag).
/******************************************************
 *  Phrase highlighting control                       *
 ******************************************************/
PREDICATES
  determ    bold (bool)
  determ    italic (bool)
  determ    underline (bool)
  procedure set_HP (integer,string)
  procedure get_ipf_font(string)
CLAUSES
  %
  %  returns current font
  %
  get_ipf_font(CurFont):-ipf_font(CurFont),!.
  get_ipf_font("").
  %
  %  bold/1, italic/1, underline/1 - handle the internal formatting DB facts
  %
  bold (1) :- retractall(ipf_bold),assert(ipf_bold).
  bold (0) :- retractall(ipf_bold).
  	
  italic (1) :- retractall(ipf_italic),assert(ipf_italic).
  italic (0) :- retractall(ipf_italic).
  
  underline (1) :- retractall(ipf_underline),assert(ipf_underline).
  underline (0) :- retractall(ipf_underline).
  %
  %  set_HP/2 - handling the internal fact of text highlighting
  %
  set_hp (HP,Tag) :-
  	retract(ipf_cur_hp(PrevHP)),!,
  	assert (ipf_cur_hp(HP)),
  	format (Tag,":ehp%d.:hp%d.",PrevHP,HP).
  set_hp (HP,Tag) :-
  	assert (ipf_cur_hp(HP)),
  	format (Tag,":hp%d.",HP).
  %
  %  hp/2 - start phrase highlighting
  %
  %  bold
  hp ("B","")  :- ipf_bold,!.
  hp ("B",Tag) :- ipf_underline,ipf_italic,set_HP(7,Tag),bold(1),!. % I prefer UL+B
  hp ("B",Tag) :- ipf_italic,set_HP(3,Tag),bold(1),!.
  hp ("B",Tag) :- ipf_underline,set_HP(7,Tag),bold(1),!.
  hp ("B",Tag) :- set_HP(2,Tag),bold(1),!.
  % italic
  hp ("I","")  :- ipf_italic,!.
  hp ("I",Tag) :- ipf_underline,ipf_bold,set_HP(6,Tag),italic(1),!. % I prefer UL+I
  hp ("I",Tag) :- ipf_bold,set_HP(3,Tag),italic(1),!.
  hp ("I",Tag) :- ipf_underline,set_HP(6,Tag),italic(1),!.
  hp ("I",Tag) :- set_HP(1,Tag),italic(1),!.
  % underline
  hp ("U","")  :- ipf_underline,!.
  hp ("U",Tag) :- ipf_italic,ipf_bold,set_HP(7,Tag),underline(1),!. % I prefer UL+B
  hp ("U",Tag) :- ipf_italic,set_HP(6,Tag),underline(1),!.
  hp ("U",Tag) :- ipf_bold,set_HP(7,Tag),underline(1),!.
  hp ("U",Tag) :- set_HP(5,Tag),underline(1),!.
  hp (_,"").
  %
  %  ehp/2 - enclose highlighting
  %
  ehp ("B",Tag):- ipf_bold,ipf_italic,ipf_underline,set_HP(6,Tag),bold(0),!.
  ehp ("B",Tag):- ipf_bold,ipf_underline,set_HP(5,Tag),bold(0),!.
  ehp ("B",Tag):- ipf_bold,ipf_italic,set_HP(1,Tag),bold(0),!.
  ehp ("B",":ehp2."):- ipf_bold,retractall(ipf_cur_hp(_)),bold(0),!.
  ehp ("I",Tag):- ipf_italic,ipf_underline,ipf_bold,set_HP(7,Tag),italic(0),!.
  ehp ("I",Tag):- ipf_italic,ipf_underline,set_HP(5,Tag),italic(0),!.
  ehp ("I",Tag):- ipf_italic,ipf_bold,set_HP(2,Tag),italic(0),!.
  ehp ("I",":ehp1."):- ipf_italic,retractall(ipf_cur_hp(_)),italic(0),!.
  ehp ("U",Tag):- ipf_underline,ipf_italic,ipf_bold,set_HP(3,Tag),underline(0),!.
  ehp ("U",Tag):- ipf_underline,ipf_italic,set_HP(1,Tag),underline(0),!.
  ehp ("U",Tag):- ipf_underline,ipf_bold,set_HP(2,Tag),underline(0),!.
  ehp ("U",":ehp5."):- ipf_underline,retractall(ipf_cur_hp(_)),underline(0),!.
  ehp (_,"").
  
/******************************************************
 *  Common IPF Tag Handling                           *
 ******************************************************/
PREDICATES
  procedure ipf_att_Txt (doc_att,string)
CLAUSES 
  %
  %  ipf_make_AttTag/4 - format tag with attribute list
  %
  ipf_make_AttTag (Key,[],Buff,Tag) :- !,
	upper_lower (Key,LKey),
	format (Tag,":%s%s.",LKey,Buff).
  ipf_make_AttTag (Key,[H|T],Buff,Tag) :-
	ipf_att_Txt (H,AttTxt),
	concat (Buff," ",B1),
	concat (B1,AttTxt,Buff_1),!,
	ipf_make_AttTag (Key,T,Buff_1,Tag).
  %
  %  ipf_att_Txt/2 - format attribute
  %
  ipf_att_Txt (doc_att(Name,nill),Name) :-!.
  ipf_att_Txt (doc_att(Name,atom(Val)),Txt) :- !,
	upper_lower (Name,LName),
	concat (LName,"=",T1),
	concat (T1,Val,Txt).
  ipf_att_Txt (doc_att(Name,lit(Val)),Txt) :- !,
	upper_lower (Name,LName),
	concat (LName,"=",T1),
	concat (T1,"'",T2),
	concat (T2,Val,T3),
	concat (T3,"'",Txt).
  ipf_att_Txt (doc_att(Name,num(Val)),Txt) :-
	str_int (S,Val),
	upper_lower (Name,LName),
	concat (LName,"=",T1),
	concat (T1,S,Txt).
  %
  %  ipf_close_Tag/2 - format enclosing tag
  %
  ipf_close_Tag (Str,Tag) :-
	upper_lower (Str,LStr),
  	concat (":e",LStr,S1),
  	concat (S1,".",Tag).
  %
  %  ipf_make_BoolTag/3 - construct boolean tag i.e :hp1. or :ehp1.
  %
  ipf_make_BoolTag (Key,1,Tag) :-!,
	upper_lower (Key,LKey),
  	format (Tag,":%s.",LKey).
  ipf_make_BoolTag (Key,0,Tag) :- !,
	upper_lower (Key,LKey),
  	format (Tag,":e%s.",LKey).
  	
  %
  %  ipf_make_OpenBlock/4 - conctruct "open" block - like <P><LI>
  %
  ipf_make_OpenBlock (Key,Attlist,Flow,Txt) :-
        ipf_make_AttTag (Key,Attlist,"",Tag),
	ipf_reset_Wrap (0),
	ipf_Flow (Flow,"",FlowTxt),
	format (Txt,"\n%s%s",Tag,FlowTxt).
  %
  %  make_CloseBlock/4 - conctructs "enclosed" block
  %
  ipf_make_CloseBlock (Key,Attlist,Flow,Txt) :-
	ipf_make_AttTag (Key,Attlist,"",Tag1),
	ipf_close_Tag (Key,Tag2),
        str_len (Tag2,Len),
	ipf_reset_Wrap (Len),
	ipf_Flow (Flow,"",FlowTxt),
	format (Txt,"\n%s%s\n%s",Tag1,FlowTxt,Tag2).
/******************************************************
 *  IPF lists formatting                              *
 ******************************************************/
PREDICATES
  procedure ipf_li_ListTxt    (string Class,li_list,string Txt)
  procedure ipf_li_Txt        (string Class,li,string Txt)
  procedure ipf_li_List_Slist (string Class,li_list,slist)

CLAUSES
  %
  %  ipf_make_List/4 - constructs the list block
  %
  ipf_make_List (Key,Attlist,LH,LIL,Txt) :-
  	retractall (ipf_in_List),
  	assert (ipf_in_List),
	ipf_make_AttTag (Key,Attlist,"",Tag1),
	ipf_close_Tag (Key,Tag2),
	LH = lh(_LH_Attlist,LH_Flow),
	ipf_Flow (LH_Flow,"",Header),
	ipf_li_ListTxt (Key,LIL,ListContent),
	format (Txt,"%s\n%s%s\n%s",Header,Tag1,ListContent,Tag2),
        str_len (Tag2,Len),
        ipf_reset_Wrap (Len),
	retractall (ipf_in_List).
  %
  %  ipf_li_ListTxt/3 - loop to convert list item list to the text
  %
  ipf_li_ListTxt (Class,L,Txt):-
  	ipf_li_List_Slist(Class,L,SL),
  	ipf_slist_string(SL,Txt).

  ipf_li_List_Slist(_,[],[]).
  ipf_li_List_Slist(Class,[H|T],[HTxt|Tail]):-
  	ipf_li_Txt(Class,H,HTxt),
  	ipf_li_List_Slist(Class,T,Tail).

  ipf_li_Txt (_,li(Attlist,Flow),Txt) :- !,
	ipf_make_OpenBlock ("li",Attlist,Flow,Txt).
  ipf_li_Txt ("parml",dt(Attlist,Flow),Txt) :- !,
	ipf_make_OpenBlock ("pt",Attlist,Flow,Txt).
  ipf_li_Txt ("parml",dd(Attlist,Flow),Txt) :- !,
	ipf_make_OpenBlock ("pd",Attlist,Flow,Txt).
  ipf_li_Txt (_,dt(Attlist,Flow),Txt) :- 
  	ipf_att_member (doc_att("class",Val),Attlist),
  	ipf_str_val (Val,"hd"),!,
  	ipf_att_exclude ("class",Attlist,NewAttlist),
	ipf_make_OpenBlock ("dthd",NewAttlist,Flow,Txt).
  ipf_li_Txt (_,dt(Attlist,Flow),Txt) :- !,
	ipf_make_OpenBlock ("dt",Attlist,Flow,Txt).
  ipf_li_Txt (_,dd(Attlist,Flow),Txt) :- 
  	ipf_att_member (doc_att("class",Val),Attlist),
  	ipf_str_val (Val,"hd"),!,
  	ipf_att_exclude ("class",Attlist,NewAttlist),
	ipf_make_OpenBlock ("ddhd",NewAttlist,Flow,Txt).
  ipf_li_Txt (_,dd(Attlist,Flow),Txt) :- !,
	ipf_make_OpenBlock ("dd",Attlist,Flow,Txt).

/******************************************************
 *   IPF tables formatting                            *
 ******************************************************/
PREDICATES
  procedure ipf_need_Border   (doc_attlist,doc_attlist)
  procedure ipf_row_ListTxt   (trow_list,string Buff,string Txt,integer,integer)
  procedure ipf_cell_ListTxt  (cell_list,string Buff,string Txt,integer,integer)
  procedure ipf_cell_Txt      (cell,string Txt,integer Spanned)
  procedure ipf_cell_spanned  (doc_attlist,integer)
  procedure ipf_cell_end      (integer,string,string)
  procedure ipf_formatcols    (integer,doc_attlist,doc_attlist)
  procedure ipf_formatcolsatt (integer,string,string)
CLAUSES
   ipf_make_Table (Attlist,Caption,RowList,Txt) :- !,
  	Caption = caption (_CapAtts,CapFlow),
  	ipf_Flow (CapFlow,"",CapTxt),
  	ipf_close_Tag ("table",Tag2),
  	retractall (ipf_intbl),
  	assert (ipf_intbl),
  	ipf_row_ListTxt (RowList,"",TableContent,0,MaxCells),
  	ipf_FormatCols (MaxCells,Attlist,Attlist1),
        ipf_need_Border (Attlist1,NewAttlist),
        retractall (ipf_intbl),
  	ipf_make_AttTag ("table",NewAttlist,"",Tag1),
  	TblFont = ":font facename=Courier.",
  	get_ipf_font (CurFont),
	format (Txt,"%s\n%s\n%s%s\n%s%s",
		CapTxt,TblFont,Tag1,TableContent,Tag2,CurFont),
  	str_len(Tag2,Len),
  	ipf_reset_Wrap (Len).  	
  %
  %  Extract table rows from various row groups
  %
  ipf_get_thead_rows([],Rows,Rows).
  ipf_get_thead_rows([H|T],B,Rows):-
  	H=thead(_,TRL),
  	ipf_list_cat(B,TRL,B1),
  	ipf_get_thead_rows(T,B1,Rows).

  ipf_get_tfoot_rows([],Rows,Rows).
  ipf_get_tfoot_rows([H|T],B,Rows):-
  	H=tfoot(_,TRL),
  	ipf_list_cat(B,TRL,B1),
  	ipf_get_tfoot_rows(T,B1,Rows).
  	
  ipf_get_tbody_rows([],Rows,Rows).
  ipf_get_tbody_rows([H|T],B,Rows):-
  	H=tbody(_,TRL),
  	ipf_list_cat(B,TRL,B1),
  	ipf_get_tbody_rows(T,B1,Rows).
  %
  %  ipf_need_Border/2 - determines weather need to add border attribute
  %
  ipf_need_Border (Attlist,Attlist) :-
  	ipf_att_member (doc_att("frame",_),Attlist),!.
  ipf_need_Border (Attlist,Attlist) :-
  	ipf_att_member (doc_att("rules",_),Attlist),!.
  %  from HTML - add attributies
  ipf_need_Border (Attlist,NewAttlist) :-
  	ipf_att_member (doc_att("border",_),Attlist),!,
  	ipf_att_exclude ("border",Attlist,Attlist_0),
  	NewAttlist = [doc_att("rules",atom("both")),doc_att("frame",atom("box"))|Attlist_0].
  ipf_need_Border (Attlist,Attlist).
  %
  %  ipf_row_ListTxt/3 - loop to convert table rows list (table content)
  %  
  ipf_row_ListTxt ([],Txt,Txt,Cells,Cells).
  ipf_row_ListTxt ([H|T],Buff,Txt,C0,Cells) :-
	H = trow (_Attlist,Cell_List),	% IPF table row has no atts
	ipf_make_AttTag ("row",[],"",Tag),
	ipf_cell_ListTxt (Cell_List,"",RowTxt,0,CellInRow),
	ipf_maxint (C0,CellInRow,C1),
	format (Buff1,"%s\n%s%s",Buff,Tag,RowTxt),
	ipf_row_ListTxt (T,Buff1,Txt,C1,Cells).

  ipf_cell_ListTxt ([],Txt,Txt,Cells,Cells).
  ipf_cell_ListTxt ([H|T],Buff,Txt,C0,Cells) :-
	ipf_cell_Txt (H,CellTxt,CellSpanned),
	concat (Buff,CellTxt,Buff1),
	C1 = C0 + CellSpanned,
	ipf_cell_ListTxt (T,Buff1,Txt,C1,Cells).

  ipf_cell_Txt (th(Attlist,Flow),Txt,CellSpanned) :- !,
  	ipf_make_OpenBlock ("c",[],Flow,Txt0),	% no atts for cells
  	ipf_cell_spanned (Attlist,CellSpanned),
  	ipf_cell_end (CellSpanned,"",CellEnd),
  	format (Txt,"%s%s",Txt0,CellEnd).
  ipf_cell_Txt (td(Attlist,Flow),Txt,CellSpanned) :- !,
  	ipf_make_OpenBlock ("c",[],Flow,Txt0),	% no atts for cells
  	ipf_cell_spanned (Attlist,CellSpanned),
  	ipf_cell_end (CellSpanned,"",CellEnd),
  	format (Txt,"%s%s",Txt0,CellEnd).
  	
  ipf_cell_spanned (Attlist,CellSpanned) :-
  	ipf_att_member (doc_att("colspan",Val),Attlist),
  	Val = num (CellSpanned),
  	CellSpanned > 1,!.
  ipf_cell_spanned (_,1).

  ipf_cell_End (1,End,End) :-!.
  ipf_cell_End (N,EndBuf,End) :-
  	N1 = N - 1,
  	concat (EndBuf,":c.",EndBuf1),
  	ipf_cell_End (N1,EndBuf1,End).
  	
  ipf_FormatCols (_Cells,Attlist,Attlist) :-
  	ipf_att_member (doc_att("cols",_),Attlist),!.
  ipf_FormatCols (Cells,Attlist,NewAttlist) :- !,
  	ipf_FormatColsAtt (Cells,"",ColsAttVal),
  	NewAttlist = [doc_att("cols",lit(ColsAttVal))|Attlist].
  	
  ipf_FormatColsAtt (1,ColsAttBuff,ColsAttVal) :- !,
  	concat (ColsAttBuff,"20",ColsAttVal).
  ipf_FormatColsAtt (N,ColsAttBuff,ColsAttVal) :-
  	concat (ColsAttBuff,"20 ",ColsAttBuff1),
  	N1 = N-1,
  	ipf_FormatColsAtt (N1,ColsAttBuff1,ColsAttVal).
	
/******************************************************
 *  IPF supports four types of admonishments          *
 ******************************************************/
PREDICATES
  determ ipf_NoteClass (string,string)
CLAUSES
  %
  %  ipf_MakeNote/3 - format the note according to its class
  %	
  ipf_MakeNote (Attlist,Flow,Txt) :-
  	ipf_att_member (doc_att("class",Val),Attlist),
  	ipf_str_val (Val,SVal),
  	upper_lower (SVal,LSVal),
  	ipf_NoteClass (LSVal,Tag),!,
  	ipf_att_exclude ("class",Attlist,NewAttlist),
  	ipf_make_CloseBlock (Tag,NewAttlist,Flow,Txt).
  ipf_MakeNote (Attlist,Flow,Txt) :-
  	ipf_make_CloseBlock ("nt",Attlist,Flow,Txt).
  %
  %  ipf_NoteClass/3 - get the IPF note class tag
  %
  ipf_NoteClass ("note","nt") :-!.
  ipf_NoteClass ("caution","caution") :-!.
  ipf_NoteClass ("warning","warning").
  
/*******************************************************
 *  Link formatting.                                   *
 *  - Replace href attribute with refid                *
 *  - cut #                                            *
 *  - add reftype                                      *
 *******************************************************/
PREDICATES
  procedure ipf_add_reftype (doc_attlist,doc_attlist)
  procedure ipf_make_refid  (doc_attlist,doc_attlist)
CLAUSES
  ipf_make_Link (Attlist,Flow,Txt) :-
  	ipf_Add_Reftype (Attlist,Attlist_1),
  	ipf_make_Refid (Attlist_1,Attlist_2),
  	ipf_make_CloseBlock ("link",Attlist_2,Flow,Txt).

  ipf_Add_Reftype (Attlist,Attlist) :-
  	ipf_att_member (doc_att("reftype",_),Attlist),!.
  ipf_Add_Reftype (Attlist,NewAttlist) :-
  	NewAttlist = [doc_att("reftype",atom("hd"))|Attlist].
  %
  %  ipf_make_Refid/2 - change HTML's local HREF to IPF's refid
  %
  ipf_make_Refid (Attlist,Attlist) :-
  	ipf_att_member (doc_att("refid",_),Attlist),!.
  ipf_make_Refid (Attlist,NewAttlist) :-
  	ipf_att_member (doc_att("href",Val),Attlist),
  	ipf_str_val(Val,HREF),
  	frontchar(HREF,'#',REFID),!,
  	ipf_att_exclude ("href",Attlist,Attlist_1),
  	NewAttlist = [doc_att("refid",atom(REFID))|Attlist_1].
  ipf_make_Refid (Attlist,Attlist).

/******************************************************
 *  IPF artwork and artlink formatting                *
 ******************************************************/
PREDICATES                            
  procedure ipf_Artwork_Usemap  (doc_attlist,doc_attlist)
  procedure ipf_Artwork_SrcName (doc_attlist,doc_attlist)
  procedure ipf_Artwork_Runin   (doc_attlist,doc_attlist)        
  determ    runin_align         (string)
  procedure ipf_AreaList_Txt    (area_list,string,string)
CLAUSES               
  %
  %  ipf_make_Artwork/2 - format artwork tag
  %                                
  ipf_make_Artwork (Attlist,Txt) :-
        ipf_artwork_UseMap (Attlist,Attlist_1),
        ipf_artwork_SrcName (Attlist_1,Attlist_2),
        ipf_artwork_Runin (Attlist_2,NewAttlist),
        ipf_make_AttTag ("artwork",NewAttlist,"",Txt0),
  	ipf_need_Wrap (Txt0,Txt).
  %
  %  ipf_artwork_Usemap/2 - exclude "usemap"
  %      
  ipf_artwork_Usemap (Attlist,NewAttlist) :-
  	ipf_att_exclude ("usemap",Attlist,NewAttlist),!.
  ipf_artwork_Usemap (Attlist,Attlist).
  %
  %  ipf_artwork_SrcName/2 - change "src" to "name"
  %
  ipf_artwork_SrcName (Attlist,Attlist) :-      
  	ipf_att_member (doc_att("name",_),Attlist),!.
  ipf_artwork_SrcName (Attlist,NewAttlist) :- 
  	ipf_att_member (doc_att("src",Val),Attlist),!,
  	ipf_att_exclude ("src",Attlist,Attlist_1),
  	NewAttlist=[doc_att("name",Val)|Attlist_1].
  ipf_artwork_SrcName (Attlist,Attlist).
  %
  %  ipf_artwork_Runin/2 - set runin if needed  
  %
  ipf_artwork_Runin (Attlist,Attlist) :- 
  	ipf_att_member (doc_att("runin",_),Attlist),!.
  ipf_artwork_Runin (Attlist,NewAttlist) :-
  	ipf_att_member (doc_att("align",Val),Attlist),
        ipf_str_val (Val,SVal),
        upper_lower (SVal,LVal),
        runin_align (LVal),!,
        ipf_att_exclude ("align",Attlist,Attlist_1),
        NewAttlist = [doc_att("runin",nill)|Attlist_1].
  ipf_artwork_Runin (Attlist,Attlist).
  %
  %  runin_align/1 - succes if requested alignment runs in line
  %
  runin_align ("top").
  runin_align ("bottom").
  runin_align ("middle").
  %
  %  ipf_make_Artlink/2 - format artlink tag
  %
  ipf_make_Artlink (Arealist,Txt) :-
  	ipf_AreaList_Txt (Arealist,"",AreaTxt),
        format (Txt,"\n:artlink.%s\n:eartlink.",AreaTxt),
        ipf_reset_Wrap (10).
       
  
  ipf_AreaList_Txt ([],AreaTxt,AreaTxt).
  ipf_AreaList_Txt ([H|T],AreaBuff,AreaTxt) :-
  	H = area(Attlist),
        ipf_make_AttTag ("link",Attlist,"",Link),
        format (Buff_1,"%s\n%s",AreaBuff,Link),
        ipf_AreaList_Txt (T,Buff_1,AreaTxt).
/******************************************************
 *  IPF Font Handling                                 *
 ******************************************************/
PREDICATES
  procedure ipf_get_FontEncoding (doc_attlist,integer)
  procedure ipf_get_FontSize     (doc_attlist, integer Size)
  determ    ipf_get_FontSize_2   (string,  integer Size)
  procedure ipf_get_FaceName     (doc_attlist, string FaceStr)
  procedure ipf_calc_FontSize    (integer Code, integer Size, string SzStr)
  procedure ipf_get_Codepage     (doc_attlist, string)
CLAUSES
  ipf_make_FontTag (Attlist,Txt) :-
  	ipf_get_FontEncoding (Attlist,Encoding),
  	ipf_get_FontSize (Attlist,Size), 
        ipf_get_FaceName (Attlist,Face),
  	ipf_calc_FontSize (Encoding,Size,SizeStr),
        ipf_get_CodePage (Attlist,CodePAge),
        format (Tag,":font %s size=%s%.",Face,SizeStr,CodePage),
        retractall (ipf_font(_)),
        assert (ipf_font(Tag)),
        ipf_need_Wrap (Tag,Txt).
  %
  %  ipf_get_Font_Encoding/2 - retrive the font encoding
  %               1-absolute font size value given (RTF/IPF)
  %               2-relative font size value given (HTML)
  %
  ipf_get_FontEncoding (Attlist,1) :-
  	ipf_att_member (doc_att("ABSOLUTE",nill),Attlist),!.
  ipf_get_FontEncoding (_,2).           
  %
  % ipf_get_FontSize/2 - extracts font size
  %
  ipf_get_FontSize (Attlist,Size) :-
  	ipf_att_member (doc_att("SIZE",num(Size)),Attlist),!.
  ipf_get_FontSize (Attlist,Size) :-
	ipf_att_member (doc_att("SIZE",atom(SzStr)),Attlist),
	ipf_get_FontSize_2 (SzStr,Size),!.
  ipf_get_FontSize (Attlist,Size) :-
	ipf_att_member (doc_att("SIZE",lit(SzStr)),Attlist),
	ipf_get_FontSize_2 (SzStr,Size),!.
  ipf_get_FontSize (_,0).

  ipf_get_FontSize_2 (SzStr,Size) :-
	fronttoken (SzStr,Front,_),
	str_int (Front,Size).
  %
  % ipf_get_FaceName/2 - extracts face name
  %
  ipf_get_FaceName (Attlist,FaceStr) :-
  	ipf_att_member (doc_att("face",atom(Face)),Attlist),!,
  	format (FaceStr," facename=%s",Face).
  ipf_get_FaceName (Attlist,FaceStr) :-
  	ipf_att_member (doc_att("face",lit(Face)),Attlist),!,
  	format (FaceStr," facename='%s'",Face).
  ipf_get_FaceName (Attlist,FaceStr) :-
  	ipf_att_member (doc_att("facename",atom(Face)),Attlist),!,
  	format (FaceStr," facename=%s",Face).
  ipf_get_FaceName (Attlist,FaceStr) :-
  	ipf_att_member (doc_att("facename",lit(Face)),Attlist),!,
  	format (FaceStr," facename='%s'",Face).
  ipf_get_FaceName (_," facename=default").
  %
  %  ipf_GetCodePage/2
  %                   
  ipf_get_CodePage (Attlist,CodePage) :-
  	ipf_att_member (doc_att("codepage",Val),Attlist),
  	ipf_str_val (Val,CP),!,
  	format (CodePage,"codepage='%s'",CP).
  ipf_get_CodePage (Attlist,CodePage) :-
  	ipf_att_member (doc_att("codepage",num(CP)),Attlist),!,
        format (CodePage,"codepage=%d",CP).
  ipf_get_CodePage (_,"").
  %
  %  ipf_calc_FontSize/3 - calculates font size
  %
  ipf_calc_FontSize (1,0,"0x0") :-!.% Absolute, but Size not set -> default size
  ipf_calc_FontSize (1,Sz,SzCode) :- !,
  	SzW = round(Sz/1.85),
  	format (Sz1,"%d",Sz),
  	format (Sz2,"%",SzW),
  	concat (Sz1,"x",Sz3),
  	concat (Sz3,Sz2,SzCode).
  %  Relatives (like Netscape)
  ipf_calc_FontSize (2,0,"8x6") 	:-!.	% 8 pt
  ipf_calc_FontSize (2,1,"8x6") 	:-!.	% 8 pt
  ipf_calc_FontSize (2,2,"10x8") 	:-!.	% 10 pt
  ipf_calc_FontSize (2,3,"12x8") 	:-!.	% 12 pt
  ipf_calc_FontSize (2,4,"14x10") 	:-!.	% 14 pt
  ipf_calc_FontSize (2,5,"18x10") 	:-!.	% 18 pt
  ipf_calc_FontSize (2,6,"24x18") 	:-!.	% 24 pt
  ipf_calc_FontSize (2,Sz,"24x18") 	:- Sz > 6,!.% 24 pt
  ipf_calc_FontSize (2,-1,"10x8") 	:-!.	% 10 pt
  ipf_calc_FontSize (2,_,"8x6") 	:-!.	% 8 pt
  ipf_calc_FontSize (_,_,"8x6") 	:-!.	% 8 pt
  
  
/******************************************************
 *  Coloured fonts handling                           *
 *****************************************************/
PREDICATES
  determ    ipf_color_name    (string,integer,integer,integer,string)
  procedure ipf_ComposeColor  (string,string,string)
  procedure ipf_get_ForeColor (doc_attlist,string)
  procedure ipf_get_BackColor (doc_attlist,string)
  determ    ipf_get_ColorVal  (string,string)
  procedure ipf_round_color   (integer,integer)
CLAUSES
  %
  %  ipf_make_ColorTag - make :color bc= fc= .
  %
  ipf_make_ColorTag (Attlist,ColorTag) :-
  	ipf_get_ForeColor (Attlist,ForeColor),
  	ipf_get_BackColor (Attlist,BackColor),
  	ipf_ComposeColor (ForeColor,BackColor,ColorTag).
  %
  %  ipf_ComposeColor/3 - make the color tag from FC and BC values
  %
  ipf_ComposeColor ("","","") :-!.
  ipf_ComposeColor (ForeColor,"",Tag) :-!,
  	format (Tag,":color fc=%s bc=default.",ForeColor).
  ipf_ComposeColor ("",BackColor,Tag) :-!,
  	format (Tag,":color fc=default bc=%s.",BackColor).
  ipf_ComposeColor (ForeColor,BackColor,Tag) :-
  	format (Tag,":color fc=%s bc=%s.",ForeColor,BackColor).
  %
  %  ipf_GetForeColor/2 - render font foreground color
  %
  ipf_get_ForeColor (Attlist,Color) :-
  	ipf_att_member (doc_att("color",Val),Attlist),
  	ipf_str_val (Val,CVal),
  	ipf_get_ColorVal (CVal,Color),!.
  ipf_get_ForeColor (_Attlist,"").
  %
  %  ipf_GetBackColor/2 - render font background color
  %
  ipf_get_BackColor (Attlist,Color) :-
  	ipf_att_member (doc_att("bgcolor",Val),Attlist),
  	ipf_str_val (Val,CVal),
  	ipf_get_ColorVal (CVal,Color),!.
  ipf_get_BackColor (_Attlist,"").
  %
  %  ipf_GetColorVal/2 - find the IPF color value
  %
  ipf_get_ColorVal (CVal,Color) :-
  	ipf_color_name (CVal,_,_,_,Color),!.
  ipf_get_ColorVal (CVal,Color) :-
    	frontchar (CVal,'#',R1),
  	frontstr (2,R1,RStr,R2),
  	frontstr (2,R2,GStr,BStr),
  	concat ("0x",Rstr,Rstr2),
  	concat ("0x",Gstr,Gstr2),
  	concat ("0x",Bstr,Bstr2),
  	str_int (Rstr2,R),
  	str_int (Gstr2,G),
  	str_int (Bstr2,B),
  	ipf_round_color (R,RR),
  	ipf_round_color (G,GR),
  	ipf_round_color (B,BR),
  	ipf_color_name (_,RR,GR,BR,Color).
  %
  %  Color names, RGB values and IPF equivalents
  %
  ipf_color_name("black",   0x00, 0x00, 0x00, "default"):-!.
  ipf_color_name("blue",    0x00, 0x00, 0xFF, "blue"):-!.
  ipf_color_name("aqua",    0x00, 0xFF, 0xFF, "cyan"):-!.  % synomin
  ipf_color_name("cyan",    0x00, 0xFF, 0xFF, "cyan"):-!.
  ipf_color_name("lime",    0x00, 0xFF, 0x00, "green"):-!.
  ipf_color_name("fuchsia", 0xFF, 0x00, 0xFF, "blue"):-!.  % synonim
  ipf_color_name("magenta", 0xFF, 0x00, 0xFF, "blue"):-!.
  ipf_color_name("red",     0xFF, 0x00, 0x00, "red"):-!.
  ipf_color_name("yellow",  0xFF, 0xFF, 0x00, "yellow"):-!.
  ipf_color_name("white",   0xFF, 0xFF, 0xFF, "default"):-!.
  ipf_color_name("navy",    0x00, 0x00, 0x80, "blue"):-!.
  ipf_color_name("teal",    0x00, 0x80, 0x80, "neutral"):-!.
  ipf_color_name("green",   0x00, 0x80, 0x80, "green"):-!.
  ipf_color_name("purple",  0x80, 0x00, 0x80, "red"):-!.
  ipf_color_name("maroon",  0x80, 0x00, 0x00, "red"):-!.  % synomim
  ipf_color_name("olive",   0x80, 0x80, 0x00, "neutral"):-!.
  ipf_color_name("gray",    0x80, 0x80, 0x80, "default"):-!.
  ipf_color_name("silver",  0xC0, 0xC0, 0xC0, "default"):-!.
  %
  %  round color values to one of 0x00 0x80 0xC0 0xFF
  %
  ipf_round_color (0x00,0x00) :-!.
  ipf_round_color (0xFF,0xFF) :-!.
  ipf_round_color (0xC0,0xC0) :-!.
  ipf_round_color (0x80,0x80) :-!.
  ipf_round_color (C,0x00) :- C > 0x00, C<=0x40,!.
  ipf_round_color (C,0x80) :- C > 0x40, C<0x80,!.
  ipf_round_color (C,0xC0) :- C > 0x80, C<=0xA0,!.
  ipf_round_color (_,0xFF) :-!.

/******************************************************
 *  Miscaleneous predicates                           *
 ******************************************************/
DATABASE - ipf_pro_misc_internal
  determ ipf_wrap_Pos (integer)
PREDICATES
  procedure ipf_wrap(integer,string,slist,slist,integer)

  procedure ipf_reverse_and_nl(slist,slist)
  procedure ipf_reverse_and_nl_1(slist,slist,slist)
CLAUSES
  ipf_reset_Wrap (Pos) :-
  	retractall (ipf_wrap_Pos(_)),
  	assert(ipf_wrap_Pos(Pos)).

  ipf_need_Wrap (Str,Str) :-
  	str_len(Str,Len),
  	ipf_wrap_Pos(Pos),
  	NewPos = Pos + Len,
  	Len < 120,!,
  	ipf_reset_Wrap (NewPos).
  ipf_need_Wrap (Str,Txt) :-
  	ipf_wrap(120,Str,[],SL,NewPos),
  	ipf_slist_string(SL,Txt),
  	ipf_reset_Wrap(NewPos).
  	
  ipf_wrap(WrapPos,Str,Buff,Slist,NewWrapPos):-
    	searchchar(Str,'\n',Pos),
    	Pos<WrapPos,
    	P1=Pos-1,
    	frontstr(P1,Str,Front,R1),
    	Buff1=[Front|Buff],
    	frontchar(R1,_,R2),!,
    	ipf_wrap(WrapPos,R2,Buff1,Slist,NewWrapPos).
  ipf_wrap(WrapPos,Str,Buff,Slist,NewWrapPos):-
    	frontstr(WrapPos,Str,F1,R1),
    	searchchar(R1,' ',Pos),!,
    	frontstr(Pos,R1,F2,R2),
    	concat(F1,F2,F),
    	Buff1=[F|Buff],!,
    	ipf_wrap(WrapPos,R2,Buff1,Slist,NewWrapPos).
  ipf_wrap(_WrapPos,Str,Buff,Slist,NewWrapPos):-
    	Buff1=[Str|Buff],
    	str_len(Str,NewWrapPos),
    	ipf_reverse_and_nl(Buff1,Slist).
   %
   %   Add NL to each line except of last
   %
   ipf_reverse_and_nl(X,Y) :- ipf_reverse_and_nl_1(X,[],Y).
   ipf_reverse_and_nl_1([],Y,Y):-!.
   ipf_reverse_and_nl_1([U|X1],X2,Y):- 
   	concat(U,"\n",U1),
   	ipf_reverse_and_nl_1(X1,[U1|X2],Y).
  	
  ipf_att_member (doc_att(Name1,Val),[doc_att(Name2,Val)|_]) :-
  	upper_lower (Name1,LN1),
  	upper_lower (Name2,LN2),
  	LN1 = LN2,!.
  ipf_att_member (Att,[_|T]) :- ipf_att_member (Att,T).

  ipf_lcase_member (S1,[S2|_]) :-
	upper_lower (S1,LS1),
	upper_lower (S2,LS2),
	LS1 = LS2,!.
  ipf_lcase_member (S1,[_|T]) :- ipf_lcase_member (S1,T).
  
  ipf_att_exclude (_,[],[]).
  ipf_att_exclude (Name1,[H|T],OUT) :-
  	H = doc_att (Name2,_),
  	upper_lower (Name1,LName1),
  	upper_lower (Name2,LName2),
  	LName1 = LName2,!,
  	ipf_att_exclude (Name1,T,OUT).
  ipf_att_exclude (Name,[H|T],[H|OUT]) :-
  	ipf_att_exclude (Name,T,OUT).
  	
  ipf_list_cat ([],L,L).
  ipf_list_cat ([X|L1],L2,[X|L3]) :- !,ipf_list_cat (L1,L2,L3).
  
  ipf_str_val (lit(Str),Str) :-!.
  ipf_str_val (atom(Str),Str).
  
  ipf_maxint (I1,I2,I1) :- I1 > I2,!.
  ipf_maxint (_,I2,I2).

