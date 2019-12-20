/******************************************************************************

                 Copyright (C) 1984 - 2000 Prolog Development Center A/S

				VISUAL PROLOG

 File name: HTML.PRO
 PURPOSE  : HTML to Prolog converter

 COMMENTS:  Implements html_term (o,i) (i,i) (o,o)


 Written by Oleg V. Erjomin

 24.11.96 <tab ...> rendered as \t
 24.11.96 Implement font size calculation for <FONT ABSOLUTE/RELATIVE>
 22.3.98  Implement RTF tables rendering
 31.3.98  Implement coloured fonts
 1.5.2000 HTML 4.01 implemented

******************************************************************************/
ifndef html_Pre_Included
 #ERROR: file html.pre must be included
enddef

GLOBAL PREDICATES
  procedure html_movemem(ulong,ulong,unsigned) - (i,i,i) language c as "_MEM_MovMem"  
  

CONSTANTS
 html_Pro_Included = 1

DOMAINS
  html_slist = string*

DATABASE - html_doc_info
   html_doc_source (string)
   html_doc_units (string)

DATABASE - html_cur_format_internal
  font_tag (string)

DATABASE - wrap_up_internal
  determ wrap_Pos (integer)
  determ in_preformatted
  
DATABASE - frameset_internal
  single frameset_txt (string)

PREDICATES
  procedure make_AttTag     (string Key, doc_attlist, string Buff, string Tag)
  procedure make_BoolTag    (string Key, bool Val, string Tag)
  procedure make_BoolAttTag (string Key, bool Val, doc_attlist, string Tag)
  procedure make_AttFlowTag (string Key, doc_attlist, doc_flow, string Txt)
  procedure make_FontTag    (doc_attlist, string Tag)
  procedure make_OpenBlock  (string IS, string Key, doc_attlist, doc_flow, string Txt)
  procedure make_CloseBlock (string IS, string Key, doc_attlist, doc_flow, string Txt)
  procedure make_CloseBlock (string Key, doc_attlist, doc_flow, string Txt)
  procedure make_Heading    (string IS, string Key, doc_attlist, doc_flow, string Txt)
  procedure make_List       (string IS, string Key, doc_attlist, lh ,li_List, string Txt)
  procedure close_Tag       (string Tag, string Txt)
  procedure indent          (integer Level, string Txt)
  procedure need_Wrap       (string Indent,string,string)
  procedure reset_Wrap      (integer)

PREDICATES
  procedure make_Prolog (string,string)
  procedure make_Head   (doc_head,string,string)
  procedure head_Txt    (doc_headelem,string)
  determ html_att_member (doc_att,doc_attlist)
  determ html_member (string,slist)
  procedure html_exclude_Attribute (slist,doc_attlist,doc_attlist,doc_attlist)
  determ html_str_val (doc_attval,string)
  procedure need_NoFrames (string,string,string)

CLAUSES
  %
  %  Default frameset fact
  %
  frameset_txt("").
  %
  %  html_term (o,i)
  %
  make_html_doc (HTML,DOC) :-
	Doc = doc (Doctype,Head,Body),
	make_Prolog (Doctype,DocProlog),
	make_Head (Head,"",DocHead),
	retractall(_,html_doc_info),
	assert (html_doc_source("HTML")),
	assert (html_doc_units("PIXEL")),
	html_ApplyDocInfo (Head),
	Body = doc_body(Attlist,Flow),
	make_CloseBlock ("","BODY",Attlist,Flow,DocBody),
	frameset_txt (FrameSets),
	need_noframes (FrameSets,NoFrames1,NoFrames2),
	reset_Wrap (0),
	retractall(in_preformatted),
	retractall (_,html_cur_format_internal),
	format (HTML,"%s\n<HTML>\n<HEAD>\n%s</HEAD>%s%s%s%s\n</HTML>",
			DocProlog,DocHead,FrameSets,
			NoFrames1,
			DocBody,
			NoFrames2).
  %
  %  html_term (i,i)
  %
  unify_html_doc (HTML,DOC) :-
	html_term (HTML,DOC_1),
	DOC = DOC_1.
  %
  %  html_term (o,o)
  %
  gen_html_doc (HTML,DOC) :-
	DOC = doc("HTML",[],doc_body([],[])),
	make_html_doc (HTML,DOC).
  %
  %  make_Prolog/2 - Constructs the document's prolog
  %
  make_Prolog ("","<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">"):-!.
  make_Prolog (Doctype,Prolog) :- format (Prolog,"<!DOCTYPE %s>",Doctype).
  %
  %  Apply Document meta information (source,units)
  %
  html_ApplyDocInfo ([]).
  html_ApplyDocInfo ([H|T]) :-
  	H=doc_meta(Attlist),
  	html_att_member (doc_att("name",A1),Attlist),
  	A1=lit(N),
  	upper_lower(N,"source"),
  	html_att_member (doc_att("content",A2),Attlist),
  	A2=lit(C),
  	upper_lower (USOURCE,C),
  	retractall (html_doc_source(_)),
  	assert (html_doc_source(USOURCE)),!,
  	html_ApplyDocInfo (T).
  html_ApplyDocInfo ([H|T]) :-
  	H=doc_meta(Attlist),
  	html_att_member (doc_att("name",A1),Attlist),
  	A1=lit(N),
  	upper_lower(N,"units"),
  	html_att_member (doc_att("content",A2),Attlist),
  	A2=lit(C),
  	upper_lower (UUNITS,C),
  	retractall (html_doc_source(_)),
  	assert (html_doc_source(UUNITS)),!,
  	html_ApplyDocInfo (T).
  html_ApplyDocInfo ([_|T]) :- !,
  	html_ApplyDocInfo (T).
  %
  %  make_Head/3 - Constructs the document's head
  %
  make_Head ([],DocHead,DocHead).
  make_Head ([H|T],Buff,DocHead) :-
	head_Txt (H,Txt),
	concat (Buff,Txt,Buff_1),
	make_Head (T,Buff_1,DocHead).
	
  need_NoFrames ("","",""):-!.
  need_NoFrames (_,"\n<NOFRAMES>","\n</NOFRAMES>").
  
  	
/***********************************************************
 *   Predicates to convert head elements into the          *
 *   HTML strings                                          *
 ***********************************************************/
CLAUSES
  head_Txt (doc_title(Str),Txt) :- !,
	format (Txt,"<TITLE>%s</TITLE>\n",Str).
  head_Txt (doc_isindex(Attlist),Txt) :- !,
	make_AttTag ("ISINDEX",Attlist,"",Str),
	concat (Str,"\n",Txt).
  head_Txt (doc_base(Attlist),Txt) :- !,
	make_AttTag ("BASE",Attlist,"",Str),
	concat (Str,"\n",Txt).
  head_Txt (doc_meta(Attlist),Txt) :- !,
	make_AttTag ("META",Attlist,"",Str),
	concat (Str,"\n",Txt).
  head_Txt (doc_link(Attlist),Txt) :- !,
	make_AttTag ("LINK",Attlist,"",Str),
	concat (Str,"\n",Txt).
  head_Txt (doc_style(Attlist,Str),Txt) :- !,
  	make_AttTag ("STYLE",Attlist,"",S1),
  	close_Tag ("STYLE",S2),
  	format (Txt,"%s\n%s\n%s\n",S1,Str,S2).

/***********************************************************
 *   Predicates to convert body elements into the          *
 *   HTML strings                                          *
 ***********************************************************/
PREDICATES
%  make_Flow     (string Indent,doc_flow,string Buff,string FlowTxt)
  procedure flow_Txt      (string Indent,doc_flow_element,string Txt)
  procedure opt_ListTxt   (string IS,option_list,string Buff,string Txt)
  procedure area_ListTxt  (string IS,area_list,string Buff,string Txt)
  procedure pre_Txt       (string, string)
  procedure html_repeat_Format (string)

  procedure make_TableCaption(string IS1,caption,string CapTxt)
  procedure make_TableHead(string IS1,thead_list,string TheadRowsTxt)
  procedure make_TableFoot(string IS1,tFoot_list,string TFootRowsTxt)
  procedure make_TableBody(string IS1,tBody_list,string TBodyRowsTxt)
  procedure make_TableColgroup(string IS1,colGroup_List,string ColGroupTxt)

  procedure make_AppletParamList (string IS,paramlist,string Buff,string Txt)
  procedure make_FrameList (string IS,framelist,string Buff,string Txt)
  procedure need_Border_1 (doc_attlist,doc_attlist)
  procedure need_Border_2 (trow_list,doc_attlist,doc_attlist)
  
  procedure html_flow_slist(string,doc_flow,slist)

  procedure html_slist_string(slist,string)
  procedure html_calc_slist_len(slist,integer,integer)
  procedure html_concat_strings(slist,ushort,unsigned)
  procedure wrap(integer,string,string,slist,slist,integer)

  procedure reverse_and_nl(string Indent,slist,slist)
  procedure reverse_and_nl_1(string Indent,slist,slist,slist)

CLAUSES
  %
  %   make_Flow/4 - loop to convert text flow into HTML string
  %
  html_Flow (L,Flow,_,FlowTxt):-
  	html_flow_slist(L,Flow,SL),
  	html_slist_string(SL,FlowTxt).
  	
  html_flow_slist(_,[],[]).
  html_flow_slist(L,[H|T],[HTxt|Tail]):-
  	flow_Txt(L,H,HTxt),
  	html_flow_slist(L,T,Tail).
  %
  %  C-like slist to string conversion
  %  Avoids concat/3's gstack eating 
  %
  html_slist_string(SL,Txt):-  	
  	html_calc_slist_len(SL,0,Len),
  	Len1=Len+1,
  	str_len(Txt,Len1),
  	ptr_dword(Txt,SEG,OFF),
  	html_concat_strings(SL,SEG,OFF).

  html_calc_slist_len ([],L,L).
  html_calc_slist_len ([H|T],L,Len):-
   	str_len(H,L0),
   	L1=L+L0,!,
   	html_calc_slist_len(T,L1,Len).
   	
  html_concat_strings([],SEG,OFF):-
   	%Pos=OFF+1,
   	membyte(SEG,OFF,0).
  html_concat_strings([H|T],SEG,OFF):-
   	str_len(H,Len),
   	Src=cast(ulong,H),
   	ptr_dword(PNew,SEG,OFF),
   	Dest=cast(ulong,PNew),
	html_movemem(Src,Dest,Len),
	OFF1=OFF+Len,
	html_concat_strings(T,SEG,OFF1).	
  %
  % make_AppletParamList/4 - loop to convert Applet paramlist
  %                          into the HTML string
  %
  make_AppletParamList (_,[],ParamTxt,ParamTxt).
  make_AppletParamList (IS,[H|T],Buff,ParamTxt) :-
        H = param(Attlist),
        make_AttTag ("PARAM",Attlist,"",Param),
        format (Buff_1,"%s\n%s%s",Buff,IS,Param),
        make_AppletParamList (IS,T,Buff_1,ParamTxt).
  %
  % make_FramesList/4 - loop to convert Frame Set
  %                          into the HTML string
  %
  make_FrameList (_,[],FramesTxt,FramesTxt).
  make_FrameList (IS,[H|T],Buff,FramesTxt) :-
        H = frame(Attlist),
        make_AttTag ("FRAME",Attlist,"",Frame),
        format (Buff_1,"%s\n%s%s",Buff,IS,Frame),
        make_FrameList (IS,T,Buff_1,FramesTxt).
  %
  %   flow_Txt/3 - converts flow element into HTML string
  %
  flow_Txt (IS,script(Attlist,ScriptTxt),Txt) :- !,
  	make_AttTag ("SCRIPT",Attlist,"",Tag1),
  	close_Tag ("SCRIPT",Tag2),
  	format (Txt,"\n%s%s\n%s\n%s%s",IS,Tag1,ScriptTxt,IS,Tag2),
  	reset_Wrap (8).
  flow_Txt (IS,applet(Attlist,ParamList,Flow),Txt) :- !,
        make_AttTag ("APPLET",Attlist,"",Tag1),
        close_Tag ("APPLET",Tag2),
        concat (IS,"\t",IS1),
        html_Flow (IS1,Flow,"",FlowTxt),
        make_AppletParamList (IS1,ParamList,"",ParamTxt),
	format (Txt,"\n%s%s%s%s\n%s%s",IS,Tag1,ParamTxt,FlowTxt,IS,Tag2),
	reset_Wrap (8).
  flow_Txt (IS,frameset(Attlist,FrameList,Flow),"") :-!,
  	make_AttTag ("FRAMESET",Attlist,"",Tag1),
  	close_Tag ("FRAMESET",Tag2),
  	concat (IS,"\t",IS1),
  	html_Flow (IS1,Flow,"",FlowTxt),
  	make_FrameList (IS1,FrameList,"",FramesTxt),
  	format(Txt,"\n%s%s%s%s\n%s%s",IS,Tag1,FramesTxt,FlowTxt,IS,Tag2),
  	frameset_txt(PrevFrameset),
  	concat(PrevFrameset,Txt,NewFrameset),
  	assert(frameset_txt(NewFrameset)).
  flow_Txt (IS,noframes(B),Txt)	:- !,
  	make_BoolTag ("NOFRAMES",B,Tag),
  	format(Txt,"\n%s%s",IS,Tag),
  	reset_Wrap (0).
  flow_Txt (IS,txt(Str),Txt) :- !,need_Wrap (IS,Str,Txt).
  % Inline elements (dont break paragraph)
  flow_Txt (IS,b(B),Txt) 	:- !,make_BoolTag ("B",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,u(B),Txt) 	:- !,make_BoolTag ("U",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,i(B),Txt) 	:- !,make_BoolTag ("I",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,tt(B),Txt) 	:- !,make_BoolTag ("TT",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,s(B),Txt) 	:- !,make_BoolTag ("S",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,big(B),Txt) 	:- !,make_BoolTag ("BIG",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,small(B),Txt) 	:- !,make_BoolTag ("SMALL",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,sub(B),Txt) 	:- !,make_BoolTag ("SUB",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,sup(B),Txt) 	:- !,make_BoolTag ("SUP",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,em(B),Txt) 	:- !,make_BoolTag ("EM",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,strong(B),Txt) 	:- !,make_BoolTag ("STRONG",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,code(B),Txt) 	:- !,make_BoolTag ("CODE",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,samp(B),Txt) 	:- !,make_BoolTag ("SAMP",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,kbd(B),Txt) 	:- !,make_BoolTag ("KBD",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,var(B),Txt) 	:- !,make_BoolTag ("VAR",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,cite(B),Txt) 	:- !,make_BoolTag ("CITE",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,dfn(B),Txt) 	:- !,make_BoolTag ("DFN",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,abbr(B),Txt)	:- !,make_BoolTag ("ABBR",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,acronym(B),Txt)	:- !,make_BoolTag ("ACRONYM",B,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,q(B),Txt)	:- !,make_BoolTag ("Q",B,Tag),need_Wrap (IS,Tag,Txt).

  flow_Txt (IS,br,Txt) :- !,format (Txt,"<BR>\n%s",IS),reset_Wrap(0).

  flow_Txt (IS,tab(_Attlist),Txt) :- !, need_Wrap (IS,"\t",Txt).
  /*flow_Txt (IS,tab(Attlist),Txt) :- !,
  	make_AttTag ("TAB",Attlist,"",Tag), need_Wrap (IS,Tag,Txt).
  */
  flow_Txt (IS,img(Attlist),Txt) :- !,
  	make_AttTag ("IMG",Attlist,"",Tag), need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,hr(Attlist),Txt) :- !,
  	make_AttTag ("HR",Attlist,"",Tag),need_Wrap (IS,Tag,Txt).

  flow_Txt (IS,font (1,Attlist),Txt) :- !,
  	make_FontTag (Attlist,Tag0),
  	%html_repeat_Format (Tag1),
  	%concat (Tag,Tag1,Tag2),
  	need_Wrap (IS,Tag0,Txt).
  flow_Txt (IS,font (0,_),Txt) :- !,
  	%html_repeat_Format (Tag0),
  	Tag0 = "",
  	concat ("</FONT>",Tag0,Tag1),
  	need_Wrap (IS,Tag1,Txt).
  %
  %    Hypertext elements
  %
  flow_Txt (IS,a(Attlist,Flow),Txt) :- !,
	make_AttFlowTag ("A",Attlist,Flow,Tag),need_Wrap (IS,Tag,Txt).
  flow_Txt (IS,fn(Attlist,Flow),Txt) :- !,
	make_AttFlowTag ("FN",Attlist,Flow,Tag),need_Wrap (IS,Tag,Txt).
  %
  %   Block elements
  %   Paragraph supports only alignment
  %
  /*
  flow_Txt (IS,par(Attlist,Flow),Txt) :- 
	html_att_member (doc_att("align",Val),Attlist),!,
	make_OpenBlock (IS,"P",[doc_att("ALIGN",Val)],Flow,Txt).
  */
  flow_Txt (IS,par(_Attlist,Flow),Txt) :- !,
	make_OpenBlock (IS,"P",_Attlist,Flow,Txt).
  flow_Txt (IS,blockquote(Attlist,Flow),Txt) :- !,
	make_CloseBlock (IS,"BLOCKQUOTE",Attlist,Flow,Txt).
  flow_Txt (_IS,preformatted(Attlist,Flow),Txt) :- !,
  	retractall(in_preformatted),
  	assert(in_preformatted),
	make_CloseBlock ("PRE",Attlist,Flow,Txt),
	retractall(in_preformatted).
  flow_Txt (IS,note(Attlist,Flow),Txt) :- !,
	make_CloseBlock (IS,"NOTE",Attlist,Flow,Txt).
  flow_Txt (IS,form(Attlist,Flow),Txt) :- !,
	make_CloseBlock (IS,"FORM",Attlist,Flow,Txt).
  flow_Txt (IS,address(Attlist,Flow),Txt) :-!,
  	make_CloseBlock (IS,"ADDRESS",Attlist,Flow,Txt).
  flow_Txt (IS,div(Attlist,Flow),Txt) :- !,
  	make_CloseBlock (IS,"DIV",Attlist,Flow,Txt).
  flow_Txt (IS,ins(Attlist,Flow),Txt) :-!,
  	make_CloseBlock(IS,"INS",Attlist,Flow,Txt).
  flow_Txt (IS,del(Attlist,Flow),Txt) :-!,
  	make_CloseBlock(IS,"DEL",Attlist,Flow,Txt).
  flow_Txt (IS,span(Attlist,Flow),Txt):- 
  	make_AttTag ("SPAN",Attlist,"",Tag1),
  	str_len (Tag1,Len),
	reset_Wrap (Len),
  	close_Tag ("SPAN",Tag2),
  	html_Flow (IS,Flow,"",FlowTxt),
  	concat(IS,FlowTxt_wo_IS,FlowTxt),!,
  	format(Txt,"%s%s%s",Tag1,FlowTxt_wo_IS,Tag2).
  flow_Txt (IS,heading(Level,Attlist,Flow),Txt) :- !,
  	str_int (SLevel,Level),
  	concat ("H",SLevel,Tag),
	make_Heading (IS,Tag,Attlist,Flow,Txt).
  %
  %   Lists
  %
  flow_Txt (IS,ul(Attlist,LH,LIL),Txt) :- !,
	make_List (IS,"UL",Attlist,LH,LIL,Txt).
  flow_Txt (IS,ol(Attlist,LH,LIL),Txt) :- !,
	make_List (IS,"OL",Attlist,LH,LIL,Txt).
  flow_Txt (IS,dl(Attlist,LH,LIL),Txt) :- !,
	make_List (IS,"DL",Attlist,LH,LIL,Txt).
  %
  %   Form elements (controls)
  %
  flow_Txt (IS,input(Attlist),Txt) :- !,
	make_AttTag ("INPUT",Attlist,"",Tag),need_Wrap(IS,Tag,Txt).
  flow_Txt (IS,select(Attlist,Optlist),Txt) :- !,
  	make_AttTag ("SELECT",Attlist,"",Tag1),
  	close_Tag ("SELECT",Tag2),
  	concat (IS,"\t",IS1),
  	opt_ListTxt (IS1,Optlist,"",OptTxt),
	format (Txt,"\n%s%s%s\n%s%s",IS,Tag1,OptTxt,IS,Tag2).
  flow_Txt (IS,textarea(Attlist,Init),Txt) :- !,
  	make_AttTag ("TEXTAREA",Attlist,"",Tag1),
  	close_Tag ("TEXTAREA",Tag2),
  	pre_Txt (Init,InitTxt),
  	format (Txt,"\n%s%s%s\n%s%s",IS,Tag1,InitTxt,IS,Tag2).
  %
  %   Tables and figures
  %
  flow_Txt (IS,table(Attlist,Caption,RowList),Txt) :- !,
  	Table4=table4(Attlist,Caption,[],[],[],[tbody([],RowList)]),
  	flow_Txt(IS,Table4,Txt).
  flow_Txt (IS,table4(Attlist,Caption,ColGroup_List,Thead_List,Tfoot_List,TBody_list),Txt):-!,
  	concat (IS,"\t",IS1),
  	make_TableCaption(IS1,Caption,CapTxt),
  	make_TableHead(IS1,Thead_list,TheadRowsTxt),
  	make_TableFoot(IS1,TFoot_list,TFootRowsTxt),
  	make_TableBody(IS1,TBody_list,TBodyRowsTxt),
  	make_TableColgroup(IS1,ColGroup_List,ColGroupTxt),
  	make_AttTag ("TABLE",Attlist,"",Tag1),
  	close_Tag ("TABLE",Tag2),
  	format(Txt,"\n%s%s%s%s%s%s%s\n%s%s",IS,Tag1,CapTxt,ColGroupTxt,TheadRowsTxt,TFootRowsTxt,TBodyRowsTxt,IS,Tag2).

  flow_Txt (IS,map(Attlist,AreaList),Txt) :- !,
        concat (IS,"\t",IS1),
  	area_ListTxt (IS1,AreaList,"",AreaTxt),
        make_AttTag ("MAP",Attlist,"",Tag1),
        close_Tag ("MAP",Tag2),
        reset_Wrap (0),
        format (Txt,"\n%s%s%s\n%s%s",IS,Tag1,AreaTxt,IS,Tag2).

  flow_Txt (IS,tag(Name,1,Attlist),Txt) :- !,
        make_AttTag(Name,Attlist,"",Tag),need_Wrap(IS,Tag,Txt).
  flow_Txt (IS,tag(Name,0,_),Txt) :- !,
        close_Tag (Name,Tag),need_Wrap(IS,Tag,Txt).
  % all others will be commented
  flow_Txt (IS,T,Txt) :- term_str(doc_flow_element,T,S),
  	format (Txt,"\n%s<!-- %s -->",IS,S).

  need_Wrap (_,Str,Str):-
  	in_preformatted,!.
  need_Wrap (_IS,Str,Str) :-
  	str_len(Str,Len),
  	wrap_Pos(Pos),
  	NewPos = Pos + Len,
  	Len < 80,!,
  	%format (Txt,"%s%s",IS,Str),
  	reset_Wrap (NewPos).
  need_Wrap (IS,Str,Txt) :-
  	wrap(80,IS,Str,[],SL,NewPos),
  	html_slist_string(SL,StrWrapped),
  	%str_len (Str,Len),
  	format (Txt,"%s%s",IS,StrWrapped),
  	reset_Wrap (NewPos).
  	
  wrap(WrapPos,IS,Str,Buff,Slist,NewWrapPos):-
    	searchchar(Str,'\n',Pos),
    	Pos<WrapPos,
    	P1=Pos-1,
    	frontstr(P1,Str,Front,R1),
    	Buff1=[Front|Buff],
    	frontchar(R1,_,R2),!,
    	wrap(WrapPos,IS,R2,Buff1,Slist,NewWrapPos).
  wrap(WrapPos,IS,Str,Buff,Slist,NewWrapPos):-
    	frontstr(WrapPos,Str,F1,R1),
    	searchchar(R1,' ',Pos),
    	frontstr(Pos,R1,F2,R2),!,
    	concat(F1,F2,F),
    	Buff1=[F|Buff],!,
    	wrap(WrapPos,IS,R2,Buff1,Slist,NewWrapPos).
  wrap(_WrapPos,IS,Str,Buff,Slist,NewWrapPos):-
    	Buff1=[Str|Buff],
    	str_len(Str,NewWrapPos),
    	reverse_and_nl(IS,Buff1,Slist).
  	
  reset_Wrap (Pos) :-
  	retractall (wrap_Pos(_)),
  	assert(wrap_Pos(Pos)).
   %
   %   Add NL to each line except of last
   %
   reverse_and_nl(IS,X,Y) :- reverse_and_nl_1(IS,X,[],Y).
   reverse_and_nl_1(_,[],Y,Y):-!.
   reverse_and_nl_1(IS,[U|X1],X2,Y):- 
   	concat(U,"\n",U1),
   	concat(U1,IS,U2),
   	reverse_and_nl_1(IS,X1,[U2|X2],Y).
 
/******************************************************
 *   Check if we need table border                    *
 ******************************************************/
PREDICATES
  determ has_BorderedRow (trow_list)
  determ has_BorderedCell (cell_list)
  determ is_RowBordered (trow)
CLAUSES  
  %
  %  form IPF we can get frame or rules attributies
  %
  need_Border_1 (Attlist,Attlist) :-
  	html_att_member (doc_att("border",_),Attlist),!.
  need_Border_1 (Attlist,Attlist1) :-
  	html_att_member (doc_att("frame",_),Attlist),!,
        Attlist1 = [doc_att("border",nill)|Attlist]. 
  need_Border_1 (Attlist,Attlist1) :-
  	html_att_member (doc_att("rules",_),Attlist),!,
        Attlist1 = [doc_att("border",nill)|Attlist]. 
  need_Border_1 (Attlist,Attlist).
  %
  %  from RTF we can get border from any row or cell
  %
  need_Border_2 (_RowList,Attlist,Attlist) :-
  	html_att_member (doc_att("border",_),Attlist),!.
  need_Border_2 (RowList,Attlist,Attlist1) :-
  	has_BorderedRow (RowList),!,
  	Attlist1 = [doc_att("border",nill)|Attlist].
  need_Border_2 (_RowList,Attlist,Attlist).
  %
  %  has_BorderedRow/1 - success if any row or cell in table has border
  %                      It is often come from RTF
  %  	
  has_BorderedRow ([]) :- !,fail.
  has_BorderedRow ([H|_]) :-
  	is_RowBordered (H),!.
  has_BorderedRow ([_|T]) :-
  	has_BorderedRow (T).
  	
  is_RowBordered (Row) :-
  	Row = trow(Attlist,_),
  	html_att_member (doc_att("border",_),Attlist),!.
  is_RowBordered (Row) :-
  	Row = trow(_,Cells),
  	has_BorderedCell (Cells).
  %
  %  has_BorderedCell/1 - success if any cell in row has border
  %
  has_BorderedCell ([]) :- !,fail.
  has_BorderedCell ([H|_]) :-
  	H = th(Attlist,_),
  	html_att_member (doc_att("border",_),Attlist),!.
  has_BorderedCell ([H|_]) :-
  	H = td(Attlist,_),
  	html_att_member (doc_att("border",_),Attlist),!.
  has_BorderedCell ([_|T]) :-
  	has_BorderedCell (T).
  
  pre_Txt ("","") :- !.
  pre_Txt (Init,InitTxt) :- concat("\n",Init,InitTxt).

/***********************************************************
 *   Miscaleneous                                          *
 ***********************************************************/
PREDICATES
  procedure att_Txt (doc_att,string)
  procedure indent_1 (integer,string,string)
CLAUSES
  %
  %  html_att_member/2 - unifies doc_att with list member
  %
  html_att_member (doc_att(Name1,Val),[doc_att(Name2,Val)|_]) :-
  	upper_lower (UN1,Name1),
  	upper_lower (UN2,Name2),
  	UN1 = UN2,!.
  html_att_member (Att,[_|T]) :- html_att_member (Att,T).
  %
  %  html_member/2 - classic
  %
  html_member (X,[X|_]) :-!.
  html_member (X,[_|Y]) :-!,html_member (X,Y).
  %
  %  exclude_Attribute/3 - filter attribute's list
  %
  html_exclude_Attribute (_,[],AL,AL).
  html_exclude_Attribute (ExList,[H|T],Buff,AL2) :-	% match - exclude it !!!
  	H = doc_att(Name,_Val),
  	upper_lower(UName,Name),
  	html_member(UName,ExList),!,
  	html_exclude_Attribute (ExList,T,Buff,AL2).
  html_exclude_Attribute (ExList,[H|T],Buff,AL2) :-!,
  	html_exclude_Attribute (ExList,T,[H|Buff],AL2).
  %
  %  html_str_val/2 - extract atom or literal value
  %
  html_str_val(lit(S),S):-!.
  html_str_val(atom(S),S):-!.
  %
  %  make_AttTag/4 - format tag with attribute list
  %
  make_AttTag (Key,[],Buff,Tag) :- 
  	concat("<",Key,B1),
  	concat(B1,Buff,B2),
  	concat(B2,">",Tag).
  	%format (Tag,"<%s%s>",Key,Buff).
  make_AttTag (Key,[H|T],Buff,Tag) :-
	att_Txt (H,AttTxt),
	%concat (Buff," ",B1),
	%concat (B1,AttTxt,Buff_1),!,
	format (Buff_1,"%s %s",Buff,AttTxt),!,
	make_AttTag (Key,T,Buff_1,Tag).
  %
  %  att_Txt/2 - format attribute
  %
  att_Txt (doc_att(Name,nill),Name) :-!.
  att_Txt (doc_att(Name,atom(Val)),Txt) :- !,
  	format(Txt,"%s=%s",Name,Val).
  att_Txt (doc_att(Name,lit(Val)),Txt) :- !,
  	format(Txt,"%s=\"%s\"",Name,Val).
  att_Txt (doc_att(Name,num(Val)),Txt) :-
	str_int (S,Val),
	format(Txt,"%s=%s",Name,S).
  %
  %  close_Tag/2 - format enclosing tag
  %
  close_Tag (Str,Tag) :-
  	concat ("</",Str,S1),
  	concat (S1,">",Tag).
  %
  %  make_BoolTag/3 - construct boolean tag i.e <B> or </B>
  %
  make_BoolTag (Key,1,Tag) :-
  	font_Tag (Key),!,
  	format (Tag,"<%s>",Key).
  make_BoolTag (Key,1,Tag) :-
  	assert (font_Tag(Key)),!,
  	format (Tag,"<%s>",Key).
  make_BoolTag (Key,0,Tag) :- !,
  	format (Tag,"</%s>",Key),
  	retractall (font_Tag(Key)).
  make_BoolTag (_,_,"").
  %
  %  make_BoolAttTag/4 - construct boolean tag with attributies
  %
  make_BoolAttTag (Key,1,Attlist,Tag) :- !,make_AttTag (Key,Attlist,"",Tag).
  make_BoolAttTag (Key,0,_,Tag) :- !, format (Tag,"</%s>",Key).
  %
  %  make_AttFlowTag/4 - constructs tag with enclosed text flow
  %                      like <A>....</A>
  %
  make_AttFlowTag (Key,Attlist,Flow,Txt) :-
	make_AttTag (Key,Attlist,"",Tag1),
	close_Tag (Key,Tag2),
	html_Flow ("",Flow,"",FlowTxt),
	concat (Tag1,FlowTxt,T1),
	concat (T1,Tag2,Txt).
  %
  %  make_OpenBlock/4 - conctruct "open" block - like <P><LI>
  %
  make_OpenBlock (IS,Key,Attlist,Flow,Txt) :-
        make_AttTag (Key,Attlist,"",Tag),
	str_len (Tag,Len),
	reset_Wrap (Len),
	html_Flow (IS,Flow,"",FlowTxt),
	format (Txt,"\n%s%s%s",IS,Tag,FlowTxt).
  %
  %  make_CloseBlock/5 - conctructs "enclosed" block
  %                       like <LH>..</LH><BQ>..</BQ>
  %
  make_CloseBlock (IS,Key,Attlist,Flow,Txt) :-
	make_AttTag (Key,Attlist,"",Tag1),
	close_Tag (Key,Tag2),
	reset_Wrap (0),
	concat (IS,"\t",IS1),
	html_Flow (IS1,Flow,"",FlowTxt),
	format (Txt,"\n%s%s\n%s%s\n%s%s",IS,Tag1,IS1,FlowTxt,IS,Tag2).
  %
  %  make_CloseBlock/4 - conctructs "enclosed" block without indents
  %                       like <PRE>....</PRE>
  %
  make_CloseBlock (Key,Attlist,Flow,Txt) :-
	make_AttTag (Key,Attlist,"",Tag1),
	close_Tag (Key,Tag2),
	reset_Wrap (0),
	html_Flow ("",Flow,"",FlowTxt),
	format (Txt,"\n%s%s%s",Tag1,FlowTxt,Tag2).
  %
  %  make_Heading/5 - make the heading tag.
  %                   if this heading is a link target, then 
  %                   embed the link anchor <A>..</A> inside
  %
  make_Heading (IS,Key,Attlist,Flow,Txt) :-
  	html_att_member (doc_att("id",Val),Attlist),!,
        NewFlow = [a([doc_att("name",Val)],Flow)],
        make_CloseBlock (IS,Key,Attlist,NewFlow,Txt).
  make_Heading (IS,Key,Attlist,Flow,Txt) :-
  	html_att_member (doc_att("res",Val),Attlist),!,
        NewFlow = [a([doc_att("name",Val)],Flow)],
        make_CloseBlock (IS,Key,Attlist,NewFlow,Txt).
  make_Heading (IS,Key,Attlist,Flow,Txt) :-
  	html_att_member (doc_att("name",Val),Attlist),!,
        NewFlow = [a([doc_att("name",Val)],Flow)],
        make_CloseBlock (IS,Key,Attlist,NewFlow,Txt).
  make_Heading (IS,Key,Attlist,Flow,Txt) :-
  	make_CloseBlock (IS,Key,Attlist,Flow,Txt).
/******************************************************************************
   Make the List Element
******************************************************************************/
predicates
  procedure li_ListTxt (string IS,li_list,string Txt)
  procedure li_List_Slist(string IS,li_list,slist)
  procedure li_Txt (string IS,li,string Txt)
clauses
  %
  %  make_List/5 - constructs the list block
  %
  make_List (IS,Key,Attlist,LH,LIL,Txt) :-
	make_AttTag (Key,Attlist,"",Tag1),
	close_Tag (Key,Tag2),
	LH = lh(LH_Attlist,LH_Flow),
	make_AttFlowTag ("LH",LH_Attlist,LH_Flow,Header),
	concat (IS,"\t",IS1),
	li_ListTxt (IS1,LIL,ListContent),
	format (Txt1,"\n%s%s\n%s%s",IS,Tag1,IS,Header),
	format (Txt2,"\n%s%s",IS,Tag2),
	html_slist_string([Txt1,ListContent,Txt2],Txt).
  %
  %  li_ListTxt/4 - loop to convert list item list to the text
  %
  li_ListTxt (IS,L,Txt):-
  	li_List_Slist(IS,L,SL),
  	html_slist_string(SL,Txt).
  
  li_List_Slist(_,[],[]).
  li_List_Slist(IS,[H|T],[HTxt|Tail]):-
  	li_Txt(IS,H,HTxt),
  	li_List_Slist(IS,T,Tail).

  li_Txt (IS,li(Attlist,Flow),Txt) :- !,
	make_OpenBlock (IS,"LI",Attlist,Flow,Txt).
  li_Txt (IS,dt(Attlist,Flow),Txt) :- !,
	make_OpenBlock (IS,"DT",Attlist,Flow,Txt).
  li_Txt (IS,dd(Attlist,Flow),Txt) :- !,
	make_OpenBlock (IS,"DD",Attlist,Flow,Txt).
/******************************************************************************
   Table rendering
******************************************************************************/
predicates
  procedure cell_ListTxt (string IS,cell_list,string Txt)
  procedure cell_List_Slist(string IS,cell_list,slist)
  procedure cell_Txt (string IS,cell,string Txt)
  procedure col_List_Slist(string IS,col_list,slist)
  procedure col_ListTxt(string IS,col_list,string)
  procedure colGroup_List_Slist(string IS,colgroup_list,slist)
  procedure row_ListTxt(string IS,trow_list,string Txt)
  procedure row_List_Slist(string IS,trow_list,slist)
  procedure row_Txt(string IS,trow,string)
  procedure thead_List_Slist(string IS,thead_list,slist)
  procedure tfoot_List_Slist(string IS,tfoot_list,slist)
  procedure tbody_List_Slist(string IS,tbody_list,slist)
clauses
  %
  %  make_TableCaption/4 - renders the table caption
  %
  make_TableCaption(_,caption(_Atts,[]),""):-!.
  make_TableCaption(IS,caption(Atts,Flow),Txt):-
  	make_CloseBlock (IS,"CAPTION",Atts,Flow,Txt).
  %
  %  make_TableColGroup/3 - renders the COLGROUP element list
  %
  make_TableColGroup(_,[],""):-!.
  make_TableColGroup(IS,List,Txt):-
  	colgroup_List_Slist(IS,LIST,SL),
  	html_slist_string(SL,Txt).

  colgroup_List_Slist(_,[],[]).
  colgroup_List_Slist(IS,[H|T],[HTxt|Tail]):-
    	H=colgroup(Attlist,Col_List),
  	make_AttTag ("COLGROUP",Attlist,"",Tag1),
  	close_Tag ("COLGROUP",Tag2),
  	concat(IS,"\t",IS1),
  	col_ListTxt(IS1,Col_List,ColTxt),
  	format(HTxt,"\n%s%s%s\n%s%s",IS,Tag1,ColTxt,IS,Tag2),
  	colgroup_List_Slist(IS,T,Tail).
  %
  %  col_ListTxt/3 - converts COL element list
  %
  col_ListTxt(IS,ColList,Txt):-
  	col_List_Slist(IS,ColList,SL),
  	html_slist_string(SL,Txt).

  col_List_Slist(_,[],[]).
  col_List_Slist(IS,[H|T],[HStr|Tail]):-
  	H=col(Attlist),
  	make_AttTag("COL",Attlist,"",Tag),
  	format(HStr,"\n%s%s",IS,Tag),
  	col_List_Slist(IS,T,Tail).
  %
  %  make_TableHead/3
  %  make_TableFoot/3
  %  make_TableBody/3  - renders the table rows group
  %
  make_TableHead(_,[],""):-!.
  make_TableHead(IS,List,Txt):-
  	thead_List_Slist(IS,List,SL),
  	html_slist_string(SL,Txt).

  make_TableFoot(_,[],""):-!.
  make_TableFoot(IS,List,Txt):-
  	tfoot_List_Slist(IS,List,SL),
  	html_slist_string(SL,Txt).

  make_TableBody(_,[],""):-!.
  make_TableBody(IS,List,Txt):-
  	tbody_List_Slist(IS,List,SL),
  	html_slist_string(SL,Txt).
  %
  %  thead_List_Slist/3
  %  tfoot_List_Slist/3
  %  tbody_List_Slist/3  - renders the group of rows
  %  	
  thead_List_Slist(_,[],[]).
  thead_List_Slist(IS,[H|T],[HTxt|Tail]):-
  	H=thead(Attlist,Trows),
  	make_AttTag ("THEAD",Attlist,"",Tag1),
  	close_Tag ("THEAD",Tag2),
  	concat(IS,"\t",IS1),
  	row_ListTxt(IS1,Trows,RowsTxt),
  	format(HTxt,"\n%s%s%s\n%s%s",IS,Tag1,RowsTxt,IS,Tag2),
  	thead_List_Slist(IS,T,Tail).

  tfoot_List_Slist(_,[],[]).
  tfoot_List_Slist(IS,[H|T],[HTxt|Tail]):-
  	H=tfoot(Attlist,Trows),
  	make_AttTag ("TFOOT",Attlist,"",Tag1),
  	close_Tag ("TFOOT",Tag2),
  	concat(IS,"\t",IS1),
  	row_ListTxt(IS1,Trows,RowsTxt),
  	format(HTxt,"\n%s%s%s\n%s%s",IS,Tag1,RowsTxt,IS,Tag2),
  	tfoot_List_Slist(IS,T,Tail).

  tbody_List_Slist(_,[],[]).
  tbody_List_Slist(IS,[H|T],[HTxt|Tail]):-
  	H=tbody(Attlist,Trows),
  	make_AttTag ("TBODY",Attlist,"",Tag1),
  	close_Tag ("TBODY",Tag2),
  	concat(IS,"\t",IS1),
  	row_ListTxt(IS1,Trows,RowsTxt),
  	format(HTxt,"\n%s%s%s\n%s%s",IS,Tag1,RowsTxt,IS,Tag2),
  	tbody_List_Slist(IS,T,Tail).
  %
  %  row_ListTxt/3 - loop to convert table rows list (table content)
  %
  row_ListTxt (IS,RowList,Txt):-
  	row_List_Slist(IS,RowList,SL),
  	html_slist_string(SL,Txt).
  
  row_List_Slist(_,[],[]).
  row_List_Slist(IS,[H|T],[HTxt|Tail]):-
  	row_Txt(IS,H,HTxt),
  	row_List_Slist(IS,T,Tail).

  row_Txt(IS,Row,Txt):-
	Row = trow (Attlist,Cell_List),
	html_exclude_Attribute (["BORDER","BORDER.STYLE","LEFT.INDENT"],
				 Attlist,[],Attlist1),
	make_AttTag ("TR",Attlist1,"",Tag),
	concat (IS,"\t",IS1),
	cell_ListTxt (IS1,Cell_List,RowTxt),
	format (Txt,"\n%s%s%s",IS,Tag,RowTxt).

  cell_ListTxt (IS,CellList,Txt):-
  	cell_List_Slist(IS,CellList,SL),
  	html_slist_string(SL,Txt).

  cell_List_Slist(_,[],[]).
  cell_List_Slist(IS,[H|T],[HTxt|Tail]):-
  	cell_Txt(IS,H,HTxt),
  	cell_List_Slist(IS,T,Tail).

  cell_Txt (IS,th(Attlist,Flow),Txt) :- !,
  	html_exclude_Attribute (["BORDER","BORDER.STYLE"],Attlist,[],Attlist1),
  	make_OpenBlock (IS,"TH",Attlist1,Flow,Txt).
  cell_Txt (IS,td(Attlist,Flow),Txt) :- !,
  	html_exclude_Attribute (["BORDER","BORDER.STYLE"],Attlist,[],Attlist1),
  	make_OpenBlock (IS,"TD",Attlist1,Flow,Txt).
  %
  %  opt_ListTxt/4 - loop to convert option list in <SELECT> element
  %
  opt_ListTxt (_,[],Txt,Txt).
  opt_ListTxt (IS,[H|T],Buff,Txt) :-
  	H = doc_option(Attlist,Item),
  	make_AttTag ("OPTION",Attlist,"",Tag),
  	format (Buff1,"%s\n%s%s%s",Buff,IS,Tag,Item),
  	opt_ListTxt (IS,T,Buff1,Txt).
  %
  %  area_ListTxt/4 - loop to convert area list in <MAP> element
  %
  area_ListTxt (_,[],Txt,Txt).
  area_ListTxt (IS,[H|T],Buff,Txt) :-
	H = area (Attlist),
  	make_AttTag ("AREA",Attlist,"",Tag),
  	format (Buff1,"%s\n%s%s%s",Buff,IS,Tag),
  	area_ListTxt (IS,T,Buff1,Txt).
  %
  %  indent/2 - format indentation string
  %
  indent (L,S) :- indent_1 (L,"",S).
  indent_1 (0,S,S).
  indent_1 (L,B,S) :-
  	L1 = L - 1,
  	concat (B,"\t",B1),
  	indent_1 (L1,B1,S).

/******************************************************
 *  FONT HANDLING                                     *
 ******************************************************/
PREDICATES
  procedure html_get_FontEncoding (doc_attlist, integer Code)
  procedure html_get_FontSize     (doc_attlist, integer Size)
  determ    html_get_FontSize_2   (string,  integer Size)
  procedure html_get_FaceName     (doc_attlist, string FaceStr)
  procedure html_get_FontColor    (doc_attlist, string ColorStr)
  procedure html_get_FontClass    (doc_attlist, string ClassStr)
  procedure html_calc_FontSize    (integer Code, integer Size, string SzStr)
  procedure format_FontTags       (html_slist, string, string)
CLAUSES
  make_FontTag (Attlist,Tag) :-
	html_get_FontEncoding (Attlist,Code),
	html_get_FontSize (Attlist,Size),
	html_calc_FontSize (Code,Size,SzStr),
	html_get_FaceName (Attlist,FaceStr),
	html_get_FontColor (Attlist,ColorStr),
	html_get_FontClass (Attlist,ClassStr),
	format (Tag,"<FONT%s%s%s%s>",FaceStr,SzStr,ColorStr,ClassStr).
  %
  %  html_get_Font_Encoding/2 - retrive the font encoding
  %                1 - absolute font size value given (RTF/IPF)
  %                2 - relative font size value given (HTML)
  %
  html_get_FontEncoding (Attlist,1) :-
  	html_att_member (doc_att("ABSOLUTE",nill),Attlist),!.
  html_get_FontEncoding (_,2).
  %
  % html_get_FontSize/2 - extracts font size
  %
  html_get_FontSize (Attlist,Size) :-
  	html_att_member (doc_att("SIZE",num(Size)),Attlist),!.
  html_get_FontSize (Attlist,Size) :-
	html_att_member (doc_att("SIZE",Val),Attlist),
	html_str_val (Val,SzStr),
	html_get_FontSize_2 (SzStr,Size),!.
  html_get_FontSize (_,0).

  html_get_FontSize_2 (SzStr,Size) :-
	fronttoken (SzStr,Front,_),
	str_int (Front,Size).
  %
  % html_get_FaceName/2 - extracts face name
  %
  html_get_FaceName (Attlist,FaceStr) :-
  	html_att_member (doc_att("FACE",Val),Attlist),
  	html_str_val (Val,Face),!,
  	format (FaceStr," FACE=\"%s\"",Face).
  html_get_FaceName (Attlist,FaceStr) :-
  	html_att_member (doc_att("FACENAME",Val),Attlist),
  	html_str_val (Val,Face),!,
  	format (FaceStr," FACE=\"%s\"",Face).
  html_get_FaceName (_,"").
  %
  %  html_get_FontColor/2 - extracts font color
  %
  html_get_FontColor (Attlist,ColorStr) :-
  	html_att_member (doc_att("COLOR",Val),Attlist),
  	html_str_val (Val,Color),!,
  	format (ColorStr," COLOR=\"%s\"",Color).
  html_get_FontColor (_,"").
  %
  %  html_get_FontClass/2 - extracts font class
  %
  html_get_FontClass (Attlist,ClassStr) :-
  	html_att_member (doc_att("CLASS",Val),Attlist),
  	html_str_val (Val,_Class),!,
  	format (ClassStr," CLASS=\"%s\"",_Class).
  html_get_FontClass (_,"").
  %
  %  html_calc_FontSize/3 - calculates font size
  %
  %  size is not set at all
  html_calc_FontSize (_,0,"") :- !.
  %  absolute (RTF/IPF)
  html_calc_FontSize (1,Sz," SIZE=1") :-Sz <= 8,!.	% 8 pt
  html_calc_FontSize (1,Sz," SIZE=2") :-Sz <= 10,!.	% 10 pt
  html_calc_FontSize (1,Sz," SIZE=3") :-Sz <= 12,!. 	% 12 pt
  html_calc_FontSize (1,Sz," SIZE=4") :-Sz <= 14,!.	% 14 pt
  html_calc_FontSize (1,Sz," SIZE=5") :-Sz <= 18,!.	% 18 pt
  html_calc_FontSize (1,Sz," SIZE=6") :-Sz <= 24,!.	% 24 pt
  html_calc_FontSize (1,Sz," SIZE=7") :- Sz > 24,!.	% 32 pt
  %  Relative (like Netscape)
  html_calc_FontSize (2,Sz,SzStr) :- format (SzStr," SIZE=%d",Sz),!.
  %  Ignore on any errors
  html_calc_FontSize (_,_,"").

  %
  %  NETSCAPE's </FONT> bypassed all previous formatting (<B>,<EM>...)
  %  so repeat them after </FONT>
  %
  %  It is not need for IEXPLORE, SPRY ..
  %
  html_repeat_Format (TagStr) :-
  	findall (Tag,font_tag(Tag),TagList),
	format_FontTags (TagList,"",TagStr).

  format_FontTags ([],TS,TS).
  format_FontTags ([H|T],Buf,TagStr) :-
  	format (Buf1,"%s<%s>",Buf,H),
  	format_FontTags (T,Buf1,TagStr).
/**************************************************
 *                                                *
 *  The simplest (as possible) error handler      *
 *                                                *
 **************************************************/
  html_yyerror (S) :-
	write (S),
	fail.


