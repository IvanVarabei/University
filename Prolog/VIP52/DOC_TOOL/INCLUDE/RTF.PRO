/******************************************************************************

                 Copyright (C) 1984 - 2000 Prolog Development Center A/S

				VISUAL PROLOG

 File name: RTF.PRO
 PURPOSE  : RTF from/to Prolog converter

 COMMENTS:  Implements rtfpage_term (o,i)
                       rtfpage_term_style (o,i)

 Written by Oleg V. Erjomin
 
 22.3.98   Implement tables
 31.3.98   Implement coloured fonts
 24.4.2000 Added tags : \ldblquote \rdblqoute

******************************************************************************/
ifndef rtf_Pre_Included
 #ERROR: file rtf.pre must be included
enddef

GLOBAL PREDICATES
  procedure rtf_movemem(ulong,ulong,unsigned) - (i,i,i) language c as "_MEM_MovMem"  
  
CONSTANTS
 rtf_pro_included = 1

DATABASE - rtf_doc_info
   rtf_doc_source (string)
   rtf_doc_units (string)

DATABASE - rtf_style_sheet
  fontstyle (integer Style,
             string  FaceName,
             string Family,
             integer Size,
             RTF_ILIST  Effects)
  determ deftab (integer)
  determ last_para
PREDICATES
  procedure make_PageHead (doc_head,string,string)

  procedure rtf_head_Txt (doc_headelem,string)
  procedure rtf_make_Flow (doc_flow,string Buff,string FlowTxt)
  
  procedure plain
  procedure get_f(integer)
  procedure get_fs(integer)
  procedure get_fc(integer)
  procedure get_bc(integer)
  procedure get_DefTab (integer)
  procedure rtf_maxint (integer,integer,integer)
  nondeterm ucase_att_member (doc_att,doc_attlist)
  determ    doc_str_val (doc_attval,string)
  procedure rtf_listconc(doc_flow,doc_flow,doc_flow)
  procedure rtf_listconc(trow_list,trow_list,trow_list)
CLAUSES
  %
  %  Version for DOCGEN
  %   - no page header informaton
  %
  rtfpage_term (Page,Doc) :-
  	rtf_Default_FontStyle,
  	retractall (deftab(_)),
  	assert(deftab(360)),
  	plain,
    	Doc = doc (_Prolog,Head,Body),
    	%make_PageHead (Head,"",PageHead),
    	retractall(_,rtf_doc_info),
    	assert(rtf_doc_source("RTF")),
    	assert(rtf_doc_units("TWIP")),
    	rtf_ApplyDocInfo (Head),
    	Body = doc_body(_Attlist,Flow),
    	rtf_make_Flow (Flow,"",Page).
    	%concat (PageHead,"\n",Txt),
    	%concat (Txt,PageBody,Page).
  %
  %  Apply Document meta information (source,units)
  %
  rtf_ApplyDocInfo ([]).
  rtf_ApplyDocInfo ([H|T]) :-
  	H=doc_meta(Attlist),
  	ucase_att_member (doc_att("NAME",A1),Attlist),
  	doc_str_val(A1,N),
  	upper_lower(N,"source"),
  	ucase_att_member (doc_att("CONTENT",A2),Attlist),
  	doc_str_val(A2,C),
  	upper_lower (USOURCE,C),
  	retractall (rtf_doc_source(_)),
  	assert (rtf_doc_source(USOURCE)),!,
  	rtf_ApplyDocInfo (T).
  rtf_ApplyDocInfo ([H|T]) :-
  	H=doc_meta(Attlist),
  	ucase_att_member (doc_att("NAME",A1),Attlist),
  	doc_str_val(A1,N),
  	upper_lower(N,"units"),
  	ucase_att_member (doc_att("CONTENT",A2),Attlist),
  	doc_str_val(A2,C),
  	upper_lower (UUNITS,C),
  	retractall (rtf_doc_source(_)),
  	assert (rtf_doc_source(UUNITS)),!,
  	rtf_ApplyDocInfo (T).
  rtf_ApplyDocInfo ([_|T]) :- !,
  	rtf_ApplyDocInfo (T).
  %
  %  make_PageHead/3 - constructs the page header
  %
  make_PageHead ([],PageHead,PageHead).
  make_PageHead ([H|T],Buff,PageHead) :-
	rtf_head_Txt (H,Txt),
	concat (Buff,Txt,Buff_1),
	make_PageHead (T,Buff_1,PageHead).
  	
  rtf_maxint (I1,I2,I1) :- I1 > I2,!.
  rtf_maxint (_,I2,I2).
  
  rtf_listconc([],L,L):-!.
  rtf_listconc([X|L1],L2,[X|L3]):-rtf_listconc(L1,L2,L3).

/***********************************************************
 *   Style sheets handling                                 *
 ***********************************************************/
CLAUSES
%
%  Set/Replase font style record
%
  rtf_Set_FontStyle (Style,FaceName,Family,Size,Effects) :-
  	retract(fontstyle(Style,_,_,_,_)),!,
  	assert(fontstyle(Style,FaceName,Family,Size,Effects)).
  rtf_Set_FontStyle (Style,FaceName,Family,Size,Effects) :-
  	assert(fontstyle(Style,FaceName,Family,Size,Effects)).
%
%  Default as for Netscape Navigator and for MS Internet Explorer
%
  rtf_Default_FontStyle :-
  	retractall (fontstyle(_,_,_,_,_)),
  	assert(fontstyle(style_default, "Times New Roman","froman",12,[])),
  	assert(fontstyle(style_heading1,"Times New Roman","froman",24,[fs_Bold])),
  	assert(fontstyle(style_heading2,"Times New Roman","froman",18,[fs_Bold])),
  	assert(fontstyle(style_heading3,"Times New Roman","froman",14,[fs_Bold])),
  	assert(fontstyle(style_heading4,"Times New Roman","froman",12,[fs_Bold])),
  	assert(fontstyle(style_heading5,"Times New Roman","froman",10,[fs_Bold])),
  	assert(fontstyle(style_heading6,"Times New Roman","froman",8, [fs_Bold])),
  	assert(fontstyle(style_code,"Courier","fmodern",12, [])),
  	assert(fontstyle(style_samp,"Courier","fmodern",12, [])),
  	assert(fontstyle(style_tt,"Terminal","fmodern",12, [])),
  	assert(fontstyle(style_kbd,"Courier","fmodern",12, [])),
  	assert(fontstyle(style_var,"Courier","fmodern",12, [fs_Italic])),
  	assert(fontstyle(style_cite,"Times New Roman","froman",12, [fs_Italic])),
  	assert(fontstyle(style_dfn,"Times New Roman","froman",12, [])),
  	assert(fontstyle(style_big,"Times New Roman","froman",18, [])),
  	assert(fontstyle(style_small,"Times New Roman","froman",10, [])).

  get_DefTab (DefTab) :- deftab(DefTab),!.
  get_DefTab (360).
/***********************************************************
 *   Predicates to convert head elements into the          *
 *   RTF string (footnotes)                                *
 ***********************************************************/
PREDICATES
  procedure make_Footnote (string Code, string NoteText, string RTF)
  procedure render_ContextSpot (doc_attlist,string)
  determ meta_RTF (doc_attlist, string Txt)
  determ get_Meta_Content (doc_attlist,string)
CLAUSES
  rtf_head_Txt (doc_title(Str),Txt)    :- make_Footnote ("$",Str,Txt),!.
  rtf_head_Txt (doc_meta(Attlist),Txt) :- meta_RTF (Attlist,Txt),!.
  %
  %  all other head elements converted into the comments
  %
  rtf_head_Txt (HeadElem,Txt) :-
  	term_str (doc_headelem,HeadElem,Str),!,
  	format (Txt,"{\\*{%s}}",Str).
  %
  %  make_Footnote/2 - make the footnote from the corresponding
  %                    document heading element.
  %  The footnote itself is in superscript. Refered text is unchanged
  %
  make_Footnote (Code,Str,Footnote) :-
  	format (Footnote,
  		"\n{\\up6 %s{\\footnote\\pard\\plain {\\up6 %s}%s}}",
  		Code,Code,Str).
  %
  %  meta_RTF/2 - converts some of <META ....> into the appropriate
  %               page attribute (footnote)
  %               #K!+
  %
  meta_RTF (Attlist,Txt) :-
  	ucase_att_member (doc_att("HTTP-EQUIV",Val),Attlist),
  	doc_str_val(Val,Lit),
  	upper_lower ("KEYWORDS",Lit),!,
  	get_Meta_Content (Attlist,Content),
  	make_Footnote ("K",Content,Txt).
  meta_RTF (Attlist,Txt) :-
  	ucase_att_member (doc_att("NAME",Val),Attlist),
  	doc_str_val(Val,Lit),
  	upper_lower ("CONTEXT",Lit),!,
  	get_Meta_Content (Attlist,Content),
  	make_Footnote ("#",Content,Txt).
  meta_RTF (Attlist,Txt) :-
  	ucase_att_member (doc_att("NAME",Val),Attlist),
  	doc_str_val(Val,Lit),
  	upper_lower ("MACRO",Lit),!,
  	get_Meta_Content (Attlist,Content),
  	make_Footnote ("!",Content,Txt).
  meta_RTF (Attlist,Txt) :-
  	ucase_att_member (doc_att("NAME",Val),Attlist),
  	doc_str_val(Val,Lit),
  	upper_lower ("BROWSE_SEQ",Lit),!,
  	get_Meta_Content (Attlist,Content),
  	make_Footnote ("+",Content,Txt).
  %
  %  get_Meta_Content/2 - retrives the "CONTENT" attribute from
  %                       the <META .... CONTENT="...">
  %
  get_Meta_Content (Attlist,Content) :-
  	ucase_att_member (doc_att("CONTENT",Val),Attlist),
  	doc_str_val(Val,Content),!.
  get_Meta_Content (Attlist,Content) :-
  	ucase_att_member (doc_att("CONTENT",Val),Attlist),
  	Val = num(Num),!,
  	str_int (Content,Num).
  %
  %  render_ContextSpot/2 - render the named link targets as #footnote
  %
  render_ContextSpot (Attlist,ContextSpot) :-
  	ucase_att_member (doc_att("ID",Val),Attlist),
  	doc_str_val(Val,Context),!,
  	make_Footnote ("#",Context,ContextSpot).
  render_ContextSpot (Attlist,ContextSpot) :-
  	ucase_att_member (doc_att("ID",Val),Attlist),
  	Val = num(ContextNum),!,
  	str_int (Context,ContextNum),
  	make_Footnote ("#",Context,ContextSpot).
  render_ContextSpot (_,"").
  	
  %  ucase_att_member/2 - unifies the doc_att(N,V) with the doc_attlist member
  %                       N must be given in upper case
  %
  ucase_att_member (doc_att(Name,Val),[doc_att(N2,Val)|_]) :-
  	upper_lower (UN2,N2),
  	Name = UN2.
  ucase_att_member (Att,[_|T]) :- ucase_att_member (Att,T).

/**********************************************************
 *  Predicates to convert the document's body elements    *
 *  into corresponding RTF string                         *
 **********************************************************/
DATABASE - rtf_wrap_up_internal
  determ rtf_wrap_Pos (integer)
  determ pre
PREDICATES
  procedure rtf_flow_Txt (doc_flow_element,string Txt)
  procedure get_Heading_Format (integer Level,string FormStr)
  procedure get_Heading_Align (doc_attlist,string)
  determ format_Heading_Align (doc_attval,string Tok)
  determ align_Token (string,string)
  nondeterm heading_style (integer,integer)
  procedure fs_Format (integer,string)
  procedure fs_Effects_FormatStr (RTF_ILIST,string,string EffectStr)
  determ fs_Effect_FormatStr (integer,string EffectStr)

  procedure rtf_need_Wrap (string,string)
  procedure rtf_reset_Wrap (integer)
  procedure rtf_need_Blank (string,string)
  procedure rtf_is_space (char)
  
  procedure rtf_BorderFmt (string Prefix, doc_attlist, string Tag)

  procedure rtf_flow_slist(doc_flow,slist)

  procedure rtf_slist_string(slist,string)
  procedure rtf_calc_slist_len(slist,integer,integer)
  procedure rtf_concat_strings(slist,ushort,unsigned)

CLAUSES
  %
  %  rtf_make_Flow/4 - loop to convert text doc_flow into HTML string
  %
  rtf_make_Flow (Flow,_,FlowTxt):-
  	rtf_flow_slist(Flow,SL),
  	rtf_slist_string(SL,FlowTxt).

  rtf_flow_slist([],[]).
  rtf_flow_slist([par(Attlist,Flow)],[Txt]):-
  	retractall (last_para),
  	asserta (last_para),!,
  	rtf_flow_txt (par(Attlist,Flow),Txt).
  rtf_flow_slist([H|T],[HTxt|Tail]):-
  	rtf_flow_Txt(H,HTxt),!,
  	rtf_flow_slist(T,Tail).
  %
  %  C-like slist to string conversion
  %  Avoids concat/3's gstack eating 
  %
  rtf_slist_string(SL,Txt):-  	
  	rtf_calc_slist_len(SL,0,Len),
  	Len1=Len+1,
  	str_len(Txt,Len1),
  	ptr_dword(Txt,SEG,OFF),
  	rtf_concat_strings(SL,SEG,OFF).

  rtf_calc_slist_len ([],L,L).
  rtf_calc_slist_len ([H|T],L,Len):-
   	str_len(H,L0),
   	L1=L+L0,!,
   	rtf_calc_slist_len(T,L1,Len).
   	
  rtf_concat_strings([],SEG,OFF):-
   	Pos=OFF+1,
   	membyte(SEG,Pos,0).
  rtf_concat_strings([H|T],SEG,OFF):-
   	str_len(H,Len),
   	Src=cast(ulong,H),
   	ptr_dword(PNew,SEG,OFF),
   	Dest=cast(ulong,PNew),
	rtf_movemem(Src,Dest,Len),
	OFF1=OFF+Len,
	rtf_concat_strings(T,SEG,OFF1).	

  rtf_need_Blank (Buff,Buff_1) :-
  	Buff <> "",
  	str_len (Buff,Len),
  	subchar (Buff,Len,C),
  	not(rtf_is_space (C)),!,
  	concat (Buff," ",Buff_1).
  rtf_need_Blank (Buff,Buff).
  
  rtf_is_space ('\n').
  rtf_is_space (' ').
  rtf_is_space ('\t').
  %
  %  doc_str_val/2 - extract atom or literal value
  %
  doc_str_val(lit(S),S):-!.
  doc_str_val(atom(S),S):-!.
  %
  %  get_Heading_Format/2 - constructs heading format string
  %
  get_Heading_Format (Level,Str) :-
  	heading_style (Level,Style),!,
  	fs_Format (Style,FormatStr),
  	concat("\n\\par\\pard\\plain",FormatStr,Str).
  get_Heading_Format (_,"\n\\par").
  %
  %  get_Heading_Align/2     - format heading alignment
  %  format_Heading_Align/2 
  %
  get_Heading_Align (Attlist,Align) :-
  	ucase_att_member (doc_att("ALIGN",Val),Attlist),
  	format_Heading_Align (Val,Align),!.
  get_Heading_Align (_Attlist,"").
  	
  format_Heading_Align (atom(Atom),Tok) :-
  	upper_lower (Atom,LAtom),
  	align_Token (LAtom,Tok),!.
  format_Heading_Align (lit(Atom),Tok) :-
  	upper_lower (Atom,LAtom),
  	align_Token (LAtom,Tok),!.
  %
  %  heading_style/2 - unifies heading style and heading level
  %
  heading_style (1,style_heading1).  heading_style (2,style_heading2).
  heading_style (3,style_heading3).  heading_style (4,style_heading4).
  heading_style (5,style_heading5).  heading_style (6,style_heading6).
  heading_style (_,style_default).
  %
  %  fs_Format/2 - render the font assignment
  %
  fs_Format (Style,FormStr) :-
  	fontstyle(Style,_,_,Size,Effects),!,
  	RTFSize = Size+Size,
  	fs_Effects_FormatStr (Effects,"",EffectStr),
  	format (FormStr,"\\f%d\\fs%d%s ",Style,RTFSize,EffectStr).
  fs_Format (_,"").
  %
  %  fs_Effects_FormatStr/3 - loop to convert font effects into RTF format string
  %                           [fs_Bold,fs_Superscript] -> \b\super
  %
  fs_Effects_FormatStr ([],Str,Str).
  fs_Effects_FormatStr ([H|T],Buf,Str) :-
  	fs_Effect_FormatStr (H,F),
  	concat (Buf,F,Buf1),!,
  	fs_Effects_FormatStr (T,Buf1,Str).
  fs_Effects_FormatStr ([_|T],Buf,Str) :-
  	fs_Effects_FormatStr (T,Buf,Str).
  %
  %  fs_Effect_FormatStr/2 - unifies font effect code with RTF token
  %
  fs_Effect_FormatStr (fs_Bold,"\\b").
  fs_Effect_FormatStr (fs_Italic,"\\i").
  fs_Effect_FormatStr (fs_Underline,"\\ul").
  fs_Effect_FormatStr (fs_Superscript,"\\super").
  fs_Effect_FormatStr (fs_Subscript,"\\sub").
  fs_Effect_FormatStr (fs_DoubleUnderline,"\\uldb").
  fs_Effect_FormatStr (fs_Strike,"\\strike").
  %
  %  rtf_need_Wrap/2 - wrap the string up to 250 characters
  %
  rtf_need_Wrap (Str,Str) :-
  	pre,!.
  rtf_need_Wrap (Str,Str) :-
  	str_len(Str,Len),
  	rtf_wrap_Pos(Pos),
  	NewPos = Pos + Len,
  	Len < 250,!,
  	rtf_reset_Wrap (NewPos).
  rtf_need_Wrap (Str,Txt) :-
  	str_len (Str,Len),
  	format (Txt,"\n%s",Str),
  	rtf_reset_Wrap (Len).
  %
  %  rtf_reset_Wrap/1 - set the new wrap position
  %
  rtf_reset_Wrap (Pos) :-
  	retractall (rtf_wrap_Pos(_)),
  	assert(rtf_wrap_Pos(Pos)).

/**********************************************************
 *  Predicates to convert the text doc_flow elements          *
 *  into corresponding RTF string                         *
 **********************************************************/
DATABASE - format_internal
  determ rtf_bold
  determ rtf_italic
  determ ul
  determ strike
  determ sub
  determ sup
  determ f(integer)
  determ fs(integer)
  determ fc(integer)
  determ bc(integer)
  determ rtf_intbl
 
PREDICATES
  procedure rtf_make_BoolTag  (string Key, bool, string Tag)
  procedure par_AttListFormat (doc_attlist, string, string)
  procedure make_Link         (doc_attlist, string Token)
  procedure make_FontCode     (doc_attlist, string FontCode)
  procedure make_LinkType     (doc_attlist, string Token)
  procedure render_ListHeader (lh, string)
  procedure list_IsCompact (doc_attlist,integer Compact)
  procedure li_UL_Txt (integer Compact,li_list,string Buff,string Txt)
  procedure li_OL_Txt (integer Compact,li_list,integer Count,string Buff,string Txt)
  procedure li_DL_Txt (integer Compact,li_list,string Buff,string Txt)
  
  procedure render_TableRows    (trow_list,string Buff,string TrowTxt)
  procedure render_Caption      (caption,string Caption)
  procedure rtf_get_thead_rows(thead_list Theads,trow_list Buff,trow_list Rows)
  procedure rtf_get_tfoot_rows(tfoot_list Tfoots,trow_list Buff,trow_list Rows)
  procedure rtf_get_tbody_rows(tbody_list Tbodies,trow_list Buff,trow_list Rows)
  
  procedure need_Pard (string Pard)
  procedure set_Bold
  procedure set_Italic
  procedure set_Strike
  procedure set_Underline
  procedure set_Sup
  procedure set_Sub
  procedure set_DB_Format     (string Key)
  procedure retract_DB_Format (string Key)
  procedure set_Font          (integer F,integer FS)
  procedure set_ForeColor     (integer)
  procedure set_BackColor     (integer)
  procedure repeat_Format     (string)
  procedure is_Last_Para      (string)
  procedure rtf_expand_HTML_Sym(string,string)
  procedure rtf_change_nl     (string,string)

CLAUSES
  %================================================================
  %   rtf_flow_Txt/3 - converts doc_flow element into RTF string
  %================================================================
  rtf_flow_Txt (heading(Level,Attlist,Flow),Txt) :-!,
  	get_Heading_Align (Attlist,Align),
  	get_Heading_Format (Level,FormStr),
  	rtf_make_Flow (Flow,"",FlowTxt),
  	format (Txt,"%s%s %s\n\\par\\pard\\plain ",FormStr,Align,FlowTxt).
  %
  %  For DOCGEN - div rendered as paragraph
  %
  rtf_flow_txt (div(Atts,Flow),Txt) :-!,
  	rtf_flow_Txt(par(Atts,Flow),Txt).
  rtf_flow_Txt (txt(Str),Txt) :- !,
  	rtf_expand_HTML_Sym(Str,Str1),
  	rtf_change_nl(Str1,Str2),
  	rtf_need_Wrap (Str2,Txt).
  %
  %  inline elements (i.e. bold/italic etc
  %
  rtf_flow_Txt (b(B),Txt) 	:- !,rtf_make_BoolTag ("b",B,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (u(B),Txt) 	:- !,rtf_make_BoolTag ("ul",B,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (i(B),Txt) 	:- !,rtf_make_BoolTag ("i",B,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (em(B),Txt) 	:- !,rtf_make_BoolTag ("i",B,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (strong(B),Txt)	:- !,rtf_make_BoolTag ("b",B,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (s(B),Txt) 	:- !,rtf_make_BoolTag ("strike",B,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (q(1),Txt)	:- !,rtf_make_BoolTag ("ldblquote",1,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (q(0),Txt)	:- !,rtf_make_BoolTag ("rdblquote",1,Tag),rtf_need_Wrap (Tag,Txt).
  % \\sub \\super has not close tags
  rtf_flow_Txt (sub(1),Txt)	:- !,rtf_make_BoolTag ("sub",1,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (sub(0),Txt)	:- !,
  	retractall (sub),
  	repeat_Format (Tag),
  	rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (sup(1),Txt)	:- !,rtf_make_BoolTag ("super",1,Tag),rtf_need_Wrap (Tag,Txt).
  rtf_flow_Txt (sup(0),Txt)	:- !,
  	retractall (sup),
  	repeat_Format (Tag),
  	rtf_need_Wrap (Tag,Txt).
  %
  %  New HTML 3.0 font Styles  	
  %
  rtf_flow_Txt (code(1),Txt) :-	!,fs_Format (style_Code,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (code(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (samp(1),Txt) :-	!,fs_Format (style_samp,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (samp(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (kbd(1),Txt) :-	!,fs_Format (style_kbd,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (kbd(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (tt(1),Txt) :-	!,fs_Format (style_tt,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (tt(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (var(1),Txt) :-	!,fs_Format (style_var,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (var(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (dfn(1),Txt) :-	!,fs_Format (style_dfn,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (dfn(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (cite(1),Txt) :-	!,fs_Format (style_cite,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (cite(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (big(1),Txt) :-	!,fs_Format (style_big,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (big(0),Txt) :-	!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (small(1),Txt) :-!,fs_Format (style_small,FormStr),rtf_need_Wrap (FormStr,Txt).
  rtf_flow_Txt (small(0),Txt) :-!,repeat_Format (FormStr),rtf_need_Wrap (FormStr,Txt).

  rtf_flow_Txt (br,"\\line\n") :- !,rtf_reset_Wrap(0).
  rtf_flow_Txt (tab(_Attlist),Txt) :- !,rtf_need_Wrap ("\\tab ",Txt).
  %
  %  for DOCGEN - hyperlinks are not rendered
  %
  rtf_flow_Txt (a(_Attlist,Flow),Txt) :- !,
  	rtf_make_Flow (Flow,"",T1),
  	rtf_need_Wrap (T1,Txt).
  rtf_flow_Txt (font(0,_Attlist),Txt) :- !,
  	set_Font (0,24),
  	set_ForeColor (1),
  	set_BackColor (8),
  	repeat_Format (Tag),
  	rtf_need_Wrap(Tag,Txt).
  rtf_flow_Txt (font(1,Attlist),Txt) :- !,
  	make_FontCode (Attlist,FontCode),
  	rtf_need_Wrap (FontCode,Txt).
  %
  %   Block elements
  %
  rtf_flow_Txt (par(Attlist,Flow),Txt) :- !,
  	rtf_reset_Wrap (0),
  	need_Pard (Pard),
  	par_AttListFormat (Attlist,Pard,FormatStr),
  	rtf_BorderFmt ("\\",Attlist,Border),
  	format (FormatStr2,"%s%s%s ",FormatStr,Border),
  	rtf_need_Wrap (FormatStr2,FormatStrWrapped),
  	rtf_make_Flow (Flow,FormatStrWrapped,Txt0),
  	is_Last_Para (ParaBreak),
  	concat (Txt0,ParaBreak,Txt).
  rtf_flow_Txt (span(_Attlist,Flow),Txt):- !,
  	rtf_make_Flow (Flow,"",Txt0),
  	rtf_Need_Wrap(Txt0,Txt).
  rtf_flow_Txt (ins(_Attlist,Flow),Txt):- !,
  	rtf_make_Flow (Flow,"",Txt0),
  	rtf_Need_Wrap(Txt0,Txt).
  rtf_flow_Txt (del(_Attlist,Flow),Txt):- !,
  	rtf_make_Flow (Flow,"",Txt0),
  	rtf_Need_Wrap(Txt0,Txt).
  %
  %  Lists and tables
  %
  rtf_flow_Txt (ul(Attlist,LH,LIL),Txt) :- !,
        render_ListHeader (LH,ListHeader),
	list_IsCompact (Attlist,Compact),
	li_UL_Txt (Compact,LIL,ListHeader,Txt).
  rtf_flow_Txt (ol(Attlist,LH,LIL),Txt) :- !,
        render_ListHeader (LH,ListHeader),
       	list_IsCompact (Attlist,Compact),
	li_OL_Txt (Compact,LIL,1,ListHeader,Txt).
  rtf_flow_Txt (dl(Attlist,LH,LIL),Txt) :- !,
        render_ListHeader (LH,ListHeader),
       	list_IsCompact (Attlist,Compact),
	li_DL_Txt (Compact,LIL,ListHeader,Txt).

  rtf_flow_Txt (table4(Attlist,Caption,_Colgroups,Theads,Tfoots,Tbodies),Txt) :- !,
  	rtf_get_thead_rows(Theads,[],Rows1),
  	rtf_get_tfoot_rows(Tfoots,Rows1,Rows2),
  	rtf_get_tbody_rows(Tbodies,Rows2,RowList),
  	Table=table(Attlist,Caption,RowList),
  	rtf_flow_Txt(Table,Txt).
  rtf_flow_Txt (table(_Attlist,Caption,Rows),Txt) :- !,
  	render_Caption (Caption,CapPar),
  	retractall (rtf_intbl),
  	assert (rtf_intbl),
  	render_TableRows (Rows,"",RowsTxt),
  	format (Txt,"%s\n%s\\pard\n",CapPar,RowsTxt),
  	retractall (rtf_intbl).

  % The following are not specialy rendered in RTF but may contain text doc_flow
  rtf_flow_Txt (fn(Attlist,Flow),Txt) :- !, 
  	render_ContextSpot (Attlist,CntxSpot),
  	rtf_make_Flow (Flow,CntxSpot,Txt).      
  rtf_flow_Txt (note(_Attlist,Flow),Txt) :- !, 
  	rtf_make_Flow (Flow," ",Txt).
  %
  % The PRE is rendered as PAR but surrounded with <CODE> and
  % all NLs will be replaced with \\line
  %
  rtf_flow_Txt (preformatted(_Attlist,Flow),Txt) :- !,
  	retractall(pre),
  	assert(pre),
  	rtf_listconc([code(1)|Flow],[code(0)],FlowPar),
  	rtf_Flow_Txt(par([],FlowPar),Txt),
  	%rtf_make_Flow (Flow," ",Txt),
  	retractall(pre).
  rtf_flow_Txt (form(Attlist,Flow),Txt) :- !,
  	render_ContextSpot (Attlist,CntxSpot),
  	rtf_make_Flow (Flow,CntxSpot,Txt).
   	
  rtf_flow_Txt (blockquote(Attlist,Flow),Txt) :- !,
  	render_ContextSpot (Attlist,CntxSpot),
  	get_DefTab (DefTab),
  	format (Start,"\n\\pard\\li%d%s ",DefTab,CntxSpot),
  	rtf_make_Flow (Flow,Start,BQTxt),
  	concat (BQTxt,"\n\\par",Txt).      % !!!
  	
  %  The folowing are not rendered in RTF at all
  % Form elements (not supported by RTF)
  rtf_flow_Txt (input(_),"") :- !.
  rtf_flow_Txt (select(_,_),"") :- !.
  rtf_flow_Txt (textarea(_,_),"") :- !.

  rtf_flow_Txt (_T,"").
/*
  rtf_flow_Txt (T,Txt) :- term_str(flow_element,T,S),
  	format (Txt,"\n{\\*{%s}}",S).
*/
  %
  %  rtf_make_BoolTag/3 - construct boolean tag i.e \b or \b0
  %
  rtf_make_BoolTag (Key,1,Tag) :- !, 
  	format (Tag,"\\%s ",Key),
  	set_DB_Format (Key).
  rtf_make_BoolTag (Key,0,Tag) :- !, 
  	format (Tag,"\\%s0 ",Key),
  	retract_DB_Format (Key).
  rtf_make_BoolTag (Key,_,"") :- 
  	retract_DB_Format (Key).  
  %
  %  determine in we need \\pard
  %
  need_Pard ("\n") :- rtf_intbl,!.
  need_Pard ("\n\\pard ").
  %
  % set_DB_Format/1     - handle the format database
  % retract_DB_Format/1
  %
  set_DB_Format ("b") :- !, set_Bold.
  set_DB_Format ("i") :- !, set_Italic.
  set_DB_Format ("strike") :- !, set_Strike.
  set_DB_Format ("ul") :- !, set_Underline.
  set_DB_Format (_).
  
  retract_DB_Format ("b") :- !, retractall (rtf_bold).
  retract_DB_Format ("i") :- !, retractall (rtf_italic).
  retract_DB_Format ("strike") :- !, retractall (strike).
  retract_DB_Format ("ul") :- !, retractall (ul).
  retract_DB_Format (_).
  %
  %  is_Last_Para/1 - last paragraph in flow does not end with \\par
  %
  is_Last_Para ("") :- retract(last_para),!.
  is_Last_Para ("\\par\n").

/******************************************************
 *  PARGRAPHS RENDERING                               *
 ******************************************************/
PREDICATES
  procedure par_AttFormat (string Attname, doc_attval, string)
CLAUSES
  %
  %  par_AttListFormat/3 - converts paragraph attributies list into RTF tokens
  %
  par_AttListFormat ([],Str,Str).
  par_AttListFormat ([H|T],Buf,Str) :-
  	H=doc_att(Name,Val),
  	upper_lower (Name,LName),
  	par_AttFormat (LName,Val,Tok),
  	concat (Buf,Tok,Buf1),
  	par_AttListFormat (T,Buf1,Str).
  %
  %  par_AttFormat/2 - converts the paragraph attribute into RTF token
  %                    Those atrtributies that are not corresponed to the
  %                    appropriate RTF token will be ignored
  %
  par_AttFormat ("align",Val,Tok) :-
  	doc_str_val(Val,Lit),
  	upper_lower (Lit,LLit),
  	align_Token (LLit,Tok),!.
  par_AttFormat ("left.indent",num(Indent),Tok) :-!,format (Tok,"\\li%d",Indent).
  par_AttFormat ("right.indent",num(Indent),Tok) :-!,format (Tok,"\\ri%d",Indent).
  par_AttFormat ("first.line.indent",num(Indent),Tok) :-!,format (Tok,"\\fi%d",Indent).
  par_AttFormat ("space.before",num(Indent),Tok) :-!,format (Tok,"\\sb%d",Indent).
  par_AttFormat ("space.after",num(Indent),Tok) :-!,format (Tok,"\\sa%d",Indent).
  par_AttFormat ("space.between",num(Indent),Tok) :-!,format (Tok,"\\sl%d",Indent).
  par_AttFormat ("nowrap",_,"\\keep") :- !.
  par_AttFormat ("noscroll",_,"\\keepn") :- !.
  par_AttFormat (_,_,"").
  %
  %  align_Token/2 - converts paragraph alignment into RTF token
  %
  align_Token ("left","\\ql").		align_Token ("right","\\qr").
  align_Token ("center","\\qc").	align_Token ("justify","\\qj").
/******************************************************
 *  HYPERTEXT LINKS HANDLING                          *
 ******************************************************/
PREDICATES
  determ link_Ref         (doc_attval, string)
  procedure is_MacroLink  (doc_attlist, string)
  procedure cut_first_num (string, string)
CLAUSES 
  %
  %  make_Link/2 - converts hyperlink into RTF "hidden text"
  %
  %                Realy, RTF doesn't suppot hypertext linking
  %                but such features is emulated by MS Windows
  %                Help Compiler/Viewer by using the following:
  %
  %                {\uldb Hotspot}{\v Link_To}
  %
  %                it is equivalent to:
  %
  %                HTML: <A HREF=Link_To>Hotspot</A>
  %                IPF:  :link href=Link_To.Hotspot:elink.
  %
  make_Link (Attlist,Link) :-
  	ucase_att_member (doc_att("HREF",Val),Attlist),
  	link_Ref (Val,Ref),
  	is_MacroLink (Attlist,IsMacro),!,
  	format (Link,"{\\v %s%s}",IsMacro,Ref).
  make_Link (Attlist,Link) :-
  	ucase_att_member (doc_att("NAME",Val),Attlist),
  	link_Ref (Val,Ref),
  	is_MacroLink (Attlist,IsMacro),!,
  	format (Link,"{\\v %s%s}",IsMacro,Ref).
  make_Link (_Attlist,"").
  %
  %  make_LinkType/2 - retrive the link type jump/popup
  %
  make_LinkType (AttList,"\\ul") :-
  	ucase_att_member(doc_att("TYPE",lit("POPUP")),AttList),!.
  make_LinkType (_,"\\uldb").
  %
  %  is_MacroLink/2 - weather the link is help macro
  %
  is_MacroLink (Attlist,"!") :-
  	ucase_att_member(doc_att("TYPE",lit("MACRO")),AttList),!.
  is_MacroLink (_,"").
  %
  %  link_Ref/2 - extracts the link reference
  %
  link_Ref (lit(Ref0),Ref1) :- !, cut_First_Num (Ref0,Ref1).
  link_Ref (atom(Ref0),Ref1) :- !, cut_First_Num (Ref0,Ref1).
  link_Ref (num(RefN),Ref) :- !, str_int (Ref,RefN).
  %
  %  cut_first_num/2 - cut first # character, used in HTML for internal links
  %
  cut_first_num (Ref0,Ref1) :- frontchar (Ref0,'#',Ref1),!.
  cut_first_num (Ref,Ref).
  
/******************************************************
 *  FONT HANDLING                                     *
 ******************************************************/
PREDICATES 
  procedure get_StyleNum      (doc_attlist, integer StyleNum)
  procedure get_FontEncoding  (doc_attlist, integer)
  procedure get_FontSize      (doc_attlist, integer Size)
  procedure get_FontForeColor (doc_attlist, string FC)
  procedure get_FontBackColor (doc_attlist, string BC)
  determ    rtf_GetColorIdx   (string Color, integer Idx)
  procedure round_Color       (integer, integer)
  determ    color_name        (string, integer R, integer G, integer B, integer Idx)
  procedure calc_FontSize     (integer, integer, integer)
  
  procedure repeat_Bold       (string)
  procedure repeat_Italic     (string)
  procedure repeat_Strike     (string)
  procedure repeat_Underline  (string)
  procedure repeat_Sub        (string)
  procedure repeat_Sup        (string)  	
  
CLAUSES
  %
  %  make_FontCode/2 - Font handling
  %
  make_FontCode (Attlist,Code) :-
  	get_StyleNum (Attlist,StyleNum),
  	get_FontEncoding (Attlist,Encoding),
  	get_FontSize (Attlist,Size),
  	get_FontForeColor (Attlist,ForeColor),
  	get_FontBackColor (Attlist,BackColor),
  	calc_FontSize (Encoding,SIze,Size2),
  	set_Font (StyleNum,Size2),
  	format (Code,"\\f%d\\fs%d%s%s ",StyleNum,Size2,ForeColor,BAckColor),!.
  %
  %  get_StyleNum/2 - retrive the style num for the given facename
  %                   or set the default face
  %
  get_StyleNum (Attlist,StyleNum) :-
  	ucase_att_member (doc_att("FACE",Val),Attlist),
  	doc_str_val(Val,FaceName),
	fontstyle (StyleNum,FaceName,_,_,_),!.
  get_StyleNum (Attlist,StyleNum) :-
  	ucase_att_member (doc_att("FACENAME",Val),Attlist),
  	doc_str_val (Val,FaceName),
	fontstyle (StyleNum,FaceName,_,_,_),!.
  get_StyleNum (_,0).
  %
  %  get_Font_Encoding/2 - retrive the font encoding
  %                        1-absolute font size value given (RTF/IPF)
  %                        2-relative font size value given (HTML)
  %
  get_FontEncoding (Attlist,1) :-
  	ucase_att_member (doc_att("ABSOLUTE",nill),Attlist),!.
  get_FontEncoding (_,2).
  %
  % get_FontSize/1 - extracts font size
  %
  get_FontSize (Attlist,Size) :-
  	ucase_att_member (doc_att("SIZE",num(Size)),Attlist),!.
  get_FontSize (Attlist,Size) :-
	ucase_att_member (doc_att("SIZE",Val),Attlist),
	doc_str_val(Val,SzStr),
	fronttoken (SzStr,Front,_),
	str_int (Front,Size),!.
  get_FontSize (_,0).
  %
  %  calc_FontSize/3 - calculates font size
  %
  calc_FontSize (1,0,24)   :-!.			% Absolute, but Size not set -> default size
  calc_FontSize (1,Sz,Sz2) :- !,Sz2 = Sz+Sz. 	% RTF multtyplies font sizes by 2
  %  Relatives (like Netscape)
  calc_FontSize (2,0,16) :-!.	% 8 pt
  calc_FontSize (2,1,16) :-!.	% 8 pt
  calc_FontSize (2,2,20) :-!.	% 10 pt
  calc_FontSize (2,3,24) :-!.	% 12 pt
  calc_FontSize (2,4,28) :-!.	% 14 pt
  calc_FontSize (2,5,36) :-!.	% 18 pt
  calc_FontSize (2,6,48) :-!.	% 24 pt
  calc_FontSize (2,Sz,64) :- Sz > 6,!.	% 32 pt
  calc_FontSize (2,-1,20) :-!.	% 10 pt
  calc_FontSize (2,_,16) :-!.	% 16 pt
  calc_FontSize (_,_,20) :-!.	% default
  %
  %  get_FontForeColor/2 - render font foreground color
  %
  get_FontForeColor (Attlist,ForeColor) :-
  	ucase_att_member (doc_att("COLOR",Val),Attlist),
  	doc_str_val (Val,ColorVal),
  	rtf_GetColorIdx (ColorVal,Idx),!,
  	set_ForeColor (Idx),
  	format (ForeColor,"\\cf%d",Idx).
  get_FontForeColor (_,"").
  %
  %  get_FontBackColor/2 - render font background color
  %
  get_FontBackColor (Attlist,ForeColor) :-
  	ucase_att_member (doc_att("BGCOLOR",Val),Attlist),
  	doc_str_val (Val,ColorVal),
  	rtf_GetColorIdx (ColorVal,Idx),!,
  	set_BackColor (Idx),
  	format (ForeColor,"\\highlight%d",Idx).
  get_FontBackColor (_,"").
  %
  %  rtf_GetColorIdx/2 - calculate RTF table color index
  %
  rtf_GetColorIdx (ColorVal,Idx) :-
  	color_name (ColorVal, _R, _G, _B, Idx),!.
  rtf_GetColorIdx (ColorVal,Idx) :-
  	frontchar (ColorVal,'#',R1),
  	frontstr (2,R1,RStr,R2),
  	frontstr (2,R2,GStr,BStr),
  	concat ("0x",Rstr,Rstr2),
  	concat ("0x",Gstr,Gstr2),
  	concat ("0x",Bstr,Bstr2),
  	str_int (Rstr2,R),
  	str_int (Gstr2,G),
  	str_int (Bstr2,B),
  	round_color (R,RR),
  	round_color (G,GR),
  	round_color (B,BR),
  	color_name (_,RR,GR,BR,Idx).
  %
  %  Color names, RGB values and Color table index
  %
  color_name("black",   0x00, 0x00, 0x00, 1):-!.
  color_name("blue",    0x00, 0x00, 0xFF, 2):-!.
  color_name("aqua",    0x00, 0xFF, 0xFF, 3):-!.  % synomin
  color_name("cyan",    0x00, 0xFF, 0xFF, 3):-!.
  color_name("lime",    0x00, 0xFF, 0x00, 4):-!.
  color_name("fuchsia", 0xFF, 0x00, 0xFF, 5):-!.  % synonim
  color_name("magenta", 0xFF, 0x00, 0xFF, 5):-!.
  color_name("red",     0xFF, 0x00, 0x00, 6):-!.
  color_name("yellow",  0xFF, 0xFF, 0x00, 7):-!.
  color_name("white",   0xFF, 0xFF, 0xFF, 8):-!.
  color_name("navy",    0x00, 0x00, 0x80, 9):-!.
  color_name("teal",    0x00, 0x80, 0x80, 10):-!.
  color_name("green",   0x00, 0x80, 0x80, 11):-!.
  color_name("purple",  0x80, 0x00, 0x80, 12):-!.
  color_name("maroon",  0x80, 0x00, 0x00, 13):-!.
  color_name("olive",   0x80, 0x80, 0x00, 14):-!.
  color_name("gray",    0x80, 0x80, 0x80, 15):-!.
  color_name("silver",  0xC0, 0xC0, 0xC0, 16):-!.
  %
  %  round color values to one of 0x00 0x80 0xC0 0xFF
  %
  round_color (0x00,0x00) :-!.
  round_color (0xFF,0xFF) :-!.
  round_color (0xC0,0xC0) :-!.
  round_color (0x80,0x80) :-!.
  round_color (C,0x00) :- C > 0x00, C<=0x40,!.
  round_color (C,0x80) :- C > 0x40, C<0x80,!.
  round_color (C,0xC0) :- C > 0x80, C<=0xA0,!.
  round_color (_,0xFF) :-!.
  %
  %  Current font database handling
  %  plain set_Font/2 repeat_Format/1 etc.
  %
  plain :-
  	retractall (_,format_internal),
  	assert (f(0)),
  	assert (fs(24)),
  	assert (fc(1)),
  	assert (bc(8)).
  
  set_Font (F,FS) :-
  	retractall (f(_)),
  	retractall (fs(_)),
  	assert (f(F)),
  	assert (fs(FS)).
  	
  set_ForeColor (FC) :- retractall (fc(_)),assert(fc(FC)).
  set_BackColor (BC) :- retractall (bc(_)),assert(bc(BC)).
  
  repeat_Format (Tag) :-
  	repeat_Bold (B),
  	repeat_Italic (I),
  	repeat_Strike (S),
  	repeat_Underline (U),
  	repeat_Sub (Sub),
  	repeat_Sup (Sup),
  	get_f(F), 
  	get_fs(FS),
  	get_fc(FC),
  	get_bc(BC),
  	format (Tag,"\\plain\\f%d\\fs%d\\cf%d\\highlight%d%s%s%s%s%s%s ",
  		F,FS,FC,BC,B,I,S,U,Sub,Sup).
  	
  repeat_Bold ("\\b") :- rtf_bold,!.		repeat_Bold ("").
  repeat_Italic ("\\i") :- rtf_italic,!.	repeat_Italic ("").
  repeat_Strike ("\\strike") :- strike,!.	repeat_Strike ("").
  repeat_Underline ("\\ul") :- ul,!.		repeat_Underline ("").
  repeat_Sub ("\\sub") :- sub,!.		repeat_Sub ("").
  repeat_Sup ("\\super") :- sup,!.		repeat_Sup ("").
  
  set_Bold :- rtf_bold,!.	set_Bold :- assert(rtf_bold).
  set_Italic :- rtf_italic,!.	set_Italic :- assert(rtf_italic).
  set_Strike :- strike,!.	set_Strike :- assert(strike).
  set_Underline :- ul,!.	set_Underline :- assert(ul).
  set_Sub :- sub,!.		set_Sub :- assert (sub).
  set_Sup :- sup,!.		set_Sup :- assert (sup).
  
  get_f(F):-f(F),!.
  get_f(0).
  get_fs(FS):-fs(FS),!.
  get_fs(24).
  get_fc(FC):-fc(FC),!.
  get_fc(1).
  get_bc(BC):-bc(BC),!.
  get_bc(8).
  
/******************************************************
 *  LISTS RENDERING                                   *
 ******************************************************/
PREDICATES
  procedure li_Start   (integer,string,string)
  procedure rtf_li_Txt (li,string Txt)
CLAUSES
  %
  %  render_ListHeader/2 - renders the list header
  %
  render_ListHeader (lh(_Attlist,[]),"") :- !.
  render_ListHeader (lh(_Attlist,Flow),Txt) :-
  	fs_Format (style_list_header,FormStr),
  	rtf_make_Flow (Flow,FormStr,LHTxt),!,
  	concat ("\n\\par ",LHTxt,Txt).
  %
  %  list_IsCompact/2 - determines weather the list is comacted
  %
  list_IsCompact (Attlist,1) :- ucase_att_member (doc_att("COMPACT",_),Attlist),!.
  list_IsCompact (_,0).
  %
  %  li_Start/3 - compacted list's items breaked with \\line, instead of \\par
  %
  li_Start (1,Beg,Start) :- !,concat ("\n\\line",Beg,Start).
  li_Start (_,Beg,Start) :-
  	get_deftab (DT),
  	format (Start,"\n\\par\\pard\\li%d\\fi-%d%s",DT,DT,Beg).
  %
  %  li_UL_Txt/4 - loop to convert unordered list to the text
  %  li_OL_Txt/4 - loop to convert ordered list to the text
  %  li_DL_Txt/4 - loop to convert definition list to the text
  %
  li_UL_Txt (_,[],Txt,Txt1):-concat(Txt,"\n\\par\\pard ",Txt1).
  li_UL_Txt (Compact,[H|T],Buff,Txt) :-
  	li_Start(Compact,"\\bullet\\tab",LiStart),
	rtf_li_Txt (H,LITxt),
	format (Buff1,"%s%s %s",Buff,LiStart,LiTxt),
	li_UL_Txt (Compact,T,Buff1,Txt).
	
  li_OL_Txt (_,[],_,Txt,Txt1):-concat(Txt,"\n\\par\\pard ",Txt1).
  li_OL_Txt (Compact,[H|T],N,Buff,Txt) :-
  	format (Num," %d.\\tab",N),
  	li_Start (Compact,Num,LiStart),
	rtf_li_Txt (H,LITxt),
	N1 = N + 1,
	format (Buff1,"%s%s %s",Buff,LiStart,LiTxt),
	li_OL_Txt (Compact,T,N1,Buff1,Txt).
	
  li_DL_Txt (_,[],Txt,Txt1):-concat(Txt,"\n\\par\\pard ",Txt1).
  li_DL_Txt (Compact,[H|T],Buff,Txt) :-
  	li_Start (Compact,"",LiStart),
	rtf_li_Txt (H,LITxt),
	format (Buff1,"%s%s %s",Buff,LiStart,LiTxt),
	li_DL_Txt (Compact,T,Buff1,Txt).
  %
  %  rtf_li_Txt/2 - renders the list item itself
  %
  rtf_li_Txt (li(_Attlist,Flow),Txt) :- !,rtf_make_Flow (Flow,"",Txt).
  rtf_li_Txt (dt(_Attlist,Flow),Txt) :- !,rtf_make_Flow (Flow,"",Txt).
  rtf_li_Txt (dd(_Attlist,Flow),Txt) :- !,rtf_make_Flow (Flow,"\\tab ",Txt).
  
/******************************************************
 *  The Tables Rendering                              *
 *  As for MS Word for Windows 2.0,6.0,               *
 *         MS Word for DOS 5.0 - 6.0                  *
 ******************************************************/
PREDICATES
  procedure render_TableCells  (cell_list,string DefRowAlign,string Buf,string Row)
  procedure render_CellFormat  (cell_list,integer FirstCellPos,string Buf,string Fmt)
  procedure render_CellFormat2 (doc_attlist,integer Pos1,integer Pos2,string Fmt)
  procedure render_Cell        (cell, string DefRowAlign, string CellTxt)
  procedure cell_Attlist       (cell, doc_attlist)
  procedure get_CellWidth      (doc_attlist, integer)
  procedure has_Align          (doc_attlist, string Align)
  procedure cell_Align         (string DefCell, string DefRow, doc_attlist, string Align)
  %cell_spanned       (doc_attlist, integer CellSpanned)
  %cell_End           (integer CellSpanned,string Buff,string CellEnd)
  procedure trow_Left          (doc_attlist, string Trleft, integer FirstCellPos)
  procedure trow_Gaph          (doc_attlist, string Gaph)
CLAUSES
  %
  %  Extract table rows from various row groups
  %
  rtf_get_thead_rows([],Rows,Rows).
  rtf_get_thead_rows([H|T],B,Rows):-
  	H=thead(_,TRL),
  	rtf_listconc(B,TRL,B1),
  	rtf_get_thead_rows(T,B1,Rows).

  rtf_get_tfoot_rows([],Rows,Rows).
  rtf_get_tfoot_rows([H|T],B,Rows):-
  	H=tfoot(_,TRL),
  	rtf_listconc(B,TRL,B1),
  	rtf_get_tfoot_rows(T,B1,Rows).
  	
  rtf_get_tbody_rows([],Rows,Rows).
  rtf_get_tbody_rows([H|T],B,Rows):-
  	H=tbody(_,TRL),
  	rtf_listconc(B,TRL,B1),
  	rtf_get_tbody_rows(T,B1,Rows).
  
  render_TableRows ([],Tbl,Tbl).
  render_TableRows ([H|T],TblBuf,Tbl) :-
  	H = trow(Attlist,Cells),
  	has_Align (Attlist,DefRowAlign),
	render_TableCells (Cells,DefRowAlign,"",Row),
	trow_Left (Attlist,TrLeft,FirstCellPos),
	trow_Gaph (Attlist,TrGaph),
	rtf_BorderFmt ("\\tr",Attlist,TBorder),
	render_CellFormat (Cells,FirstCellPos,"",CellFmt),
	format (TblBuf1,"%s\n\\trowd%s%s %s %s \\intbl{%s}{\\row}",TblBuf,TrLeft,TrGaph,TBorder,CellFmt,Row),!,
	render_TableRows (T,TblBuf1,Tbl).
  %
  %  trow_Left/2 - get \\trleft if this attribute has in list
  %
  trow_Left (Attlist,TrLeft,Left) :-
  	ucase_att_member (doc_att("LEFT.INDENT",Val),Attlist),
  	Val = num (Left),!,
  	format (TrLeft,"\\trleft%d",Left).
  trow_Left (_,"",0).
  
  trow_Gaph (Attlist,TrGaph) :-
  	ucase_att_member (doc_att("GAPH",Val),Attlist),
  	Val = num (Gaph),!,
  	format (TrGaph,"\\trgaph%d",Gaph).
  trow_Gaph (_,"").
    
  render_TableCells ([],_,Row,Row).
  render_TableCells ([H|T],DefRowAlign,RowBuf,Row) :-
	render_Cell (H,DefRowAlign,CellTxt),
	format (RowBuf1,"%s\n%s",RowBuf,CellTxt),
	render_TableCells (T,DefRowAlign,RowBuf1,Row).
	
  render_CellFormat ([],_,CellFmt,CellFmt).
  render_CellFormat ([H|T],Pos,Buff,CellFmt) :-
  	cell_Attlist (H,Attlist),
  	render_CellFormat2 (Attlist,Pos,Pos2,ThisCellFmt),
  	concat (Buff,ThisCellFmt,Buff1),!,
  	render_CellFormat (T,Pos2,Buff1,CellFmt).
  	
  cell_Attlist (th(Attlist,_),Attlist).
  cell_Attlist (td(Attlist,_),Attlist).
  
  render_CellFormat2 (Attlist,PrevPos,Pos,CellFmt) :-
  	rtf_BorderFmt ("\\cl",Attlist,Border),
  	get_CellWidth (Attlist,Width),
  	Pos = PrevPos+Width,
  	format (CellFmt,"%s\\cellx%d ",Border,Pos).
  %
  %  get_CellWidth/2 - extract cell width or set default to 2 inch
  %
  get_CellWidth (Attlist,Width) :-
  	ucase_att_member (doc_att("WIDTH",num(Width)),Attlist),!.
  get_CellWidth (_,2888).
	
  render_Cell (th(_Attlist,Flow),_DefRowAlign,CellTxt) :-
  	%cell_Align ("\\qc",DefRowAlign,Attlist,CellAlign),
  	%cell_spanned (Attlist,CellSpanned),
  	%cell_end (CellSpanned,"\\cell",CellEnd),
	rtf_make_Flow (Flow,"",CellFlow),
	format (CellTxt,"%s{\\cell}",CellFlow).
  render_Cell (td(_Attlist,Flow),_DefRowAlign,CellTxt) :-
  	%cell_Align ("\\ql",DefRowAlign,Attlist,CellAlign),
  	%cell_spanned (Attlist,CellSpanned),
  	%cell_end (CellSpanned,"\\cell",CellEnd),
	rtf_make_Flow (Flow,"",CellFlow),
	format (CellTxt,"%s{\\cell}",CellFlow).
  	
  cell_Align (_DefCellAlign,_DefRowAlign,Attlist,CellAlign) :-
  	has_Align (Attlist,CellAlign),
  	CellAlign <> "",!.
  cell_Align (DefCellAlign,_DefRowAlign,_Attlist,DefCellAlign) :-
  	DefCellAlign <> "",!.
  cell_Align (_DefCellAlign,DefRowAlign,_Attlist,DefRowAlign).

  has_Align (Attlist,Align) :-
  	ucase_att_member (doc_att("ALIGN",Val),Attlist),
  	doc_str_val (Val,Lit),
  	upper_lower (Lit,LLit),
  	align_Token (LLit,Align),!.
  has_Align (_,"").
  /*	
  cell_spanned (Attlist,CellSpanned) :-
  	ucase_att_member (doc_att("COLSPAN",Val),Attlist),
  	Val = num (CellSpanned),
  	CellSpanned > 1,!.
  cell_spanned (_,1).

  cell_End (1,End,End) :-!.
  cell_End (N,EndBuf,End) :-
  	N1 = N - 1,
  	concat (EndBuf,"\\cell",EndBuf1),
  	cell_End (N1,EndBuf1,End).
  */
  
  render_Caption (caption(Attlist,Flow),CapPar) :-
  	has_Align (Attlist,Align),
  	rtf_make_Flow (Flow,"",CapTxt),
  	format (CapPar,"\n{\\pard %s %s}\\par",Align,CapTxt).

/******************************************************
 *  Border Handling                                   *
 ******************************************************/
PREDICATES
  determ    rtf_BorderBit (string Prefix,integer AttVal,string Style,integer Bit,string Tag)
  determ    rtf_BorderTag (string Prefix,string Style,integer Bit,string Tag)
  procedure rtf_BorderStyle (doc_attlist, string Tag)
  determ    rtf_BorderStyleTag (string Style, string Tag)
  procedure table_Specific (string,string,string)
CLAUSES  
  %
  %  rtf_BorderFmt/3 - render table/cell/par border's type
  %         prefixes - \\cl - cell border
  %                  - \\tr - row border
  %                  - \\   - paragraph border
  %
  %         each border element is followed by style tag
  %
  rtf_BorderFmt (Pfx,Attlist,Tag) :-
  	ucase_att_member (doc_att("BORDER",Val),Attlist),
  	Val = num (BT),
  	rtf_BorderStyle (Attlist,Style),
  	rtf_BorderBit (Pfx,BT,Style,border_type_box,Box),
    	rtf_BorderBit (Pfx,BT,Style,border_type_right,R),
  	rtf_BorderBit (Pfx,BT,Style,border_type_left,L),
  	rtf_BorderBit (Pfx,BT,Style,border_type_top,T),
  	rtf_BorderBit (Pfx,BT,Style,border_type_bottom,B),
  	table_Specific (Pfx,Style,TblSpec),!,
  	format (Tag,"%s%s%s%s%s%s",Box,R,L,T,B,TblSpec).
  rtf_BorderFmt (_,_,"").
  %
  %  table_Specific/2 - add two table specific tags if we are in table
  %
  table_Specific ("\\tr",Style,Tag) :-!,
  	format (Tag,"\\trbrdrh%s\\brdrw10 \\trbrdrv%s\\brdrw10",Style,Style).
  table_Specific (_,_,"").
  %
  %  rtf_BorderStyle/2 - render table/cell/par border's style
  %
  rtf_BorderStyle (Attlist,Tag) :-
  	ucase_att_member (doc_att("BORDER.STYLE",Val),Attlist),
  	doc_str_val (Val,Style),
  	upper_lower (Style,LStyle),
  	rtf_BorderStyleTag (LStyle,Tag),!.
  rtf_BorderStyle (_,"\\brdrs").
  %
  %  rtf_BorderBit/3 - checks if the bit is on/off
  %
  rtf_BorderBit (Pfx,BT,Style,Bit,Tag) :-
  	bitand (BT,Bit,Res),
  	Res <> 0,!,
  	rtf_BorderTag (Pfx,Style,Bit,Tag).
  rtf_BorderBit (_,_,_,_,"").
  %
  %  rtf_BorderTag/3 - convert border bit into RTF tag
  %
  rtf_BorderTag (Pfx,Style,border_type_box,Tag) :-format (Tag,"%sbox%s\\brdrw10",Pfx,Style),!.
  rtf_BorderTag (Pfx,Style,border_type_right,Tag):-format(Tag,"%sbrdrr%s\\brdrw10",Pfx,Style),!.
  rtf_BorderTag (Pfx,Style,border_type_left,Tag):-format(Tag,"%sbrdrl%s\\brdrw10",Pfx,Style),!.
  rtf_BorderTag (Pfx,Style,border_type_top,Tag):-format(Tag,"%sbrdrt%s\\brdrw10",Pfx,Style),!.
  rtf_BorderTag (Pfx,Style,border_type_bottom,Tag):-format(Tag,"%sbrdrb%s\\brdrw10",Pfx,Style),!.
  %
  %  rtf_BorderStyleTag/2 - convert border style into RTF tag
  %
  rtf_BorderStyleTag ("thick","\\brdrth").
  rtf_BorderStyleTag ("doub","\\brdrdb").
  rtf_BorderStyleTag ("shade","\\brdrsh").

/******************************************************
 *  RTF HEADER                                        *
 *                                                    *
 *  Produces the default RTF document header          *
 *  Incliding the fonttable and color table           *
 ******************************************************/
PREDICATES
  procedure collect_FontTable (RTF_ILIST,STRING,STRING)
CLAUSES
  
  rtf_Header (Header) :-
  	get_DefTab(DefTab),
  	format(Head0,"{\\rtf1\\ansi \\deff0\\deftab%d",Deftab),
  	rtf_FontTable (FontTbl),
  	rtf_ColorTable (ColorTbl),
  	concat (Head0,FontTbl,Head1),
  	concat (Head1,ColorTbl,Header).
  	
  rtf_FontTable (FTBL) :-
  	findall(Style,fontstyle(Style,_,_,_,_),StyleList),
  	collect_FontTable (StyleList,"{\\fonttbl",FTBL).
  
  collect_FontTable ([],Buf,FTBL) :- concat(Buf,"}",FTBL).
  collect_FontTable ([Style|T],Buf,FTBL) :-
  	fontstyle (Style,FaceName,Family,_Size,_Effects),!,
	format (FtblRec,"{\\f%d\\%s\\fprq2 %s;}\n",Style,Family,FaceName),
	concat (Buf,FtblRec,Buf1),!,
	collect_FontTable (T,Buf1,FTBL).
  collect_FontTable ([_|T],Buf,FTBL) :-
  	collect_FontTable (T,Buf,FTBL).
  	  	
  rtf_ColorTable (ColorTbl) :-
  	CT00 = "{\\colortbl;",
  	concat (CT00,"\\red0\\green0\\blue0;",CT01),		% Black (00 00 00)
  	concat (CT01,"\\red0\\green0\\blue255;",CT02),		% Blue  (00 00 FF)
  	concat (CT02,"\\red0\\green255\\blue255;",CT03),	% Cyan  (
  	concat (CT03,"\\red0\\green255\\blue0;",CT04),		% Green
  	concat (CT04,"\\red255\\green0\\blue255;",CT05),	% Magenta
  	concat (CT05,"\\red255\\green0\\blue0;",CT06),		% Red
  	concat (CT06,"\\red255\\green255\\blue0;",CT07),	% Yellow
  	concat (CT07,"\\red255\\green255\\blue255;",CT08),	% White
  	concat (CT08,"\\red0\\green0\\blue128;",CT09),		% DkBlue (Marine)
  	concat (CT09,"\\red0\\green128\\blue128;",CT10),	% DkCyan
  	concat (CT10,"\\red0\\green128\\blue0;",CT11),		% DkGreen
  	concat (CT11,"\\red128\\green0\\blue128;",CT12),	% Purple
  	concat (CT12,"\\red128\\green0\\blue0;",CT13),		% Bordo
  	concat (CT13,"\\red128\\green128\\blue0;",CT14),	% Chaki
  	concat (CT14,"\\red128\\green128\\blue128;",CT15),	% Gray
  	concat (CT15,"\\red192\\green192\\blue192;}",ColorTbl).	% LtGray

/******************************************************************************
    Expand HTML &sym;
******************************************************************************/
PREDICATES
   procedure rtf_expand_HTML_Sym2(string,string)
   procedure rtf_change_nl2(string,string,string)
CLAUSES
   
   rtf_expand_HTML_Sym (InStr,OutStr) :-
   	searchchar(InStr,'&',P1),
   	searchchar(InStr,';',P2),
   	P2>P1,!,
   	rtf_expand_HTML_Sym2 (InStr,OutStr).
   rtf_expand_HTML_Sym (Str,Str).
   
   rtf_expand_HTML_Sym2 (InStr,OutStr) :-
   	searchstring(InStr,"&nbsp;",Pos),
   	P1=Pos-1,
   	frontstr(P1,InStr,F,R1),
   	frontstr(6,R1,_,R2),
   	format (InStr2,"%s %s",F,R2),!,
   	rtf_expand_HTML_Sym2 (InStr2,OutStr).
   rtf_expand_HTML_Sym2 (InStr,OutStr) :-
   	searchstring(InStr,"&gt;",Pos),
   	P1=Pos-1,
   	frontstr(P1,InStr,F,R1),
   	frontstr(4,R1,_,R2),
   	format (InStr2,"%s>%s",F,R2),!,
   	rtf_expand_HTML_Sym2 (InStr2,OutStr).
   rtf_expand_HTML_Sym2 (InStr,OutStr) :-
   	searchstring(InStr,"&lt;",Pos),
   	P1=Pos-1,
   	frontstr(P1,InStr,F,R1),
   	frontstr(4,R1,_,R2),
   	format (InStr2,"%s<%s",F,R2),!,
   	rtf_expand_HTML_Sym2 (InStr2,OutStr).
   rtf_expand_HTML_Sym2 (InStr,OutStr) :-
   	searchstring(InStr,"&#",Pos),
   	P1=Pos-1,
   	frontstr(P1,InStr,F,R1),
   	frontstr(2,R1,_,R2),
   	searchchar(R2,';',Pos2),
   	P2=Pos2-1,
   	frontstr(P2,R2,MaybeDigits,R3),
   	str_int(MaybeDigits,YesDigits),
   	char_int(Char,YesDigits),
   	frontchar(R3,';',R4),
   	format(InStr2,"%s%c%s",F,Char,R4),!,
   	rtf_expand_HTML_Sym2(InStr2,OutStr).
   rtf_expand_HTML_Sym2 (InStr,InStr).
   
   rtf_change_nl(InStr,OutStr):-
   	pre,!,
   	rtf_change_nl2(InStr,"",OutStr).
   rtf_change_nl(Str,Str).
   	
   rtf_change_nl2(InStr,Buff,OutStr):-
   	searchchar(InStr,'\n',Pos),
   	P1=Pos-1,
   	frontstr(P1,InStr,F,R1),
   	frontchar(R1,_,R2),
   	format(Buff1,"%s%s\\line\n",Buff,F),!,
   	rtf_change_nl2(R2,Buff1,OutStr).
   rtf_change_nl2(InStr,Buff,OutStr):-
   	concat(Buff,InStr,OutStr).
   	