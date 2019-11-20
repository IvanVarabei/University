/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  AADEMO
 FileName: AADEMO.PRO
 Purpose: Demonstrates Autodesk Animation Playing .DLL using
 Written by: PDC
 Comments:

******************************************************************************/

include "aademo.inc"
include "aademo.con"
include "hlptopic.con"


%BEGIN_WIN Task Window
/***************************************************************************
	Event handling for Task Window
***************************************************************************/

PREDICATES

  task_win_eh : EHANDLER

CONSTANTS

%BEGIN Task Window, CreateParms, 19:17:44-24.11.1999, Code automatically updated!
  task_win_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Close,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings]
  task_win_Menu  = res_menu(idr_task_menu)
  task_win_Title = "Aademo"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

CLAUSES

%BEGIN Task Window, e_Create
  task_win_eh(_Win,e_Create(_),0):-!,
%BEGIN Task Window, InitControls, 19:17:44-24.11.1999, Code automatically updated!
%END Task Window, InitControls
%BEGIN Task Window, ToolbarCreate, 19:17:44-24.11.1999, Code automatically updated!
%END Task Window, ToolbarCreate
IFDEF use_message
	msg_Create(100),
ENDDEF
	aaOpen(),
	win_animation_Create(_Win,"8MMINTRO.FLI"),
	win_animation_Create(_Win,"ACHOOO.FLI"),
	win_animation_Create(_Win,"H&S.FLI"),
	win_animation_Create(_Win,"LITENING.FLI"),
	vpi_MoveMDIWindowsCascade( [] ),
	!.
%END Task Window, e_Create

%MARK Task Window, new events

%BEGIN Task Window, e_Destroy
  task_win_eh(_Win,e_Destroy,0):-!,
	aaClose(),
	!.
%END Task Window, e_Destroy

%BEGIN Task Window, id_help_contents
  task_win_eh(_Win,e_Menu(id_help_contents,_ShiftCtlAlt),0):-!,
  	vpi_ShowHelp("aademo.hlp"),
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
  	vpi_ShowHelpContext("aademo.hlp",HelpTopic),!.

/***************************************************************************
	Main Goal
***************************************************************************/

GOAL

IFDEF use_mdi
  vpi_SetAttrVal(attr_win_mdi,b_true),
ENDDEF
IFDEF use_3dctrl
  vpi_SetAttrVal(attr_win_3dcontrols,b_true),
ENDDEF
IFDEF use_tbar
  vpi_SetAttrVal(attr_win_tbar,use_tbar),
ENDDEF
IFDEF use_sbar
  vpi_SetAttrVal(attr_win_sbar,use_sbar),
ENDDEF
  vpi_Init(task_win_Flags,task_win_eh,task_win_Menu,"aademo",task_win_Title).

%BEGIN_DLG About dialog
/**************************************************************************
	Creation and event handling for dialog: About dialog
**************************************************************************/

CONSTANTS

%BEGIN About dialog, CreateParms, 19:58:44-24.11.1999, Code automatically updated!
  dlg_about_dialog_ResID = idd_dlg_about
  dlg_about_dialog_DlgType = wd_Modal
  dlg_about_dialog_Help = idh_contents
%END About dialog, CreateParms

PREDICATES

  dlg_about_dialog_eh : EHANDLER

CLAUSES

  dlg_about_dialog_Create(Parent):-
	win_CreateResDialog(Parent,dlg_about_dialog_DlgType,dlg_about_dialog_ResID,dlg_about_dialog_eh,0),!.

%BEGIN About dialog, idc_ok _CtlInfo
  dlg_about_dialog_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtrlInfo),0):-!,
	win_Destroy(_Win),
	!.
%END About dialog, idc_ok _CtlInfo
%MARK About dialog, new events

  dlg_about_dialog_eh(_,_,_):-!,fail.

%END_DLG About dialog

%BEGIN_WIN animation

DATABASE - ww_facts
  aaHandle(WINDOW,AAHandle)

/**************************************************************************
        Creation and event handling for window: animation
**************************************************************************/

CONSTANTS
%BEGIN animation, CreateParms, 19:17:28-24.11.1999, Code automatically updated!
  win_animation_WinType = w_TopLevel
  win_animation_Flags = [wsf_Border,wsf_TitleBar,wsf_Close,wsf_ClipSiblings]
  win_animation_RCT = rct(100,80,440,240)
  win_animation_Menu = no_menu
  win_animation_Title = "animation"
  win_animation_Help = idh_contents
%END animation, CreateParms

PREDICATES

  win_animation_eh : EHANDLER

CLAUSES

  win_animation_Create(Parent,Title):-
	win_Create(win_animation_WinType,win_animation_RCT,Title,
		   win_animation_Menu,Parent,win_animation_Flags,win_animation_eh,0).

%BEGIN animation, e_Create
  win_animation_eh(_Win,e_Create(_),0):-!,
	% The title of the Window gives a fileame to animate
	File=win_GetText(_Win),

	% Load the animation
	WMode = aa_STOPNOTIFY + aa_STOPSTATUS,
	HWin = cast(WORD,_Win),
	AAhandle = aaload(File,HWin,WMode,0,0,2000,2000,0,0),
	AAhandle >< 0,
	assert(aahandle(_Win,AAHandle)),

	% Now get size of Loaded animation and resize window
	SIZE = sizeof(aaparms),
	aaGetParmIndirect(AAhandle,AAPARMS,SIZE),
	AAPARMS = aaparms(_,_,_,_,_,_,_,_,_,_,_,_,_,Width,Height,_,_,_,_,_,_,_,_,_,_,_,_),
	OuterRCT=win_GetOuterRect(_Win),
	RCT = rect_GetClient(win_animation_Flags,b_True,OuterRct),
	RCT = rct(L,T,_R,_B),
	R1 = L + Width, B1 = T + Height,
	win_Move(_Win,rct(L,T,R1,B1)),

	% OK, start playing
	aaplay(AAhandle),
	!.
%END animation, e_Create

%MARK animation, new events

%BEGIN animation, e_Destroy
  win_animation_eh(_Win,e_Destroy,0):-!,
	retract(aaHandle(_Win,AAHandle)),
	aaStop(AAhandle),
	aaUnload(AAHandle),
	!.
%END animation, e_Destroy

%BEGIN animation, e_Menu, Parent window 
  win_animation_eh(Win,e_Menu(ID,CAS),0):-!,
	PARENT = win_GetParent(Win),
	win_SendEvent(PARENT,e_Menu(ID,CAS)),
	!.
%END animation, e_Menu, Parent window

%END_WIN animation







