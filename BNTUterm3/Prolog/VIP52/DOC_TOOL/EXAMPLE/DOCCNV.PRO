/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: DOCCNV.PRO
 Purpose: DOC_TOOL Sample
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "doccnv.inc"
include "error.con"
include "doccnv.con"
include "hlptopic.con"

GLOBAL DOMAINS
  file = input
  
GLOBAL PREDICATES
  dump_element (doc_flow_element) - (i) language C

CONSTANTS
  plain = 0
  html  = 1
  rtf   = 2
  ipf   = 3
  term  = 4

DATABASE - internal
  determ inp_win  (WINDOW)
  determ out_win  (WINDOW)
  determ out_str  (STRING)
  determ out_flow (DOC_FLOW)
  determ inp_type (INTEGER)
  determ out_type (INTEGER)
  
DATABASE - page_count_internal
  single page_Count (integer)

%BEGIN_WIN Task Window
/***************************************************************************
	Event handling for Task Window
***************************************************************************/

  
PREDICATES

  task_win_eh : EHANDLER
  procedure calc_edit_rct (WINDOW,RCT,RCT)
  procedure what_is_input (STRING,INTEGER,STRING)
  determ out_file_atts (INTEGER,STRING,SLIST,STRING)
  procedure err_Hndl (INTEGER)

  determ convert_to_html (STRING IN,INTEGER TYPE,STRING OUT)
  determ convert_to_ipf  (STRING IN,INTEGER TYPE,STRING OUT)
  determ convert_to_rtf  (STRING IN,INTEGER TYPE,STRING OUT)
  determ convert_to_term (STRING IN,INTEGER TYPE,STRING OUT)
  
CONSTANTS

%BEGIN Task Window, CreateParms, 21:24:16-26.11.1999, Code automatically updated!
  task_win_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Close,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings]
  task_win_Menu  = res_menu(idr_task_menu)
  task_win_Title = "Document Converter"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

CLAUSES

%BEGIN Task Window, e_Create
  task_win_eh(_Win,e_Create(_),0):-!,
%BEGIN Task Window, InitControls, 21:24:16-26.11.1999, Code automatically updated!
%END Task Window, InitControls
%BEGIN Task Window, ToolbarCreate, 21:24:16-26.11.1999, Code automatically updated!
	tb_project_toolbar_Create(_Win),
	tb_help_line_Create(_Win),
%END Task Window, ToolbarCreate
IFDEF use_message
	MsgWin=msg_Create(100),
	calc_edit_rct (MsgWin,RCT1,RCT2),
	INP=win_src_text_Create(_Win,RCT1),
	OUT=win_tgt_text_Create(_Win,RCT2),
	retractall (_,internal),
	assert (inp_win(INP)),
	assert (out_win(OUT)),
	assert (inp_type(plain)),
ENDDEF
	!.
%END Task Window, e_Create

%MARK Task Window, new events

%BEGIN Task Window, id_file_new_term
  task_win_eh(_Win,e_Menu(id_file_new_term,_ShiftCtlAlt),0):-!,
  	inp_win(INP_WIN),
  	edit_Suspend(INP_WIN),
  	edit_PasteStr(INP_WIN,"doc(\"\",[title(\"Prolog Term\")],body([],[]))"),
  	retractall (inp_type(_)),
  	assert (inp_type(term)),
  	win_SetText(INP_WIN,"Source Text (Prolog Term)"),
  	edit_Resume(INP_WIN),
	!.
%END Task Window, id_file_new_term

%BEGIN Task Window, id_file_new_plain_text
  task_win_eh(_Win,e_Menu(id_file_new_plain_text,_ShiftCtlAlt),0):-!,
  	inp_win(INP_WIN),
  	edit_Suspend(INP_WIN),
  	edit_PasteStr(INP_WIN,"Plain Text"),
  	retractall (inp_type(_)),
  	assert (inp_type(plain)),
  	win_SetText(INP_WIN,"Source Text (Plain)"),
  	edit_Resume(INP_WIN),
	!.
%END Task Window, id_file_new_plain_text

%BEGIN Task Window, id_file_New_rtf
  task_win_eh(_Win,e_Menu(id_file_New_rtf,_ShiftCtlAlt),0):-!,
  	inp_win(INP_WIN),
  	edit_Suspend(INP_WIN),
  	edit_PasteStr(INP_WIN,"{\\rtf1\\ansi\n\\pard\\plain RTF Text\n}"),
  	retractall (inp_type(_)),
  	assert (inp_type(rtf)),
  	win_SetText(INP_WIN,"Source Text (RTF)"),
  	edit_Resume(INP_WIN),
	!.
%END Task Window, id_file_New_rtf

%BEGIN Task Window, id_file_New_ipf
  task_win_eh(_Win,e_Menu(id_file_New_ipf,_ShiftCtlAlt),0):-!,
  	inp_win(INP_WIN),
  	edit_Suspend(INP_WIN),
  	edit_PasteStr(INP_WIN,":userdoc.\n:title.IPF Text\n:euserdoc."),
  	retractall (inp_type(_)),
  	assert (inp_type(ipf)),
  	win_SetText(INP_WIN,"Source Text (IPF)"),
  	edit_Resume(INP_WIN),
	!.
%END Task Window, id_file_New_ipf

%BEGIN Task Window, id_file_New_html
  task_win_eh(_Win,e_Menu(id_file_New_html,_ShiftCtlAlt),0):-!,
  	inp_win(INP_WIN),
  	edit_Suspend(INP_WIN),
  	edit_PasteStr(INP_WIN,"<HTML>\n<HEAD>\n\t<TITLE>HTML Text</TITLE>\n</HEAD>\n<BODY>\n</BODY>\n</HTML>"),
  	retractall (inp_type(_)),
  	assert (inp_type(html)),
  	win_SetText(INP_WIN,"Source Text (HTML)"),
  	edit_Resume(INP_WIN),
	!.
%END Task Window, id_file_New_html

%BEGIN Task Window, id_file_save
  task_win_eh(_Win,e_Menu(id_file_save,_ShiftCtlAlt),0):-!,
  	out_type (OUT_TYPE),
  	out_file_atts (OUT_TYPE,DefExt,Patterns,Title),
  	FN=dlg_GetFileName(DefExt,Patterns,Title,[],"",_),
  	format(Msg,"Can't open %s",FN),
  	out_win(OUT_WIN),
  	STR=edit_GetText(OUT_WIN),
  	trap(file_str(FN,Str),_,dlg_Error(Msg)),
  	write (FN, " written"),nl,
	!.
%END Task Window, id_file_save_html_text

%BEGIN Task Window, id_file_convert_to_html
  task_win_eh(_Win,e_Menu(id_file_convert_to_html,_ShiftCtlAlt),0):-!,
  	inp_win (INP),
  	out_win (OUT),
  	InpStr=edit_GetText(INP),
  	inp_type (INP_TYPE),
  	convert_to_html (InpStr,INP_TYPE,OutStr),
   	edit_PasteStr (OUT,OutStr),
   	write ("Source text is converted to HTML format\n"),
   	win_SetText (OUT,"Target Text (HTML)"),
   	retractall (out_type(_)),
   	assert (out_type(html)),
	!.
%END Task Window, id_file_convert_to_html

%BEGIN Task Window, id_file_Convert_to_ipf
  task_win_eh(_Win,e_Menu(id_file_Convert_to_ipf,_ShiftCtlAlt),0):-!,
  	inp_win (INP),
  	out_win (OUT),
  	InpStr=edit_GetText(INP),
  	inp_type (INP_TYPE),
  	convert_to_ipf (InpStr,INP_TYPE,OutStr),
   	edit_PasteStr (OUT,OutStr),
   	write ("Source text is converted to IPF format\n"),
   	win_SetText (OUT,"Target Text (IPF)"),
   	retractall (out_type(_)),
   	assert (out_type(ipf)),
	!.
%END Task Window, id_file_Convert_to_ipf

%BEGIN Task Window, id_file_Convert_to_rtf
  task_win_eh(_Win,e_Menu(id_file_Convert_to_rtf,_ShiftCtlAlt),0):-!,
  	inp_win (INP),
  	out_win (OUT),
  	InpStr=edit_GetText(INP),
  	inp_type (INP_TYPE),
  	convert_to_rtf (InpStr,INP_TYPE,OutStr),
   	edit_PasteStr (OUT,OutStr),
   	write ("Source text is converted to RTF format\n"),
   	win_SetText (OUT,"Target Text (RTF)"),
   	retractall (out_type(_)),
   	assert (out_type(rtf)),
	!.
%END Task Window, id_file_Convert_to_rtf

%BEGIN Task Window, id_file_Convert_to_term
  task_win_eh(_Win,e_Menu(id_file_Convert_to_term,_ShiftCtlAlt),0):-!,
  	inp_win (INP),
  	out_win (OUT),
  	InpStr=edit_GetText(INP),
  	inp_type (INP_TYPE),
  	convert_to_term (InpStr,INP_TYPE,OutStr),
   	edit_PasteStr (OUT,OutStr),
   	write ("Source text is converted to Prolog term\n"),
   	win_SetText (OUT,"Target Text (Prolog Term)"),
   	retractall (out_type(_)),
   	assert (out_type(term)),
	!.
%END Task Window, id_file_Convert_to_term


%BEGIN Task Window, id_file_open
  task_win_eh(_Win,e_Menu(id_file_open,_ShiftCtlAlt),0):-!,
  	FN=dlg_GetFileName("*.htm",["HTML Text (*.htm)","*.htm",
  	                            "RTF Text (*.rtf)","*.rtf",
  	                            "IPF Text (*.ipf)","*.ipf",
  	                            "Prolog Term (*.dba)","*.dba",
  	                            "All files (*.*)","*.*"],
  	                   "Open Source Text",[],"",_),
  	trap(file_str(FN,Str),Err,err_Hndl(Err)),
  	filenameext (FN,_,EXT),
  	upper_lower (EXT,LEXT),
  	what_is_input (LEXT,TYPE,TITLE),
  	retractall (inp_type(_)),
  	assert (inp_type(TYPE)),
  	inp_win(INP_WIN),
  	edit_Suspend(INP_WIN),
  	edit_PasteStr(INP_WIN,Str),
  	edit_Resume(INP_WIN),
  	win_SetText(INP_WIN,TITLE),
  	write ("Opened ",FN),nl,
	!.
%END Task Window, id_file_open

%BEGIN Task Window, id_help_contents
  task_win_eh(_Win,e_Menu(id_help_contents,_ShiftCtlAlt),0):-!,
	ifdef platform_16bit
  		vpi_ShowHelp("doccnv16.hlp"),
        elsedef
        	vpi_ShowHelp("doccnv32.hlp"),
        enddef
	!.
%END Task Window, id_help_contents

%BEGIN Task Window, id_help_about
  task_win_eh(Win,e_Menu(id_help_about,_ShiftCtlAlt),0):-!,
	dlg_about_dialog_Create(Win),
	!.
%END Task Window, id_help_about

%BEGIN Task Window, id_file_exit
  task_win_eh(Win,e_Menu(id_file_exit,_ShiftCtlAlt),0):-!,
  	win_Destroy(Win),
	!.
%END Task Window, id_file_exit

%BEGIN Task Window, e_Size
  task_win_eh(_Win,e_Size(_Width,_Height),0):-!,
IFDEF use_tbar
	toolbar_Resize(_Win),
ENDDEF
IFDEF use_message
	msg_Resize(_Win),
ENDDEF
	!.
%END Task Window, e_Size

%END_WIN Task Window

/***************************************************************************
	Invoking on-line Help
***************************************************************************/

  project_ShowHelpContext(HelpTopic):-
  	vpi_ShowHelpContext("rtf2html.hlp",HelpTopic).
CLAUSES
  err_Hndl (err_filetoobig) :- !,dlg_Error ("File too big, or not enough memory").
  err_Hndl (Code) :- 
  	format (Msg,"Can't open input file. Error code: %d",Code),
  	dlg_Error (Msg).
  %
  %  Tile Editors
  %
  calc_edit_rct (MsgWin,RCT1,RCT2) :-
  	MsgRCT = win_GetOuterRect(MsgWin),
  	MsgRCT = rct(ML,MT,MR,_MB),
  	Tbar = val(integer,vpi_GetAttrVal(attr_win_tbar)),
	Width = MR - ML,
  	W2 = Width div 2,
  	Top = Tbar,
  	Bottom = MT - 10,
  	L1 = ML,
  	R1 = W2-5,
  	L2 = MR - W2,
  	R2 = MR,
  	RCT1 = rct (L1,Top,R1,Bottom),
  	RCT2 = rct (L2,Top,R2,Bottom).
  	
  what_is_input (".rtf",rtf,"Source Text (RTF)") :-!.
  what_is_input (".htm",html,"Source Text (HTML)") :-!.
  what_is_input (".html",html,"Source Text (HTML)") :-!.
  what_is_input (".ipf",ipf,"Source Text (IPF)") :-!.
  what_is_input (".dba",term,"Source Text (Prolog Term)") :-!.
  what_is_input (_,plain,"Source Text (Plain)") :- !,
  	dlg_Note ("Unrecognized file name extension.\nThis file is assumed as plain text").

  out_file_atts (html,"*.htm",["HTML Text (*.htm)","*.htm"],"Save HTML file") :-!.
  out_file_atts (rtf,"*.rtf",["RTF Text (*.rtf)","*.rtf"],"Save RTF file") :-!.
  out_file_atts (ipf,"*.ipf",["IPF Text (*.ipf)","*.ipf"],"Save IPF file") :-!.
  out_file_atts (term,"*.dba",["Prolog Term (*.dba)","*.dba"],"Save Prolog Term") :-!.
  
/***************************************************************************
	Main Goal
***************************************************************************/


GOAL

IFDEF use_mdi
  vpi_SetAttrVal(attr_win_mdi,b_true),
ENDDEF
IFDEF ws_win
  IFDEF use_3dctrl
    vpi_SetAttrVal(attr_win_3dcontrols,b_true),
  ENDDEF
ENDDEF  
  vpi_Init(task_win_Flags,task_win_eh,task_win_Menu,"rtf2html",task_win_Title).

%BEGIN_TLB Project toolbar, 21:24:54-26.11.1999, Code automatically updated!
/**************************************************************************
	Creation of toolbar: Project toolbar
**************************************************************************/

clauses

  tb_project_toolbar_Create(_Parent):-
ifdef use_tbar
	toolbar_create(tb_top,0xC0C0C0,_Parent,
		[tb_ctrl(id_file_open,pushb,idb_open_up,idb_open_dn,idb_open_up,"Open;Open source file",1,1),
		 separator,
		 tb_ctrl(id_help_contents,pushb,idb_help_up,idb_help_down,idb_help_up,"Help;Help",0,1)]),
enddef
	true.
%END_TLB Project toolbar










%BEGIN_TLB Help line, 21:25:10-26.11.1999, Code automatically updated!
/**************************************************************************
	Creation of toolbar: Help line
**************************************************************************/

clauses

  tb_help_line_Create(_Parent):-
ifdef use_tbar
	toolbar_create(tb_bottom,0xC0C0C0,_Parent,
		[tb_text(idt_help_line,tb_context,452,0,4,10,0x0,"")]),
enddef
	true.
%END_TLB Help line





%BEGIN_DLG About dialog
/**************************************************************************
	Creation and event handling for dialog: About dialog
**************************************************************************/

CONSTANTS

%BEGIN About dialog, CreateParms, 21:48:30-26.11.1999, Code automatically updated!
  dlg_about_dialog_ResID = idd_dlg_about
  dlg_about_dialog_DlgType = wd_Modal
  dlg_about_dialog_Help = idh_contents
%END About dialog, CreateParms

PREDICATES

  dlg_about_dialog_eh : EHANDLER

CLAUSES

  dlg_about_dialog_Create(Parent):-
	win_CreateResDialog(Parent,dlg_about_dialog_DlgType,dlg_about_dialog_ResID,dlg_about_dialog_eh,0).

%BEGIN About dialog, idc_ok _CtlInfo
  dlg_about_dialog_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtrlInfo),0):-!,
	win_Destroy(_Win),
	!.
%END About dialog, idc_ok _CtlInfo
%MARK About dialog, new events

%BEGIN About dialog, e_Create
  dlg_about_dialog_eh(_Win,e_Create(_CreationData),0):-!,
  	Ver=win_GetCtlHandle(_Win,idct_doclibversion),
  	doclib_getversion(Major,Minor,Build),
  	format(Txt,"DOCLIB Version %d.%d, Build %d",Major,Minor,Build),
  	win_SetText(Ver,Txt),
	!.
%END About dialog, e_Create

  dlg_about_dialog_eh(_,_,_):-!,fail.

%END_DLG About dialog

%BEGIN_WIN Source Text
/**************************************************************************
	Creation and event handling for window: "Source Text"
**************************************************************************/

CONSTANTS

%BEGIN Source Text, CreateParms, 21:24:00-26.11.1999, Code automatically updated!
  win_source_text_WinType = w_TopLevel
  win_source_text_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings]
  win_source_text_RCT = rct(100,80,440,240)
  win_source_text_Menu = no_menu
  win_source_text_Title = "Source Text (Plain)"
  win_source_text_Help = idh_contents
%END Source Text, CreateParms

PREDICATES

  win_src_text_eh : EHANDLER

CLAUSES

  win_src_text_Create(_Parent,RCT,Win):-
IFDEF use_editor
	Text = "Plain Text",
	Font = font_Create(ff_Fixed,[],10),
	ReadOnly = b_false, Indent = b_true, Wrap = b_true, InitPos = 1,
	Win=edit_CreateWrap(win_source_text_WinType,RCT,win_source_text_Title,
		 win_source_text_Menu,_Parent,win_source_text_Flags,Font,ReadOnly,
		 Indent,Wrap,Text,InitPos,win_src_text_eh),
ENDDEF
	true.

%BEGIN Source Text, e_Create
  win_src_text_eh(_Win,e_Create(_),0):-!,
%BEGIN Source Text, InitControls, 21:24:00-26.11.1999, Code automatically updated!
%END Source Text, InitControls
%BEGIN Source Text, ToolbarCreate, 21:24:00-26.11.1999, Code automatically updated!
%END Source Text, ToolbarCreate
	!.
%END Source Text, e_Create

%BEGIN Source Text, e_Menu, Editor default popup menu 
  win_src_text_eh(_Win,e_Menu(ID,_CAS),0):-
	ID >= edit_MenuUndo, ID <= edit_MenuFont, 
	!,fail.
%END Source Text, e_Menu, Editor default popup menu
%MARK Source Text, new events

%BEGIN Source Text, e_Size
  win_src_text_eh(_Win,e_Size(_Width,_Height),0):-!,
IFDEF use_tbar
	toolbar_Resize(_Win),
ENDDEF
	!.
%END Source Text, e_Size

%BEGIN Source Text, e_Menu, Parent window 
  win_src_text_eh(Win,e_Menu(ID,CAS),0):-!,
	PARENT = win_GetParent(Win),
	win_SendEvent(PARENT,e_Menu(ID,CAS)),
	!.
%END Source Text, e_Menu, Parent window

%END_WIN Source Text


%BEGIN_WIN Target Text
/**************************************************************************
	Creation and event handling for window: "Target Text"
**************************************************************************/

CONSTANTS

%BEGIN Target Text, CreateParms, 21:23:44-26.11.1999, Code automatically updated!
  win_target_text_WinType = w_TopLevel
  win_target_text_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings]
  win_target_text_RCT = rct(100,80,440,240)
  win_target_text_Menu = no_menu
  win_target_text_Title = "Target Text"
  win_target_text_Help = idh_contents
%END Target Text, CreateParms

PREDICATES

  win_target_text_eh : EHANDLER

CLAUSES

  
  win_tgt_text_Create(_Parent,RCT,Win) :-
IFDEF use_editor
	Text = "",
	Font = font_Create(ff_Fixed,[],10),
	ReadOnly = b_false, Indent = b_true, Wrap = b_true, InitPos = 1,
	Win=edit_CreateWrap(win_target_text_WinType,RCT,win_target_text_Title,
		 win_target_text_Menu,_Parent,win_target_text_Flags,Font,ReadOnly,
		 Indent,Wrap,Text,InitPos,win_target_text_eh),
ENDDEF
	true.

%BEGIN Target Text, e_Create
  win_target_text_eh(_Win,e_Create(_),0):-!,
%BEGIN Target Text, InitControls, 21:23:44-26.11.1999, Code automatically updated!
%END Target Text, InitControls
%BEGIN Target Text, ToolbarCreate, 21:23:44-26.11.1999, Code automatically updated!
%END Target Text, ToolbarCreate
	!.
%END Target Text, e_Create

%BEGIN Target Text, e_Menu, Editor default popup menu 
  win_target_text_eh(_Win,e_Menu(ID,_CAS),0):-
	ID >= edit_MenuUndo, ID <= edit_MenuFont, 
	!,fail.
%END Target Text, e_Menu, Editor default popup menu
%MARK Target Text, new events

%BEGIN Target Text, e_Size
  win_target_text_eh(_Win,e_Size(_Width,_Height),0):-!,
IFDEF use_tbar
	toolbar_Resize(_Win),
ENDDEF
	!.
%END Target Text, e_Size

%BEGIN Target Text, e_Menu, Parent window 
  win_target_text_eh(Win,e_Menu(ID,CAS),0):-!,
	PARENT = win_GetParent(Win),
	win_SendEvent(PARENT,e_Menu(ID,CAS)),
	!.
%END Target Text, e_Menu, Parent window

%END_WIN Target Text


/******************************************************
   DOCUMENT's CONVERSION PROCEDURES
******************************************************/
PREDICATES
  toHTML_Callback : RTF_DOCPARSER_CALLBACK
  toIPF_Callback  : RTF_DOCPARSER_CALLBACK
  toTERM_Callback : RTF_DOCPARSER_CALLBACK
  procedure reverse (DOC_FLOW,DOC_FLOW,DOC_FLOW)
CLAUSES
  %--------------------HTML--------------------------------
  convert_to_html (INPSTR,rtf,OUTSTR) :- !,
  	write("Writing temp file ..."),
  	file_str("TMP.RTF",InpStr),
  	write ("done"),nl,
  	readdevice (Old),
  	openread(input,"TMP.RTF"),
  	 	readdevice (input),
   		retractall (out_str(_)),
  		assert (out_str("<HTML>\n<BODY>")),
  		assert (page_Count(0)),
  		rtfpage_term (toHTML_Callback),
   		out_str (OUT_0),
   		concat (OUT_0,"\n</BODY>\n</HTML>",OUTSTR),
   	readdevice (Old),
   	closefile (input),
   	trap(deletefile("TMP.RTF"),_,fail).
  convert_to_html(INPSTR,plain,OUTSTR) :- !,
  	DOC = doc ("",[],doc_body([],[txt(INPSTR)])),
  	html_term (OUTSTR,DOC).
  convert_to_html(INPSTR,html,INPSTR) :- !.
  convert_to_html(INPSTR,ipf,OUTSTR) :- !,
  	ipf_term (INPSTR,DOC),
  	html_term (OUTSTR,DOC).
  convert_to_html(INPSTR,term,OUTSTR) :- !,
  	trap(term_str(doc,DOC,INPSTR),_,dlg_Error("Input string cannot be converted into the DOC term")),
  	html_term (OUTSTR,DOC).
  %
  %  RTF converter calls this routine at each page end
  %
  toHTML_Callback (Doc,Ret) :-
  	page_Count (Count),
  	Count1 = Count + 1,
  	assert(page_Count(Count1)),
  	%
  	%   Converts the term into HTML
  	%
  	Doc = doc (_,Head,Body),
  	rtf_ApplyDocInfo (Head),
  	Body = doc_body (_,PageFlow),
  	retract (out_str(OutStr0)),
  	html_Flow ("",PageFlow,"",NewPageStr),
  	format (OutStr1,"%s\n%s\n<HR>",OutStr0,NewPageStr),
  	assert (out_str(OutStr1)),
  	%
  	%   Print diagnostic and ask for next page
  	%
  	writef ("Page: %d\n",Count),
  	vpi_ProcessEvents (),
  	char_int(Ret,1),!.
  toHTML_Callback (_,0).
  %---------------------IPF---------------------------------
  convert_to_ipf(INPSTR,rtf,OUTSTR) :- !,
    	write("Writing temp file ..."),
  	file_str("TMP.RTF",InpStr),
  	write ("done"),nl,
  	readdevice (Old),
  	openread(input,"TMP.RTF"),
  	 	readdevice (input),
   		retractall (out_str(_)),
  		assert (out_str(":userdoc.")),
  		assert (page_Count(0)),
  		rtfpage_term (toIPF_Callback),
   		out_str (OUT_0),
   		concat (OUT_0,"\n:euserdoc.",OUTSTR),
   	readdevice (Old),
   	closefile (input),
   	trap(deletefile("TMP.RTF"),_,fail).
  convert_to_ipf(INPSTR,plain,OUTSTR) :- !,
  	DOC = doc ("",[],doc_body([],[txt(INPSTR)])),
  	ipf_term (OUTSTR,DOC).
  convert_to_ipf(INPSTR,ipf,INPSTR) :- !.
  convert_to_ipf(INPSTR,html,OUTSTR) :- !,
  	html_term (INPSTR,DOC),
  	ipf_term (OUTSTR,DOC).
  convert_to_ipf(INPSTR,term,OUTSTR) :- !,
  	trap(term_str(doc,DOC,INPSTR),_,dlg_Error("Input string cannot be converted into the DOC term")),
  	ipf_term (OUTSTR,DOC).
  %
  %  RTF converter calls this routine at each page end
  %
  toIPF_Callback (Doc,Ret) :-
  	page_Count(Count),
  	Count1 = Count + 1,
  	assert(page_Count(Count1)),
  	%
  	%   Converts the term into IPF
  	%
  	Doc = doc (_,Head,Body),
  	rtf_ApplyDocInfo (Head),
  	Body = doc_body (_,PageFlow),
  	retract (out_str(OutStr0)),
  	ipf_Flow (PageFlow,"",NewPageStr),
  	format (OutStr1,"%s\n:h1.Page %d\n%s\n",OutStr0,Count,NewPageStr),
  	assert (out_str(OutStr1)),
  	%
  	%   Print diagnostic and ask for next page
  	%
  	writef ("Page: %d\n",Count),
  	vpi_ProcessEvents (),
  	char_int(Ret,1),!.
  toIPF_Callback (_,0).
  %--------------------------RTF------------------------------
  
  page_Count(0).
  
  convert_to_rtf(INPSTR,rtf,INPSTR) :- !.
  convert_to_rtf(INPSTR,plain,OUTSTR) :- !,
  	DOC = doc ("",[],doc_body([],[txt(INPSTR)])),
  	rtfpage_term (PAGE,DOC),
  	rtf_Header (HEADER),
  	format (OUTSTR,"%s%s\n}",HEADER,PAGE).
  convert_to_rtf(INPSTR,ipf,OUTSTR) :- !,
  	ipf_term (INPSTR,DOC),
  	rtfpage_term (PAGE,DOC),
  	rtf_Header (HEADER),
  	format (OUTSTR,"%s%s\n}",HEADER,PAGE).
  convert_to_rtf(INPSTR,html,OUTSTR) :- !,
  	html_term (INPSTR,DOC),
  	rtfpage_term (PAGE,DOC),
  	rtf_Header (HEADER),
  	format (OUTSTR,"%s%s\n}",HEADER,PAGE).
  convert_to_rtf(INPSTR,term,OUTSTR) :- !,
  	trap(term_str(doc,DOC,INPSTR),_,dlg_Error("Input string cannot be converted into the DOC term")),
  	rtfpage_term (PAGE,DOC),
  	rtf_Header (HEADER),
  	format (OUTSTR,"%s%s\n}",HEADER,PAGE).
  	
  %---------------------Term---------------------------------
  convert_to_term(INPSTR,rtf,OUTSTR) :- !,
    	write("Writing temp file ..."),
  	file_str("TMP.RTF",InpStr),
  	write ("done"),nl,
  	readdevice (Old),
  	openread(input,"TMP.RTF"),
  	 	readdevice (input),
   		retractall (out_flow(_)),
  		assert (out_flow([])),
  		assert (page_Count(0)),
  		rtfpage_term (toTerm_Callback),
   		out_flow (OUT_FLOW_0),
   		reverse (OUT_FLOW_0,[],OUT_FLOW),
   		DOC=doc("",[],doc_body([],OUT_FLOW)),
  		trap(term_str(doc,DOC,OUTSTR),_,dlg_Error("Input string cannot be converted into the DOC term")),
   	readdevice (Old),
   	closefile (input),
   	trap(deletefile("TMP.RTF"),_,fail).
  convert_to_term(INPSTR,plain,OUTSTR) :- !,
  	DOC = doc ("",[],doc_body([],[txt(INPSTR)])),
  	trap(term_str(doc,DOC,OUTSTR),_,dlg_Error("Input string cannot be converted into the DOC term")).
  convert_to_term(INPSTR,term,INPSTR) :- !.
  convert_to_term(INPSTR,html,OUTSTR) :- !,
  	html_term (INPSTR,DOC),
  	trap(term_str(doc,DOC,OUTSTR),_,dlg_Error("Input string cannot be converted into the DOC term")).
  convert_to_term(INPSTR,ipf,OUTSTR) :- !,
  	ipf_term (INPSTR,DOC),
  	trap(term_str(doc,DOC,OUTSTR),_,dlg_Error("Input string cannot be converted into the DOC term")).
  %
  %  RTF converter calls this routine at each page end
  %
  toTERM_Callback (Doc,Ret) :-
  	page_Count(Count),
  	Count1 = Count + 1,
  	assert(page_Count(Count1)),
  	%
  	%   Converts the term into IPF
  	%
  	Doc = doc (_,_,Body),
  	Body = doc_body (_,PageFlow),
  	NewDiv = div ([],PageFlow), % page = division
  	retract (out_flow(OutFlow0)),
  	assert (out_flow([NewDiv|OutFlow0])),
  	%
  	%   Print diagnostic and ask for next page
  	%
  	
  	writef ("Page: %d\n",Count),
  	vpi_ProcessEvents (),
  	char_int(Ret,1),!.
  toTERM_Callback (_,0).

  reverse ([],FLOW,FLOW).
  reverse ([H|T],B,FLOW) :- !,reverse (T,[H|B],FLOW).

CLAUSES
   dump_element (E) :-
   	write ("\n----DUMP----\n",E).























