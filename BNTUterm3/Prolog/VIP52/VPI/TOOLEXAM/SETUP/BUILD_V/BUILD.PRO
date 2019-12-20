/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  BUILD
 FileName: BUILD.PRO
 Purpose: Demo about building simple distribuytive set
 Written by: Zaichenko Michael
 Comments: VPI 16 bit version
******************************************************************************/

include "build.inc"
include "build.con"
include "hlptopic.con"
include "script.con"

CONSTANTS
 background_str = "Any User Defined Text"
 config_file_name = "build.cfg"

database - build_cfg
  determ t_path(STRING)		% tarfget path
  single t_pl(INTEGER)		% target platform(s)
  single en_vol(BOOLEAN,LONG)	% enable /disable multi volume mode
  single bmake(BOOLEAN,BOOLEAN) % mode of build work (packing / coping)
  
PREDICATES
  procedure b_GetIni(STRING,Integer,BOOLEAN,Long,BOOLEAN,BOOLEAN)-(o,o,o,o,o,o)
  procedure get_tpath(STRING)-(o)
  procedure get_EnVol(Boolean,LONG)-(o,o)
  b_SetIni(STRING,Integer,BOOLEAN,DIALOG_LONG,BOOLEAN,BOOLEAN)-(i,i,i,i,i,i)
  procedure init_scrips()
CLAUSES 

  t_pl(0).		% default values
  en_vol(0,0).
  bmake(1,1).

  get_tpath(Path):-
	t_path(Path),!.
  get_tpath(Path):-
	disk(Path).
	
  
  get_EnVol(Enable,Size):-
	en_vol(Enable,Size),
	Size>360000,
	!.
  get_EnVol(0,1457600).
  

  b_GetIni(_,_,_,_,_,_):-
	sysPath(SysPath,_),
	fileNamePath(INI,SysPath,config_file_name),
	trap(consult(INI,build_cfg),_,fail),
	fail.
  b_GetIni(TPATH,TPLATFORM,EnableVol,VolSize,DoDist,DoPack):-
	get_tpath(TPATH),
	t_pl(TPLATFORM),
	get_EnVol(EnableVol,VolSize),
	bmake(DoDist,DoPack).

  b_SetIni(_,_,Enable,l(Size),_,_):-
	assert(en_vol(Enable,Size)),
	fail.
  b_SetIni(Path,TPlatform,_,_,DoDist,DoPack):-
	retractall(t_path(_)),
	assert(t_path(Path)),
	assert(t_pl(TPlatform)),
	assert(bmake(DoDist,DoPack)),
	sysPath(SysPath,_),
	fileNamePath(INI,SysPath,config_file_name),
	trap(save(INI,build_cfg),_,fail),
	fail.
  b_SetIni(_,_,_,_,_,_):-!.

PREDICATES
 determ convert_platf(DIALOG_CONTROL_ID,INTEGER)-(i,o)(o,i)
CLAUSES
 convert_platf(idc_win,0):-!.
 convert_platf(idc_os2,1):-!.
 convert_platf(idc_win_and_os2,2):-!.

%BEGIN_DLG start
/**************************************************************************
	Creation and event handling for dialog: start
**************************************************************************/

CONSTANTS

%BEGIN start, CreateParms, 17:12:38-24.11.1999, Code automatically updated!
  dlg_start_ResID = idd_start
  dlg_start_DlgType = wd_Modeless
  dlg_start_Help = idh_contents
%END start, CreateParms

PREDICATES

  dlg_start_eh : EHANDLER
  %dlg_start_update(DIALOG_VAL_LIST)

   enable_SButton(window)
CLAUSES

   enable_SButton(_Win):-
 	_ValList = dialog_GetValues(_WIN),
	Copy = dialog_VLGetCheck(idc_enable_coping,_VALLIST),
	Pack = dialog_VLGetCheck(idc_enable_packing,_VALLIST),
	bitOr(Copy,Pack,Enable),
	dialog_SetState(_Win,[enable(idc_ok,Enable)]),!.
	
	


  dlg_start_Create(Parent):-
	b_GetIni(TPath,TPlatform,Enable_Multi_Volume,VolSize,Enable_COPING,Enable_Packing),
	Volume_Size = l(VolSize),
	convert_platf(Target_Platform,TPlatform),

%MARK start, new variables

	dialog_CreateModeless(Parent,dlg_start_ResID,"",
  		[
%BEGIN start, ControlList, 17:12:38-24.11.1999, Code automatically updated!
		df(idc_path,editstr(TPATH,[mandatory]),nopr),
		df(idc_enable_volume,checkbox(ENABLE_MULTI_VOLUME),nopr),
		df(idc_volume_size,editlong(VOLUME_SIZE,[mandatory,minimum(360000)]),nopr),
		df(idc_enable_packing,checkbox(ENABLE_PACKING),nopr),
		df(idc_enable_coping,checkbox(ENABLE_COPING),nopr),
		df(TARGET_PLATFORM,radiobuttongroup([idc_win,idc_win_and_os2,idc_os2]),nopr)
%END start, ControlList
		],
		dlg_start_eh,0).

%MARK start, new events

%BEGIN start, e_Create
  dlg_start_eh(_Win,e_Create(_),0):-!,
	enable_SButton(_Win).
%END start, e_Create

%BEGIN start, idc_enable_packing _CtlInfo
  dlg_start_eh(_Win,e_Control(idc_enable_packing,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
     enable_SButton(_Win).
%END start, idc_enable_packing _CtlInfo

%BEGIN start, idc_enable_coping _CtlInfo
  dlg_start_eh(_Win,e_Control(idc_enable_coping,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
     enable_SButton(_Win).
%END start, idc_enable_coping _CtlInfo

%BEGIN start, idc_ok _CtlInfo
  dlg_start_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	_ValList=dialog_GetValues(_WIN),
%BEGIN start, Update controls, 17:12:38-24.11.1999, Code automatically updated!
	_TPATH = dialog_VLGetstr(idc_path,_VALLIST),
	_ENABLE_MULTI_VOLUME = dialog_VLGetCheck(idc_enable_volume,_VALLIST),
	_VOLUME_SIZE = dialog_VLGetlong(idc_volume_size,_VALLIST),
	_ENABLE_COPING = dialog_VLGetCheck(idc_enable_coping,_VALLIST),
	_ENABLE_PACKING = dialog_VLGetCheck(idc_enable_packing,_VALLIST),
	_TARGET_PLATFORM = dialog_VLGetRadiobutton(idc_win,_VALLIST),
%END start, Update controls
	convert_platf(_TARGET_PLATFORM,TP),
	b_SetIni(_TPATH,TP,_ENABLE_MULTI_VOLUME,_VOLUME_SIZE,_ENABLE_COPING,_ENABLE_PACKING),
	b_GetIni(TPath,TPl,E_MultiVol,VolSize,E_Coping,E_Packing),
	build_initValues(TPath,TPl,E_MultiVol,VolSize,E_Coping,E_Packing),
	TW = vpi_GetTaskWin(),
	win_PostEvent(TW,e_Menu(id_file_initbuild,0)),
	win_Destroy(_Win),
	!.
%END start, idc_ok _CtlInfo

%BEGIN start, idc_browse _CtlInfo
  dlg_start_eh(_Win,e_Control(idc_browse,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
  	OldPath=dialog_GetStr(_Win,idc_path),
	A=dlg_GetDirectoryName(_Win,OldPath,Path),
	A=b_true,
	OldPath<>Path,
	dialog_SetStr(_Win,idc_path,Path),
	!.
%END start, idc_browse _CtlInfo

%BEGIN start, idc_enable_volume _CtlInfo
  dlg_start_eh(_Win,e_Control(idc_enable_volume,_CtrlTye,_CtrlWin,activated()),0):-!,
	Enable = dialog_GetCheck(_Win,idc_enable_volume),
	dialog_SetState(_Win,[enable(idc_volume_size,Enable)]),
	!.
%END start, idc_enable_volume _CtlInfo

%BEGIN start, idc_cancel _CtlInfo
  dlg_start_eh(_Win,e_Control(idc_cancel,_CtrlType,_CtrlWin,_CtlInfo),0):-
	TW = vpi_GetTaskWin(),
	win_Destroy(_Win),
	win_PostEvent(TW,e_Menu(id_file_exit,0)),
	!.
%END start, idc_cancel _CtlInfo

%END_DLG start


%BEGIN_WIN Task Window
/***************************************************************************
	Event handling for Task Window
***************************************************************************/

PREDICATES

  task_win_eh : EHANDLER

CONSTANTS

%BEGIN Task Window, CreateParms, 17:13:02-24.11.1999, Code automatically updated!
  task_win_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Close,wsf_ClipSiblings]
  task_win_Menu  = res_menu(idr_task_menu)
  task_win_Title = "build"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

CLAUSES

%BEGIN Task Window, e_Create
  task_win_eh(_Win,e_Create(_),0):-!,
%BEGIN Task Window, InitControls, 17:13:02-24.11.1999, Code automatically updated!
%END Task Window, InitControls
	progress_register(),
IFDEF use_message
	msg_Create(100),
ENDDEF
	win_PostEvent(_Win,e_Menu(id_file_start,0)),
	FONT = font_Create(ff_times,[],30), 
	win_SetFont(_Win,Font),
	!.
%END Task Window, e_Create

%MARK Task Window, new events

%BEGIN Task Window, e_Update
  task_win_eh(_Win,e_Update(_UpdateRct),0):-
	win_clear(_win,_UpdateRct,color_gray),
	win_SetForeColor(_Win,color_yellow),
	draw_text(_win,5,30,background_str),
	!.
%END Task Window, e_Update

%BEGIN Task Window, e_EraseBackGround
  task_win_eh(_Win,e_EraseBackGround,0):-!,
	!.
%END Task Window, e_EraseBackGround

%BEGIN Task Window, id_file_initbuild
  task_win_eh(_Win,e_Menu(id_file_initbuild,_ShiftCtlAlt),0):-
	build_Go(),
	fail.
  task_win_eh(_Win,e_Menu(id_file_initbuild,_ShiftCtlAlt),0):-
	win_PostEvent(_Win,e_Menu(id_file_exit,0)),
	!.
%END Task Window, id_file_initbuild

%BEGIN Task Window, id_file_start
  task_win_eh(_Win,e_Menu(id_file_start,_ShiftCtlAlt),0):-!,
	dlg_start_Create(_Win),
	!.
%END Task Window, id_file_start

%BEGIN Task Window, id_file_exit
  task_win_eh(Win,e_Menu(id_file_exit,_ShiftCtlAlt),0):-!,
  	win_Destroy(Win),
	!.
%END Task Window, id_file_exit

%BEGIN Task Window, e_Size
  task_win_eh(_Win,e_Size(_Width,_Height),0):-!,
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
  	vpi_ShowHelpContext("build.hlp",HelpTopic).

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
  init_scrips(),
  vpi_Init(task_win_Flags,task_win_eh,task_win_Menu,"build",task_win_Title).


/***************************************************************************
 InstallScript. the rest of BUILD.PRO should
 be generic. Ids must match either those defined in SCRIPT.CON, which ids are
 all either on the dialog (see script.con), or be enabled by the selected/1 
 clauses in SETUP.PRO (from setup2.vpr)
 ***************************************************************************/
 
CLAUSES
  init_scrips():-
	ExcludeScript = ["*.BAK", "*.SYM", "*.ZIP","*.MAP","*.BK1","*.ARJ", "*.SAV", "*.OLD","*.GID"],

	WinFiles = [   "setup.exe"
		       ifdef cd_VER
	 		,"ANIMATE.FLC"
			enddef 
		   ],

   GeneralScript = [
	%% derived (rule-based) groups. defined in SETUP.PRO, selected/1

   group(0,	
  	startFromPath("INSTALL.INT"),
	no_exclusions,
	[file("SETUP2.EXE"),
	 file("SETUP3.EXE"),
	 file("SETUP.HLP"),
 	 file("LICENSE.TXT")
ifdef cd_ver
 	 ,file("AAPLAY.DLL")
enddef
	]),
   group(1,	
  	startFromPath("INSTALL.INT\\OS2"),
	no_exclusions,
	[file("SETUP2.EXE"),
	 file("SETUP3.EXE"),
	 file("SETUP.HLP"),
 	 file("LICENSE.TXT")
	]),

/****************************************************************
	user groups defination start from here
*****************************************************************/
  group(idg_class,
	fromInstallRoot,
	excluding(["EXE"]),
	[directory("CLASS")]),

  group(idg_clipbrd,
	fromInstallRoot,
	excluding(["EXE"]),
	[directory("CLIPBRD")]),
  group(idg_colors,
	fromInstallRoot,
	excluding(["EXE"]),
	[directory("COLORS")]),
  
  
  
  group(idg_classEXE,	
  	startFromPath("CLASS"),
  	no_exclusions,
	[directory("EXE")]),
  group(idg_clipbrdEXE,	
  	startFromPath("CLIPBRD"),
  	no_exclusions,
	[directory("EXE")]),
  group(idg_colorsEXE,	
  	startFromPath("COLORS"),
  	no_exclusions,
	[directory("EXE")]),


  group(idg_any_example,  % if any compiler version
 	fromInstallRoot,
 	no_exclusions,
	[ file("clean.bat")])],

	build_InitScripts(ExcludeScript,GeneralScript),

	% Script for copy additional files to Distributive
	build_InitCopyScript(WinFiles,0),	% for 16 bit plaforms
	build_InitCopyScript(["os2\\setupos2.exe"],1),% for 32 bit platforms
	!.




