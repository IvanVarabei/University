/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SETUP
 FileName: SETUP.PRO
 Purpose: Setup Program
 Written  by: Leo Jensen
 Modified by: Zaichenko Michael
 Comments:
******************************************************************************/

include "setup.inc"
include "hlptopic.con"
ifdef ws_win
 include "setup.con"
elsedef
 include "setup2.con"
enddef
%include "BMPCTRL.PRE"
include "build_v\\script.con"

CONSTANTS
 % group name appears to be limited to 30 characters

DOMAINS
% struct defination for options from each dialog
  demo = struct demo(BOOLEAN cass,BOOLEAN clip,BOOLEAN col,BOOLEAN classexe,BOOLEAN clipexe,BOOLEAN colexe)

DATABASE - other
%  determ known_exist_drive(CHAR Drive)
  determ pathBrowser(STRING tempPath)

  determ selectionType(DIALOG_CONTROL_ID)
  sizeEachGroup(ULONG Size ,INTEGER GroupId)
 


DATABASE -setup
 determ programGroup(BOOLEAN setupProgramGroup)

 determ firstGroup(DEMO)
 
PREDICATES
  determ setSelections(DIALOG_CONTROL_ID)  
  getProgramGroup(BOOLEAN setupProgramGroup)
CLAUSES
 

  setSelections(_):-
	retractAll(firstGroup(_)),
	fail.
	
  setSelections(idc_minimal):-!,
	assert(firstGroup(demo(b_false,b_true,b_false,b_false,b_false,b_false))),
	!.

  setSelections(idc_custom):-!,
	assert(firstGroup(demo(b_true,b_true,b_false,b_false,b_false,b_false))),
	!.
  setSelections(idc_all):-!,
	assert(firstGroup(demo(b_true,b_true,b_true,b_true,b_true,b_true))),
	!.
 

  getPath(P):-
	pathBrowser(P),!.
  getPath(P):-
	path(P),!.
  getPath(Path):-
	disk(P),
	frontchar(P,D,_),
	frontchar(Path,D,":\\EXAMPLES"),!.


  getProgramGroup(Group):-
	programGroup(Group),!.
  getProgramGroup(b_True).		%inital  State 


CLAUSES
  setAllGroups:-
	 retractall(is_selected(_)),
	 retractall(is_selected2(_)),
	firstGroup(demo(Class1,Clip,Color,ClassE,ClipE,ColorE)),
	 file_setOneGroup(Class1,idg_class),
	 file_setOneGroup(Clip,idg_clipbrd),
	 file_setOneGroup(Color,idg_colors),
	 file_setOneGroup(ClassE,idg_classEXE),
	 file_setOneGroup(ClipE,idg_clipbrdEXE),
	 file_setOneGroup(ColorE,idg_colorsEXE),!.
PREDICATES
  determ managerGroup_notNeed
CLAUSES
  managerGroup_notNeed:-		% rules for dsable/enable control in finish dlg
	not(selected(idg_classEXE)),
	not(selected(idg_clipbrdEXE)),	% no exe , not create group
	not(selected(idg_colorsEXE)).
  
  
PREDICATES
  nondeterm for(LONG Counter,LONG Start,LONG Stop)	%-(o,i,i)
  nondeterm member(DIR_ENTRY,DIRECTORY)
  nondeterm member(IGRP2,INSTALL_SCRIPT2)

CLAUSES
  for(I,I,_).
  for(I,J,K):- J<K, !,J2=J+1, for(I,J2,K).
  

  member(H, [H|_]).
  member(H,[_|T]):- member(H,T).

/******************************************************
	INSTALL
******************************************************/
PREDICATES
  install(DISKSTAT)
 CLAUSES
 
  install(DS):-  	% install all selected groups
	path(Ipath),
	file_setMake(Ipath), 	% make target dir if not there
	%member(install_group(Id, Directory), Script),
	iScript(install_group(Id, Directory)),
	  install_work_now,	% cancelation?
	  selected(Id),
	  file_my_ProcessEvents,
	  file_expandDirectory(Directory,DS),
	fail.
ifdef  ws_win
  install(_):-
  	install_work_now,
	programGroup(b_true),
	
	getPath(ProDir),

	IconItemScript=
	[
	    pGroup("Demo Group From Setup Tool"),

	    pItem(idg_classEXE,"Class Example","\\Class\\exe\\class.exe",ProDir),
	    pItem(idg_clipbrdEXE,"Clipboard Example","\\clipbrd\\exe\\clipbrd.exe",ProDir),
	    pItem(idg_colorsEXE,"Colors Example","\\Colors\\exe\\colors.exe",ProDir)
	],
	
	setupDDE_createGroup(IconItemScript),	%create  program group with items
    	!.
enddef
  install(_).
 
 
 
  selected(idg_any_example):-!,	 % rule for assign to logical group
  				 % some physycal groups
	is_selected(_),!.	
  selected(X):- is_selected(X),!.


  misk_select(_,_).	% in demo version not used, 
 			% about usage this predicate see visual prolog setup 


PREDICATES
 determ setup_setRequestAndAvail
 determ  setup_setRequest
CLAUSES
  setup_updateSpaceDialog(DRIVE):-
	retractAll(pathBrowser(_)),
	frontstr(1,Drive,D,_),
	concat(D,":\\",Path),
	assert(pathBrowser(Path)),
	setup_setRequestAndAvail,!.
  setup_updateSpaceDialog(_).
  
  setup_setRequestAndAvail:-
 	setAllGroups,
	getPath(PATH),
	%dlg_note(PATH),
	frontChar(Path,Drive,D2),
	frontChar(D2,':',D3),
	frontChar(D3,'\\',_),
	trap(diskSpace(Drive,FreeSpace),_,fail),
	file_findAllocUnitSize(Drive ,_,TotalSpace),!,
	getSizeSelected(Path,Requ),
	TotalSpaceKB=TotalSpace div 1024,
	FreeSpaceKB=FreeSpace div 1024,
	RequiredKB=Requ div 1024,
	space_setAvail(TotalSpaceKB,FreeSpaceKB),
	space_setRequest(RequiredKB),
	!.

  setup_setRequest:-
 	setAllGroups,
 	getPath(Path),
	getSizeSelected(Path,Requ),
	RequiredKB=Requ div 1024,
	space_setRequest(RequiredKB),
	!.


PREDICATES
  load_and_play_animation(WINDOW,STRING File)
  stop_animation(WINDOW)
  calc_centered_position(WINDOW,INTEGER XPos,INTEGER YPPos)

CLAUSES
  load_and_play_animation(_Win,_File):-
	!.

  % Stop Animation if it is running
  stop_animation(_WIN):-
	win_PostEvent(_Win,e_Menu(id_file_edit,0)).

  % The Animation picture has the VGA (640*480) size
  calc_centered_position(_Win,XPos,YPos):-
	Rct = win_GetClientRect(_Win),
	Rct = rct(_,_,R,B),
	R > 640, !,  %Better than VGA resolution !
	XPos = (R - 640) div 2,
	YPos = (B-480) div 2.
  calc_centered_position(_Win,0,0).

/*****************************************************************
	Dummy Install Window 	21.05.96
******************************************************************/
CONSTANTS
  user_id_go_install= 4096
PREDICATES
  install_win_eh:EHANDLER
  create_invisible_install_win(WINDOW parent)
CLAUSES
  create_invisible_install_win(TW):-
	win_create(w_TopLevel,rct(1,1,2,2),"",no_menu,TW,[wsf_InVisible],install_win_eh,0).

  install_win_eh(Win,e_Create(_),0):-!,
	win_PostEvent(Win,e_Menu(user_id_go_install,10)).

  install_win_eh(_Win,e_Menu(user_id_go_install,_),0):-
	setup_started_on_path(SPath),
	assert(install_work_now),
	diskStat(DiskArray),
	%iScript(Script),
	fileNamePath(Disk1File,Spath, "DISK_1"),
	openread(archive,Disk1File),
	filemode(archive,0),
	file_SetDiskFileSize,
	setDwordEntry(DiskArray,i_disk, 1), %current disk is 1 at start
	install(DiskArray),
	fail.
  install_win_eh(_Win,e_Menu(user_id_go_install,_),0):-
	install_work_now,
	path(PATH),
	fileNamePath(ReadMe,Path,"readme.wri"),
	concat("",ReadMe,CmdLine),
	system(CmdLine,1,_),
	fail.

  install_win_eh(Win,e_Menu(user_id_go_install,_),0):-
	win_Destroy(Win),
	TW = cast(window,vpi_GetAttrVal(attr_task_window)),
	win_postEvent(TW,e_menu(id_file_task_Destroy,0)),	 %add 20.05.96
	!.							

%BEGIN_WIN Task Window
/***************************************************************************
	Event handling for Task Window
***************************************************************************/
DATABASE - pictures
	bmp(PICTURE,INTEGER ResId,INTEGER VerSize,INTEGER HorSize)

PREDICATES

  task_win_eh : EHANDLER

CONSTANTS

%BEGIN Task Window, CreateParms, 17:33:18-24.11.1999, Code automatically updated!
  task_win_Flags = [wsf_Border,wsf_Maximized,wsf_ClipSiblings,wsf_ClipChildren]
  task_win_Menu  = no_menu
  task_win_Title = " Visual Prolog Setup"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

CLAUSES

%BEGIN Task Window, e_Create
   task_win_eh(_Win,e_Create(_),0):-
ifdef ws_win
	set_error_mode(sem_failcriticalerrors),
enddef
%BEGIN Task Window, InitControls, 17:33:18-24.11.1999, Code automatically updated!
%END Task Window, InitControls
%BEGIN Task Window, ToolbarCreate, 17:33:18-24.11.1999, Code automatically updated!
%END Task Window, ToolbarCreate
	
	assert(selectionType(idc_minimal)),
	setSelections(idc_minimal),
	
	bmpctrl_register(),
	progress_register,
	space_register,
	setupDDE_register,
	
	%assert(normal_update_falg),	%rem 30.05.96
	
	PICT_C = pict_GetFromRes(idb_copyright),
	pict_GetSize(Pict_C,W_c,H_c,_),
	assert(bmp(PICT_C,idb_Copyright,H_c,W_c)),

ifdef professional
	PICT_T = pict_GetFromRes(idb_professional),
	pict_GetSize(Pict_T,W_t,H_t,_),
	assert(bmp(PICT_T,idb_professional,H_t,W_t)),
elsedef
	PICT_T = pict_GetFromRes(idb_standard),
	pict_GetSize(Pict_T,W_t,H_t,_),
	assert(bmp(PICT_T,idb_standard,H_t,W_t)),
enddef
	file_readScript,	%
	win_PostEvent(_Win,e_Menu(id_file_edit,0)),
	!.
   task_win_eh(_Win,e_Create(_),0):-!,
	win_destroy(_Win).

%END Task Window, e_Create

  % THIS IS ACTIVATED BY POSTEVENT !
  task_win_eh(_Win,e_Menu(id_file_dlg1,_ShiftCtlAlt),0):-!,
	dlg_dialog1_Create(_Win),
	!.
  task_win_eh(_Win,e_Menu(id_file_dlg15,_ShiftCtlAlt),0):-!,
	dlg_dialog15_Create(_Win),
	!.
  task_win_eh(_Win,e_Menu(id_file_dlg6,_ShiftCtlAlt),0):-!,
	dlg_dialog6_Create(_Win),
	!.
 
 
 
 
   task_win_eh(_Win,e_Menu(id_file_inst_progress,_ShiftCtlAlt),0):-
	trap(deletefile("SETUP.HLP"),_,fail),fail.

  task_win_eh(_Win,e_Menu(id_file_inst_progress,_ShiftCtlAlt),0):-!,
	dlg_installation_in_progress_Create(_Win),!.
  task_win_eh(_Win,e_Menu(id_file_inst,_ShiftCtlAlt),0):-
	create_invisible_install_win(_Win).

  task_win_eh(_Win,e_Menu(id_file_Task_Destroy,_ShiftCtlAlt),0):-%add 20.05.96
	win_Destroy(_Win),
	!.
 task_win_eh(_Win,e_Menu(id_file_Edit,_ShiftCtlAlt),0):-!,
 	dlg_space_indicator_Create(_Win),		%20.05.96
	dlg_license_Create(_Win,"dummy licence"),
	!.

 task_win_eh(_Win,e_Menu(id_file_animate,_ShiftCtlAlt),0):-!,
	load_and_play_animation(_Win,"animate.flc").

 task_win_eh(_Win,e_Menu(id_file_animate,_ShiftCtlAlt),0):-
	load_and_play_animation(_Win,"animate.flc").


 task_win_eh(_Win,e_Menu(id_file_start,_ShiftCtlAlt),0):-
	%dlg_space_indicator_Create(_Win),
  	space_SetDialogVisible,
	setup_setRequestAndAvail,
	retractall(path(_)),
  	getPath(P),
  	assert(path(P)),
  	for(ID,1,100),
  	  get_size_one_group_str(Id,_,0),	%mark all bad group
  	fail.
 task_win_eh(_Win,e_Menu(id_file_start,_ShiftCtlAlt),0):-!,
	setSelections(idc_minimal).

%MARK Task Window, new events

%BEGIN Task Window, e_Char
  task_win_eh(_Win,e_Char(_Char,_ShiftCtlAlt),0):-!,
	stop_animation(_Win),
	!.
%END Task Window, e_Char

%BEGIN Task Window, e_EraseBackGround
  task_win_eh(_Win,e_EraseBackGround,0):-!.
        %normal_update_falg.			%rem 30.05.95
%END Task Window, e_EraseBackGround

%BEGIN Task Window, e_Destroy

  task_win_eh(_Win,e_Destroy,0):-!,
	mypath(P),
	disk(P),
	filenamepath(CMD,P,"setup3.exe"),!,	% delete setup2 and setup3.exe
	%vpi_processEvents
	system(CMD).
%END Task Window, e_Destroy


%BEGIN Task Window, e_Update
  task_win_eh(Win,e_Update(UpdateRect),0):-
	file_DrawBlueWin(Win,UpdateRect),!.	% this predicate always give fail
	  
  task_win_eh(_Win,e_Update(rct(_X0,_Y0,_X1,_Y1)),0):-
	Client=win_GetClientRect(_Win),
	Client=rct(_,_,_,Ymax),
	%Y0<Ymax-40,
	bmp(PICT,idb_copyright,H,_),
	Y=Ymax-H-1,
	pict_Draw(_Win,Pict,pnt(0,Y),rop_SrcPaint),
	fail.
  task_win_eh(_Win,e_Update(rct(_X0,_Y0,_X1,_Y1)),0):-
ifdef professional
	bmp(PICT,idb_professional,_,_),
elsedef
	bmp(PICT,idb_standard,_,_),
enddef
	pict_Draw(_Win,Pict,pnt(10,10),rop_SrcPaint),
	!.
%END Task Window, e_Update

%BEGIN Task Window, e_Size
  task_win_eh(_Win,e_Size(_Width,_Height),0):-!,
	!.
%END Task Window, e_Size

/***************************************************************************
	Invoking on-line Help
***************************************************************************/

  project_ShowHelpContext(HelpTopic):-
	vpi_ShowHelpContext("setup.hlp",HelpTopic),!.

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
  
  vpi_Init(task_win_Flags,task_win_eh,task_win_Menu,"setup",task_win_Title).

%END_WIN Task Window
predicates
 % add slash to end 
 addEndSlash(string,string)-(i,o)
clauses
 
 addEndSlash(I,I):-
	str_Len(I,Len),
	subchar(I,Len,C),
	C='\\',
	!.
 addEndSlash(I,O):-
	concat(I,"\\",O).


PREDICATES
  is_PathDir_empty
  count_dir(BINARY Counter)
CLAUSES
  is_PathDir_empty:-
	BIN = makeBinary(2),
	setWordEntry(BIN,0,0),
	count_dir(BIN),
	C = getWordEntry(BIN,0),
	C>2,!,
	dlg_note("Warning: Directory not Empty\nBe Carefull not to Install Over\nan Old Version of Project.").
  is_PathDir_empty.

  count_dir(BIN):-
  	getPath(Dir),
  	filenamepath(PathName,Dir,"*.*"),
	trap(dirfiles(PathName,$3f,_Name,_,_,_,_,_,_,_,_),_,fail),
	  C = getWordEntry(BIN,0),
	  CN=C+1,
	  setWordEntry(BIN,0,CN),
	fail.  
  count_dir(_).


%BEGIN_DLG Dialog1
/**************************************************************************
	Creation and event handling for dialog: Dialog1
**************************************************************************/

CONSTANTS

%BEGIN Dialog1, CreateParms, 16:04:25-24111995, Code automatically updated!
  dlg_dialog1_ResID = idd_dialog1
  dlg_dialog1_DlgType = wd_Modal
  dlg_dialog1_Help = idh_contents
%END Dialog1, CreateParms


PREDICATES

  dlg_dialog1_eh : EHANDLER
 determ dlg_dialog1_update(DIALOG_VAL_LIST)
 procedure dlg_1_ok(Window)
CLAUSES
  dlg_1_ok(WIN):-
	getPath(P),
	frontChar(P,Drive,_),
	file_IsDriveNoReadOnly(Drive),!,
	ParentW=win_GetParent(Win),
	win_Destroy(Win),
	win_PostEvent(ParentW,e_Menu(id_file_dlg15,0)).
  dlg_1_ok(_).
  


   dlg_dialog1_Create(Parent):-
	getPath(P),
	retractall(sizeEachGroup(_,_)),
	selectionType(SELECTIONTYPE),
%MARK Dialog1, new variables

	dialog_CreateModal(Parent,dlg_dialog1_ResID,"",
		[
%BEGIN Dialog1, ControlList, 16:04:25-24111995, Code automatically updated!
		df(id_path_name,editstr(P,[]),nopr),
		df(SELECTIONTYPE,radiobuttongroup([idc_minimal,idc_custom,idc_all]),nopr)
%END Dialog1, ControlList
		],
		dlg_dialog1_eh,0,_VALLIST,_ANSWER),
	!.

  dlg_dialog1_update(_VALLIST):-!,
%BEGIN Dialog1, Update controls, 16:04:25-24111995, Code automatically updated!
	_P = dialog_VLGetstr(id_path_name,_VALLIST),
	_SELECTIONTYPE = dialog_VLGetRadiobutton(idc_minimal,_VALLIST),
%END Dialog1, Update controls
	retractall(path(_)),
	retractall(selectionType(_)),
	assert(selectionType(_SELECTIONTYPE)),
	assert(path(_P)),
	setup_setRequestAndAvail,
	!.

%MARK Dialog1, new events

%BEGIN Dialog1, id_path_name losefocus
  dlg_dialog1_eh(_Win,e_Control(id_path_name,_CtrlType,_CtrlWin,losefocus),0):-
	VALLIST=dialog_GetValues(_WIN),
	dlg_dialog1_update(VALLIST),
	!.
%END Dialog1, id_path_name losefocus

%BEGIN Dialog1, e_CloseRequest
  dlg_dialog1_eh(_Win,e_CloseRequest,0):-!,
	!.
%END Dialog1, e_CloseRequest

%BEGIN Dialog1, idc_help _CtlInfo
  dlg_dialog1_eh(_Win,e_Control(idc_help,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	project_ShowHelpContext(idh_contents),
	!.
%END Dialog1, idc_help _CtlInfo

%BEGIN Dialog1, idc_all _CtlInfo
  dlg_dialog1_eh(_Win,e_Control(idc_all,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	setSelections(idc_all),
	setup_setRequest,
	!.
%END Dialog1, idc_all _CtlInfo

%BEGIN Dialog1, idc_custom _CtlInfo
  dlg_dialog1_eh(_Win,e_Control(idc_custom,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	setSelections(idc_custom),
	setup_setRequest,
	!.
%END Dialog1, idc_custom _CtlInfo

%BEGIN Dialog1, idc_minimal _CtlInfo
  dlg_dialog1_eh(_Win,e_Control(idc_minimal,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	setSelections(idc_minimal),
	setup_setRequest,
	!.
%END Dialog1, idc_minimal _CtlInfo

%BEGIN Dialog1, idc_cancel _CtlInfo
  dlg_dialog1_eh(_Win,e_Control(idc_cancel,_CtrlType,_CtrlWin,_CtlInfo),0):-
	dlg_cancelation_Create(_Win),!.
%END Dialog1, idc_cancel _CtlInfo

%BEGIN Dialog1, idc_browse _CtlInfo
  dlg_dialog1_eh(_Win,e_Control(idc_browse,_CtrlType,_CtrlWin,_CtlInfo),0):-
	retractAll(pathBrowser(_)),
	OldPath=dialog_GetStr(_Win,id_path_name),
	A=dlg_GetDirectoryName(_Win,OldPath,PathWithoutSlash),
	A=b_true,
	addEndSlash(PathWithoutSlash,Path),
	
	dialog_SetStr(_Win,id_path_name,Path),
	VALLIST=dialog_GetValues(_WIN),
	dlg_dialog1_update(VALLIST),
	fail.
  dlg_dialog1_eh(_Win,e_Control(idc_browse,_CtrlType,_CtrlWin,_CtlInfo),0):-
	retractAll(pathBrowser(_)),!.
%END Dialog1, idc_browse _CtlInfo

%BEGIN Dialog1, idc_ok _CtlInfo
  dlg_dialog1_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtlInfo),0):-
	VALLIST=dialog_GetValues(_WIN),
	dlg_dialog1_update(VALLIST),
	is_pathDir_empty,!,
	dlg_1_ok(_WIN).

  dlg_dialog1_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtlInfo),0):-
 	dlg_note("Drive or path is not valid,\n correct it and try again."),
  	!.
%END Dialog1, idc_ok _CtlInfo

%BEGIN Dialog1, e_Create
  dlg_dialog1_eh(_Win,e_Create(_CreationData),0):-!,
	BMPW = win_GetCtlHandle(_Win, idc_mybitmap),
	bmpctrl_SetBMPResId(BMPW,idb_prolog,b_true,b_false),
	!.
%END Dialog1, e_Create

  dlg_dialog1_eh(_,_,0):-!,fail.
%END_DLG Dialog1










PREDICATES
 PROCEDURE maybe_finish(UlONG Avail,ULONG Required,ULONG PushButtonState)
CLAUSES
  maybe_finish(_,0,1):-!.	% nothing selected
  maybe_finish(A,R,1):-A<R,!.	% not avail memory
  maybe_finish(_,_,0).  	% ok



%BEGIN_DLG Dialog6
/**************************************************************************
	Creation and event handling for dialog: Dialog6
**************************************************************************/

CONSTANTS

%BEGIN Dialog6, CreateParms, 17:37:14-24.11.1999, Code automatically updated!
  dlg_dialog6_ResID = idd_dialog6
  dlg_dialog6_DlgType = wd_Modal
  dlg_dialog6_Help = idh_contents
%END Dialog6, CreateParms

PREDICATES

  dlg_dialog6_eh : EHANDLER
  dlg_dialog6_update(DIALOG_VAL_LIST)

CLAUSES

  dlg_dialog6_Create(Parent):-
	setAllGroups,
	path(PATH),
	frontChar(Path,Drive,NextChars),
	frontChar(NextChars,':',_),
	diskSpace(Drive,FreeSpace),
	getSizeSelected(Path,Requ),
	RequKb=Requ div 1024,
	FreeSpacekb=FreeSpace div 1024,
	format(Available,"%U Kb",FreeSpaceKB),
	format(Required,"%U KB",RequKB),
	maybe_finish(FreeSpace,Requ,PBState),
	file_SetSpaceValue(Requ,0),
	
	getProgramGroup(SETUPPROGMANGROUP),

%MARK Dialog6, new variables

	dialog_CreateModal(Parent,dlg_dialog6_ResID,"",
		[
%BEGIN Dialog6, ControlList, 17:37:14-24.11.1999, Code automatically updated!
		df(idc_required,editstr(REQUIRED,[]),nopr),
		df(id_setupprogmangroup,checkbox(SETUPPROGMANGROUP),nopr),
		df(idc_available,editstr(AVAILABLE,[]),nopr)
%END Dialog6, ControlList
		],
		dlg_dialog6_eh,PBState,_VALLIST,_ANSWER),
	!.

  dlg_dialog6_update(_VALLIST):-!,
%BEGIN Dialog6, Update controls, 17:37:14-24.11.1999, Code automatically updated!
	_AVAILABLE = dialog_VLGetstr(idc_available,_VALLIST),
	_REQUIRED = dialog_VLGetstr(idc_required,_VALLIST),
	_SETUPPROGMANGROUP = dialog_VLGetCheck(id_setupprogmangroup,_VALLIST),
%END Dialog6, Update controls
	retractall(programgroup(_)),
	assert(programgroup(_SETUPPROGMANGROUP)),
	!.

%MARK Dialog6, new events

%BEGIN Dialog6, e_CloseRequest
  dlg_dialog6_eh(_Win,e_CloseRequest,0):-!,
	!.
%END Dialog6, e_CloseRequest

%BEGIN Dialog6, idc_help _CtlInfo
  dlg_dialog6_eh(_Win,e_Control(idc_help,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	project_ShowHelpContext(idh_contents),
	!.
%END Dialog6, idc_help _CtlInfo

%BEGIN Dialog6, idc_cancel _CtlInfo
  dlg_dialog6_eh(_Win,e_Control(idc_cancel,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	dlg_cancelation_Create(_Win),
	!.
%END Dialog6, idc_cancel _CtlInfo

%BEGIN Dialog6, e_Destroy
  dlg_dialog6_eh(_Win,e_Destroy,0):-!,
  	VALLIST=dialog_GetValues(_WIN),
        dlg_dialog6_update(VALLIST),
	!.
%END Dialog6, e_Destroy

%BEGIN Dialog6, idc_ok _CtlInfo
  dlg_dialog6_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	ParentW=win_GetParent(_Win),
	win_Destroy(_Win),
	win_PostEvent(ParentW,e_Menu(id_file_inst_progress,0)),
%	dlg_installation_in_progress_Create(ParentW),
	!.
%END Dialog6, idc_ok _CtlInfo

%BEGIN Dialog6, idc_back _CtlInfo
  dlg_dialog6_eh(_Win,e_Control(idc_back,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	ParentW=win_GetParent(_Win),
	win_Destroy(_Win),
	win_PostEvent(ParentW,e_Menu(id_file_dlg15,0)),
	!.
%END Dialog6, idc_back _CtlInfo



%BEGIN Dialog6, e_Create
  dlg_dialog6_eh(_Win,e_Create(1),0):-
	dialog_SetState(_Win,[enable(idc_ok,b_false)]),
	BMPW = win_GetCtlHandle(_Win, idc_mybitmap),
    ifdef ws_win
	bmpctrl_SetBMPResId(BMPW,idb_hand,b_true,b_true),
    enddef
    ifdef os_os2
	bmpctrl_SetBMPResId(BMPW,idb_handdown,b_true,b_false),
    enddef
	fail.
  dlg_dialog6_eh(_Win,e_Create(D),0):- D<>1,
	BMPW = win_GetCtlHandle(_Win, idc_mybitmap),
	bmpctrl_SetBMPResId(BMPW,idb_hand,b_true,b_false),fail.
  dlg_dialog6_eh(_Win,e_Create(_CreationData),0):-!,
    ifdef ws_win
	managerGroup_notNeed,  	 %fails when not selected components to create program group/items
	%setupDDE_notNeed,
    enddef
	dialog_SetCheck(_Win,id_setupprogmangroup,b_false),
	dialog_SetState(_Win,[enable(id_setupprogmangroup,b_false)]),
	!.
%END Dialog6, e_Create

  dlg_dialog6_eh(_,_,0):-!,fail.
%END_DLG Dialog6




%BEGIN_DLG dialog1.5
/**************************************************************************
	Creation and event handling for dialog: dialog1.5
**************************************************************************/

CONSTANTS

%BEGIN dialog1.5, CreateParms, 17:37:38-24.11.1999, Code automatically updated!
  dlg_dialog15_ResID = idd_dialog15
  dlg_dialog15_DlgType = wd_Modal
  dlg_dialog15_Help = idh_contents
%END dialog1.5, CreateParms

PREDICATES

  dlg_dialog15_eh : EHANDLER
  dlg_dialog15_update(DIALOG_VAL_LIST)

CLAUSES

  dlg_dialog15_Create(Parent):-
	retractall(invisible(_)),
	firstGroup(demo(Class1,Clip,Colors,ClassExe,ClipExe,ColorsExe)),
	get_size_one_group_str(idg_class,S_CLASS,idc_class),
	get_size_one_group_str(idg_clipbrd,S_CLIP,idc_clip),
	get_size_one_group_str(idg_colors,S_COLORS,idc_colors),

	get_size_one_group_str(idg_classEXE,S_CLASSEXE,idc_classexe),
	get_size_one_group_str(idg_clipbrdEXE,S_CLIPEXE,idc_clipexe),
	get_size_one_group_str(idg_colorsEXE,S_COLORSEXE,idc_colorsexe),



%MARK dialog1.5, new variables

	dialog_CreateModal(Parent,dlg_dialog15_ResID,"",
  		[
%BEGIN dialog1.5, ControlList, 17:37:38-24.11.1999, Code automatically updated!
		df(idc_class,checkbox(CLASS1),nopr),
		df(idc_clip,checkbox(CLIP),nopr),
		df(idc_classexe,checkbox(CLASSEXE),nopr),
		df(idc_clipexe,checkbox(CLIPEXE),nopr),
		df(idc_colorsexe,checkbox(COLORSEXE),nopr),
		df(idc_colors,checkbox(COLORS),nopr),
		df(idct_size_class,statictext(S_CLASS),nopr),
		df(idct_size_clip,statictext(S_CLIP),nopr),
		df(idct_size_classexe,statictext(S_CLASSEXE),nopr),
		df(idct_size_clipexe,statictext(S_CLIPEXE),nopr),
		df(idct_size_colorsexe,statictext(S_COLORSEXE),nopr),
		df(idct_size_colors,statictext(S_COLORS),nopr)
%END dialog1.5, ControlList
		],
		dlg_dialog15_eh,0,_VALLIST,_ANSWER),!.

  dlg_dialog15_update(_VALLIST):-
%BEGIN dialog1.5, Update controls, 17:37:38-24.11.1999, Code automatically updated!
	_CLASS1 = dialog_VLGetCheck(idc_class,_VALLIST),
	_CLIP = dialog_VLGetCheck(idc_clip,_VALLIST),
	_CLASSEXE = dialog_VLGetCheck(idc_classexe,_VALLIST),
	_CLIPEXE = dialog_VLGetCheck(idc_clipexe,_VALLIST),
	_COLORSEXE = dialog_VLGetCheck(idc_colorsexe,_VALLIST),
	_COLORS = dialog_VLGetCheck(idc_colors,_VALLIST),
%END dialog1.5, Update controls
	New=demo(_CLASS1,_CLIP,_COLORS,_CLASSEXE,_CLIPEXE,_COLORSEXE),
	retract(firstGroup(Old)),
	assert(firstGroup(New)),
	Old=New,
	!.
  dlg_dialog15_update(_VALLIST):-!,
	retractall(selectionType(_)),
	assert(selectionType(idc_custom)).


%MARK dialog1.5, new events
  dlg_dialog15_eh(_Win,e_Control(_,_,_,_),0):-
  	VALLIST=dialog_GetValues(_WIN),
	dlg_dialog15_update(VALLIST),
	setup_setRequest,
	
	fail.

%BEGIN dialog1.5, idc_back _CtlInfo
  dlg_dialog15_eh(_Win,e_Control(idc_back,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	ParentW=win_GetParent(_Win),
	win_Destroy(_Win),
	win_PostEvent(ParentW,e_Menu(id_file_dlg1,0)),
	!.
%END dialog1.5, idc_back _CtlInfo

%BEGIN dialog1.5, idc_help _CtlInfo
  dlg_dialog15_eh(_Win,e_Control(idc_help,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	project_ShowHelpContext(idh_contents),
	!.
%END dialog1.5, idc_help _CtlInfo

%BEGIN dialog1.5, idc_cancel _CtlInfo
  dlg_dialog15_eh(_Win,e_Control(idc_cancel,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	dlg_cancelation_Create(_Win),
	!.
%END dialog1.5, idc_cancel _CtlInfo

%BEGIN dialog1.5, idc_ok _CtlInfo
  dlg_dialog15_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	ParentW=win_GetParent(_Win),
	win_Destroy(_Win),
	win_PostEvent(ParentW,e_Menu(id_file_dlg6,0)),!.
%END dialog1.5, idc_ok _CtlInfo


%BEGIN dialog1.5, e_CloseRequest
  dlg_dialog15_eh(_Win,e_CloseRequest,0):-!,
	!.
%END dialog1.5, e_CloseRequest

%BEGIN dialog1.5, e_Destroy
  dlg_dialog15_eh(_Win,e_Destroy,0):-!,
	VALLIST=dialog_GetValues(_WIN),
	dlg_dialog15_update(VALLIST),
	!.
%END dialog1.5, e_Destroy

%BEGIN dialog1.5, e_Create
  dlg_dialog15_eh(_Win,e_Create(_CreationData),0):-!,
	file_SetInvisible(_Win),
	BMPW = win_GetCtlHandle(_Win, idc_mybitmap),
	bmpctrl_SetBMPResId(BMPW,idb_comp,b_true,b_false),
	selectionType(Type),
	VALLIST=dialog_GetValues(_WIN),
	dlg_dialog15_update(VALLIST),
	retractall(selectionType(_)),
	assert(selectionType(Type)),
	!.
%END dialog1.5, e_Create

  dlg_dialog15_eh(_,_,_):-!,fail.

%END_DLG dialog1.5



















