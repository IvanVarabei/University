/*****************************************************************************

	       Copyright (c) 1984 - 2000 Prolog Development Center A/S

				Class  examples


 Project:  SHAPES
 FileName: SHAPES.PRO
 Purpose: Example of Classes & Objects
 Written by: Compiler Group
 Comments:
******************************************************************************/

include "shapes.inc"
include "shapes.con"
include "hlptopic.con"

constants

  err_nofocus = "One of the users's windows must be focused"

database - objects_db
  object( ObjectManager, WINDOW )

predicates
  error( STRING )
  nondeterm ObjectManager getFocusedObject()

clauses
  error( Msg ):- dlg_Note( Msg ).

  getFocusedObject( OM ):-
	Wnd = win_GetFocus(),
	object( OM, Wnd ).
  getFocusedObject( _ ):-
	error( err_nofocus ),
	fail.

clauses
  win_handler( _Win, e_Create( _ ), 0 ):- !.
  win_handler( Wnd, e_Update( _ ), 0 ):- !,
	object( OM, Wnd ), %!,
	OM:update, !.
  win_handler( Wnd, e_Timer( TmrID ), 0 ):- !,
	timer_Kill( TmrID ),
	object( OM, Wnd ),
	retract( object( OM, Wnd ), objects_db ),
	OM:delete(), !.
  win_handler( Wnd, e_CloseRequest, 0 ):- !,
	object( OM, Wnd ),
	retract( object( OM, Wnd ), objects_db ),
	OM:delete(), !.

predicates
  createObject
  nondeterm destroyObject
  nondeterm createShape( Shape_Kind )
  nondeterm moveShape( Move_Kind )

clauses
  createObject :-
	OM = ObjectManager::new(),
	Wnd = OM:getHandle(),
	assert( object( OM, Wnd ), objects_db ).

  destroyObject :-
	OM = getFocusedObject(), !,
	OM:destroy.
  destroyObject.

  createShape( SK ) :-
	OM = getFocusedObject(), !,
	OM:newShape( SK ).
  createShape( _ ).

  moveShape( MK ) :-
	OM = getFocusedObject(), !,
	OM:shiftShape( MK ).
  moveShape( _ ).

%BEGIN_WIN Task Window
/***************************************************************************
	Event handling for Task Window
***************************************************************************/

PREDICATES

  task_win_eh : EHANDLER

CONSTANTS

%BEGIN Task Window, CreateParms, 16:59:28-26.11.1999, Code automatically updated!
  task_win_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Close,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings,wsf_ClipChildren]
  task_win_Menu  = res_menu(idr_task_menu)
  task_win_Title = "Shapes"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

CLAUSES

%BEGIN Task Window, e_Create
  task_win_eh(_Win,e_Create(_),0):-!,
%BEGIN Task Window, InitControls, 16:59:28-26.11.1999, Code automatically updated!
%END Task Window, InitControls
%BEGIN Task Window, ToolbarCreate, 16:59:28-26.11.1999, Code automatically updated!
%END Task Window, ToolbarCreate
IFDEF use_message
	msg_Create(100),
ENDDEF
	!.
%END Task Window, e_Create

%MARK Task Window, new events

%BEGIN Task Window, id_Objects_Move_Shape_bottom
  task_win_eh(_Win,e_Menu(id_Objects_Move_Shape_bottom,_ShiftCtlAlt),0):-!,
	moveShape( m_down ),
	!.
%END Task Window, id_Objects_Move_Shape_bottom

%BEGIN Task Window, id_Objects_Move_Shape_top
  task_win_eh(_Win,e_Menu(id_Objects_Move_Shape_top,_ShiftCtlAlt),0):-!,
	moveShape( m_up ),
	!.
%END Task Window, id_Objects_Move_Shape_top

%BEGIN Task Window, id_Objects_Move_Shape_right
  task_win_eh(_Win,e_Menu(id_Objects_Move_Shape_right,_ShiftCtlAlt),0):-!,
	moveShape( m_right ),
	!.
%END Task Window, id_Objects_Move_Shape_right

%BEGIN Task Window, id_Objects_Move_Shape_left
  task_win_eh(_Win,e_Menu(id_Objects_Move_Shape_left,_ShiftCtlAlt),0):-!,
	moveShape( m_left ),
	!.
%END Task Window, id_Objects_Move_Shape_left

%BEGIN Task Window, id_Objects_New_ShapetCtrlS_rectangle
  task_win_eh(_Win,e_Menu(id_Objects_New_ShapetCtrlS_rectangle,_ShiftCtlAlt),0):-!,
	createShape( s_rectangle ),
	!.
%END Task Window, id_Objects_New_ShapetCtrlS_rectangle

%BEGIN Task Window, id_Objects_New_ShapetCtrlS_ellipse
  task_win_eh(_Win,e_Menu(id_Objects_New_ShapetCtrlS_ellipse,_ShiftCtlAlt),0):-!,
	createShape( s_ellipse ),
	!.
%END Task Window, id_Objects_New_ShapetCtrlS_ellipse

%BEGIN Task Window, id_Objects_New_ShapetCtrlS_line
  task_win_eh(_Win,e_Menu(id_Objects_New_ShapetCtrlS_line,_ShiftCtlAlt),0):-!,
	createShape( s_line ),
	!.
%END Task Window, id_Objects_New_ShapetCtrlS_line

%BEGIN Task Window, id_Objects_delete
  task_win_eh(_Win,e_Menu(id_Objects_delete,_ShiftCtlAlt),0):-!,
  	destroyObject,
	!.
%END Task Window, id_Objects_delete

%BEGIN Task Window, id_Objects_create
  task_win_eh(_Win,e_Menu(id_Objects_create,_ShiftCtlAlt),0):-!,
  	createObject,
	!.
%END Task Window, id_Objects_create

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

/***************************************************************************
	Invoking on-line Help
***************************************************************************/

  project_ShowHelpContext(HelpTopic):-
  	vpi_ShowHelpContext("shapes.hlp",HelpTopic),!.

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
  vpi_Init(task_win_Flags,task_win_eh,task_win_Menu,"shapes",task_win_Title).

%END_WIN Task Window

%BEGIN_DLG About dialog
/**************************************************************************
	Creation and event handling for dialog: About dialog
**************************************************************************/

CONSTANTS

%BEGIN About dialog, CreateParms, 17:07:16-26.11.1999, Code automatically updated!
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

  dlg_about_dialog_eh(_,_,0):-!,fail.
%END_DLG About dialog










